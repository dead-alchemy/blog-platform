"use client";

import { redirect } from "next/dist/server/api-utils";
import styles from "../page.module.scss";
const ActionButton = ({ label, action, post_id }) => {
	const handleClick = async () => {
		await fetch(`/api/admin/blog`, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({
				action,
				post_id,
			}),
		}).then(() => {
			window.location.replace(`/admin`);
		});
	};

	return (
		<div>
			<button className={styles[action]} onClick={handleClick}>
				{label}
			</button>
		</div>
	);
};

export default ActionButton;
