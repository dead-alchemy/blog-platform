import { signinSchema } from "@/lib/schemas";
import { querySingle } from "@/lib/pg";
import { NextResponse } from "next/server";
import { makeToken } from "@/lib/functions/jwt";

// signing in a single user.
export async function POST(req) {
	// get the body of our request.
	const body = await req.json();

	// validate the data from the sign up with the same schema
	// from the front end.
	const validation = await signinSchema
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

	const values = [body.email, body.password, undefined, undefined];
	const result = await querySingle(
		"CALL validate_and_insert_authentication($1, $2, $3, $4)",
		values
	);
	const jwt = makeToken({
		user_id: result.p_user_id,
		authentication_id: result.p_authentication_id,
	});

	return NextResponse.json(jwt);
}
