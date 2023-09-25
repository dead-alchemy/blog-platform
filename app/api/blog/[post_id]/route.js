import { querySingle } from "@/lib/pg";
import { checkAuth } from "@/lib/functions";
import { NextResponse } from "next/server";
import { readToken } from "@/lib/functions/jwt";

// signing up a single user.
export async function GET(req, { params }) {
	// get the body of our request.
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

	//console.log(result.post_title);
	return NextResponse.json(result);
}
