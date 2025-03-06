return {
  vim.keymap.set('n', '<C-S>', ':w<CR>', { desc = 'Save Buffer' }),
  vim.keymap.set('n', 'Q', '<cmd>bd<CR>', { desc = 'Buffer Delete' }),
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
  vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next Buffer' }),
  vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Previous Buffer' }),
  -- Gen
  vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>', { desc = 'Open Gen menu' }),
  -- Augment
  vim.keymap.set({ 'n', 'v' }, '<leader>[m', ':Augment<CR>', { desc = 'Open Augment menu' }),
  vim.keymap.set('i', '<C-y>', '<CMD>call augment#Accept()<CR>', { desc = 'Accept Augment' }),
  vim.keymap.set({ 'n', 'v' }, '<leader>[c', ':Augment chat<CR>', { desc = 'Open Chat menu' }),
  vim.keymap.set({ 'n', 'v' }, '<leader>[t', ':Augment chat-toggle<CR>', { desc = 'toggle Chat menu' }),
  vim.keymap.set({ 'n', 'v' }, '<leader>[n', ':Augment chat-new<CR>', { desc = 'new Chat menu' }),
}
