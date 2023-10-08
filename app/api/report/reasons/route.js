import { query } from "@/lib/pg";
import { checkAuth } from "@/lib/functions";
import { NextResponse } from "next/server";
import { readToken } from "@/lib/functions/jwt";
import { cookies } from "next/headers";

export async function GET(req) {
	const token = cookies().get("token");

	const { authenticated } = await checkAuth(readToken(token.value));

	if (!authenticated) {
		return NextResponse.json({ error: "Not Authorized" }, { status: 401 });
	}

	const results = await query(
		`
		select 	ref_report_reason_id
			,	report_reason
			,	report_reason_desc
		from ref_report_reasons
		`
	);

	return NextResponse.json(results);
}
