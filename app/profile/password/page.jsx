import { Input } from "@/app/components";

import styles from "./page.module.scss";
import Form from "./components/Form";

const Page = () => {
	return (
		<div className={styles.main}>
			<h2>Change Password</h2>
			<Form />
		</div>
	);
};

export default Page;
