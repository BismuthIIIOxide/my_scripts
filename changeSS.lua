local change = {}
    warn([[\n
    ==============
        LOADED
    ==============
    ]])
function change:Other(STAT, VAL)
    STAT.Value = VAL
end
function change:PrintStyles()
warn([[
boxing
muaythai
karate
judo
sumo
wrestling
kungfu
taekwondo
woozy
]])
end
-- not stats
function change:Style(VAL)
    game.Players.LocalPlayer.pstats.style.Value = VAL
    game.Players.LocalPlayer.pstats.stylestate.Value = 4
end
function change:Element(VAL)
    game.Players.LocalPlayer.pstats.element.Value = VAL
end
function change:Clan(VAL)
    game.Players.LocalPlayer.pstats.clan.Value = VAL
end
function change:Armor(VAL)
    game.Players.LocalPlayer.soularmor.Value = VAL
end

-- stats
function change:Strength(VAL)
    game.Players.LocalPlayer.pstats.strength.Value = VAL
end
function change:Endurance(VAL)
    game.Players.LocalPlayer.pstats.endurance.Value = VAL
end
function change:Agility(VAL)
    game.Players.LocalPlayer.pstats.agility.Value = VAL
end
function change:Speed(VAL)
    game.Players.LocalPlayer.pstats.speed.Value = VAL
end
function change:Mana(VAL)
    game.Players.LocalPlayer.pstats.mana.Value = VAL
end
function change:Combatexp(VAL)
    game.Players.LocalPlayer.pstats.combatexp.Value = VAL
end

-- for fun
function change:Phrase(VAL)
    game.Players.LocalPlayer.phrase.Value = VAL
end
function change:Name(VAL)
    game.Players.LocalPlayer.guardianname.Value = VAL
end


getgenv()["change"] = change
