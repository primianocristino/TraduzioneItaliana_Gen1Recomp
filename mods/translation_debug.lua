-- mods/translation_debug.lua
return function(mod)
  mod.log:info("[DEBUG_TXT] Script di lettura RAM/Save avviato!")

  local function readGameData()
    mod.log:info("==========================================")
    mod.log:info("[DEBUG_TXT] ---> ESTRAZIONE DATI SAVE <---")

    if mod.save and type(mod.save.get) == "function" then
      -- Tentativo di lettura tramite le chiavi standard del recompiler C++ di Gen1Recomp
      local money = mod.save:get("wPlayerMoney")
      local hours = mod.save:get("wPlayTimeHours")
      local mins  = mod.save:get("wPlayTimeMinutes")
      local secs  = mod.save:get("wPlayTimeSeconds")

      mod.log:info("[DEBUG_TXT] wPlayerMoney: %s", tostring(money))
      mod.log:info("[DEBUG_TXT] wPlayTime: %s:%s:%s", tostring(hours), tostring(mins), tostring(secs))
      
      -- Se wPlayerMoney restituisce una tabella o userdata, proviamo a stamparne i campi
      if type(money) == "table" then
        for k, v in pairs(money) do
          mod.log:info("[DEBUG_TXT] money[%s] = %s", tostring(k), tostring(v))
        end
      end
    else
      mod.log:warn("[DEBUG_TXT] mod.save.get non disponibile o non è una funzione")
    end

    mod.log:info("==========================================")
  end

  -- Intercettiamo l'evento in cui il salvataggio è effettivamente pronto in memoria
  mod.events:on("map.enter", function()
    readGameData()
  end)
end