import { query } from "@/lib/pg";
import { readCheckAuth } from "@/lib/functions";
import { NextResponse } from "next/server";
import { cookies } from "next/headers";

export async function GET(req) {
	const token = cookies().get("token");

	const { authenticated } = await readCheckAuth(token?.value);

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
