import { checkAuth } from "@/lib/functions";
import { readToken } from "@/lib/functions/jwt";
import { cookies } from "next/headers";
const Nav = async () => {
	const token = cookies().get("token");

	const { authenticated } = await checkAuth(readToken(token?.value));

	if (authenticated) {
		return (
			<main>
				<div>Hello user</div>
			</main>
		);
	}

	return (
		<main>
			<div>Hello stranger</div>
		</main>
	);
};

export default Nav;
