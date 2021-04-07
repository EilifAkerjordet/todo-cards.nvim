local layout = require('todo-cards.layout')
local mappings = require('todo-cards.mappings')

local api = vim.api
local actions = {}

function actions.close_todo_window(prompt)
	if (api.nvim_buf_is_valid(prompt)) then
		api.nvim_buf_delete(prompt, { force = true })
	end
end

function actions.open_todo_window()
	local config = _ConfigurationValues
  local buf_handle, _ = layout.createFloatingWindow()
	mappings.apply_keymap(buf_handle, config.mappings.buffer)
end

return actions
