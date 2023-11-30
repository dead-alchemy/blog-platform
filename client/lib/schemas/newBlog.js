import * as Yup from "yup";

function isValidWordCount(message) {
	return this.test("isValidWorkCount", message, function (value) {
		const { path, createError } = this;

		if (!value) {
			return createError({
				path,
				message: message ?? "Must have content",
			});
		}
		if (value.replace(/^#+\s/g, "").split(" ").length < 500) {
			return createError({
				path,
				message: message ?? "Must be at least 500 words",
			});
		}

		return true;
	});
}

Yup.addMethod(Yup.mixed, "isValidWordCount", isValidWordCount);

export const newBlogSchema = Yup.object().shape({
	title: Yup.string()
		.min(10, "Please provide a title at least 10 characters long")
		.max(250, "Please shorten the title to no more than 250 characters")
		.required("A title is required"),
	markdown: Yup.mixed().isValidWordCount(),
});
