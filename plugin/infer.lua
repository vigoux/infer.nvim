local infer = require 'infer'
local cmd = vim.api.nvim_create_user_command

cmd("InferLoad", function(args)
  infer.to_qflist(args.fargs[1])
end, { nargs = '?' })
cmd("InferFocus", function() infer.focus() end, {})
