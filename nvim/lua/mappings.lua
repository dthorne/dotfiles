-- Check if running in VSCode Neovim extension
local is_vscode = vim.g.vscode == 1

-- Leader key
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<space>', '<nop>', {noremap = true, silent = true})


-- Clear search highlighting
vim.api.nvim_set_keymap('n', '<leader>h', ':noh<cr>', {noremap = true, silent = true})

-- Window navigation (only when not in VSCode)
if not is_vscode then
  print('vim.g.vscode', vim.g.vscode)
  -- Replace visual selection
  vim.api.nvim_set_keymap('v', '<C-r>', '"hy:%s/<C-r>h//g<left><left>', {noremap = true})

  -- Quick escape and save
  vim.api.nvim_set_keymap('i', 'jj', '<esc><esc>:w<CR>', {})
  
  -- Window navigation
  vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
  vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
  vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
  vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})

  -- FZF mappings
 kvim.api.nvim_set_keymap('n', '<leader><space>', ':Files<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>f', ':Ag<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>a', ':Buffers<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>A', ':Windows<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>o', ':BTags<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>O', ':Tags<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>?', ':History<CR>', {noremap = true, silent = true})

  -- FZF completion
  vim.api.nvim_set_keymap('i', '<C-x><C-f>', '<plug>(fzf-complete-file-ag)', {})
  vim.api.nvim_set_keymap('i', '<C-x><C-l>', '<plug>(fzf-complete-line)', {})

  -- NNN file manager
  vim.api.nvim_set_keymap('n', '<leader>n', ':NnnPicker<CR>', {noremap = true, silent = true})

  -- NERDTree
  vim.api.nvim_set_keymap('n', '<C-p>', ':NERDTreeToggle<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>P', ':NERDTreeFind<CR>', {noremap = true, silent = true})

  -- Git mappings
  vim.api.nvim_set_keymap('n', '<leader>gs', ':Git ', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', {noremap = true, silent = true})

  -- Copilot Chat
  vim.api.nvim_set_keymap('n', '<leader>ai', ':CopilotChatToggle<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('v', '<leader>ai', ':CopilotChatExplain<CR>', {noremap = true, silent = true})
end

-- Return the module
return {}