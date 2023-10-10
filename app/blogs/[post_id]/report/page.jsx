import { cookies } from "next/headers";
import Form from "./components/Form";
import styles from "./page.module.scss";
import { redirect } from "next/navigation";

const Report = async ({ params }) => {
	const getData = async () => {
		const getCookie = async (name) => {
			return cookies().get(name)?.value ?? "";
		};

		const cookie = await getCookie("token");

		const res = await fetch(`http://127.0.0.1:3000/api/report/reasons/`, {
			headers: {
				Cookie: `token=${cookie};`,
			},
		});

		if (res.status !== 200) {
			redirect("/signin");
		}

		let data = await res.json();

		return data;
	};

	const { rows } = await getData();

	return (
		<main>
			<div className={styles.main}>
				<h2>Report</h2>
				<p>Why would you like to report this content?</p>

				<Form report_reasons={rows} post_id={params.post_id} />
			</div>
		</main>
	);
};

export default Report;
