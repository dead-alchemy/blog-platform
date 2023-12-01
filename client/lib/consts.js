export const adminRoutes = [{ name: "Admin", pathname: "/admin" }];

/**
 * The routes avaliable to autheniticated users.
 */
export const authRoutes = [
	{ name: "Blogs", pathname: "/blogs" },
	{ name: "Profile", pathname: "/profile" },
	{ name: "New Blog", pathname: "/blogs/createnew" },
	{ name: "Sign Out", pathname: "/signout" },
];

/**
 * The routes avaliable to non-autheniticated users.
 */
export const regRoutes = [
	{ name: "Sign Up", pathname: "/signup" },
	{ name: "Sign In", pathname: "/signin" },
];
