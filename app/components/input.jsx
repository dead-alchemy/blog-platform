"use client";
const Input = ({
	name,
	handleChange,
	label,
	value,
	type = "text",
	error,
	rest,
}) => {
	return (
		<div>
			<label htmlFor={name}>{label}</label>
			<input
				type={type}
				id={name}
				name={name}
				onChange={handleChange}
				value={value}
				{...rest}
			/>
			{error?.length > 0 && <div>{error}</div>}
		</div>
	);
};

export default Input;
