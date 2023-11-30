import { checkAuth } from "@/lib/functions";
import { readToken } from "@/lib/functions/jwt";
import { query, querySingle } from "@/lib/pg";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

import styles from "./page.module.scss";
const Profile = async ({ params }) => {
	const { user_id } = params;
	const token = cookies().get("token");

	const { authenticated } = await checkAuth(readToken(token?.value));

	if (!authenticated) {
		redirect("/signin");
	}

	const { rows } = await query(
		`
	select 	post_id
		,	post_title
		,	p.created_dttm
	from posts p

	join users u
		on p.user_id = u.user_id
		
	where is_deleted = false
	and u.user_id = $1

	order by  p.created_dttm desc
	limit 25
	`,
		[user_id]
	);

	const userDetails = await querySingle(
		`
		SELECT 	first_name
			,	last_name
			,	email_address
			,	created_dttm
		FROM users
		where user_id = $1
		`,
		[user_id]
	);

	if (!userDetails.email_address) {
		redirect("/");
	}
	return (
		<main className={styles.main}>
			<h3>{`${userDetails.first_name} ${userDetails.last_name}`}</h3>
			<div>
				{rows.length > 0 ? (
					rows.map((row) => (
						<div key={row.post_id} className={styles.row}>
							<div>
								<a href={`/blogs/${row.post_id}`}>
									{row.post_title}
								</a>
							</div>
							<div>{row.created_dttm.toLocaleDateString()}</div>
						</div>
					))
				) : (
					<div>No Posts Yet!</div>
				)}
			</div>
		</main>
	);
};

export default Profile;
