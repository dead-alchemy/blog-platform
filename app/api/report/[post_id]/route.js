import { querySingle } from "@/lib/pg";
import { checkAuth } from "@/lib/functions";
import { NextResponse } from "next/server";
import { readToken } from "@/lib/functions/jwt";
import { newBlogSchema } from "@/lib/schemas";
import { cookies } from "next/headers";

export async function POST(req, { params }) {
	// get the body of our request.
	const body = await req.json();

	// if the requestor is not from a valid url return not authorized.

	// getting our current user id and auth_id from our token.
	const token = cookies().get("token");

	// now check if the current auth token is the most recently issued one.

	const jwt = readToken(token.value);

	const { authenticated } = await checkAuth(jwt);

	if (!authenticated) {
		return NextResponse.json({ error: "Not Authorized" }, { status: 401 });
	}

	querySingle(
		`INSERT INTO reports
			(user_id, post_id, ref_report_reason_id)
			VALUES
			($1, $2, $3)`,
		[jwt.user_id, params.post_id, body.report_reasons]
	);
	return NextResponse.json("Thank you for reporting.");
}
