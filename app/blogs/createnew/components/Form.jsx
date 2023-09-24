"use client";

import { useFormik } from "formik";
import dynamic from "next/dynamic";

const Editor = dynamic(() => import("./Editor"), { ssr: false });

const Form = () => {
	const formik = useFormik({
		initialValues: {
			markdown: "# Hello",
		},
	});

	return (
		<div styles={"width: 100vw"}>
			<Editor markdown={formik.values.markdown} />
		</div>
	);
};

export default Form;
