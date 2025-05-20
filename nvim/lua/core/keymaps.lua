---------------------------------------
-- Leader is mapped in /core/lazy.lua --
----------------------------------------

------------------------
-- Set Custom Keymaps --
------------------------

local map = require("helpers.keys").map -- map signature (mode:str, lhs:str, rhs:str, desc:str, opts:table)

-- Function to wrap a text command in <cmd> ... <CR>
local function cmd(command)
  return table.concat({ "<cmd>", command, "<CR>" })
end

-- Vim commands --
map("i", "kj", "<ESC>", "", { noremap = true })
map("n", "<Esc>", cmd("nohlsearch"), "Clear highlights after searching")

-- Key cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", "", { noremap = true, silent = true })
map("n", "<C-u>", "<C-u>zz", "", { noremap = true, silent = true })

-- better indenting
map("v", ">", ">gv")
map("v", "<", "<gv")

-- yanking/pasting improved
map({ "n", "v" }, "x", '"_x', "Delete character and send to black hole register")
map({ "n", "v" }, "c", '"_c', "Change selection and send to black hole register")
map("v", "p", '"_dp', "Paste over currently selected text without yanking it")
map("v", "P", '"_dP', "Paste over currently selected text without yanking it")
---------------------
-- Plugin controls --
---------------------

-- Navigate vim panes better (TMUX) --
map("n", "<C-h>", ":wincmd h<CR>", "Move window left")
map("n", "<C-j>", ":wincmd j<CR>", "Move window down")
map("n", "<C-k>", ":wincmd k<CR>", "Move window up")
map("n", "<C-l>", ":wincmd l<CR>", "Move window right")

-- Telescope --
local telescope_builtin = require("telescope.builtin")
map("n", "<leader>T", ":Telescope<CR>", "Open Telescope Main")
map("n", "<leader>ff", telescope_builtin.find_files, "Telescope - Find File")
map("n", "<leader>fg", telescope_builtin.live_grep, "Telescope - Live Grep")
map("n", "<leader>fc", telescope_builtin.current_buffer_fuzzy_find, "Telescope - Current buffer fuzzy find")
map("n", "<leader>fd", telescope_builtin.diagnostics, "Telescope - Diagnostics")
map("n", "<leader><leader>", telescope_builtin.buffers, "Telescope - Existing Buffers")
map("n", "<leader>fh", require("telescope").extensions.recent_files.pick, "Telescope - Recent Files")
map("n", "<leader>fr", require("telescope").extensions.frecency.frecency, "Telescope - Frecent Files")
map("n", "<leader>gs", telescope_builtin.git_status, "Git Status")
map("n", "<leader>ft", cmd("TodoTelescope"), "Telescope - TODO list")
map("n", "<leader>fk", telescope_builtin.keymaps, "Telescope - Keymaps")

-- Treesitter Textobjects Movement --
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, "Repeat f search", { expr = true })
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, "Repeat F search", { expr = true })
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, "Repeat t search", { expr = true })
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, "Repeat T search", { expr = true })

-- Oil --
map("n", "<leader>o", cmd("Oil"))

-- Neo-Tree --
map("n", "<C-n>", ":Neotree toggle filesystem reveal left<CR>", "Neo-Tree Toggle")

-- Noice --
map("n", "<leader>dn", ":NoiceDismiss<CR>", "Dismiss the Noice popups on screen")

-- Buffer Control --
map("n", "<A-c>", ":BufferClose<CR>", "Close Buffer", { noremap = true })
map("n", "<A-d>", ":BufferDelete<CR>", "Delete Buffer", { noremap = true })

-- Buffer Movement --
map("n", "<A-,>", ":BufferPrevious<CR>", "Previous Buffer", { noremap = true })
map("n", "<A-.>", ":BufferNext<CR>", "Next Buffer", { noremap = true })
-- map("n", "<leader>x", ":BufferClose<CR>", "Close Buffer", { noremap = true })

map("n", "<A-<>", ":BufferMovePrevious<CR>", "Move Buffer Previous", { noremap = true })
map("n", "<A->>", ":BufferMoveNext<CR>", "Move Buffer Next", { noremap = true })

map("n", "<A-1>", ":BufferGoto 1<CR>", "Move to Buffer 1", { noremap = true })
map("n", "<A-2>", ":BufferGoto 2<CR>", "Move to Buffer 2", { noremap = true })
map("n", "<A-3>", ":BufferGoto 3<CR>", "Move to Buffer 3", { noremap = true })
map("n", "<A-4>", ":BufferGoto 4<CR>", "Move to Buffer 4", { noremap = true })
map("n", "<A-5>", ":BufferGoto 5<CR>", "Move to Buffer 5", { noremap = true })
map("n", "<A-6>", ":BufferGoto 6<CR>", "Move to Buffer 6", { noremap = true })
map("n", "<A-7>", ":BufferGoto 7<CR>", "Move to Buffer 7", { noremap = true })
map("n", "<A-8>", ":BufferGoto 8<CR>", "Move to Buffer 8", { noremap = true })
map("n", "<A-9>", ":BufferGoto 9<CR>", "Move to Buffer 9", { noremap = true })
map("n", "<A-0>", ":BufferLast<CR>", "Move to Last Buffer", { noremap = true })

-- Harpoon Setup --
local harpoon = require("harpoon")
harpoon:setup()
map("n", "<leader>a", function()
  harpoon:list():add()
end, "Add mark to Harpoon list")

map("n", "<C-x>u", function()
  harpoon:list():select(1)
end)
map("n", "<C-x>i", function()
  harpoon:list():select(2)
end)
map("n", "<C-x>o", function()
  harpoon:list():select(3)
end)
map("n", "<C-x>p", function()
  harpoon:list():select(4)
end)

-- Harpoon Telescope Setup --
local conf = require("telescope.config").values

local function toggle_telescope(harpoon_files)
  local make_finder = function()
    local paths = {}

    for _, item in ipairs(harpoon_files.items) do
      table.insert(paths, item.value)
    end

    return require("telescope.finders").new_table({
      results = paths,
    })
  end

  require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = make_finder(),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        layout_strategy = "horizontal",
        layout_config = {
          preview_cutoff = 1,
          width = function(_, max_columns, _)
            return math.min(max_columns, 100)
          end,
          height = function(_, _, max_lines)
            return math.min(max_lines, 40)
          end,
        },
        attach_mappings = function(prompt_buffer_number, mymap)
          -- The keymap you need
          mymap("i", "<c-d>", function()
            local state = require("telescope.actions.state")
            local selected_entry = state.get_selected_entry()
            local current_picker = state.get_current_picker(prompt_buffer_number)

            local selected_index = selected_entry.index
            -- This is the line you need to remove the entry
            table.remove(harpoon_files.items, selected_index)
            current_picker:refresh(make_finder(), { reset_prompt = true })
          end)

          return true
        end,
      })
      :find()
end
map("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, "Open Harpoon Window")

-- Colorscheme (via Huez) --
map("n", "<leader>th", ":Huez<CR>", "Colorscheme Picker")

-- Window Resizing (via window-nvim)

map("n", "<C-w>m", cmd("WindowsMaximize"), "Maximize current window")
map("n", "<C-w>mv", cmd("WindowsMaximizeVertically"), "Maximize current window vertically")
map("n", "<C-w>mh", cmd("WindowsMaximizeHorizontally"), "Maximize current window horizontally")
map("n", "<C-w>=", cmd("WindowsEqualize"), "Equalize all windows")
