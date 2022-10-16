DUMP = function(input)
	local file = io.open("output.txt", "w")

	io.output(file)
	io.write(vim.inspect(input))
end

require "alphakeks"
require "configs"
