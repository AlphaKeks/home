-- INSTALLING STUFF : mason
local mason_status, mason = pcall(require, "mason")
if (not mason_status) then
	print("mason failed to load")
	return
end

mason.setup {}
