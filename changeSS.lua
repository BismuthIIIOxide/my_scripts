local change = {}
local lp = game.Players.LocalPlayer
local pstats = lp.pstats

function change:Other(STAT, VAL)
    STAT.Value = VAL
end

-- not stats
function change:Style(VAL)
    pstats.style = VAL
    pstats.stylestate = 4
end
function change:Element(VAL)
    pstats.element = VAL
end
function change:Clan(VAL)
    pstats.clan = VAL
end
function change:Armor(VAL)
    lp.soularmor = VAL
end

-- stats
function change:Strength(VAL)
    pstats.strength = VAL
end
function change:Endurance(VAL)
    pstats.endurance = VAL
end
function change:Agility(VAL)
    pstats.agility = VAL
end
function change:Speed(VAL)
    pstats.speed = VAL
end
function change:Mana(VAL)
    pstats.mana = VAL
end
function change:Combatexp(VAL)
    pstats.combatexp = VAL
end

-- for fun
function change:Phrase(VAL)
    lp.phrase = VAL
end
function change:Name(VAL)
    lp.guardianname = VAL
end


getgenv()["change"] = change
