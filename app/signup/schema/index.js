import * as Yup from "yup";
export const signupSchema = Yup.object().shape({
	first_name: Yup.string()
		.min(1, "Please provide a first name")
		.max(250, "Please provide a shortend name up to 250 characters")
		.required("A first name is required"),
	last_name: Yup.string()
		.min(1, "Please provide a last name")
		.max(250, "Please provide a shortend name up to 250 characters")
		.required("A lasts name is required"),
	email: Yup.string().email("Invalid email").required("Required"),
	password: Yup.string()
		.min(8, "A password must be at least 8 characters")
		.required("Password is required"),
	password_validation: Yup.string().oneOf(
		[Yup.ref("password"), null],
		"Passwords must match"
	),
	birth_date: Yup.string().required("Please provide a birthday"),
});
