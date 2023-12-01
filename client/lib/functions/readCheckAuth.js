import { checkAuth } from "./checkAuth";
import { readToken } from "./jwt";

/**
 *
 * @param {string} token_value the value of the cookie token.
 * @returns {Promise<Object>} - A promise that resolves to an object containing the authentication status and, if applicable, the administrator's ID.
 *   - `authenticated`: A boolean indicating whether the user is authenticated.
 *   - `admin_id`: The administrator's ID if the user is an administrator, or `undefined` if not an administrator.
 * @returns
 *
 * @throws {Error} - Throws an error if the authentication check fails.
 * @example
 * const authenticationResult = await readCheckAuth(token?.value);
 * console.log(authenticationResult);
 * // {
 * //   authenticated: true,
 * //   admin_id: uuid // or undefined if not an admin
 * // }
 */

export const readCheckAuth = async (token_value) => {
	const result = await checkAuth(readToken(token_value));

	return result;
};
