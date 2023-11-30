import { querySingle } from "../pg";

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
