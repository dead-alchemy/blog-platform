"use client";
import React from "react";
import { useFormik } from "formik";
import { Input } from "app/components";
import { signinSchema } from "@/lib/schemas";
import { useRouter } from "next/navigation";

import styles from "./form.module.scss";

const SignInForm = () => {
	const router = useRouter();
	// Pass the useFormik() hook initial form values and a submit function that will
	// be called when the form is submitted
	const inputs = [
		{
			name: "email",
			label: "Email",
			initValue: "",
			type: "email",
		},
		{
			name: "password",
			label: "Password",
			initValue: "",
			type: "password",
			autocomplete: "password",
		},
	];

	const initialValues = {};

	inputs.forEach(({ name, initValue }) => {
		initialValues[name] = initValue;
	});

	const formik = useFormik({
		initialValues,
		validationSchema: signinSchema,
		validateOnBlur: false,
		validateOnChange: false,
		onSubmit: async (values) => {
			await fetch("/api/user/signin", {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
				},
				body: JSON.stringify(values),
			})
				.then(async (res) => {
					const data = JSON.parse(await res.text());

					if (data.status === 400) {
						formik.setErrors({ email: data.error });
						return;
					}

					if (data.status === 402) {
						formik.setErrors({ email: data.error });
						return;
					}
					window.location.replace("/blogs");
				})
				.catch((error) => {
					console.log(error);
				});
		},
	});
	return (
		<div className={styles.page}>
			<form onSubmit={formik.handleSubmit}>
				{inputs.map((input) => (
					<Input
						key={input.name}
						handleChange={formik.handleChange}
						value={formik.values[input.name]}
						label={input.label}
						name={input.name}
						error={formik.errors[input.name]}
						{...input}
					/>
				))}
				<button type="submit">Submit</button>
			</form>
		</div>
	);
};

export default SignInForm;
