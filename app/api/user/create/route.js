import { signupSchema } from "@/lib/schemas";
import { querySingle } from "@/lib/pg";
import { validateURL } from "@/lib/functions";
import { NextResponse } from "next/server";

// signing up a single user.
export async function POST(req) {
	// get the url of the requestor
	const requestURL = req.headers.get("referer");

	// if the requestor is not from a valid url return not authorized.
	if (!validateURL(requestURL)) {
		return NextResponse.json(
			{ message: "Not Authorized" },
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
			{ message: "Not Authorized" },
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
			{ message: JSON.stringify(err) },
			{
				status: 400,
			}
		);
	}

	// check to see if an email is already used.
	const { email_check } = await querySingle(
		`
	select case count(*) 
		when 0 then true
		else false
		end as email_check
	from  blogplatform.public.users
	where email_address = $1
	`,
		[body.email]
	);

	// if the email is in use let the client know.
	if (!email_check) {
		return NextResponse.json(
			{ message: "Email already in use" },
			{ status: 400 }
		);
	}

	// all checks have passed.
	// create new user and send back new JWT.
	const result = await querySingle(
		`
		WITH myconstants (salt) as (
		values (gen_salt('bf', 8))
		)

		insert into users
			(	email_address
			,	first_name
			,	last_name
			,	password_hash
			,	stored_salt
			,	birthdate
			)
		select	$1
			,	$2
			,	$3
			,	crypt($4, salt)
			,	salt
			,	$5
		from myconstants
		returning user_id
		`,
		[
			body.email,
			body.first_name,
			body.last_name,
			body.password,
			body.birth_date,
		]
	);

	return NextResponse.json(result);
}
