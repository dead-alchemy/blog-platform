import { readCheckAuth } from "@/lib/functions";
import { cookies } from "next/headers";
import styles from "./nav.module.scss";
import NavItem from "./components/NavItem";

import { adminRoutes, authRoutes, regRoutes } from "@/lib/consts";

const Nav = async () => {
	const token = cookies().get("token");

	const { authenticated, admin_id } = await readCheckAuth(token?.value);

	const buildRoutes = () => {
		if (admin_id !== undefined) {
			return [...adminRoutes, ...authRoutes];
		}
		if (authenticated) {
			return [...authRoutes];
		} else {
			return [...regRoutes];
		}
	};

	return (
		<main className={styles.main}>
			<div className={styles.hero}>Blog Platform</div>
			<div className={styles.links}>
				{authenticated
					? buildRoutes().map((route) => (
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
