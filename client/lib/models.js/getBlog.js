import { querySingle } from "@/lib/pg";

/**
 * Retrieves a blog post information.
 *
 * @async
 * @function
 * @param {number} post_id - The unique identifier of the blog post to retrieve.
 * @returns {Promise<Object|null>} - A promise that resolves to an object representing the blog post with author details, or `null` if the post is not found.
 * @throws {Error} - Throws an error if the retrieval process fails.
 *
 * @example
 * const blogPost = await getBlog(123);
 * console.log(blogPost);
 * // {
 * //   post_title: 'Sample Post',
 * //   post_content: 'This is the content of the post.',
 * //   created_dttm: '2023-01-01T12:34:56Z', // Date and time of post creation
 * //   last_name: 'Doe', // Author's last name
 * //   first_name: 'John', // Author's first name
 * //   user_id: 456 // Author's unique identifier
 * // }
 */
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

	return result;
};
