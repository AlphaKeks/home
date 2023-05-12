local icons = {
  expanded = "",
  collapsed = "",
  border = "|",
}

local function not_in_fold()
  return vim.fn.foldlevel(vim.v.lnum) <= 0
end

local function not_fold_start()
  local line = vim.v.lnum
  return vim.fn.foldlevel(line) <= vim.fn.foldlevel(line - 1)
end

local function fold_opened()
  return vim.fn.foldclosed(vim.v.lnum) == -1
end

local highlights_cache = {}

vim.api.nvim_set_hl(0, "FoldIcon", { fg = "#7f849c" })

local function git_signs()
  local sign = vim.fn.sign_getplaced(
    vim.api.nvim_get_current_buf(),
    {
      group = "gitsigns_vimfn_signs_",
      lnum = vim.v.lnum
    }
  )[1].signs[1]

  if sign then
    if not highlights_cache[sign.name] then
      highlights_cache[sign.name] = vim.fn.sign_getdefined(sign.name)[1].texthl
    end

    return string.format(
      "%%#%s#%s",
      highlights_cache[sign.name], icons.border
    )
  else
    return ""
  end
end

function StatusColumn()
  -- wrapped or virtual line
  if vim.v.virtnum ~= 0 then
    return ""
  end

  local icon = ""
  if not_in_fold() or not_fold_start() then
    icon = " "
  elseif fold_opened() then
    icon = icons.expanded
  else
    icon = icons.collapsed
  end

  local line = "%=%{v:relnum ? v:relnum : v:lnum}"

  return string.format("  %s %%s %%#FoldIcon#%s", line, icon)
end

vim.opt.statuscolumn = "%{%v:lua.StatusColumn()%} "
