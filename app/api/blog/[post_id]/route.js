import { querySingle } from "@/lib/pg";
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
		return NextResponse.json({ error: "Not Authorized" }, { status: 401 });
	}

	const { post_id } = params;
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

	return NextResponse.json(result);
}
