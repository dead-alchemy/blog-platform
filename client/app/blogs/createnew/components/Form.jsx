"use client";

import { useFormik } from "formik";
import { Input } from "@/app/components";
import dynamic from "next/dynamic";
import { newBlogSchema } from "@/lib/schemas";
import { redirect } from "next/navigation";

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
			}).then(async (res) => {
				const data = JSON.parse(await res.text());
				window.location.replace(`/blogs/${data}`);
			});
			// .catch((error) => {
			// 	console.log(error);
			// });
		},
	});

	return (
		<div style={{ width: "100vw" }}>
			<div>
				<Input
					name="title"
					label={"Blog Title"}
					error={formik.errors.title}
					handleChange={formik.handleChange}
				/>
			</div>
			{formik.errors.markdown && <div>{formik.errors.markdown}</div>}
			<div style={{ background: "white" }}>
				<Editor
					markdown={formik.values.markdown}
					handleChange={(value) => {
						formik.setFieldValue("markdown", value);
					}}
				/>
			</div>
			<button
				style={{ marginTop: ".5rem" }}
				type="submit"
				onClick={formik.handleSubmit}
			>
				Create
			</button>
		</div>
	);
};

export default Form;
