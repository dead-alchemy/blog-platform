import { querySingle } from "@/lib/pg";
import { checkAuth, validateURL } from "@/lib/functions";
import { NextResponse } from "next/server";
import { readToken } from "@/lib/functions/jwt";

// signing up a single user.
export async function GET(req, { params }) {
	// get the body of our request.
	const { post_id } = params;

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

	const result = await querySingle(
		`
		select	post_title
			,	post_content
			,	p.created_dttm
			,	u.last_name
			,	u.first_name
		from posts p
		
		join users u
			on p.user_id = u.user_id

		where is_deleted = false
		and post_id = $1

	`,
		[post_id]
	);

	console.log(result.title);
	return NextResponse.json(result);
}
