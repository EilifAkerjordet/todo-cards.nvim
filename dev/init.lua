-- This file contains configurations to use in the development process

-- force lua to import the modules again
package.loaded['dev'] = nil
package.loaded['todo-cards'] = nil
package.loaded['todo-cards.actions'] = nil
package.loaded['todo-cards.config'] = nil
package.loaded['todo-cards.utils'] = nil
package.loaded['todo-cards.layout'] = nil
package.loaded['todo-cards.mappings'] = nil
print('Reloaded!')

-- [ , + r ] keymap to reload the lua file
-- NOTE: someone need to source this file to apply these configurations. So, the
-- very first time you open the project, you have to source this file using
-- ":luafile dev/init.lua". From that point onward, you can hit the keybind to
-- reload
vim.api.nvim_set_keymap('n', '<Localleader>r', '<cmd>luafile dev/init.lua<cr>', {})

-- keybind to test the plugin
-- vim.api.nvim_set_keymap('n', '<Localleader>w', '<cmd>lua TodoCards.actions.toggleTodoWindow()<cr>', {})

-- Config
require('todo-cards').setup(function(actions)
  return {
    defaults = {
      border = 1,
			topleft_border = '╭',
			topright_border = '╮',
			botleft_border = '╰',
			botright_border = '╯',
			vertical_border = '│',
			horizontal_border = '─',

      mappings = {
        buffer = {
          n = {
            ['q'] = actions.close_todo_window,
          },
        },
        global = {
          n = {
            ['<Localleader>w'] = actions.open_todo_window
          },
        }
      }
    },
  }
end)
