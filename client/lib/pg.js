import { Pool } from "pg";

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
 * A query function to execute paramaterized queries to postgres
 * @param {String} query The query string. Params like $1, $2, etc.
 * @param {Array} values Array of the values for the query string.
 * @returns
 */
export const query = async (query, values = []) => {
	const result = await pool.query(query, values);

	return {
		rows: result.rows,
		rowCount: result.rowCount,
	};
};

export const querySingle = async (query, values = []) => {
	const result = await pool.query(query, values);

	return result.rows[0];
};
