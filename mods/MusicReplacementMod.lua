return function(mod)
  -- 1. Traduzione tramite hook o sovrascrittura delle tabelle globali della mod se accessibili,
  -- oppure traduciamo l'output della funzione che mostra il valore a schermo.
  
  if mod.ui and mod.ui.insertAfter then
    local originalInsertAfter = mod.ui.insertAfter
    mod.ui.insertAfter = function(rows, anchor, row)
      for i, a in ipairs({ "SFX VOL", "MUSIC VOL", "SOUNDTRACK" }) do
        if anchor == a then
          if a == "MUSIC VOL" then anchor = "VOL. MUSICA" end
          if a == "SFX VOL" then anchor = "VOL. EFFETTI" end
          if a == "SOUNDTRACK" then anchor = "COLONNA SONORA" end
          break
        end
      end
      if row then
        if row.id == "mod_soundtrack" then
          row.label = "COLONNA SONORA"
          -- Intercettiamo e traduciamo il valore restituito a schermo per la colonna sonora
          local origValue = row.value
          row.value = function()
            local val = origValue and origValue() or ""
            if val == "ORIGINAL" then return "ORIGINALE"
            elseif val == "GBA / FIRE RED" then return "GBA / ROSSO FUOCO"
            elseif val == "LET'S GO" then return "LET'S GO" end
            return val
          end
        elseif row.id == "mod_sfx_pack" then
          row.label = "EFFETTI SONORI"
          -- Intercettiamo e traduciamo il valore restituito a schermo per gli effetti sonori
          local origValue = row.value
          row.value = function()
            local val = origValue and origValue() or ""
            if val == "ORIGINAL" then return "ORIGINALE"
            elseif val == "FIRE RED" then return "ROSSO FUOCO"
            elseif val == "MODERN" then return "MODERNO"
            elseif val == "GEN 5" then return "GEN 5" end
            return val
          end
        end
      end
      return originalInsertAfter(rows, anchor, row)
    end
  end
end