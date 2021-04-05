local api = vim.api
local mappings = {}

_Keymaps = _Keymaps or setmetatable({}, {
  __index = function(t, k)
    rawset(t, k, {})

    return rawget(t, k)
  end
})
local keymap_store = _Keymaps

local _mapping_key_id = 0
local get_next_id = function()
  _mapping_key_id = _mapping_key_id + 1
  return _mapping_key_id
end

local assign_function = function(prompt, func)
  local func_id = get_next_id()

  keymap_store[prompt][func_id] = func

  return func_id
end

local function map(prompt, mode, key_bind, key_func, opts)
	if not key_func then return end

	local set_keymap
	if not prompt or prompt == 'global' then
		prompt = 0
		set_keymap = api.nvim_set_keymap
	else
		set_keymap = function(...) api.nvim_buf_set_keymap(prompt, ...) end
	end

	opts = opts or {}
	if opts.noremap == nil then opts.noremap = true end
  if opts.silent == nil then opts.silent = true end

	if type(key_func) == 'string' then
		set_keymap(mode, key_bind, key_func, opts or { silent = true })

	else
		local key_id = assign_function(prompt, key_func)
		local prefix

		local map_string
    if opts.expr then
      map_string = string.format(
        [[luaeval("require('todo-cards.mappings').execute_keymap(%s, %s)")]],
				prompt,
        key_id
      )
    else
      if mode == "i" and not opts.expr then
        prefix = "<cmd>"
      elseif mode == "n" then
        prefix = ":<C-U>"
      else
        prefix = ":"
      end

      map_string = string.format(
        "%slua require('todo-cards.mappings').execute_keymap(%s, %s)<CR>",
        prefix,
				prompt,
        key_id
      )
    end

	 set_keymap(
      mode,
      key_bind,
      map_string,
      opts
    )
	end
end

function mappings.execute_keymap(prompt, keymap_identifier)
  local key_func = keymap_store[prompt][keymap_identifier]

  assert(
    key_func,
    string.format(
      "Unsure of how we got this failure: %s %s",
      prompt,
      keymap_identifier
    )
  )
	if prompt == 'global' then
		key_func()
	else
	  key_func(prompt)
	end
end

function mappings.apply_keymap(prompt, key_maps)
	if prompt == 'global' then prompt = 0 end
	for mode, _ in pairs(key_maps) do
		for binding, action in pairs(key_maps[mode]) do
		  map(prompt, mode, binding, action)
		end
	end
end

return mappings
