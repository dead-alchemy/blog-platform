import { querySingle } from "../pg";

export const checkAuth = async ({ user_id, authentication_id }) => {
	const values = [user_id, authentication_id, undefined];
	const { authenticated } = await querySingle(
		"call check_auth($1, $2, $3)",
		values
	);

	return { authenticated };
};
