local plenary = require 'plenary'

local cwd = vim.fn.expand('%:p:h')

local test = plenary.scandir.scan_dir(cwd, {
	hidden = true,
	search_pattern = 'eslint'
	-- search_pattern = 'penis'
})

print(vim.inspect({
	cwd = cwd,
	test = vim.inspect(test)
}))

if test[1] then
	print 'hello'
end
