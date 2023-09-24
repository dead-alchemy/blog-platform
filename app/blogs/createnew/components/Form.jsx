"use client";

import { useFormik } from "formik";
import dynamic from "next/dynamic";

const Editor = dynamic(() => import("./Editor"), { ssr: false });

const Form = () => {
	const formik = useFormik({
		initialValues: {
			markdown: "# Hello",
		},
	});

	console.log(formik.values);

	return (
		<div styles={"width: 100vw"}>
			<Editor
				markdown={formik.values.markdown}
				handleChange={(value) => {
					formik.setFieldValue("markdown", value);
				}}
			/>
		</div>
	);
};

export default Form;
