import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import ReactMarkdown from "react-markdown";
import { querySingle } from "@/lib/pg";
import { readCheckAuth } from "@/lib/functions";

import styles from "./page.module.scss";
import { getBlog } from "@/lib/models.js/getBlog";
import ReachedBottom from "./components/read";

const Post = async ({ params }) => {
	const token = cookies().get("token");

	const { authenticated } = await readCheckAuth(token?.value);

	if (!authenticated) {
		redirect("/signin");
	}

	const { post_id } = params;

	const blog = await getBlog(post_id);

	// increment blog counter by 1.
	await querySingle(
		`
		update posts
			set views = views + 1
		where post_id = $1
	`,
		[post_id]
	);

	return (
		<main>
			<div className={styles.content}>
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
				<ReachedBottom post_id={params.post_id} />
				<form action={`/blogs/${params.post_id}/report`}>
					<input type="submit" value="Report This Content" />
				</form>
			</div>
		</main>
	);
};

export default Post;
