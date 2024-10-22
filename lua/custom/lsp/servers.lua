local lspconfig_util = require 'lspconfig.util'
local schemastore = require 'schemastore'

local configs = {
  arduino_language_server = {
    cmd = {
      'arduino-language-server',
      '-cli-config',
      '$HOME/.arduino15/arduino-cli.yaml',
      '-fqbn',
      'arduino:avr:micro',
    },
  },
  bashls = {},
  biome = {
    root_dir = lspconfig_util.root_pattern('biome.json', 'biome.jsonc'),
    single_file_support = false,
  },
  clangd = {},
  csharp_ls = {
    handlers = {
      ['textDocument/definition'] = require('csharpls_extended').handler,
      ['textDocument/typeDefinition'] = require('csharpls_extended').handler,
    },
  },
  gopls = {},
  cssls = {},
  dockerls = {},
  eslint = {},
  html = {},
  jsonls = {

    settings = {
      json = {
        schemas = schemastore.json.schemas(),
        validate = {
          enable = true,
        },
      },
    },
  },
  lemminx = {},
  lua_ls = {},
  -- lua_ls = {
  -- 	on_init = function(client)
  -- 		local path = client.workspace_folders[1].name
  -- 		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
  -- 			client.config.settings = vim.tbl_deep_extend("force", client.config.settings.Lua, {
  -- 				telemetry = { enable = false },
  -- 				runtime = {
  -- 					version = "LuaJIT",
  -- 					-- path = runtime_path,
  -- 				},
  -- 				diagnostics = {
  -- 					globals = { "vim" },
  -- 				},
  -- 				workspace = {
  -- 					checkThirdParty = false,
  -- 					library = {
  -- 						vim.fn.expand("$VIMRUNTIME/lua"),
  -- 						vim.fn.stdpath("config") .. "/lua",
  -- 					},
  -- 				},
  -- 				completion = {
  -- 					callSnippet = "Replace",
  -- 				},
  -- 			})
  --
  -- 			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  -- 		end
  -- 		return true
  -- 	end,
  -- },
  -- omnisharp = {
  -- 	cmd = { "omnisharp" },
  -- 	enable_roslyn_analyzers = true,
  -- 	enable_import_completion = true,
  -- 	organize_imports_on_format = true,
  -- 	handlers = {
  -- 		["textDocument/definition"] = require("omnisharp_extended").handler,
  -- 	},
  -- },
  powershell_es = {
    bundle_path = require('mason-core.path').package_prefix 'powershell-editor-services',
  },
  basedpyright = {
    analysis = {
      -- venvPath = '/home/matp/.cache/pypoetry/virtualenvs',
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,
      autoImportCompletions = true,
      diagnosticMode = 'openFilesOnly',
      extraPaths = {},
      updateImportsOnFileMove = true,
    },
  },
  tailwindcss = {
    root_dir = lspconfig_util.root_pattern 'tailwind.config.js',
  },
  vimls = {},
  vtsls = {
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = 'always' },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = '',
        },
        schemas = schemastore.yaml.schemas(),
      },
    },
  },
}

return {
  server_configs = configs,
  exclude_install = {},
}
