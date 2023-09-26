"use client";

import { useFormik } from "formik";
import { Input } from "@/app/components";
import dynamic from "next/dynamic";
import { newBlogSchema } from "@/lib/schemas";

const Editor = dynamic(() => import("./Editor"), { ssr: false });

const Form = () => {
	const formik = useFormik({
		initialValues: {
			title: "",
			markdown: "",
		},
		validateOnBlur: false,
		validateOnChange: false,
		validationSchema: newBlogSchema,
		onSubmit: async (values) => {
			await fetch("/api/blog/create", {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
				},
				body: JSON.stringify(values),
			})
				.then(async (res) => {
					const data = JSON.parse(await res.text());
					alert(data);
				})
				.catch((error) => {
					console.log(error);
				});
		},
	});

	return (
		<div styles={"width: 100vw"}>
			<Input
				name="title"
				label={"Blog Title"}
				error={formik.errors.title}
				handleChange={formik.handleChange}
			/>
			{formik.errors.markdown && <div>{formik.errors.markdown}</div>}
			<Editor
				markdown={formik.values.markdown}
				handleChange={(value) => {
					formik.setFieldValue("markdown", value);
				}}
			/>
			<button type="submit" onClick={formik.handleSubmit}>
				Create
			</button>
		</div>
	);
};

export default Form;
