import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import ReactMarkdown from "react-markdown";

import styles from "./page.module.scss";

const Post = async ({ params }) => {
	const getData = async () => {
		const getCookie = async (name) => {
			return cookies().get(name)?.value ?? "";
		};

		const cookie = await getCookie("token");

		const res = await fetch(
			`http://127.0.0.1:3000/api/blog/${params.post_id}`,
			{
				headers: {
					Cookie: `token=${cookie};`,
				},
			}
		);

		if (res.status !== 200) {
			redirect("/signin");
		}

		let data = await res.json();

		return data;
	};

	const data = await getData();

	return (
		<main>
			<div className={styles.content}>
				<h2 className={styles.title}>{data.post_title}</h2>
				<ReactMarkdown children={data.post_content} />
				<form action={`/blogs/${params.post_id}/report`}>
					<input type="submit" value="Report This Content" />
				</form>
			</div>
		</main>
	);
};

export default Post;
