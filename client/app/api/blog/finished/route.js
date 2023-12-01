import { querySingle } from "@/lib/pg";
import { readCheckAuth } from "@/lib/functions";
import { NextResponse } from "next/server";
import { cookies } from "next/headers";

export async function POST(req) {
	// get the body of our request.
	const token = cookies().get("token");

	const { authenticated } = await readCheckAuth(token.value);

	if (!authenticated) {
		return NextResponse.json({ error: "Not Authorized" }, { status: 401 });
	}

	const { post_id } = await req.json();

	// increment blog counter by 1.
	await querySingle(
		`
		update posts
			set finished = finished + 1
		where post_id = $1
	`,
		[post_id]
	);

	return NextResponse.json({ status: 200 });
}
