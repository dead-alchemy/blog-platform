"use client";
import { useState } from "react";
import { useFormik } from "formik";
import { Input } from "@/app/components";

const Form = ({ report_reasons, post_id }) => {
	const [submitted, setSubmitted] = useState(false);

	const formik = useFormik({
		initialValues: {
			report_reasons: 0,
			post_id,
		},
		onSubmit: async (values) => {
			await fetch(`/api/report/${post_id}`, {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
				},
				body: JSON.stringify(values),
			})
				.then(async (res) => {
					const data = JSON.parse(await res.text());
					setSubmitted(data);
				})
				.catch((error) => {
					console.log(error);
				});
		},
	});

	if (!submitted) {
		return (
			<div>
				{report_reasons.map((report) => (
					<Input
						key={report.ref_report_reason_id}
						type={"radio"}
						name={"report_reasons"}
						id={report.report_reason.replace(" ", "_")}
						value={report.ref_report_reason_id}
						label={report.report_reason}
						handleChange={formik.handleChange}
					/>
				))}

				<button type="submit" onClick={formik.handleSubmit}>
					Submit
				</button>
			</div>
		);
	}

	return <div>Thank you for reporting</div>;
};

export default Form;
