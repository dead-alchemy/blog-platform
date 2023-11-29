"use client";
import { useEffect } from "react";

import { useRouter } from "next/navigation";

const SignOut = async () => {
	const router = useRouter();

	useEffect(() => {
		const signout = async () => {
			await fetch("/api/user/signout", {
				method: "GET",
				headers: {
					"Content-Type": "application/json",
				},
			}).then(window.location.replace("/"));
		};

		signout();
	}, []);

	return <></>;
};

export default SignOut;
