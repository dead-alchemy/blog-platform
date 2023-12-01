import { Pool } from "pg";

// creating a pool to connect.
// pg smartly assigns resouces to the pools avaliable.
const pool = new Pool({
	host: "db",
	port: process.env.PG_PORT,
	database: process.env.PG_DATABASE,
	user: process.env.PG_USER,
	password: process.env.PG_PASSWORD,
});

pool.on("error", (err) => {
	console.error("There was an error!", err.stack);
});

/**
 * Executes a SQL query using the provided query string and optional values.
 *
 * @async
 * @function
 * @param {string} query - The SQL query string to be executed.
 * @param {Array<*>} [values=[]] - An optional array of parameter values to be used in the query.
 * @returns {Promise<{ rows: Array<Object>, rowCount: number }>} - A promise that resolves to an object containing the query result.
 *   - `rows`: An array of objects representing the result rows.
 *   - `rowCount`: The number of rows affected by the query.
 * @throws {Error} - Throws an error if the query execution fails.
 *
 * @example
 * const result = await query('SELECT * FROM users WHERE id = $1', [userId]);
 * console.log(result.rows); // Array of user objects
 * console.log(result.rowCount); // Number of rows affected
 */
export const query = async (query, values = []) => {
	const result = await pool.query(query, values);

	return {
		rows: result.rows,
		rowCount: result.rowCount,
	};
};

/**
 * Executes a SQL query and returns the first row of the result.
 *
 * @async
 * @function
 * @param {string} query - The SQL query string to be executed.
 * @param {Array<*>} [values=[]] - An optional array of parameter values to be used in the query.
 * @returns {Promise<Object|null>} - A promise that resolves to the first row of the query result or `null` if no rows are returned.
 * @throws {Error} - Throws an error if the query execution fails.
 *
 * @example
 * const user = await querySingle('SELECT * FROM users WHERE id = $1', [userId]);
 * console.log(user); // The first user object or null if not found
 */
export const querySingle = async (query, values = []) => {
	const result = await pool.query(query, values);

	return result.rows[0];
};
