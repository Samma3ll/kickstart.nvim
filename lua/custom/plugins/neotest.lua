return {
  require('neotest').setup {
    adapters = {
      require 'neotest-robotframework' {
        test_patterns = { '.*%.robot$' },
        args = { '--loglevel', 'DEBUG' },
        root = vim.fn.getcwd(),
        python_path = 'python3',
      },
    },
    log_level = 5,
    status = {
      virtual_text = true,
      signs = true,
    },
    output = {
      open_on_run = true,
    },
    floating = {
      border = 'rounded',
      max_height = 0.6,
      max_width = 0.6,
    },
  },
}
