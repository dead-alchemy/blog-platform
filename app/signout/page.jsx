const SignOut = async () => {
	const signOut = async () =>
		await fetch("http://localhost:3000/api/user/signout", {
			method: "get",
			credentials: "include",
		});

	const res = await signOut();

	console.log(res);

	return <div>Signed Out!</div>;
};

export default SignOut;
