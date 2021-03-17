local change = {}
local lp = game.Players.LocalPlayer
local pstats = lp.pstats

function change:Other(STAT, VAL)
    STAT.Value = VAL
end

-- not stats
function change:Style(VAL)
    pstats.style.Value = VAL
    pstats.stylestate.Value = 4
end
function change:Element(VAL)
    pstats.element.Value = VAL
end
function change:Clan(VAL)
    pstats.clan.Value = VAL
end
function change:Armor(VAL)
    lp.soularmor.Value = VAL
end

-- stats
function change:Strength(VAL)
    pstats.strength.Value = VAL
end
function change:Endurance(VAL)
    pstats.endurance.Value = VAL
end
function change:Agility(VAL)
    pstats.agility.Value = VAL
end
function change:Speed(VAL)
    pstats.speed.Value = VAL
end
function change:Mana(VAL)
    pstats.mana.Value = VAL
end
function change:Combatexp(VAL)
    pstats.combatexp.Value = VAL
end

-- for fun
function change:Phrase(VAL)
    lp.phrase.Value = VAL
end
function change:Name(VAL)
    lp.guardianname.Value = VAL
end


getgenv()["change"] = change
