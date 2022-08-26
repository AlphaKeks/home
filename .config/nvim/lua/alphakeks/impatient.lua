-- LAZY LOADING : impatient
_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_modpaths',
  }
}

local impatient_status, impatient = pcall(require, "impatient")
if (not impatient_status) then
	print("impatient failed to load")
	return
end

impatient.enable_profile()
