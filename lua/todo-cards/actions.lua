local buffer = require('todo-cards.buffer')
local api = vim.api
local M = {}

function M.closeTodoWindow()
	if (api.nvim_buf_is_valid(M.buf_handle)) then
	  api.nvim_buf_delete(M.buf_handle, { force = true })
	end
end

function M.toggleTodoWindow(config)
  if buffer.buf_handle == nil or not api.nvim_buf_is_valid(buffer.buf_handle) then
    buffer.createFloatingWindow(config)
    api.nvim_command("startinsert")
  else
		M.closeTodoWindow()
  end
end

return M
