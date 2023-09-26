import { cookies } from "next/headers";

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

	const cookieStore = cookies();

	const newcookies = cookieStore.getAll().map((cookie) => (
		<div key={cookie.name}>
			<p>Name: {cookie.name}</p>
			<p>Value: {cookie.value}</p>
		</div>
	));

	return (
		<main>
			{JSON.stringify(
				cookies,
				{
					post_id: params.post_id,
					...data,
				},
				null,
				2
			)}

			{newcookies}
		</main>
	);
};

export default Post;
