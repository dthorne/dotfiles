-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local function table_to_json(tbl)
  local function serialize(tbl)
    local result = {}
    for k, v in pairs(tbl) do
      local key = '"' .. tostring(k) .. '"'
      local value
      if type(v) == "table" then
        value = serialize(v)
      elseif type(v) == "string" then
        value = '"' .. v .. '"'
      else
        value = tostring(v)
      end
      table.insert(result, key .. ":" .. value)
    end
    return "{" .. table.concat(result, ",") .. "}"
  end
  return serialize(tbl)
end
-- define a function to add all which-key bindings to a buffer
function print_bindings()
  local wk = require("which-key.config")
  local buf = vim.api.nvim_create_buf(false, true)
  local mappings_json = table_to_json(wk.mappings)

  vim.api.nvim_buf_set_option(buf, "filetype", "json")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {mappings_json})
  vim.api.nvim_set_current_buf(buf)
end


-- define vim command
vim.cmd("command! PrintBindings lua print_bindings()")
