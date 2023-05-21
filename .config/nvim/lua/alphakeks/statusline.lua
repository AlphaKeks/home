vim.opt.showmode = false

local modes = {
  ['n']     = 'NORMAL',
  ['no']    = 'O-PENDING',
  ['nov']   = 'O-PENDING',
  ['noV']   = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI']   = 'NORMAL',
  ['niR']   = 'NORMAL',
  ['niV']   = 'NORMAL',
  ['nt']    = 'NORMAL',
  ['ntT']   = 'NORMAL',
  ['v']     = 'VISUAL',
  ['vs']    = 'VISUAL',
  ['V']     = 'V-LINE',
  ['Vs']    = 'V-LINE',
  ['\22']   = 'V-BLOCK',
  ['\22s']  = 'V-BLOCK',
  ['s']     = 'SELECT',
  ['S']     = 'S-LINE',
  ['\19']   = 'S-BLOCK',
  ['i']     = 'INSERT',
  ['ic']    = 'INSERT',
  ['ix']    = 'INSERT',
  ['R']     = 'REPLACE',
  ['Rc']    = 'REPLACE',
  ['Rx']    = 'REPLACE',
  ['Rv']    = 'V-REPLACE',
  ['Rvc']   = 'V-REPLACE',
  ['Rvx']   = 'V-REPLACE',
  ['c']     = 'COMMAND',
  ['cv']    = 'EX',
  ['ce']    = 'EX',
  ['r']     = 'REPLACE',
  ['rm']    = 'MORE',
  ['r?']    = 'CONFIRM',
  ['!']     = 'SHELL',
  ['t']     = 'TERMINAL',
}

local function mode()
  local current_mode = vim.fn.mode()
  return (modes)[current_mode] or "UNK"
end

local function git_status()
  local git_status = ""

  if vim.b.gitsigns_head then
    git_status = string.format("%%#StatusGitBranch# %s", vim.b.gitsigns_head)
  end

  local function git_diff(type)
    local gsd = vim.b.gitsigns_status_dict

    if gsd and gsd[type] and gsd[type] > 0 then
      return tostring(gsd[type])
    end

    return ""
  end

  local added = git_diff("added")
  if added:len() > 0 then
    git_status = git_status .. " %#GitsignsAdd#+" .. tostring(added)
  end

  local changed = git_diff("changed")
  if changed:len() > 0 then
    git_status = git_status .. " %#GitsignsChange#~" .. tostring(changed)
  end

  local removed = git_diff("removed")
  if removed:len() > 0 then
    git_status = git_status .. " %#GitsignsDelete#-" .. tostring(removed)
  end

  return git_status
end

local function diagnostics()
  local diagnostics = ""

  local hints = vim.tbl_count(vim.diagnostic.get(0, { severity = 4 }))
  if hints > 0 then
    diagnostics = diagnostics .. "%#DiagnosticSignHint#" .. tostring(hints) .. "  "
  end

  local infos = vim.tbl_count(vim.diagnostic.get(0, { severity = 3 }))
  if infos > 0 then
    diagnostics = diagnostics .. "%#DiagnosticSignInfo#" .. tostring(infos) .. "  "
  end

  local warns = vim.tbl_count(vim.diagnostic.get(0, { severity = 2 }))
  if warns > 0 then
    diagnostics = diagnostics .. "%#DiagnosticSignWarn#" .. tostring(warns) .. "  "
  end

  local errors = vim.tbl_count(vim.diagnostic.get(0, { severity = 1 }))
  if errors > 0 then
    diagnostics = diagnostics .. "%#DiagnosticSignError#" .. tostring(errors) .. "  "
  end

  return diagnostics
end

local function lsp_info()
  local progress = vim.lsp.util.get_progress_messages()
  if not progress[1] then
    return ""
  end

  local message = progress[1].title or ""

  if progress[1].message then
    message = string.format("%s %s", message, progress[1].message)
  end

  if progress[1].percentage then
    message = string.format("%s (%s%%%%)", message, progress[1].percentage)
  end

  return "%#StatusMode#" .. message
end

function LeftStatusline()
  local sep = "%#StatusSeparator#█"
  local mode = "%#StatusMode# " .. mode()
  local git = git_status()
  return string.format("%s%s %s", sep, mode, git)
end

function RightStatusline()
  return string.format("%s %s %%#StatusSeparator#█", lsp_info(), diagnostics())
end

function Winbar()
  local path = vim.fn.expand("%:p:~")
  return string.format("%%#StatusWinbar#%s", path)
end

local dawn_installed, dawn = pcall(require, "dawn")

if dawn_installed then
  vim.api.nvim_set_hl(0, "StatusSeparator", { fg = dawn.palette.lavender })
  vim.api.nvim_set_hl(0, "StatusMode", { fg = dawn.palette.text, bold = true })
  vim.api.nvim_set_hl(0, "StatusGitBranch", { fg = dawn.palette.mauve })
  vim.api.nvim_set_hl(0, "StatusWinbar", { link = "WinBar" })
end

vim.opt.statusline = "%{%v:lua.LeftStatusline()%} %= %{%v:lua.RightStatusline()%}"
vim.opt.winbar = "%{%v:lua.Winbar()%}"
