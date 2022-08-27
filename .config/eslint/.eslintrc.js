module.exports = {
	env: {
		es2021: true,
		node: true
	},
	extends: ["eslint:recommended", "plugin:@typescript-eslint/recommended"],
	parser: "@typescript-eslint/parser",
	parserOptions: {
		ecmaVersion: "latest",
		sourceType: "module"
	},
	plugins: ["@typescript-eslint"],
	rules: {
		"no-duplicate-imports": "error",
		"no-irregular-whitespace": "warn",
		"no-unused-vars": ["warn", { argsIgnorePattern: "^_" }],
		camelcase: "warn",
		eqeqeq: "error",
		"no-var": "error",
		"prefer-const": "warn",
		"arrow-parens": "error",
		"comma-spacing": "error",
		indent: ["error", "tab", { SwitchCase: 1 }],
		"linebreak-style": ["error", "unix"],
		"max-len": ["warn", { code: 120 }],
		"no-trailing-spaces": "error",
		semi: ["error", "always"],
		"@typescript-eslint/no-non-null-assertion": "off",
		"@typescript-eslint/no-unused-vars": ["warn", { argsIgnorePattern: "^_" }],
		"@typescript-eslint/ban-ts-comment": "off",
	}
};
