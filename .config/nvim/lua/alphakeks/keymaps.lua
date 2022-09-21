local M = {}

M.map = vim.keymap.set
M.def = { noremap = true, silent = true }

M.map('', '<Space>', '<Nop>', M.def) -- reset <Space>
vim.g.mapleader = ' ' -- set <Space> as leader key

M.map('n', '<C-s>', '<cmd>write<cr>', M.def)
M.map('n', '<C-w>', '<cmd>bdelete<cr>', M.def)
M.map('n', '<leader>r', ':%s/', { noremap = true })

M.map('n', 'U', '<C-r>', M.def)
M.map('n', 'x', '"_x', M.def)
M.map('n', 'dw', 'diw', M.def)
M.map('n', 'cw', 'ciw', M.def)
M.map('n', 'yw', 'yiw', M.def)
M.map('n', 'vw', 'viw', M.def)
M.map('n', 'cc', '"_cc', M.def)
M.map({ 'v', 'x' }, 'p', '"_dP', M.def)
M.map({ 'v', 'x' }, 'c', '"_c', M.def)
M.map('n', 'j', 'gj', M.def)
M.map('n', 'k', 'gk', M.def)

M.map({ 'n', 'v', 'x' }, '<leader>p', '"+p', M.def)
M.map({ 'n', 'v', 'x' }, '<leader>y', '"+y', M.def)

M.map('n', 'J', 'V:m \'>+1<cr>gv=gv<esc>', M.def)
M.map('n', 'K', 'V:m \'<-2<cr>gv=gv<esc>', M.def)
M.map({ 'v', 'x' }, 'J', ':m \'>+1<cr>gv=gv', M.def)
M.map({ 'v', 'x' }, 'K', ':m \'<-2<cr>gv=gv', M.def)
M.map('n', '>', '>>', M.def)
M.map('n', '<', '<<', M.def)
M.map({ 'v', 'x' }, '>', '>gv', M.def)
M.map({ 'v', 'x' }, '<', '<gv', M.def)

M.map({ 'n', 't' }, '<C-h>', '<C-w>h', M.def)
M.map({ 'n', 't' }, '<C-j>', '<C-w>j', M.def)
M.map({ 'n', 't' }, '<C-k>', '<C-w>k', M.def)
M.map({ 'n', 't' }, '<C-l>', '<C-w>l', M.def)
M.map({ 'n', 't' }, '<S-h>', '<cmd>bprevious<cr>', M.def)
M.map({ 'n', 't' }, '<S-l>', '<cmd>bnext<cr>', M.def)
M.map('n', 'ss', '<cmd>split<cr>', M.def)
M.map('n', 'sv', '<cmd>vsplit<cr>', M.def)

local chars = {
	['('] = ')',
	['['] = ']',
	['{'] = '}',
	['"'] = '"',
	['\''] = '\'',
	['`'] = '`',
}

for l,r in pairs(chars) do
	M.map('v', l, 'di' .. l .. '<esc>pa' .. r .. '<esc>', M.def)
	M.map('v', r, 'di' .. l .. '<esc>pa' .. r .. '<esc>', M.def)
end

return M
