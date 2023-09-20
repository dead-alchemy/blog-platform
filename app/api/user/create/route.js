import { signupSchema } from "@/lib/schemas";
import { query, querySingle } from "@/lib/pg";
import { validateURL } from "@/lib/functions";
import { NextResponse } from "next/server";

export async function POST(req) {
	//return NextResponse.json("hello");
	const requestURL = req.headers.get("referer");

	if (!validateURL(requestURL)) {
		return NextResponse.json(
			{ message: "Not Authorizedasdf" },
			{
				status: 401,
			}
		);
	}

	const body = await req.json();

	const parsedUrl = new URL(requestURL);

	if (parsedUrl.pathname.toLowerCase() !== "/signup") {
		return NextResponse.json(
			{ message: "Not Authorized" },
			{
				status: 401,
			}
		);
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
		return NextResponse.json(
			{ message: JSON.stringify(err) },
			{
				status: 400,
			}
		);
	}

	//email
	// first_name;
	// last_name;
	// password;
	// birth_date;

	const { email_check } = await querySingle(
		`
	select case count(*) 
		when 0 then true
		else false
		end as email_check
	from  blogplatform.public.users
	where email_address = $1
	`,
		[body.email]
	);

	console.log(email_check);

	if (email_check === false) {
		return NextResponse.json(
			{ message: "Email already in use" },
			{ status: 401 }
		);
	}

	const result = await querySingle(
		`
		WITH myconstants (salt) as (
		values (gen_salt('bf', 8))
		)

		insert into users
			(	email_address
			,	first_name
			,	last_name
			,	password_hash
			,	stored_salt
			,	birthdate
			)
		select	$1
			,	$2
			,	$3
			,	crypt($4, salt)
			,	salt
			,	$5
		from myconstants
		returning user_id
		`,
		[
			body.email,
			body.first_name,
			body.last_name,
			body.password,
			body.birth_date,
		]
	);

	return NextResponse.json(result);
}
