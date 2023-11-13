"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

import styles from "../nav.module.scss";

const NavItem = ({ pathname, name }) => {
	const path = usePathname();

	return (
		<Link
			className={
				path.toUpperCase() === pathname.toUpperCase()
					? styles.active
					: styles.link
			}
			href={pathname}
			key={pathname}
		>
			{name}
		</Link>
	);
};

export default NavItem;
