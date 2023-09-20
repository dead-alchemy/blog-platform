"use client";
import React from "react";
import { useFormik } from "formik";
import { Input } from "app/components";
import { signupSchema } from "@/lib/schemas";

const SignUpForm = () => {
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
			name: "first_name",
			label: "First Name",
			initValue: "",
			type: "text",
		},
		{
			name: "last_name",
			label: "Last Name",
			initValue: "",
			type: "text",
		},
		{
			name: "password",
			label: "Password",
			initValue: "",
			type: "password",
			autocomplete: "new-password",
		},
		{
			name: "password_validation",
			label: "Reenter Password",
			initValue: "",
			type: "password",
			autocomplete: "new-password",
		},
		{
			name: "birth_date",
			label: "Your Birthday",
			initValue: "",
			type: "date",
		},
	];

	const initialValues = {};

	inputs.forEach(({ name, initValue }) => {
		initialValues[name] = initValue;
	});

	const formik = useFormik({
		initialValues,
		validationSchema: signupSchema,
		validateOnBlur: false,
		validateOnChange: false,
		onSubmit: async (values) => {
			alert(JSON.stringify(values, null, 2));
			const res = await fetch("/api/user/create", {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
				},
				body: JSON.stringify(values),
			});

			if (res.status === 400) {
				formik.setErrors({ email: "Email already used." });
				return;
			}

			if (res.status === 200) {
				alert("user created");
			}
		},
	});
	return (
		<form onSubmit={formik.handleSubmit}>
			{JSON.stringify(formik.errors, null, 2)}
			{JSON.stringify(formik.values, null, 2)}
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
	);
};

export default SignUpForm;
