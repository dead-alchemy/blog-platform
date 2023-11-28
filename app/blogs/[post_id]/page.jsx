import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import ReactMarkdown from "react-markdown";
import { querySingle } from "@/lib/pg";
import { checkAuth } from "@/lib/functions";
import { readToken } from "@/lib/functions/jwt";

import styles from "./page.module.scss";

const Post = async ({ params }) => {
	const token = cookies().get("token");

	const { authenticated } = await checkAuth(readToken(token?.value));

	if (!authenticated) {
		redirect("/signin");
	}

	const { post_id } = params;

	const data = await querySingle(
		`
		select	post_title
			,	post_content
			,	p.created_dttm
			,	u.last_name
			,	u.first_name
			,	u.user_id
		from posts p
		
		join users u
			on p.user_id = u.user_id

		where is_deleted = false
		and post_id = $1

	`,
		[post_id]
	);

	return (
		<main>
			<div className={styles.content}>
				<div className={styles.title}>
					<h2>{data.post_title}</h2>
					<h3
						style={{
							textAlign: "right",
							marginRight: ".5rem",
							paddingBottom: 0,
						}}
					>
						By{" "}
						<a href={"/profile/" + data.user_id}>
							{`${data.first_name} ${data.last_name}`}
						</a>
					</h3>
					<h4
						style={{
							textAlign: "right",
							marginRight: ".5rem",
							paddingBottom: 0,
						}}
					>
						Published on {data.created_dttm.toLocaleDateString()}
					</h4>
				</div>

				<ReactMarkdown children={data.post_content} />
				<form action={`/blogs/${params.post_id}/report`}>
					<input type="submit" value="Report This Content" />
				</form>
			</div>
		</main>
	);
};

export default Post;
