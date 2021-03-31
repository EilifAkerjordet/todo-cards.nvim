local api = vim.api
local M = {}

function M.createFloatingWindow(defaults)
	local config = defaults.values

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

	-- Create buffer
  M.buf_handle = api.nvim_create_buf(false, true)

	if config.border == 1 then
		local top_left = config.topleft_border
		local top_right = config.topright_border
		local horizontal = config.horizontal_border
		local vertical = config.vertical_border
		local bot_left = config.botleft_border
		local bot_right = config.botright_border

		local top_border = top_left..string.rep(horizontal, width - 0.5)..top_right
		local mid_border = vertical..string.rep(" ", width - 0.5)..vertical
		local bot_border = bot_left..string.rep(horizontal, width - 0.5)..bot_right

		-- Create lines object
		local lines = {top_border}
		for _=1, math.ceil(height)-2, 1 do
			table.insert(lines, mid_border)
		end
		table.insert(lines, bot_border)
		-- Set border lines
		api.nvim_buf_set_lines(M.buf_handle, 0, -1, true, lines)
	end

	M.win_handle = api.nvim_open_win(M.buf_handle, true, opts)
	api.nvim_win_set_option(M.win_handle, 'winhl', 'Normal:Floating')
end

return M
