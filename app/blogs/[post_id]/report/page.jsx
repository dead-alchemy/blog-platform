const Report = ({ params }) => {
	return <div>{JSON.stringify(params, "", 2)}</div>;
};

export default Report;
