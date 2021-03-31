local M = {}

function M.first_non_nil(...)
  local n = select('#', ...)
  for i = 1, n do
    local value = select(i, ...)

    if value ~= nil then
      return value
    end
  end
end

function M.lookup(t, ...)
    for _, k in pairs{...} do
        t = t[k]
        if not t then
            return nil
        end
    end
    return t
end

return M
