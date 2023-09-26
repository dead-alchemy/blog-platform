import { cookies } from "next/headers";

async function getData(post_id) {
	const getCookie = async (name) => {
		return cookies().get(name)?.value ?? "";
	};

	const cookie = await getCookie("token");

	const res = await fetch(`http://127.0.0.1:3000/api/blog/`, {
		headers: {
			Cookie: `token=${cookie};`,
		},
	});
	// The return value is *not* serialized
	// You can return Date, Map, Set, etc.

	let data = await res.json();
	return data;
}

const Blogs = async () => {
	const { rows } = await getData();

	return (
		<main>
			<h2>Blogs</h2>

			<div>
				{rows.map((row) => (
					<div key={row.post_id}>
						<span>{row.post_title}</span>
						<span>{row.first_name + " " + row.last_name}</span>
					</div>
				))}
			</div>
		</main>
	);
};

export default Blogs;
