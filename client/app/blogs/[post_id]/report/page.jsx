import { cookies } from "next/headers";
import Form from "./components/Form";
import styles from "./page.module.scss";
import { redirect } from "next/navigation";
import { query } from "@/lib/pg";
import { readCheckAuth } from "@/lib/functions";

const Report = async ({ params }) => {
	const token = cookies().get("token");

	const { authenticated } = await readCheckAuth(token?.value);

	if (!authenticated) {
		redirect("/signin");
	}

	const { rows } = await query(
		`
		select 	ref_report_reason_id
			,	report_reason
			,	report_reason_desc
		from ref_report_reasons
		`
	);

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
