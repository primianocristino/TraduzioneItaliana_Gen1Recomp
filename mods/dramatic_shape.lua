-- scripts/dramatic_shape.lua
return function(mod)

  local translations = {
    ["BATTLE SIZE"]  = "DIMENSIONE LOTTA",
    ["BATTLE BG"]    = "SFONDO LOTTA",
    ["FAITHFUL RES"] = "RESA FEDELE",
    ["VOXEL"]        = "PROSPETTIVA 3D",
    ["T-SHIFT"]      = "SFOCATURA 3D"
  }

  mod.hooks:wrap("ui.options.rows", function(next_fn, self, ...)
    local rows = next_fn(self, ...)
    if type(rows) == "table" then
      for _, row in ipairs(rows) do
        if row.label and translations[row.label] then
          row.label = translations[row.label]
        end
      end
    end
    return rows
  end)

end