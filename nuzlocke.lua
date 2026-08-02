-- nuzlocke.lua
return function(mod)
  -- 1. Intercettiamo direttamente l'inserimento dei dialoghi della Mod Nuzlocke
  if mod.ui and mod.ui.insertStepAfter then
    local originalInsert = mod.ui.insertStepAfter
    mod.ui.insertStepAfter = function(steps, afterId, stepData)
      if stepData then
        if stepData.id == "nuzlocke_intro" then
          stepData.text = "Una Nuzlocke é una\npromessa.\fOgni perdita é\npermanente."
        elseif stepData.id == "nuzlocke_slow_start" then
          stepData.text = "Usare PARTENZA LENTA?\nLe regole iniziano con\nle POKé BALL."
        elseif stepData.id == "nuzlocke_dupes" then
          stepData.text = "Se incontri una\nfamiglia gia' nota?"
          stepData.choices = { "SALTA", "PERDI" }
        elseif stepData.id == "nuzlocke_safari" then
          stepData.text = "Settori ZONA SAFARI\nseparati?"
        elseif stepData.id == "nuzlocke_close" then
          stepData.text = "Dai un nome a ogni\namico. Tienili al\nsicuro. Buona fortuna!"
        end
      end
      return originalInsert(steps, afterId, stepData)
    end
  end

  -- 2. Traduzione dei messaggi dinamici durante la cattura nei combattimenti
  mod.events:on("game.ready", function()
    local BattleState = require("src.battle.BattleState")
    if BattleState and BattleState.throwBall then
      local currentThrow = BattleState.throwBall
      BattleState.throwBall = function(self, ball)
        local originalSay = self.say
        self.say = function(sSelf, text)
          if text == "This area already\nhas a captured POKéMON!" then
            text = "Hai gia' catturato un\nPOKéMON in quest'area!"
          elseif text == "You already have\nthis POKéMON family!" then
            text = "Possiedi gia' questa\nfamiglia di POKéMON!"
          end
          return originalSay(sSelf, text)
        end
        
        local res = currentThrow(self, ball)
        self.say = originalSay
        return res
      end
    end
  end)
end