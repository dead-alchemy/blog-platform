import { NextResponse } from "next/server";

import { query } from "@/lib/pg";

export async function GET() {
	//return NextResponse.json("hello");
	const result = await query(
		"select CURRENT_TIMESTAMP as time, 'hello' as test, $1::text as param",
		["its me mario"]
	);

	return NextResponse.json(result);
}
