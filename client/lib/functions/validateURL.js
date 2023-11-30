export const validateURL = (url) => {
	try {
		new URL(url);
		return true;
	} catch (err) {
		console.log(err);
		return false;
	}
};
