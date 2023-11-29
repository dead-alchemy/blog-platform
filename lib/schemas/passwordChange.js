import * as Yup from "yup";
export const passwordChangeSchema = Yup.object().shape({
	password: Yup.string()
		.min(8, "A password must be at least 8 characters")
		.required("Password is required"),
	password_validation: Yup.string().oneOf(
		[Yup.ref("password"), null],
		"Passwords must match"
	),
});
