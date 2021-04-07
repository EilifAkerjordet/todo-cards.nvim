local api = vim.api
local layout = {}

-- set_config_item('borderchars', { '─', '│', '─', '│', '╭', '╮', '╯', '╰'})
function layout.createFloatingWindow()
	local config = _ConfigurationValues
	local layout_config = layout.split_view()

	local opts = {
		relative = "editor",
		width = math.ceil(layout_config.win_width) + 2,
		height  = math.ceil(layout_config.win_height) + 2,
		row = layout_config.row - 1,
		col = layout_config.col - 1,
		style = "minimal"
	}

	local buf_handle = api.nvim_create_buf(false, true)
	api.nvim_buf_set_option(buf_handle, 'bufhidden', 'wipe')
	-- Create buffer
	if config.border == 1 then
		local top_left = config.topleft_border
		local top_right = config.topright_border
		local horizontal = config.horizontal_border
		local vertical = config.vertical_border
		local bot_left = config.botleft_border
		local bot_right = config.botright_border

		local top_border = top_left..string.rep(horizontal, layout_config.win_width)..top_right

		local mid_border =
		  vertical
			..string.rep(' ', layout_config.main_view_width)
			..vertical
			..string.rep(' ', layout_config.side_view_width - 1)
			..vertical

		local bot_border = bot_left..string.rep(horizontal, layout_config.win_width)..bot_right

		-- Create lines object
		local lines = {top_border}
		for _=1, math.ceil(layout_config.win_height) do
			table.insert(lines, mid_border)
		end
		table.insert(lines, bot_border)
		-- Set border lines
		api.nvim_buf_set_lines(buf_handle, 0, -1, true, lines)
	end

	local win_handle = api.nvim_open_win(buf_handle, true, opts)
	api.nvim_win_set_option(win_handle, 'winhl', 'Normal:Floating')
	return buf_handle, win_handle
end

function layout.split_view()
	local config = _ConfigurationValues
	local result = {}

	local width = api.nvim_get_option("columns")
	local height = api.nvim_get_option("lines")

	result.win_width = math.ceil(width * config.window_dimensions.width)
	result.win_height = math.ceil(height * config.window_dimensions.height)

	result.main_view_width = result.win_width * config.view_split_ratio
	result.main_view_height = result.win_height

	result.side_view_width = result.win_width - result.main_view_width
	result.side_view_height = result.win_height

	result.row = math.ceil((height - result.win_height) / 2 - 1)
  result.col = math.ceil((width - result.win_width) / 2)

	return result
end

return layout
