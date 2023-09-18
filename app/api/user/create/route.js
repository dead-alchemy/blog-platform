import { NextResponse } from "next/server";
import { signupSchema } from "@/lib/schemas";
import { query } from "@/lib/pg";

export async function POST(req) {
	//return NextResponse.json("hello");
	const parsedUrl = new URL(req.headers.get("referer"));

	const body = await req.json();

	if (parsedUrl.pathname.toLowerCase() !== "/signup") {
		return NextResponse.status(401).json("Not Authorized");
	}

	const validation = await signupSchema
		.validate(body)
		.then(() => {
			return null;
		})
		.catch((err) => {
			console.log(err);

			return err;
		});

	if (validation !== null) {
		return NextResponse.status(400).json(err);
	}

	//email
	// first_name;
	// last_name;
	// password;
	// birth_date;

	const result = await query("select $1, $2, $3, $4, $5", [
		body.email,
		body.first_name,
		body.last_name,
		body.password,
		body.birth_date,
	]);

	return NextResponse.json(result);
}
