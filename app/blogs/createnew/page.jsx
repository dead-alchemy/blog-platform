import { Suspense } from "react";
import Form from "./components/Form";

const CreateNew = () => {
	return (
		<main>
			<h2>Create New Blog</h2>

			<Suspense fallback={null}>
				<Form />
			</Suspense>
		</main>
	);
};

export default CreateNew;
