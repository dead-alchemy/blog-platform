import { query } from "@/lib/pg";
import { checkAuth } from "@/lib/functions";
import { NextResponse } from "next/server";
import { readToken } from "@/lib/functions/jwt";
import { cookies } from "next/headers";

// getting a single post.
export async function GET(req, { params }) {
	// get the body of our request.
	const token = cookies().get("token");

	const { authenticated } = await checkAuth(readToken(token.value));

	if (!authenticated) {
		return NextResponse.body(
			{ error: "Not Authorized" },
			{
				status: 401,
			}
		);
	}

	const result = await query(
		`
		select 	post_id
			,	post_title
			,	u.first_name
			, 	u.last_name
			,	p.created_dttm
		from posts p

		join users u
			on p.user_id = u.user_id
			
		where is_deleted = false

		order by  p.created_dttm desc
		limit 25



	`
	);

	return NextResponse.json(result);
}
