import { passwordChangeSchema } from "@/lib/schemas";
import { querySingle } from "@/lib/pg";
import { NextResponse } from "next/server";
import { makeToken, readToken } from "@/lib/functions/jwt";
import { cookies } from "next/headers";
import { checkAuth } from "@/lib/functions";

export async function POST(req) {
	const body = await req.json();
	const token = cookies().get("token");

	const { authenticated } = await checkAuth(readToken(token?.value));
	const { user_id } = readToken(token?.value);

	if (!authenticated) {
		return NextResponse.json({ error: "Not Authorized" }, { status: 401 });
	}

	await passwordChangeSchema
		.validate(body)
		.then(() => {
			return null;
		})
		.catch((err) => {
			console.log(err);

			return NextResponse.json(
				{ error: JSON.stringify(err.message) },
				{
					status: 400,
				}
			);
		});

	const values = [user_id, body.password, undefined];
	const jwt = await querySingle("CALL update_password ($1, $2, $3)", values)
		.then((result) => {
			const jwt = makeToken({
				user_id: result.p_user_id,
				authentication_id: result.p_authentication_id,
			});

			cookies().set({
				name: "token",
				value: JSON.stringify(jwt),
				httpOnly: true,
				path: "/",
			});

			return jwt;
		})
		.catch((error) => {
			return {
				status: 402,
				error: error.message,
			};
		});

	return NextResponse.json(jwt);
}
