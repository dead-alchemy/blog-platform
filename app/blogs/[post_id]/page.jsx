import { cookies } from "next/headers";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";

async function getData(post_id) {
	const getCookie = async (name) => {
		return cookies().get(name)?.value ?? "";
	};

	const cookie = await getCookie("token");

	const res = await fetch(`http://127.0.0.1:3000/api/blog/${post_id}`, {
		headers: {
			Cookie: `token=${cookie};`,
		},
	});
	// The return value is *not* serialized
	// You can return Date, Map, Set, etc.

	let data = await res.json();
	return data;
}

const Post = async ({ params }) => {
	const data = await getData(params.post_id);

	return (
		<main>
			<h1>{data.post_title}</h1>
			<ReactMarkdown
				children={data.post_content}
				remarkPlugins={[remarkGfm]}
			/>
		</main>
	);
};

export default Post;
