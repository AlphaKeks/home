module.exports = {
	env: {
		es2021: true,
		node: true,
	},
	extends: ["eslint:recommended", "plugin:@typescript-eslint/recommended"],
	parser: "@typescript-eslint/parser",
	parserOptions: {
		ecmaVersion: "latest",
		sourceType: "module",
	},
	plugins: ["@typescript-eslint"],
	rules: {
		"camelCase": "warn",
		"eqeqeq": "error",
		"semi": ["error", "always"],
		"indent": ["error", "tab", { "SwitchCase": 1 }],
		"linebreak-style": ["error", "unix"],
		"no-unused-vars": ["warn", { "argsIgnorePattern": "^_" }],
		"prefer-const": "warn",
		"max-len": ["warn", { "code": 100 }],
		"@typescript-eslint/no-unused-vars": ["warn", { "argsIgnorePattern": "^_" }],
		"@typescript-eslint/no-non-null-assertion": "off",
		"@typescript-eslint/ban-ts-comment": "off",
	},
};
