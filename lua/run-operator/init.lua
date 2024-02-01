local M = {}
local utils = require("run-operator.utils")

---trigger operator
---@param motion string
function M.operator(motion)
  vim.o.operatorfunc = "v:lua.require'run-operator'.operator_callback"
  vim.api.nvim_feedkeys("g@" .. (motion or ""), "mi", false)
end


function M.operator_callback(type)
  local position = utils.get_mark(0, type)
  local text = utils.get_text(0, position, type)
  vim.notify("get: " .. table.concat(text, "\n"), vim.log.levels.INFO)
end

return M
