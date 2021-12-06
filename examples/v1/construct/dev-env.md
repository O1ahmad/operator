# Configure the development environment of inventory node (e.g. tmux configuration):
* installation and configuration of the tmux terminal multi-plexer 
* installation and configuration of the vim text editor

### curl --request POST --data @dev-example.json https://{operator-host-address}:{port}/v1/construct
------------
`> cat dev-example.json`
```json
{
    "id": "dev-env",
    "setup": [
        {
            "type": "tmux",
            "url": "0x0i.tmux",
            "properties": {
                "tmux_config": {
                    "ahmad": [
                        {
                            "comment": "Add ctrl-A as secondary prefix key",
                            "commands": [
                                { "set": "-g prefix2 C-a" },
                                { "bind": "C-a send-prefix -2" }
                            ]
                        },
                        {
                            "comment": "Bind current vertical/horizontal split-window keys to values not requiring ^(shift)",
                            "commands": [
                                { "bind": "- split-window -v" },
                                { "bind": "/ split-window -h" }
                            ]
                        },
                        {
                            "comment": "More convenient macros for general operations",
                            "commands": [
                                { "bind": "C-n new-session" },
                                { "bind": "C-w new-window" },
                                { "bind": "C-d detach-client" },
                                { "bind": "C-p paste-buffer" },
                                { "bind": "R refresh-client" },
                                { "unbind": "r; bind r source-file ~/.tmux.conf" }
                            ]
                        },
                        {
                            "comment": "set first window to index 1 (not 0) to map more to the keyboard layout",
                            "commands": [
                                { "set": "-g base-index 1" },
                                { "set": "-g pane-base-index 1" }
                            ]
                        },
                        {
                            "comment": "Enable use of the mouse to switch panes",
                            "commands": [
                                { "setw": "-g mouse" }
                            ]
                        },
                        {
                            "comment": "Enable Switching panes with alt",
                            "commands": [
                                { "bind": "-n M-Left select-pane -L" },
                                { "bind": "-n M-Right select-pane -R" },
                                { "bind": "-n M-Up select-pane -U" },
                                { "bind": "-n M-Down select-pane -D" }
                            ]
                        },
                        {
                            "comment": "Visual Activity Monitoring between windows",
                            "commands": [
                                { "setw": "-g monitor-activity on" },
                                { "set": "-g visual-activity on" }
                            ]
                        },
                        {
                            "comment": "install TPM plugin manager",
                            "commands": [
                                { "set": "-g @plugin 'tmux-plugins/tpm'" }
                            ]
                        },
                        {
                            "comment": "tmux-resurrect - save and reload sessions and windows after a restart",
                            "commands": [
                                { "set": "-g @plugin 'tmux-plugins/tmux-resurrect'" },
                                { "set": "-g @resurrect-strategy-vim 'session'" },
                                { "set": "-g @resurrect-capture-pane-contents 'on'" },
                                { "set": "-g @resurrect-save-bash-history 'on'" }
                            ]
                        },
                        {
                            "comment": "tmux-continuum - automatically save and restore tmux sessions",
                            "commands": [
                                { "set": "-g @plugin 'tmux-plugins/tmux-continuum'" },
                                { "set": "-g @continuum-restore 'on'" },
                                { "set": "-g @continuum-save-interval '5'" }
                            ]
                        },
                        {
                            "comment": "tmux-yank - advanced copy mode",
                            "commands": [
                                { "set": "-g @plugin 'tmux-plugins/tmux-yank'" }
                            ]
                        },
                        {
                            "comment": "tmux-sidebar - provides tree view for inspecting current path/filesystem",
                            "commands": [
                                { "set": "-g @plugin 'tmux-plugins/tmux-sidebar'" }
                            ]
                        },
                        {
                            "comment": "tmux-open - opening highlighted selection directly from Tmux copy mode",
                            "commands": [
                                { "set": "-g @plugin 'tmux-plugins/tmux-open'" }
                            ]
                        },
                        {
                            "comment": "tmux-copycat - advanced regex searching",
                            "commands": [
                                { "set": "-g @plugin 'tmux-plugins/tmux-copycat'" }
                            ]
                        },
                        {
                            "comment": "initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)",
                            "commands": [
                                { "run": "'~/.tmux/plugins/tpm/tpm'" }
                            ]
                        }
                    ]
                }
            }
        },
        {
            "type": "vim",
            "url": "0x0i.vim",
            "properties": {
                "tmux_config": {
                    "global": [
                        {
                            "comment": "Disable compatibility with vi",
                            "commands": [
                                { "set": "nocompatible" }
                            ]
                        },
                    ],
                    "ahmad": [
                        {
                            "comment": "Disable compatibility with vi",
                            "commands": [
                                { "set": "nocompatible" }
                            ]
                        },
                        {
                            "comment": "Load sane defaults",
                            "commands": [
                                { "source": "$VIMRUNTIME/defaults.vim" }
                            ]
                        },
                        {
                            "comment": "Help force plugins to load correctly when re-enabled below",
                            "commands": [
                                { "filetype": "off" }
                            ]
                        },
                        {
                            "comment": "Enable syntax highlighting",
                            "commands": [
                                { "syntax": "enable" }
                            ]
                        },
                        {
                            "comment": "Spaces and tabs",
                            "commands": [
                                { "set": "tabstop=4" },
                                { "set": "softtabstop=4" },
                                { "set": "expandtab" },
                                { "set": "shiftwidth=4" }
                            ]
                        },
                        {
                            "comment": "Searching",
                            "commands": [
                                { "set": "incsearch" },
                                { "set": "hlsearch" },
                                { "set": "ignorecase" },
                                { "set": "smartcase" },
                                { "set": "showmatch" },
                                { "nnoremap": "<leader><space> :nohlsearch<CR>" }
                            ]
                        },
                        {
                            "comment": "Folding",
                            "commands": [
                                { "set": "foldenable" },
                                { "set": "foldlevelstart=10" },
                                { "set": "foldnestmax=10" },
                                { "nnoremap": "<space> za" },
                                { "set": "foldmethod=marker" }
                            ]
                        },
                        {
                            "comment": "UI config",
                            "commands": [
                                { "set": "number" },
                                { "set": "ttyfast" },
                                { "set": "laststatus=2" },
                                { "set": "showcmd" },
                                { "set": "showmode" },
                                { "set": "cursorline" },
                                { "filetype": "indent on" },
                                { "set": "wildmenu" },
                                { "set": "ruler" },
                                { "set": "visualbell" },
                                { "set": "encoding=utf-8" },
                                { "set": "lazyredraw" }
                            ]
                        },
                        {
                            "comment": "Movement",
                            "commands": [
                                { "nnoremap": "j gj" },
                                { "nnoremap": "k gk" },
                                { "nnoremap": "B ^" },
                                { "nnoremap": "E $" },
                                { "nnoremap": "gV `[v`]" }
                            ]
                        },
                        {
                            "comment": "Leader shortcuts",
                            "commands": [
                                { "let": "mapleader=','" },
                                { "set": "cursorline" },
                                { "nnoremap": "<leader>u :GundoToggle<CR>" },
                                { "nnoremap": "<leader>ev :vsp $MYVIMRC<CR>" },
                                { "nnoremap": "<leader>eb :vsp ~/.bashrc<CR>" },
                                { "nnoremap": "<leader>sv :source $MYVIMRC<CR>" },
                                { "nnoremap": "<leader>s :mksession<CR>" },
                                { "nnoremap": "<leader>a :Ag" }
                            ]
                        },
                        {
                            "comment": "Plugins",
                            "commands": [
                                { "set": "rtp+=~/.vim/bundle/Vundle.vim" },
                                { "call": "vundle#begin()" },
                                { "Plugin": "'VundleVim/Vundle.vim'" },
                                { "Plugin": "'scrooloose/nerdtree'" },
                                { "Plugin": "'ErichDonGubler/vim-sublime-monokai'" },
                                { "Plugin": "'joshdick/onedark.vim'" },
                                { "Plugin": "'vim-syntastic/syntastic'" },
                                { "Plugin": "'rking/ag.vim'" },
                                { "Plugin": "'ctrlpvim/ctrlp.vim'" },
                                { "Plugin": "'sjl/gundo.vim'" },
                                { "call": "vundle#end()" },
                                { "filetype": "plugin indent on" }
                            ]
                        },
                        {
                            "comment": "NERDTree settings",
                            "commands": [
                                { "autocmd": "vimenter * NERDTree" },
                                { "autocmd": "vimEnter * wincmd p" },
                                { "autocmd": "bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif" },
                                { "map": "<C-n> :NERDTreeToggle<CR>" }
                            ]
                        },
                        {
                            "comment": "syntastic settings",
                            "commands": [
                                { "let": "g:syntastic_python_python_exec = 'python3'" }
                            ]
                        },
                        {
                            "comment": "set color-scheme",
                            "commands": [
                                { "colorscheme": "onedark" },
                                { "set": "t_Co=256" }
                            ]
                        }
                    ]
                }
            }
        }
    ],
    "inventory": [
        {
            "name": "example-node",
            "address": "localhost",
            "user": "example-user",
            "roles": ["tmux", "vim"]
        }
    ]
}
```
