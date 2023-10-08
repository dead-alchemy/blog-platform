"use client";
const Input = ({
	name,
	handleChange,
	label,
	value,
	type = "text",
	error,
	rest,
	id = "",
}) => {
	return (
		<div>
			<label htmlFor={name}>{label}</label>
			<input
				type={type}
				id={id ? id : name}
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
