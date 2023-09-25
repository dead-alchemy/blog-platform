import { querySingle } from "@/lib/pg";
import { checkAuth, validateURL } from "@/lib/functions";
import { NextResponse } from "next/server";
import { readToken } from "@/lib/functions/jwt";
import { newBlogSchema } from "@/lib/schemas";

// signing up a single user.
export async function POST(req) {
	// get the body of our request.
	const body = await req.json();

	const return_not_authorized = (bool) => {
		// if the requestor is not from a valid url return not authorized.
		if (bool) {
			return NextResponse.json(
				{ error: "Not Authorized" },
				{
					status: 401,
				}
			);
		}
	};

	// if the requestor is not from a valid url return not authorized.

	return_not_authorized(!req.cookies.get("token")?.value);

	// getting our current user id and auth_id from our token.
	const token = readToken(req.cookies.get("token")?.value);

	// now check if the current auth token is the most recently issued one.

	const { authenticated } = await checkAuth(token);

	return_not_authorized(!authenticated);

	const validated = await newBlogSchema
		.validate(body)
		.then(() => {
			return null;
		})
		.catch((err) => {
			console.log(err);

			return err;
		});

	// if validation failed, send back the error.
	if (validated !== null) {
		return NextResponse.json(
			{ error: JSON.stringify(err) },
			{
				status: 400,
			}
		);
	}

	const { post_id } = await querySingle(
		`
		insert into posts 
			(	user_id
			,	post_title
			,	post_content
			)
		values
			(	$1
			,	$2
			,	$3
			)
		returning post_id
	`,
		[token.user_id, body.title, body.markdown]
	);

	return NextResponse.json(post_id);
}
