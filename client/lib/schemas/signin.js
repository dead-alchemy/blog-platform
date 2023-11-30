import * as Yup from "yup";
export const signinSchema = Yup.object().shape({
	email: Yup.string().email("Invalid email").required("Required"),
	password: Yup.string()
		.min(8, "A password must be at least 8 characters")
		.required("Password is required"),
});
