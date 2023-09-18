import {Client} from "pg";

const client = new Client({
	host: process.env.PG_HOST,
	port: process.env.PG_PORT,
	database: process.env.PG_DATABASE,
	user: process.env.PG_USER,
	password: process.env.PG_PASSWORD,
});

/**
 * A query function to execute paramaterized queries to postgres
 * @param {String} queryName The name of the query to be run.
 * @param {String} queryString The query string. Params like $1, $2, etc.
 * @param {Array} values Array of the values for the query string.
 * @returns
 */
const query = async (queryName, queryString, values = []) => {
	const query = {
		name: queryName,
		text: queryString,
		values: values,
		rowMode: "array",
	};
	const result = await client.query(query);

	client.on("error", (err) => {
		console.error("There was an error!", err.stack);
	});

	await client.end();

	return result;
};

module.exports = query;
