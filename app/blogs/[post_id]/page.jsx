import { cookies } from "next/headers";
import jsCookies from "js-cookie";

const getCookie = async (name) => {
	return cookies().get(name)?.value ?? "";
};

async function getData(post_id) {
	const res = await fetch(`http://127.0.0.1:3000/api/blog/${post_id}`, {
		method: "GET",
		headers: {
			"Content-Type": "application/json",
			Cookie: getCookie("token"),
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
			{JSON.stringify(
				{
					jsCookies: jsCookies.get("token"),
					post_id: params.post_id,
					...data,
				},
				null,
				2
			)}
		</main>
	);
};

export default Post;
