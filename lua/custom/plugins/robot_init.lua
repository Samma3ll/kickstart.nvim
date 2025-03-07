return {
  -- Define the robotframework_ls plugin spec
  {
    'neovim/nvim-lspconfig',
    -- This ensures this config runs after lspconfig is loaded
    dependencies = {},
    opts = {},
    config = function()
      -- Define the RobotFixLsp command
      vim.api.nvim_create_user_command('RobotFixLsp', function()
        -- Print debug info
        print 'Running RobotFixLsp command...'

        -- Stop the LSP if it's running
        if vim.lsp.get_active_clients({ name = 'robotframework_ls' })[1] then
          vim.cmd 'LspStop robotframework_ls'
          print 'Stopped robotframework_ls'
        end

        -- Wait a bit
        vim.defer_fn(function()
          -- Update the settings
          local lspconfig = require 'lspconfig'
          lspconfig.robotframework_ls.setup {
            on_attach = function(client, bufnr)
              -- Custom keybindings for Robot Framework
              local bufopts = { noremap = true, silent = true, buffer = bufnr }
              vim.keymap.set('n', '<leader>rp', '<cmd>RobotPywordGotoDefinition<CR>', bufopts)
              vim.keymap.set('n', '<leader>rr', '<cmd>RobotRunSuite<CR>', bufopts)
              vim.keymap.set('n', '<leader>rt', '<cmd>RobotRunTest<CR>', bufopts)

              -- Print confirmation
              print('Robot Framework LSP attached to buffer', bufnr)
            end,
            root_dir = function(fname)
              return lspconfig.util.root_pattern 'robot.yaml'(fname)
                or lspconfig.util.root_pattern('requirements.txt', 'pyproject.toml', '.git', '*.robot')(fname)
                or lspconfig.util.fs.dirname(fname)
            end,
            settings = {
              robot = {
                configurationFile = '/Users/goinn00/git/PGA/pga/robot/robot.yaml',
                python = {
                  executable = '/Users/goinn00/git/PGA/pga/.venv/bin/python',
                },
                variables = {
                  EXECDIR = '/Users/goinn00/git/PGA/pga/robot/',
                },
                variableFiles = {
                  '/Users/goinn00/git/PGA/pga/robot/variables.py',
                },
                args = {
                  '--variablefile',
                  '/Users/goinn00/git/PGA/pga/robot/variables.py',
                  '--variable',
                  'EXECDIR:/Users/goinn00/git/PGA/pga/robot/',
                },
                loadVariablesFromArgumentsFile = true,
              },
            },
            filetypes = { 'robot' },
            single_file_support = true,
            flags = {
              debounce_text_changes = 150,
            },
            autostart = true,
          }

          -- Restart the LSP
          vim.cmd 'LspStart robotframework_ls'
          print 'Robot Framework LSP started with updated settings'

          -- Attach to all open robot files
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) then
              local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
              if ft == 'robot' then
                vim.api.nvim_buf_call(buf, function()
                  vim.cmd 'LspStart robotframework_ls'
                end)
                print('Attached LSP to buffer', buf)
              end
            end
          end
        end, 500)
      end, {})

      -- Run RobotFixLsp when a Robot file is opened
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        pattern = { '*.robot' },
        callback = function()
          -- Check if the LSP is already running with the correct settings
          local clients = vim.lsp.get_active_clients { name = 'robotframework_ls' }
          if
            #clients == 0
            or not clients[1].config.settings
            or not clients[1].config.settings.robot
            or not clients[1].config.settings.robot.variables
            or not clients[1].config.settings.robot.variables.EXECDIR
          then
            -- LSP is not running or doesn't have the correct settings
            vim.cmd 'RobotFixLsp'
          end
        end,
      })

      -- Function to check if Robot Framework LSP is properly configured
      function CheckRobotLspStatus()
        local clients = vim.lsp.get_active_clients { name = 'robotframework_ls' }
        if #clients == 0 then
          print 'Robot Framework LSP is not running'
          return false
        end

        local client = clients[1]
        if
          not client.config.settings
          or not client.config.settings.robot
          or not client.config.settings.robot.variables
          or not client.config.settings.robot.variables.EXECDIR
        then
          print 'Robot Framework LSP is running but EXECDIR is not configured'
          return false
        end

        print('Robot Framework LSP is properly configured with EXECDIR = ' .. client.config.settings.robot.variables.EXECDIR)
        return true
      end

      -- Create a command to check the status
      vim.api.nvim_create_user_command('RobotLspStatus', function()
        CheckRobotLspStatus()
      end, {})
    end,
  },
}
