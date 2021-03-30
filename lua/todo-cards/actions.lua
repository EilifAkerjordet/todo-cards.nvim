local defaults = require('todo-cards.config').values

local api = vim.api
local M = {}

function M.createFloatingWindow()
	M.win_prev = api.nvim_tabpage_get_win(0)
	local column = api.nvim_get_option("columns")
	local line = api.nvim_get_option("lines")

	-- TODO make this user adjustable
	local width = column * 0.89
	local height = line * 0.89
	local opts = {
		relative = "editor",
		width = math.ceil(width),
		height  = math.ceil(height),
		row = math.ceil((line - height) / 2)-1 ,
		col = math.ceil((column - width)  / 2),
		style = "minimal"
	}

	if defaults.border == 1 then
		local top_left = defaults.topleft_border
		local top_right = defaults.topright_border
		local horizontal = defaults.horizontal_border
		local vertical = defaults.vertical_border
		local bot_left = defaults.botleft_border
		local bot_right = defaults.botright_border

		local top_border = top_left..string.rep(horizontal, width - 2)..top_right
		local mid_border = vertical..string.rep(" ", width - 2)..vertical
		local bot_border = bot_left..string.rep(horizontal, width - 2)..bot_right
		local lines = {top_border}
		for _=1, math.ceil(height)-2, 1 do
			table.insert(lines, mid_border)
		end
		table.insert(lines, bot_border)
		M.buf_handle = api.nvim_create_buf(false, true)
		api.nvim_buf_set_lines(M.buf_handle, 0, -1, true, lines)
		M.win_handle = api.nvim_open_win(M.buf_handle, true, opts)
		api.nvim_win_set_option(M.win_handle, 'winhl', 'Normal:Floating')
	end

	opts['width'] = opts['width'] - 4
	opts['height'] = opts['height'] -2
	opts['row'] = opts['row'] + 1
	opts['col'] = opts['col'] + 2
	M.buf_handle = api.nvim_create_buf(false, true)
	M.setMapping()
	M.win_handle = api.nvim_open_win(M.buf_handle, true, opts)
	api.nvim_win_set_option(M.win_handle, 'winhl', 'Normal:Floating')
end

return M
