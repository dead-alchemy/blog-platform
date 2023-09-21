import jwt from "jsonwebtoken";

export const makeToken = (payload) => {
	const encodedJwt = jwt.sign(payload, process.env.JW_SECRET, {
		algorithm: "HS256",
	});

	return encodedJwt;
};

export const readToken = (token) => {
	try {
		const decodedPayload = jwt.verify(token, process.env.JW_SECRET, {
			algorithms: ["HS256"],
		});
		return decodedPayload;
	} catch (error) {
		if (error.name === "TokenExpiredError") {
			throw new Error("Token has expired.");
		} else {
			throw new Error("Invalid token or signature.");
		}
	}
};
