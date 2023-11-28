import { checkAuth } from "@/lib/functions";
import { readToken } from "@/lib/functions/jwt";
import { cookies, headers } from "next/headers";
import styles from "./nav.module.scss";
import Link from "next/link";
import NavItem from "./components/NavItem";

const Nav = async () => {
	const token = cookies().get("token");

	const { authenticated } = await checkAuth(readToken(token?.value));

	const authRoutes = [
		{ name: "Blogs", pathname: "/blogs" },
		{ name: "Profile", pathname: "/profile" },
		{ name: "New Blog", pathname: "/blogs/createnew" },
		{ name: "Sign Out", pathname: "/signout" },
		,
	];
	const regRoutes = [
		{ name: "Sign Up", pathname: "/signup" },
		{ name: "Sign In", pathname: "/signin" },
	];

	return (
		<main className={styles.main}>
			<div className={styles.hero}>Blog Platform</div>
			<div className={styles.links}>
				{authenticated
					? authRoutes.map((route) => (
							<NavItem key={route.pathname} {...route} />
					  ))
					: regRoutes.map((route) => (
							<NavItem key={route.pathname} {...route} />
					  ))}
			</div>
		</main>
	);
};

export default Nav;
