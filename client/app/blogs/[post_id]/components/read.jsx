"use client";
import { useState, useEffect } from "react";

const usePageBottom = () => {
	const [reachedBottom, setReachedBottom] = useState(false);

	useEffect(() => {
		const handleScroll = () => {
			const offsetHeight = document.documentElement.offsetHeight;
			const innerHeight = window.innerHeight;
			const scrollTop = document.documentElement.scrollTop;

			const hasReachedBottom =
				offsetHeight - (innerHeight + scrollTop) <= 10;

			setReachedBottom(hasReachedBottom);
		};

		window.addEventListener("scroll", handleScroll);

		return () => window.removeEventListener("scroll", handleScroll);
	}, []);

	return reachedBottom;
};

const ReachedBottom = ({ post_id }) => {
	const reachedBottom = usePageBottom();
	const [postFinished, setPostFinished] = useState(false);

	useEffect(() => {
		console.log("hello");

		console.log(reachedBottom, !postFinished);

		const postFinish = async () => {
			console.log("Am I firing?");
			await fetch("/api/blog/finished/", {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
				},
				body: JSON.stringify(post_id),
			}).then(() => {
				setPostFinished(true);
			});
		};
		if (reachedBottom && !postFinished) {
			postFinish();
		}
	}, [reachedBottom, postFinished]);

	return <></>;
};

export default ReachedBottom;
