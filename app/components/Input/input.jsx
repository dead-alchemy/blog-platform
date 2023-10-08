"use client";

import styles from "./input.module.scss";
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
		<div className={type === "radio" ? styles.radio : styles.input}>
			<label htmlFor={name}>{label}</label>
			<input
				type={type}
				id={id ? id : name}
				name={name}
				onChange={handleChange}
				value={value}
				{...rest}
			/>
			{error?.length > 0 && <div className={styles.error}>{error}</div>}
		</div>
	);
};

export default Input;
