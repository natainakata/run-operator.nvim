local M = {}

function M.operator(type)
  local position = get_mark(0, type)
end

function get_mark(bufnr, type)
  local pos_start, pos_finish
  if type == 'char' then
    pos_start = vim.api.nvim_buf_get_mark(bufnr, "[")
    pos_finish = vim.api.nvim_buf_get_mark(bufnr, "]")
  else
    pos_start = vim.api.nvim_buf_get_mark(bufnr, "<")
    pos_finish = vim.api.nvim_buf_get_mark(bufnr, ">")
  end
  return {
    start = {
      row = pos_start[1],
      col = pos_start[2]
    },
    finish = {
      row = pos_finish[1],
      col = pos_finish[2],
    }
  }
end

-- function get_text(bufnr, position, type)
--   if type == 'line' then
--     return vim.api.nvim_buf_get_lines(bufnr, position.start.row - 1, position.finish.row, false)
--   end
--   if type == 'block' then
--     vim.notify("Block Select unable use", vim.log.levels.WARN)
--     return ""
--   end
--   return vim.api.nvim_buf_get_text(
--     bufnr,
--     position.start.row - 1,
--     start.col,
--     finish.row - 1,
--
--   )
-- end
