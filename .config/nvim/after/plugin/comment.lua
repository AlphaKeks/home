-- COMMENTING : comment
local comment_status, comment = pcall(require, "Comment")
if (not comment_status) then
	print("Comment failed to load")
	return
end

comment.setup {
	pre_hook = function(ctx)
		local U = require("Comment.utils")
		local type = ctx.type == U.ctype.linewise and "__default" or "__multiline"
		local location = nil

		if ctx.ctype == U.ctype.block then
			location = require("ts_context_commentstring.utils").get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = require("ts_context_commentstring.utils").get_visual_start_location()
		end

		return require("ts_context_commentstring.internal").calculate_commentstring({
			key = type,
			location = location
		})
	end
}
