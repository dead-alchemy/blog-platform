import { cookies } from "next/headers";
import { redirect } from "next/navigation";

import style from "./page.module.scss";

const Blogs = async () => {
	async function getData() {
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

		if (res.status !== 200) {
			redirect("/signin");
		}

		let data = await res.json();

		return data;
	}

	const { rows } = await getData();

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
