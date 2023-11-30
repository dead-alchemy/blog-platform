import SignInForm from "./components/form";
import { cookies } from "next/headers";

const SignIn = () => {
	return (
		<main>
			<h1>Sign In</h1>
			<SignInForm />
		</main>
	);
};

export default SignIn;
