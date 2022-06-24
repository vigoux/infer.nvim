local M = {}

local cached = {}

local function load_report(fname)
  local file = io.open(fname)
  if file then
    local content = vim.json.decode(file:read "*a")
    return content
  else
    return {}
  end
end

function M.to_qflist(fname)
  fname = fname or "./infer-out/report.json"
  local content = load_report(fname)
  local qf_content = {}
  for index, err in ipairs(content) do
    local qfitem = {
      filename = err.file,
      lnum = err.line,
      col = err.column,
      nr = index,
      text = err.qualifier,
      valid = true,
    }
    table.insert(qf_content, qfitem)
  end
  vim.fn.setqflist({}, ' ', {
    items = qf_content,
    context = content,
    title = "Infer report",
  })
end

function M.focus(errnr)
  local qfstate = vim.fn.getqflist { idx = 0, context = true }

  local item = qfstate.context[errnr or qfstate.idx]
  if not item then return end

  local newqf = {}
  for _, suberr in ipairs(item.bug_trace) do
    local nqfitem = {
      filename = suberr.filename,
      lnum = suberr.line_number,
      col = suberr.column_number,
      text = suberr.description,
      nr = suberr.level,
      valid = true,
    }
    table.insert(newqf, nqfitem)
  end

  vim.fn.setqflist({}, ' ', {
    items = newqf,
    title = string.format("Infer focus: %s", item.key)
  })
end

return M
