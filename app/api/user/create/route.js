import { signupSchema } from "@/lib/schemas";
import { querySingle } from "@/lib/pg";
import { validateURL } from "@/lib/functions";
import { NextResponse } from "next/server";
import { makeToken } from "@/lib/functions/jwt";

// signing up a single user.
export async function POST(req) {
	// get the url of the requestor
	const requestURL = req.headers.get("referer");

	// if the requestor is not from a valid url return not authorized.
	if (!validateURL(requestURL)) {
		return NextResponse.json(
			{ error: "Not Authorized" },
			{
				status: 401,
			}
		);
	}

	// then parse the body of the url since we know it's good.
	const parsedUrl = new URL(requestURL);

	// check to see if the requestor came from sign up page.
	// if from signup proceced. If not send back 401
	if (parsedUrl.pathname.toLowerCase() !== "/signup") {
		return NextResponse.json(
			{ error: "Not Authorized" },
			{
				status: 401,
			}
		);
	}

	// get the body of our request.
	const body = await req.json();

	// validate the data from the sign up with the same schema
	// from the front end.
	const validation = await signupSchema
		.validate(body)
		.then(() => {
			return null;
		})
		.catch((err) => {
			console.log(err);

			return err;
		});

	// if validation failed, send back the error.
	if (validation !== null) {
		return NextResponse.json(
			{ error: JSON.stringify(err) },
			{
				status: 400,
			}
		);
	}

	const email_values = [body.email, undefined];
	// check to see if an email is already used.
	const { email_check } = await querySingle(
		"call check_email_proc($1, $2)",
		email_values
	);

	console.log(email_values, email_check);
	// if the email is in use let the client know.
	if (!email_check) {
		return NextResponse.json(
			{ error: "Email already in use" },
			{ status: 400 }
		);
	}

	// all checks have passed.
	// create new user and send back new JWT.

	const values = [
		body.email,
		body.first_name,
		body.last_name,
		body.password,
		body.birth_date,
		undefined,
		undefined,
	];
	await querySingle("CALL create_user($1, $2, $3, $4, $5, $6, $7)", values);

	const jwt = makeToken({
		user_id: values[5],
		authentication_id: values[6],
	});

	return NextResponse.json(jwt);
}
