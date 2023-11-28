import { querySingle } from "@/lib/pg";
import { checkAuth } from "@/lib/functions";
import { NextResponse } from "next/server";
import { readToken } from "@/lib/functions/jwt";
import { newBlogSchema } from "@/lib/schemas";
import { cookies } from "next/headers";

// signing up a single user.
export async function POST(req) {
	// get the body of our request.
	const body = await req.json();

	const token = cookies().get("token");

	// if the requestor is not from a valid url return not authorized.

	// getting our current user id and auth_id from our token.

	// now check if the current auth token is the most recently issued one.

	const { authenticated } = await checkAuth(readToken(token?.value));
	const { user_id } = readToken(token?.value);

	if (!authenticated) {
		return NextResponse.json({ error: "Not Authorized" }, { status: 401 });
	}

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
		[user_id, body.title, body.markdown]
	);

	return NextResponse.json(post_id);
}
