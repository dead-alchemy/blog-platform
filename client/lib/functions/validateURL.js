/**
 * Validates if a given string is a well-formed URL.
 *
 * @param {string} url - The URL string to be validated.
 * @returns {boolean} - `true` if the URL is valid, `false` otherwise.
 *
 * @example
 * const urlToValidate = 'https://www.example.com';
 * const isValid = validateURL(urlToValidate);
 * console.log(isValid); // true or false
 */
export const validateURL = (url) => {
	try {
		new URL(url);
		return true;
	} catch (err) {
		console.log(err);
		return false;
	}
};
