return {
  vim.keymap.set('n', '<C-S>', ':w<CR>', { desc = 'Save Buffer' }),
  vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Buffer Delete' }),
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
  vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next Buffer' }),
  vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Previous Buffer' }),
  -- Gen
  vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>', { desc = 'Open Gen menu' }),
  -- Automaton
  vim.keymap.set('n', '<leader>fml', '<CMD>CellularAutomaton make_it_rain<CR>'),
  vim.keymap.set('n', '<leader>fmc', '<CMD>CellularAutomaton game_of_life<CR>'),
}
