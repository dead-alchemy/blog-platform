import { checkAuth } from "@/lib/functions";
import { readToken } from "@/lib/functions/jwt";
import { query, querySingle } from "@/lib/pg";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

import styles from "./page.module.scss";

const Profile = async () => {
	const token = cookies().get("token");

	const { authenticated, admin_id } = await checkAuth(
		readToken(token?.value)
	);

	if (!authenticated) {
		redirect("/signin");
	}

	if (!admin_id) {
		redirect("/");
	}

	const { rows } = await query(`
	select 	p.post_id
		,	p.user_id
		,	p.post_title
		,	count(r.report_id) as reports
		,	min(r.created_dttm) as first_report
	from posts p

	join reports r
		on p.post_id = r.post_id
		and r.is_deleted = false
		
	join ref_report_reasons rrr
		on rrr.ref_report_reason_id = r.ref_report_reason_id

	where p.is_deleted = false
		
	group by p.post_id
		,	p.user_id
		,	p.post_title
	`);

	return (
		<main className={styles.container}>
			<h3>Admin / Reported Blogs</h3>
			<div className={styles.row_container}>
				{rows.length ? (
					<table>
						<thead>
							<tr>
								<th style={{ textAlign: "left" }}>Blog Name</th>
								<th style={{ paddingRight: "1rem" }}>
									Times Reported
								</th>
								<th style={{ paddingRight: "1rem" }}>
									First Report
								</th>
							</tr>
						</thead>
						<tbody>
							{rows.map((row) => (
								<tr key={row.post_id}>
									<td>
										<a href={`/admin/${row.post_id}`}>
											{row.post_title}
										</a>
									</td>
									<td>{row.reports}</td>
									<td>
										{row.first_report.toLocaleDateString()}
									</td>
								</tr>
							))}
						</tbody>
					</table>
				) : (
					<div>Nothing Reported!</div>
				)}
			</div>
		</main>
	);
};

export default Profile;
