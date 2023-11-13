import { signinSchema } from "@/lib/schemas";
import { querySingle } from "@/lib/pg";
import { NextResponse } from "next/server";
import { makeToken } from "@/lib/functions/jwt";
import { cookies } from "next/headers";

// signing in a single user.
export async function POST(req) {
	// get the body of our request.
	const body = await req.json();

	// validate the data from the sign up with the same schema
	// from the front end.
	await signinSchema
		.validate(body)
		.then(() => {
			return null;
		})
		.catch((err) => {
			console.log(err);

			return NextResponse.json(
				{ error: JSON.stringify(err.message) },
				{
					status: 400,
				}
			);
		});

	const values = [body.email, body.password, undefined, undefined];
	const jwt = await querySingle(
		"CALL validate_and_insert_authentication($1, $2, $3, $4)",
		values
	)
		.then((result) => {
			console.log(result);
			const jwt = makeToken({
				user_id: result.p_user_id,
				authentication_id: result.p_authentication_id,
			});

			cookies().set({
				name: "token",
				value: JSON.stringify(jwt),
				httpOnly: true,
				path: "/",
			});

			return jwt;
		})
		.catch((error) => {
			return {
				status: 402,
				error: error.message,
			};
		});

	return NextResponse.json(jwt);
}
