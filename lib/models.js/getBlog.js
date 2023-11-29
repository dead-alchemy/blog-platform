import { querySingle } from "@/lib/pg";
export const getBlog = async (post_id) => {
	const result = await querySingle(
		`
	select	post_title
		,	post_content
		,	p.created_dttm
		,	u.last_name
		,	u.first_name
		,	u.user_id
	from posts p
	
	join users u
		on p.user_id = u.user_id

	where is_deleted = false
	and post_id = $1
`,
		[post_id]
	);

	console.log(result);
	return result;
};
