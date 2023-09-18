"use client";
const Input = ({name, handleChange, label, value, type = "text", rest}) => {
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
		</div>
	);
};

export default Input;
