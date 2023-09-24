"use client";

import { useFormik } from "formik";
import { Input } from "@/app/components";
import dynamic from "next/dynamic";

const Editor = dynamic(() => import("./Editor"), { ssr: false });

const Form = () => {
	const formik = useFormik({
		initialValues: {
			title: "",
			markdown: "# Hello",
		},
	});

	return (
		<div styles={"width: 100vw"}>
			<Input
				name="title"
				label={"Blog Title"}
				handleChange={formik.handleChange}
			/>
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
