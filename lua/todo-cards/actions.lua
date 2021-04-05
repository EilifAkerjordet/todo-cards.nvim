local buffer = require('todo-cards.buffer')
local api = vim.api
local M = {}

function M.test()
	print('heiheiheiheie')
end

function M.close_todo_window()
	if (api.nvim_buf_is_valid(M.buf_handle)) then
	  api.nvim_buf_delete(M.buf_handle, { force = true })
	end
end

function M.open_todo_window()
  if buffer.buf_handle == nil or not api.nvim_buf_is_valid(buffer.buf_handle) then
    buffer.createFloatingWindow()
    -- api.nvim_command("startinsert")
  end
end

return M
