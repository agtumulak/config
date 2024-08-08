-- misc globals
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>", {})

-- misc options
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 999
vim.filetype.add {
    extension = {
        ["mcnp"] = "mcnp",
        ["code-snippets"] = "json",
    },
}

-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath, })
end
vim.opt.rtp:prepend(lazypath)

-- https://github.com/LazyVim/LazyVim/discussions/1583
local LazyFile = { "BufReadPost", "BufWritePost", "BufNewFile" }

require("lazy").setup({
    -- https://github.com/RRethy/base16-nvim?tab=readme-ov-file#nvim-base16
    {
        "RRethy/base16-nvim",
        config = function()
            vim.opt.termguicolors = true
            require("base16-colorscheme").with_config {
                telescope = false,
                cmp = false,
            }
            vim.cmd.colorscheme("base16-gruvbox-dark-hard")
        end,
    },
    -- https://github.com/hrsh7th/nvim-cmp?tab=readme-ov-file#setup
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#install
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
                config = function(_, opts)
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_vscode").lazy_load { paths = "~/.mcnp" }
                    local ls = require("luasnip")
                    ls.setup(opts)
                    ls.filetype_extend("cpp", { "cppdoc" })
                    -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                    vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
                    vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
                    vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })
                    vim.keymap.set({ "i", "s" }, "<C-E>", function()
                        if ls.choice_active() then
                            ls.change_choice(1)
                        end
                    end, { silent = true })
                end,
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    "saadparwaiz1/cmp_luasnip",
                },
            },
            -- https://github.com/windwp/nvim-autopairs?tab=readme-ov-file#mapping-cr
            {
                "windwp/nvim-autopairs",
                event = "InsertEnter",
                config = true,
            },
        },
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered(),
                },
                -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
                mapping = cmp.mapping.preset.insert {
                    ["<C-p>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp", },
                    { name = "nvim_lsp_signature_help", },
                    { name = "luasnip", },
                    { name = "path", },
                    { name = "buffer", },
                },
            }
            -- https://github.com/hrsh7th/cmp-cmdline?tab=readme-ov-file#setup
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline {
                    ["<CR>"] = cmp.mapping {
                        c = cmp.mapping.confirm { select = false },
                    }, },
                sources = {
                    { name = "buffer", }
                }
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline {
                    ["<CR>"] = cmp.mapping {
                        c = cmp.mapping.confirm { select = false },
                    }, },
                sources = cmp.config.sources {
                    {
                        name = "path",
                        option = { trailing_slash = true, },
                    },
                    { name = "cmdline", },
                },
            })
            -- https://github.com/windwp/nvim-autopairs?tab=readme-ov-file#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
            cmp.event:on(
                "confirm_done",
                require("nvim-autopairs.completion.cmp").on_confirm_done()
            )
        end,
    },
    -- https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#suggested-configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "nvim-telescope/telescope.nvim",
            -- this hierarchy is intended to load dependencies in the correct order
            -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#setup
            {
                "williamboman/mason-lspconfig.nvim",
                tag = "v1.29.0",
                dependencies = {
                    {
                        "williamboman/mason.nvim",
                        -- TODO: Repalce with a version tag once the following is merged:
                        -- https://github.com/williamboman/mason.nvim/pull/1639
                        commit = "0088ca599114e33bae3a4822dbfc5dc8ba357ab8",
                        opts = { ui = { border = "rounded", }, },
                    },
                },
                opts = { automatic_installation = true, },
                config = function(_, opts)
                    require("mason-lspconfig").setup(opts)
                end,
            },
        },
        -- https://github.com/LazyVim/LazyVim/blob/86ac9989ea15b7a69bb2bdf719a9a809db5ce526/lua/lazyvim/plugins/lsp/init.lua#L5
        event = LazyFile,
        config = function()
            local lspconfig = require("lspconfig")
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gd",
                        function() require("telescope.builtin").lsp_definitions { show_line = false } end, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr",
                        function() require("telescope.builtin").lsp_references { show_line = false, } end, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>m",
                        function() vim.lsp.buf.format { async = true } end, opts)
                    vim.keymap.set("n", "<leader>s",
                        function() require("telescope.builtin").lsp_document_symbols { symbol_width = 40 } end, opts)
                    vim.keymap.set("n", "<C-s>", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
                end,
            })
            -- https://www.reddit.com/r/neovim/comments/wscfar/comment/ikxnw81/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = "rounded" }
            )
            -- https://github.com/neovim/nvim-lspconfig/issues/3158
            require("lspconfig.ui.windows").default_options.border = "rounded"
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
            lspconfig.lua_ls.setup {
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                        return
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = { version = "LuaJIT" },
                        -- make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                    })
                end,
                settings = { Lua = {} },
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            }
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
            lspconfig.clangd.setup {
                cmd = {
                    "clangd",
                    "--background-index",
                },
            }
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
            -- Proxy needs to be set for NPM: https://stackoverflow.com/a/10304317
            lspconfig.pyright.setup {
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<leader>m", function() vim.cmd "!black %" end,
                        { buffer = bufnr, desc = "Autoformat with Black" })
                end,
            }
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cmake
            lspconfig.cmake.setup {}
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
            lspconfig.jsonls.setup {}
        end,
    },
    -- https://github.com/rcarriga/nvim-dap-ui?tab=readme-ov-file#installation
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"
        }
    },
    -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#modules
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { LazyFile, "VeryLazy" },
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
            modules = {},
            ignore_install = {},
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            require("nvim-treesitter.install").compilers = { "clang" }
            vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { link = "Comment" })
        end,
    },
    -- https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#installation
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "jonarrien/telescope-cmdline.nvim",
            "nvim-treesitter/nvim-treesitter",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build =
                "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
            },
        },
        keys = {
            { "<leader>;",  "<cmd>Telescope cmdline<cr>",    desc = "Cmdline" },
            { "<leader>fd", "<cmd>Telescope find_files<cr>", desc = "Search with `fd`" },
            { "<leader>rg", "<cmd>Telescope live_grep<cr>",  desc = "Search with `rg`" },
            { "<leader>b",  "<cmd>Telescope buffers<cr>",    desc = "Search buffers" },
            { "<leader>h",  "<cmd>Telescope help_tags<cr>",  desc = "Search help tags" },
        },
        opts = {
            defaults = {
                layout_strategy = "vertical",
            },
            extensions = {
                file_browser = {
                    mappings = {
                        n = {
                            ["h"] = function(prompt_bufnr, bypass)
                                require("telescope").extensions.file_browser.actions
                                    .goto_parent_dir(prompt_bufnr, bypass)
                            end,
                            ["l"] = function(prompt_bufnr) require("telescope.actions").select_default(prompt_bufnr) end,
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
            telescope.load_extension("cmdline")
            vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"
        end,
    },
    -- https://github.com/nvim-telescope/telescope-file-browser.nvim?tab=readme-ov-file#installation
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>fb", ":Telescope file_browser<CR>",                               desc = "File browser from cwd" },
            { "<leader>fc", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File browser from current file" },
        },
    },
    -- https://github.com/axkirillov/easypick.nvim?tab=readme-ov-file#configuration
    {
        "axkirillov/easypick.nvim",
        config = function()
            local easypick = require("easypick")
            local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
            local base_branch = vim.fn.system(get_default_branch) or "main"
            easypick.setup({
                pickers = {
                    {
                        name = "changed_files",
                        command = "git diff --name-only",
                        previewer = easypick.previewers.branch_diff({ base_branch = base_branch })
                    },
                }
            })
        end,
        keys = {
            { "<leader>cf", "<cmd>Easypick changed_files<cr>", desc = "List changed files not staged" },
        },
    },
    -- https://github.com/lewis6991/gitsigns.nvim?tab=readme-ov-file#keymaps
    {
        "lewis6991/gitsigns.nvim",
        event = LazyFile,
        branch = "release",
        opts = {
            on_attach = function(bufnr)
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                local gs = package.loaded.gitsigns
                -- navigation
                map("n", "]c", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true })
                map("n", "[c", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true })
                -- keymaps
                map("n", "<leader>hb", function() gs.blame_line { full = true } end)
                map("n", "<leader>hs", gs.stage_hunk)
                map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end)
                map("n", "<leader>hu", gs.reset_hunk)
                map("v", "<leader>hu", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
            end
        }
    },
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    {
        "lukas-reineke/indent-blankline.nvim",
        event = LazyFile,
        main = "ibl",
        opts = {
            indent = { char = "▏" },
            scope = { show_start = false, show_end = false },
        }
    },
    -- https://github.com/christoomey/vim-tmux-navigator
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    -- https://github.com/iamcco/markdown-preview.nvim?tab=readme-ov-file#installation--usage
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    -- https://github.com/rbong/vim-flog?tab=readme-ov-file#installation
    {
        "rbong/vim-flog",
        tag = "v2.0.0",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
    -- https://github.com/kaplanz/retrail.nvim
    {
        "kaplanz/retrail.nvim",
        opts = { trim = { auto = false, }, },
    },
    -- https://github.com/g2boojum/vim-mcnp
    {
        "g2boojum/vim-mcnp",
    },
}, { ui = { border = "rounded" } })
