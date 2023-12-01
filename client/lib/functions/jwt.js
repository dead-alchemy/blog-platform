import jwt from "jsonwebtoken";

/**
 * Creates a JSON Web Token (JWT) by encoding the provided payload using the specified secret key.
 *
 * @param {Object} payload - The data payload to be encoded in the JWT.
 * @returns {string} - The encoded JWT string.
 * @throws {Error} - Throws an error if the JWT encoding fails.
 *
 * @example
 * const userPayload = { user_id: 123, username: 'john_doe' };
 * const authToken = makeToken(userPayload);
 * console.log(authToken); // Encoded JWT string
 */
export const makeToken = (payload) => {
	const encodedJwt = jwt.sign(payload, process.env.JW_SECRET, {
		algorithm: "HS256",
	});

	return encodedJwt;
};

/**
 * Decodes a JSON Web Token (JWT) using the specified secret key.
 *
 * @param {string} token - The JWT string to be decoded.
 * @returns {Object|Error} - The decoded payload if the token is valid, or an Error object if the token is invalid.
 * @throws {Error} - Throws an error if the JWT decoding process encounters an issue other than token expiration.
 *
 * @example
 * const authToken = '...'; // Replace with an actual JWT string
 * const decodedPayload = readToken(authToken);
 * if (decodedPayload instanceof Error) {
 *   console.error(decodedPayload.message); // Handle the error
 * } else {
 *   console.log(decodedPayload); // Decoded JWT payload
 * }
 */
export const readToken = (token) => {
	try {
		const decodedPayload = jwt.verify(
			JSON.parse(token),
			process.env.JW_SECRET,
			{
				algorithms: ["HS256"],
			}
		);
		return decodedPayload;
	} catch (error) {
		if (error.name === "TokenExpiredError") {
			return new Error("Token has expired.");
		} else {
			return new Error("Invalid token or signature.");
		}
	}
};
