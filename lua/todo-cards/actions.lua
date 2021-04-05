local layout = require('todo-cards.layout')
local mappings = require('todo-cards.mappings')

local api = vim.api
local M = {}

function M.close_todo_window(prompt)
	if (api.nvim_buf_is_valid(prompt)) then
		api.nvim_buf_delete(prompt, { force = true })
	end
end

function M.open_todo_window()
	local config = _ConfigurationValues
  if layout.buf_handle == nil or not api.nvim_buf_is_valid(layout.buf_handle) then
    layout.createFloatingWindow()
		mappings.apply_keymap(layout.buf_handle, config.mappings.buffer)
		-- api.nvim_command("startinsert")
  end
end

return M
