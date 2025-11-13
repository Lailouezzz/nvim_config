# Neovim Keybindings — README

> **Leader** = `<Space>`; `A` = Alt; `C` = Ctrl.
> Notation: `<CR>` = Enter, `<BS>` = Backspace.

---

## Table of contents

1. [General / Utilities](#general--utilities)
2. [Barbar — buffer management](#barbar---buffer-management)
3. [Neo-tree — file explorer](#neo-tree---file-explorer)
4. [Telescope — search & navigation](#telescope---search--navigation)
5. [Gitsigns — git actions in buffer](#gitsigns---git-actions-in-buffer)
6. [LSP — useful commands](#lsp---useful-commands)
7. [Completions (nvim-cmp)](#completions-nvim-cmp)
8. [Neovide (GUI) — controls](#neovide-gui---controls)
9. [DAP — Debugging](#dap---debugging-nvim-dap)
10. [Window Resize](#window-resize-bufresize-nvim)
11. [Other plugin / helper shortcuts](#other-plugin--helper-shortcuts)

---

## General / Utilities

```
<leader>e    : Toggle Neo-tree (file explorer)
<leader>l    : Open Lazy (plugin manager)
<C-s>        : :w (save)
<leader>n    : :nohlsearch (clear search highlights)
<leader>tt   : Toggle floating terminal (custom terminal with Esc to close)
<leader>tr   : Toggle bottom terminal split (15 lines, persistent buffer)
<leader>dg   : Neogen (generate documentation)

Terminal mode:
  <ESC>      : Exit terminal mode / close floating terminal
  <C-S-v>    : <C-\><C-n>pi (paste in terminal)

Insert mode:
  <C-BS>     : <C-w> (delete previous word)
  <C-v>      : <C-o>P (paste)
```

---

## Barbar — buffer management

```
n  <A-,>     -> :BufferPrevious
n  <A-.>     -> :BufferNext
n  <A-<>     -> :BufferMovePrevious
n  <A->>     -> :BufferMoveNext
n  <A-1>..9  -> :BufferGoto 1..9
n  <A-0>     -> :BufferLast
n  <A-p>     -> :BufferPin
n  <A-c>     -> :BufferClose
n  <C-p>     -> :BufferPick
n  <leader>bb-> :BufferOrderByBufferNumber
n  <leader>bn-> :BufferOrderByName
n  <leader>bd-> :BufferOrderByDirectory
n  <leader>bl-> :BufferOrderByLanguage
n  <leader>bw-> :BufferOrderByWindowNumber
```

---

## Neo-tree — file explorer

### Window / main mappings

```
<Space>        : toggle_node
<2-LeftMouse>  : open
<CR>           : open
<Esc>          : cancel (close preview/floating)
P              : toggle_preview (float / image)
l              : focus_preview
S              : open_split
s              : open_vsplit
t              : open_tabnew
w              : open_with_window_picker
C              : close_node
z              : close_all_nodes
a              : add file
A              : add directory
d              : delete
r              : rename
y              : copy_to_clipboard
x              : cut_to_clipboard
p              : paste_from_clipboard
c              : copy (asks destination)
m              : move (asks destination)
q              : close_window
R              : refresh
?              : show_help
<              : prev_source
>              : next_source
i              : show_file_details
```

### Filesystem / filter / search mappings

```
<BS>           : navigate_up
.              : set_root
H              : toggle_hidden (dotfiles)
/              : fuzzy_finder
D              : fuzzy_finder_directory
#              : fuzzy_sorter
f              : filter_on_submit
<C-x>          : clear_filter
[g             : prev_git_modified
]g             : next_git_modified
o              : order_by menu (prefix 'o')
oc, od, og, om, on, os, ot : order_by_created/diagnostics/git/modified/name/size/type
```

### Buffers view (inside neo-tree)

```
bd             : buffer_delete
<BS>           : navigate_up
.              : set_root
o, oc, od, om, on, os, ot : sorting commands
```

### Git status window (float)

```
A, gu, ga, gr, gc, gp, gg : git actions (add/unstage/add/revert/commit/push/commit+push)
o, oc, od, om, on, os, ot : sorting commands
```

---

## Telescope — search & navigation

```
<leader>ff    : Find files (telescope.find_files)
<leader>fg    : Live grep (telescope.live_grep)
<leader>fb    : Buffers (telescope.buffers)
<leader>fh    : Help tags (telescope.help_tags)
<leader>fo    : Old files (telescope.oldfiles)
<leader>fs    : LSP workspace symbols (telescope.lsp_workspace_symbols)
<leader>fS    : LSP dynamic workspace symbols
<leader>cm    : Commands (telescope.commands)
<leader>km    : Keymaps (telescope.keymaps)
<leader>gb    : Git branches
<leader>gc    : Git commits
<leader>gs    : Git status

Telescope UI mappings:
  - Normal mode:  q = close, s = select_horizontal
  - Insert mode: <C-s> = select_horizontal
```

---

## Gitsigns — git actions (buffer on\_attach)

```
]c / [c        : next / prev hunk (respects 'diff' mode)
<leader>hs     : stage hunk (normal)
<leader>hr     : reset hunk (normal)
(v) <leader>hs : stage selected range (visual)
(v) <leader>hr : reset selected range (visual)
<leader>hS     : stage buffer
<leader>hR     : reset buffer
<leader>hp     : preview hunk
<leader>hi     : preview inline
<leader>hb     : blame line (full)
<leader>hd     : diffthis
<leader>hD     : diffthis('~') (against parent)
<leader>hQ     : setqflist('all')
<leader>hq     : setqflist
<leader>tb     : toggle_current_line_blame
<leader>tw     : toggle_word_diff
ih (o/x modes) : gitsigns.select_hunk (text object)
```

---

## LSP — useful commands (on\_attach)

```
<leader>ca    : code actions (vim.lsp.buf.code_action)
<leader>rn    : rename (vim.lsp.buf.rename)
gD            : declaration
gd            : definitions (Telescope)
gi            : implementations (Telescope)
gr            : references (Telescope)
K             : hover (vim.lsp.buf.hover)
<leader>E     : diagnostics float (vim.diagnostic.open_float)
```

---

## Completions — nvim-cmp (insert/select mode)

```
<C-b>         : scroll docs up
<C-f>         : scroll docs down
<C-Space>     : trigger completion
<C-e>         : abort completion
<CR>          : confirm selection (select = true)
<ESC> (i,s)   : if cmp visible -> abort, else fallback
<Tab> (i,s)   : if cmp.visible -> confirm; elseif luasnip expandable -> expand/jump; else fallback
<S-Tab> (i,s) : if cmp.visible -> select_next_item; elseif luasnip.jumpable(-1) -> jump(-1); else fallback
```

---

## Neovide (GUI) — controls (active only if `vim.g.neovide`)

```
<leader>f+   : increase font size (+2)
<leader>f-   : decrease font size (-2)
<leader>o+   : increase opacity (+0.05)
<leader>o-   : decrease opacity (-0.05)
```

---

## DAP — Debugging (nvim-dap)

### Basic Debug Controls

```
<F5>         : Start/Continue debugging
<F10>        : Step Over
<F11>        : Step Into
<F12>        : Step Out
```

### Breakpoint Management

```
<leader>db   : Toggle breakpoint at current line
<leader>dB   : Set conditional breakpoint (prompts for condition)
<leader>dc   : Clear all breakpoints
<leader>dL   : List all breakpoints (Telescope)
```

### Debug UI & Sessions

```
<leader>du   : Toggle DAP UI (side panels + REPL)
<leader>dr   : Open REPL console
<leader>dl   : Run last debug configuration
<leader>dt   : Terminate debug session
<leader>dR   : Restart debug session
```

### Debug Information

```
<leader>de   : Evaluate expression under cursor (normal/visual mode)
<leader>dh   : Hover variables (float scopes window)
<leader>dv   : View variables (Telescope)
<leader>df   : View stack frames (Telescope)
<leader>ds   : Debug commands (Telescope)
<leader>dC   : Debug configurations (Telescope)
```

### Installed Debuggers (via Mason)

- **Python**: debugpy
- **C/C++/Rust**: codelldb
- **.NET (C#/F#)**: coreclr (netcoredbg)
- **Go**: delve

---

## Window Resize (bufresize.nvim)

```
<leader>w,   : Decrease width by 10 columns
<leader>w.   : Increase width by 10 columns
<leader>w+   : Increase height by 5 lines
<leader>w-   : Decrease height by 5 lines
<leader>w_   : Maximize height
<leader>w|   : Maximize width
<leader>wo   : Maximize both (full window)
```

---

## Other plugin / helper shortcuts

```
dv           : Toggle Diffview (open/close) [plugin key in plugins.lua]
UU           : Toggle undotree (via plugin key)
<leader>cp   : MarkdownPreviewToggle (markdown-preview.nvim — lazy-loaded)
<F1>         : Stdheader (42-header.nvim command)
<leader>dg   : Neogen (generate documentation for functions/classes)

nvim-surround (text object manipulation):
  ys{motion}{char} : Add surrounding (e.g., ysiw" adds quotes around word)
  ds{char}         : Delete surrounding (e.g., ds" removes quotes)
  cs{old}{new}     : Change surrounding (e.g., cs"' changes " to ')

nvim-autopairs:
  Auto-closes (, [, {, ", ', etc. when typing

git-conflict.nvim:
  Automatically loaded for conflict resolution in Git merge conflicts
```

---

## Configuration Details

### General Vim Settings

```lua
Leader key          : <Space>
Tab settings        : tabstop=4, shiftwidth=4, softtabstop=4
Line numbers        : enabled (nu)
Cursor line         : enabled (cursorline)
Undo persistence    : enabled (undofile with 1000 levels)
Clipboard           : synced with system (unnamed + unnamedplus)
Search highlighting : enabled (hlsearch)
Auto-indent         : enabled
Expand tabs         : disabled (uses real tabs)
Whitespace display  : visible (tab=→, space=·, trail=·)
```

### LSP Configuration

- **Server**: clangd (auto-installed via Mason)
- **Filetypes**: c, cpp, objc, objcpp, cuda, proto, h, hpp, tpp, inl, ipp
- **Features**: background-index, clang-tidy, detailed completion style

### Treesitter Languages

Ensured installed: c, lua, vim, vimdoc, query, elixir, heex, javascript, html, markdown

---

## Notes

* Many mappings are provided by plugins (Barbar, Neo-tree, Gitsigns, Telescope). Change mappings by editing the matching `./lua/plugin_config/*.lua` or `./lua/keymaps.lua`.
* This README is a concise reference of **configured** mappings plus a few recommended helpers you may want to enable.
* Configuration files structure:
  - `init.lua` : Main entry point
  - `lua/plugins.lua` : Plugin declarations (Lazy.nvim)
  - `lua/keymaps.lua` : General keybindings
  - `lua/plugin_config/` : Individual plugin configurations
  - `lua/snippets/` : Custom LuaSnip snippets
  - `lua/neovide_config.lua` : Neovide GUI-specific settings
