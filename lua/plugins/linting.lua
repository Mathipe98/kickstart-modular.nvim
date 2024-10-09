return {
  'mfussenegger/nvim-lint',
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      -- markdown = { "markdownlint" },
      cpp = { 'cpplint' },
      -- yaml = { "actionlint" },
      python = { 'pylint' },
    }
    local venv_path =
      'import sys; sys.path.append("/usr/lib/python3.10/site-packages"); import pylint_venv; pylint_venv.inithook(force_venv_activation=True, quiet=True)'
    local pylint = lint.linters.pylint
    pylint.args = {
      '-f',
      'json',
      '--init-hook',
      venv_path,
    }
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
