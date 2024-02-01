local utils = {}

---get motion mark
---@param bufnr integer buffer index
---@param type string select type
---@return table #mark position
function utils.get_mark(bufnr, type)
  local pos_start, pos_finish
  if type == "char" then
    pos_start = vim.api.nvim_buf_get_mark(bufnr, "[")
    pos_finish = vim.api.nvim_buf_get_mark(bufnr, "]")
  else
    pos_start = vim.api.nvim_buf_get_mark(bufnr, "<")
    pos_finish = vim.api.nvim_buf_get_mark(bufnr, ">")
  end
  return {
    start = {
      row = pos_start[1],
      col = pos_start[2],
    },
    finish = {
      row = pos_finish[1],
      col = pos_finish[2],
    },
  }
end

---get selected text
---@param bufnr integer buffer index
---@param position table position table use:get_mark()
---@param type string select type
---@return string[] # selected text
function utils.get_text(bufnr, position, type)
  if type == "line" then
    return vim.api.nvim_buf_get_lines(bufnr, position.start.row - 1, position.finish.row, false)
  end
  if type == "block" then
    vim.notify("Block Select unable use", vim.log.levels.WARN)
    return { "" }
  end
  return vim.api.nvim_buf_get_text(
    bufnr,
    position.start.row - 1,
    position.start.col,
    position.finish.row - 1,
    utils.get_next_char_bytecol(position.finish.row, position.finish.col),
    {}
  )
end

---get next char bytecol
---@param linenr integer
---@param colnr integer
---@return integer
function utils.get_next_char_bytecol(linenr, colnr)
  local line = vim.fn.getline(linenr)
  local utf_index = vim.str_utfindex(line, math.min(line:len(), colnr + 1))
  return vim.str_byteindex(line, utf_index)
end

return utils
