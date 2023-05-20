local dap_installed, dap = pcall(require, "dap")
local dap_ui_installed, dap_ui = pcall(require, "dapui")

if not dap_installed then
  vim.notify("dap is not installed.")
  return
end

if not dap_ui_installed then
  vim.notify("dap-ui is not installed.")
  return
end

dap_ui.setup({
  layouts = {
    {
      elements = {
        {
          id = "scopes",
          size = 0.5,
        },
        {
          id = "watches",
          size = 0.3,
        },
        {
          id = "stacks",
          size = 0.2,
        },
      },
      position = "right",
      size = tonumber(vim.o.columns) - 111,
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = dap_ui.open
dap.listeners.before.event_terminated["dapui_config"] = dap_ui.close
dap.listeners.before.event_exited["dapui_config"] = dap_ui.close

vim.keymap.set("n", "<Leader>ba", dap.toggle_breakpoint)
vim.keymap.set("n", "<Leader>bc", dap.clear_breakpoints)
vim.keymap.set("n", "<Leader>br", dap.restart)
vim.keymap.set("n", "<Leader>bx", dap.terminate)
vim.keymap.set("n", "<Leader>bb", dap.step_back)
vim.keymap.set("n", "<Leader>bn", dap.step_over)
vim.keymap.set("n", "<Leader>bi", dap.step_into)
vim.keymap.set("n", "<Leader>bo", dap.step_over)
vim.keymap.set({ "n", "v" }, "<Leader>br", dap_ui.eval)

vim.keymap.set("n", "<Leader>wa", function()
  dap_ui.elements.watches.add()
  vim.cmd.norm("\"wyiw")
  local var = vim.fn.getreg("w")
  vim.notify("Now watching `" .. var .. "`")
end)

vim.keymap.set("v", "<Leader>wa", function()
  dap_ui.elements.watches.add()
  vim.cmd.norm("\"wy")
  local var = vim.fn.getreg("w")
  vim.notify("Now watching `" .. var .. "`")
end)
