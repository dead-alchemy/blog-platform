import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import ReactMarkdown from "react-markdown";
import { query, querySingle } from "@/lib/pg";
import { checkAuth } from "@/lib/functions";
import { readToken } from "@/lib/functions/jwt";

import styles from "./page.module.scss";
import { getBlog } from "@/lib/models.js/getBlog";

const Post = async ({ params }) => {
	const token = cookies().get("token");

	const { authenticated } = await checkAuth(readToken(token?.value));

	if (!authenticated) {
		redirect("/signin");
	}

	const { post_id } = params;

	const blog = await getBlog(post_id);

	const reportReasons = await query(
		`
	select r.ref_report_reason_id
		,	report_reason
		,	count(report_id) as reports
	from reports r
	join ref_report_reasons rrr
		on rrr.ref_report_reason_id = r.ref_report_reason_id
	where post_id = $1

	group by r.ref_report_reason_id
		,	report_reason`,
		[post_id]
	);

	return (
		<main>
			<div className={styles.content}>
				<table>
					<thead>
						<tr>
							<th style={{ textAlign: "left" }}>Report Reason</th>
							<th style={{ paddingRight: "1rem" }}>
								Times Reported
							</th>
						</tr>
					</thead>
					<tbody>
						{reportReasons.rows.map((row) => (
							<tr key={row.ref_report_reason_id}>
								<td>{row.report_reason}</td>
								<td>{row.reports}</td>
							</tr>
						))}
					</tbody>
				</table>
				<div className={styles.title}>
					<h2>{blog.post_title}</h2>
					<h3
						style={{
							textAlign: "right",
							marginRight: ".5rem",
							paddingBottom: 0,
						}}
					>
						By{" "}
						<a href={"/profile/" + blog.user_id}>
							{`${blog.first_name} ${blog.last_name}`}
						</a>
					</h3>
					<h4
						style={{
							textAlign: "right",
							marginRight: ".5rem",
							paddingBottom: 0,
						}}
					>
						Published on {blog.created_dttm.toLocaleDateString()}
					</h4>
				</div>

				<ReactMarkdown children={blog.post_content} />

				<div className={styles.actions}>
					<div>
						<form action={`/admin/${params.post_id}/delete`}>
							<input
								className={styles.delete}
								type="submit"
								value="Delete This Content"
							/>
						</form>
					</div>
					<div>
						<form action={`/admin/${params.post_id}/ok`}>
							<input
								className={styles.ok}
								type="submit"
								value="Content Ok"
							/>
						</form>
					</div>
				</div>
			</div>
		</main>
	);
};

export default Post;
