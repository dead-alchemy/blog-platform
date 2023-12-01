import { querySingle } from "../pg";

/**
 * Checks the authentication status and, if applicable, identifies the user as an administrator.
 *
 * @async
 * @function
 * @param {Object} authData - The authentication data object.
 * @param {number} authData.user_id - The unique identifier of the user.
 * @param {number} authData.authentication_id - The unique identifier of the authentication session.
 * @returns {Promise<Object>} - A promise that resolves to an object containing the authentication status and, if applicable, the administrator's ID.
 *   - `authenticated`: A boolean indicating whether the user is authenticated.
 *   - `admin_id`: The administrator's ID if the user is an administrator, or `undefined` if not an administrator.
 * @throws {Error} - Throws an error if the authentication check fails.
 *
 * @example
 * const authenticationResult = await checkAuth({
 *   user_id: 123,
 *   authentication_id: 456,
 * });
 * console.log(authenticationResult);
 * // {
 * //   authenticated: true,
 * //   admin_id: uuid // or undefined if not an admin
 * // }
 */
export const checkAuth = async ({ user_id, authentication_id }) => {
	const values = [user_id, authentication_id, undefined];

	const { authenticated } = await querySingle(
		"call check_auth($1, $2, $3)",
		values
	);

	const adminResults = await querySingle(
		`select admin_id
		from admins
		where user_id = $1
		and current_date between start_dt and coalesce(current_date, end_dt)`,
		[user_id]
	);

	if (authenticated === null) {
		return { authenticated: false };
	}

	if (adminResults?.admin_id) {
		return {
			authenticated,
			admin_id: adminResults?.admin_id,
		};
	}

	return { authenticated };
};
