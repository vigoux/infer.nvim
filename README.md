# `infer.nvim`

## Usage

```lua
-- Load the infer report to the qf list, you must do this first
require'infer'.to_qflist("/path/to/report.json")

-- Focus on one event (get his stack)
require'infer'.focus(errnumber)

-- If you want to focus on the event currently selected in the qflist
require'infer'.focus()
```

This plugins makes a heavy use of the quickfix list, so after focusing
on one bug, you can just do:
```vim
" This returns to the older quickfix list, the one with the list of bugs
:colder
```

And if you want to jump back to the same error:
```vim
:cnewer
```
