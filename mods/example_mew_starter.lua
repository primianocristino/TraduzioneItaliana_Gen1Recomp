-- example_mew_starter.lua
return function(mod)
  -- Intercettiamo l'assegnazione del Mew prima che venga dato al giocatore
  mod.events:on("pokemon.before_give", function(gift)
    if gift.species == "MEW" and gift.nickname == "HOGHEAD" then
      gift.nickname = "MEW" -- Sostituisci con il nickname in italiano se preferisci
    end
  end)
end