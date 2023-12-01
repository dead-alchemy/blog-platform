import { NextResponse } from "next/server";
import { cookies } from "next/headers";
import { querySingle } from "@/lib/pg";
import { readCheckAuth } from "@/lib/functions";

// signing up a single user.
export async function POST(req) {
	// get the body of our request.
	const { action, post_id } = await req.json();

	const token = cookies().get("token");

	const { authenticated, admin_id } = await readCheckAuth(token?.value);

	if (!authenticated || !admin_id) {
		return NextResponse.json({ error: "Not Authorized" }, { status: 401 });
	}

	if (action === "ok") {
		await querySingle(
			`
			update reports
				set is_deleted = true
			where post_id = $1
			`,
			[post_id]
		);

		return NextResponse.json("ok");
	}

	if (action === "delete") {
		await querySingle(
			`
			update posts
				set is_deleted = true
			where post_id = $1
			`,
			[post_id]
		);

		return NextResponse.json("deleted");
	}

	return NextResponse.json({ error: "No Action" }, { status: 400 });
}
