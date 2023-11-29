"use client";

import { useFormik } from "formik";
import { passwordChangeSchema } from "@/lib/schemas";
import { Input } from "@/app/components";

const Form = () => {
	// Pass the useFormik() hook initial form values and a submit function that will
	// be called when the form is submitted
	const inputs = [
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
	];

	const initialValues = {};

	inputs.forEach(({ name, initValue }) => {
		initialValues[name] = initValue;
	});

	const formik = useFormik({
		initialValues,
		validationSchema: passwordChangeSchema,
		validateOnBlur: false,
		validateOnChange: false,
		onSubmit: async (values) => {
			await fetch("/api/user/password", {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
				},
				body: JSON.stringify(values),
			})
				.then(async (res) => {
					const data = JSON.parse(await res.text());
					if (res.status === 400) {
						formik.setErrors({ email: data.error });
						return;
					}
					alert("Password Updated");
					window.location.replace("/profile");
				})
				.catch((error) => {
					console.log(error);
				});
		},
	});
	return (
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
	);
};

export default Form;
