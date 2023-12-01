import { checkAuth } from "@/lib/functions";
import { readToken } from "@/lib/functions/jwt";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import { query } from "@/lib/pg";

import style from "./page.module.scss";

const Blogs = async () => {
	const token = cookies().get("token");

	const { authenticated } = await checkAuth(readToken(token?.value));

	if (!authenticated) {
		redirect("/signin");
	}

	const { rows } = await query(
		`
		select 	post_id
			,	post_title
			,	u.first_name
			, 	u.last_name
			,	p.created_dttm
		from posts p

		join users u
			on p.user_id = u.user_id
			
		where is_deleted = false

		order by  p.created_dttm desc
		limit 50
	`
	);

	return (
		<main className={style.main}>
			<h2>Blogs</h2>

			<div className={style.row_container}>
				{rows.map((row) => (
					<div key={row.post_id} className={style.row}>
						<div>
							<a href={`/blogs/${row.post_id}`}>
								{row.post_title}{" "}
							</a>
						</div>
						<div>{row.first_name + " " + row.last_name}</div>
					</div>
				))}
			</div>
		</main>
	);
};

export default Blogs;
