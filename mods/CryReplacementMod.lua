return function(mod)
  if mod.options and mod.options.define then
    local originalDefine = mod.options.define
    mod.options.define = function(self, optionsDef)
      if type(optionsDef) == "table" then
        for _, opt in ipairs(optionsDef) do
          if opt.key == "cries" then
            opt.label = "VERSI POKEMON"
            if opt.choices then
              for _, choice in ipairs(opt.choices) do
                if choice[1] == "ORIGINAL" then choice[1] = "ORIGINALE"
                elseif choice[1] == "ANIME" then choice[1] = "ANIME"
                elseif choice[1] == "FIRE RED" then choice[1] = "ROSSO FUOCO" end
              end
            end
          end
        end
      end
      return originalDefine(self, optionsDef)
    end
  end

  if mod.ui and mod.ui.insertAfter then
    local originalInsertAfter = mod.ui.insertAfter
    mod.ui.insertAfter = function(rows, anchor, row)
      for i, a in ipairs({ "SFX VOL", "MUSIC VOL", "PIKACHU VOL", "POKEMON CRIES" }) do
        if anchor == a then
          if a == "MUSIC VOL" then anchor = "VOL. MUSICA" end
          if a == "SFX VOL" then anchor = "VOL. EFFETTI" end
          if a == "PIKACHU VOL" then anchor = "VOL. PIKACHU" end
          if a == "POKEMON CRIES" then anchor = "VERSI POKEMON" end
          break
        end
      end
      if row then
        if row.id == "mod_cries" then
          row.label = "VERSI POKEMON"
          local origValue = row.value
          row.value = function()
            local val = origValue and origValue() or ""
            if val == "ORIGINAL" then return "ORIGINALE"
            elseif val == "ANIME" then return "ANIME"
            elseif val == "FIRE RED" then return "ROSSO FUOCO" end
            return val
          end
        end
      end
      return originalInsertAfter(rows, anchor, row)
    end
  end
end