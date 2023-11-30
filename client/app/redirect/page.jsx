"use client";

import { redirect } from "next/navigation";

const Redirect = ({ searchParams }) => {
	if (searchParams?.url) {
		setTimeout(() => {}, 100);

		redirect(searchParams?.url);
	} else {
		redirect("/");
	}
};

export default Redirect;
