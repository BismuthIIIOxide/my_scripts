local PLAYER = "" -- can be a nick name



-->> PJJ Player Stats Grabber(singular)
-->> ValentinesDayAlone
-->> June 23, 2020
-->> updated fusions, new stands and shit yyayayayayyayayay
-->> ROBLOX has a stroke if you use custom functions, shouldn't be a suprise though
local exploitWrite = false; if writefile then exploitWrite = true end; -- writefile check, added before actual script just because
print(exploitWrite) -- debug 

-- > begin script
local function GetPlayerFromString(s)
    s = s:lower() -- Remove this if you want case sensitivity
    for _, player in ipairs(game.Players:GetPlayers()) do
        if s == player.Name:lower():sub(1, #s) then
            return player
        end
    end
    return nil
end

local blessings = { -- all the blessings
    ["Holy"] = "All cooldowns are halved.";

    ["Divine"] = "Chance to do critical damage [3.5x] to an opponent. (1/3)";
    
    ["Blessed"] = "Redirects 20% of damage taken towards the attacker.";
    
    ["Sanctified"] = "Chance to take 3.5x less damage from an attack.";
    
    ["Saintly"] = "Chance to inflict the Holy Flames. (1/4) - Saintly deals 19-20 tick damage that is 17.8% of the base damage of the attack used.";
    
    ["Heavenly"] = "Chance to summon heaven orbs that fly at the target being damaged. (1/5)";
    
    ["Angelic"] = "All damage triggers a minor stun effect and all damage bypasses dodge/damage counters, including: RTZ, sanctified, blessed, love train and others.";
    
    ["Hallowed"] = "On kill, enemies will explode around the killed player. Hallowed Explosion damage is based on proximity to the source. Users will have to be near the source to be effected by this Blessing. (Still pretty effective at the edge of the AoE) It just does much less. Damage is based off the Original Subjects' HP.";
    
    ["Righteous"] = "Pull in all nearby targets while constantly damaging them while posing. (Random chance of activating) In addition, this will double your on-damage proc rate. (Example: twice as likely for a WS sub to proc)";
    
    ["Anointed"] = "Outputted damage will always deal slight percentage damage to your opponent.";
    
    ["Transcendent"] = "Grants immunity to all knockback/stun (similar to GER's passive), plus additional immunity to White Album's freeze. Effects like Harvest's Drunkenness does not count as a Stun, it is a Status Effect.";
    
    ["Almighty"] = "Repel all nearby targets while constantly damaging them while posing. (Random chance of activating) In addition, this will double your on-damage proc rate. (Example: twice as likely for a WS sub to proc)";
    
    ["Exalted"] = "Block nearly all damage from opponents while posing. (Has a chance to be bypassed) [Random chance of activating] In addition, this will double your on-damage proc rate. (Example: twice as likely for a WS sub to proc)";

    ["None"] = "" -- although i could just check for this in a "normal" way, i dont give a shit because im a dumbass
} 

local fusions = {-- fusions, of course PJJ sucks and some of them probably dont wont (like GE/GER and all the AU ones). I also dont know why the it's not in the order it was in, but whatever.
    ["TheWorld"] = "Allows your designated stand the ability to use Time-Stop. Cooldown is 2 minutes.",

    ["SmashingPumpkin"] = "Allows you to use Sneaking Shadow.",

    ["Metallica"] = "Grants the ability Iron Cloak.",

    ["CreamStarter"] = "Gives attacks a chance to blind.",

    ["Whitesnake"] = "Grants the ability to silence a target upon damage for a short amount of time. The proc chance for this is very low.",

    ["FunFunFun"] = "Any players that take damage, within a certain range of you, get marked. Gives you the Limb Control ability.",

    ["Rumble"] = "Gives the ability of Slam Dunk.",

    ["CrazyDiamond"] = "Gives any projectile move the chance to home in on targets.",

    ["ChariotRequiem"] = "Gives you the Sleep Aura, and the Bodyswap passive. The cooldown on it is proportional to the regular SCR's aura.",

    ["TheWorldOverHeaven"] = "Basic melee becomes Over Heavenly melee plus granting Mini Star-Volley.",

    ["Mr.President"] = "Passive doubled defense.",

    ["StarPlatinumPrime"] = "Turns basic melee into Strong melee, 1.5x melee damage plus giving Super Ora punch. This Passives applies to all melee types, EXCLUDING Over-Heavens.",

    ["Anubis"] = "Allows the stand user to use Anubis' deflect move.",

    ["Star-SpangledBanner"] = "Gives all Rush Attacks an infinite duration. (Excludes Homing Barrages) Gives the fusion move SSB's F move. This gives certain non-humanoid stand barrages like Emperor's E infinite duration.",

    ["Kiss"] = "Most projectiles are duplicated 3x and offset plus granting Self-Arm duplication. Projectiles only have a chance to become tripled. - SoD's Missiles, Harvest projectiles, Echoes Act 2 projectiles, The Sun's beam, Metallica's scalpels, BNR's smoke bombs, and KQAU's mines will not be duplicated with Kiss as a subfusion..",

    ["MagiciansRed"] = "Your projectiles become engulfed in flames, dealing damage dependent on the projectile's damage.",

    ["HeavensDoor"] = "Gives Open Book move to your stand.",

    ["Aerosmith"] = "Allows your stand to use Machine Gun.",

    ["MoodyBlues"] = "Let's you use the 'Replay!' ability Moody Blues' T move.",

    ["WhiteWedding"] = "Grants the ability of Ionic Bond.",

    ["CrazyTrain"] = "Grants Relativity Shift.",

    ["HermitPurple"] = "Grants a chance to pull in target with vine upon damage.",

    ["TheHand"] = "Gives Erasure Damage for all attacks above a certain damage scaling threshold. (More than 10,000 Damage). As well as grants Erasure Swipe as your U ability.",

    ["CreamOverHeaven"] = "Chance to put the target to sleep upon damage.",

    ["KingCrimson"] = "Allows your stand to Time-Erase. Will not allow you to move during a time stop, however.",

    ["TheEmperor"] = "Makes any projectiles into weak homing projectiles. (Damage is reduced by 1.5x.",

    ["SpeedKing"] = "Damage dealt will have a chance to ignite the enemy, dealing flame damage over time. You must be close range to activate the ability.",

    ["MadeInHeaven"] = "Grants the stand user the ability to Universe Reset plus its Over Heaven melee type, alongside a heavy speed boost.",

    ["StarPlatinum"] = "Turns basic melee into Strong melee, 1.5x melee damage plus giving Bearing Shot. This Passives applies to all melee types, EXCLUDING Over-Heavens.",

    ["SpiceGirl"] = "Chance to bounce the enemy away from you upon damage, as well as granting the ability to use Soft Bounce.",

    ["StickyFingers"] = "Grants the head-removing Head Detachment ability. Has a cooldown of 7.5 seconds.",

    ["TheSun"] = "Gives the main stand the ability Bright Burner (passive ability). Certain stands do not work with this Passive, this includes: Harvest, Six Pistols, The Emperor, Metallica, etc.",

    ["Harvest"] = "Grants the chance to cause drunk effect upon damage.",

    ["Echoes"] = "Percent chance that attacks apply the Three-Freeze effect.",

    ["BlackSabbath"] = "Ability to teleport behind player closest to your cursor. Has a range of about The World's Time Stop.",

    ["WhiteAlbum"] = "Chance to freeze target upon damage.",

    ["Cream"] = "All forms of damage will deal Void damage. Void does x2.5 damage based on proximity. Ineffective if you leave a certain range.",

    ["SilverChariot"] = "Grants your stand Silver Chariot's sword. DOESN'T change the rush to the sword, instead letting you use Silver Chariot's Flanking Slash.",

    ["None"] = "", -- same as before, don't care. never will. probably

    ["KillerQueen"] = "1/4 chance for a projectile to become explosive, dealing triple the damage. Grants the fusion ability Primary Bomb.",

    ["20thCenturyBoy"] = "Grants Absolute Defense.",

    ["HeyYa"] = "100% chance to dodge physical attacks. This includes stand rushes (NOT over heaven), and strong punches.",

    ["StoneFree"] = "Grants String Tether. Longer cooldown than regular Stone Free.",

    ["KillerQueenAlternateUniverse"] = "Damage done below a certain damage scaling threshold causes mini explosions. (Damage Below 3000). You also obtain the U ability, Mini Sheer Heart attacks.",

    ["StarPlatinumOverHeaven"] = "Basic melee becomes Over Heavenly melee plus granting Star Blast.",

    ["SymphonyofDestruction"] = "Grants Radioactive Tremor that pulls in targets and explodes.",

    ["GuestPlatinum"] = "Holding U will use a Homing Rush.",

    ["BallBreaker"] = "Grants Infinite Rotation, making all damage AOE transfer. 1/4 chance to cause Infinite Rotation. Also grant's the Infinite Rotation Blast move.",

    ["Soft&Wet"] = "Damage done to a nearby enemy has a chance of stealing their balance. Changes most melee to bubble melee, and giving you the Bubble Prison fusion ability.",

    ["HighwayStar"] = "All attacks give Life Steal. This Life Steal can be combined with vampire to buff life steal damage. 1/4 chance to Life Steal 100% of the damage you gave them.",

    ["BokunoRhythmwoKiitekure"] = "Grants Sticky-Bomb Toss. Close-ranged attacks have the chance to put a bomb on them, albeit a very low chance.",

    ["ScaryMonsters"] = "Allows a chance to spawn a dino minion upon damage. Has an approximately 1/15 chance of activating. (User has to be within close range.)",

    ["DiverDown"] = "All damage dealt becomes Stored Energy within the target, and releases on a delay similar to its barrage. Delayed damage dealt is 50% Extra.",

    ["GoldExperience/Requiem"] = "Turns basic punches into GER punches, grants Return to Zero and the ability to see any D4C in dimension and such. This fusion relies on power. (Requires requiem to use RTZ.",

    ["Mandom"] = "Allows the stand to rewind time.",

    ["Ratt"] = "Chance to add 2.66x damage. 1/3 of your total damage happen 8 total times, dealing damage over time. (example: 1000-> 333 (x8).",

    ["WeatherReport"] = "Damage done to an enemy that is far away has a chance of shooting a snail at them.",

    ["TheWorldAlternateUniverse"] = "Gives SOME/CERTAIN stand's E attacks the homing property, allows the use of Knife Throw. Barrages will change to the Piercing type. This removes the ability to do % damage.",

    ["Tusk"] = "Damage done that is 30% or more of the target's max hp applies the infinite spin debuff to them. (This will NOT increase their damage.) Gives the ability to use \"Fingernail Shotgun\". Turns Basic punches into Tusk punches, scaling off of Power.",

    ["C-Moon"] = "Gives Gravity Manipulation and Basic Melee turn into Inversion Melee. It only delays melee damage. - Only affects Basic Stand Punches. Will not affect Barrages or any other sort of Melee Attacks.",

    ["HierophantGreen"] = "Damage dealt to others has a chance to proc a Tentacle Stun. Adds the ability to use Emerald Splash as your U Utility.",

    ["SexPistols"] = "Projectiles are guaranteed to auto aim (projectiles don't become homing, they're aimed towards the nearest target). Also buffs projectiles by 35%.",

    ["RollingStones"] = "Damage dealt to targets with 25% or less health instantly kills the target.",

    ["AtomHeartFather"] = "Grants the ability to use photo flight.",

    ["Osiris"] = "Grants the Soul Chip move. Reduces your Overall Base Damage.",

    ["PurpleHaze"] = "Basic melee has a chance of becoming Bulb Punch plus grants the Bulb Cannon.",

    ["D4C"] = "Gives the ability to use Dimensional Flag. It cannot bypass time stops nor time accelerations while in Dimension. The user can't stand jump while using this move either. The fusion ability's cooldown is currently 10 seconds per use.",

    ["TheGratefulDead"] = "Grants Aging Aura, a new passive that will whittle anyone in its radius' defense and speed. This will also give you the give Ice sub-ability.",
    
    ["BoyIIMan"] = "Grants the ability to steal a stand's E move.",

    ["ChocolateDisco"] = "Grants Projectile Dislocation."
}

local plr2 = GetPlayerFromString(PLAYER)
plr2 = plr2.Name

local pltrait = game.Players[plr2].Trait.Value
local plendurance = game.Players[plr2].Endurance.Value
local pllvl = game.Players[plr2].Level.Value
local plmoney = game.Players[plr2].Money.Value
local plpower = game.Players[plr2].Power.Value
local plspecial = game.Players[plr2].Special.Value
local plstand = game.Players[plr2].Stand.Value
local plworth = game.Players[plr2].Worth.Value
local plblessing = game.Players[plr2].Blessing.Value
local plfusion = game.Players[plr2].FusedStand.Value
local plstandlvl = game.Players[plr2].StandLevel.Value
local plreq = game.Players[plr2].Requiem.Value
local plulf = game.Players[plr2].IsUltimate.Value
local plhamon = game.Players[plr2].IsHamon.Value
local plvampire = game.Players[plr2].IsVampire.Value
local plrock = game.Players[plr2].IsRock.Value
local plspin = game.Players[plr2].IsSpin.Value
local plstolen1 = game.Players[plr2].stolenability1.Value
local plstolen2 = game.Players[plr2].stolenability2.Value
local plstolen3 = game.Players[plr2].stolenability3.Value
local plstolen4 = game.Players[plr2].stolenability4.Value
local caps = string.upper(plr2)
local funnystring = ""
local blessing = ""
local fusion = ""

if plfusion ~= "None" then -- checks if fusion exists
    funnystring = plstand..' + '..plfusion..caps
else
    funnystring = plstand..caps
end

for i, v in pairs(blessings) do 
    if string.find(plblessing, i) then -- find the blessing the user has
        print(plblessing) -- for debugging
        if plblessing == "None" then
            blessing = plblessing
        else
            blessing = plblessing.. ' -- '.. v -- adds what the blessing does, because opening the trello is dumb and takes too long. fuck you
        end
    end
end
warn(plfusion)-- for debugging
for i, v in pairs(fusions) do
    --warn(i, v) --this is dumb so ignore it
    if string.find(plfusion, i) then -- find the fusion the user has
        warn(plfusion) -- for debugging
        if plfusion == "None" then
            fusion = plfusion
        else
            fusion = plfusion.. ' -- '.. v -- adds what the fusion does, because opening the trello is dumb and takes even longer than blessings. i FUCKING HATE YOU TRELLO MANAGERS
        end
    end
end

local stuffSTRING = ""
local stuff
if plstand == "BoyIIMan" then 
    if string.find(plstolen4, "REQ") ~= nil then
        plstolen4 = string.gsub(plstolen4, "REQ", "")
    end
    stuff = { -- the B2M version, includes the stolen abilities
        "USER: "..plr2..'\n';
        "-------------------------------------------------- \n";
        "STAND: ".. plstand;
        "FUSION: ".. fusion;
        "TRAIT: ".. pltrait;
        "BLESSING: ".. blessing .. "\n";
        "----------------------------------------------------\n";
        "ENDURANCE: ".. plendurance;
        "POWER: ".. plpower;
        "SPECIAL: ".. plspecial;
        "STAND LEVEL: " .. plstandlvl;
        "LEVEL: " .. pllvl .. '\n';
        "----------------------------------------------------\n";
        "REQ: " .. tostring(plreq),
        "SPIN: " .. tostring(plspin),
        "HAMON: " .. tostring(plhamon),
        "VAMP:" .. tostring(plvampire),
        "ULF: " .. tostring(plulf),
        "ROCK: " .. tostring(plrock),
        "----------------------------------------------------\n";
        "ABILITY 1: ".. plstolen1;
        "ABILITY 2: ".. plstolen2;
        "ABILITY 3: ".. plstolen3;
        "ABILITY 4: ".. plstolen4; 
}
else
    stuff = { -- write whats needed for the file
        "USER: "..plr2..'\n';
        "-------------------------------------------------- \n";
        "STAND: ".. plstand;
        "FUSION: ".. fusion;
        "TRAIT: ".. pltrait;
        "BLESSING: ".. blessing .. "\n";
        "----------------------------------------------------\n";
        "ENDURANCE: ".. plendurance;
        "POWER: ".. plpower;
        "SPECIAL: ".. plspecial;
        "STAND LEVEL: " .. plstandlvl;
        "LEVEL: " .. pllvl .. '\n';
        "----------------------------------------------------\n";
        "REQ: " .. tostring(plreq),
        "SPIN: " .. tostring(plspin),
        "HAMON: " .. tostring(plhamon),
        "VAMP:" .. tostring(plvampire),
        "ULF: " .. tostring(plulf),
        "ROCK: " .. tostring(plrock),
    }
end
print("----------------------------------------------------\n")-- for console

for i, v in pairs(stuff) do
    stuffSTRING = stuffSTRING.. stuff[i]..'\n'
end
wait()
if exploitWrite then
    if syn then --fuck you thats why
        if isfolder("PJJStands") then
            writefile('\\PJJStands\\'..(funnystring)..".txt", "----------------------------------------------------\n\n")
        else
            print(false)
            makefolder("PJJStands")
            wait(.5)
            writefile('\\PJJStands\\'..(funnystring)..".txt", "----------------------------------------------------\n\n")
        end
        writefile('\\PJJStands\\'..(funnystring)..".txt", stuffSTRING)
    else
        writefile(funnystring..".txt", "----------------------------------------------------\n\n")
        wait()
        writefile((funnystring)..".txt", stuffSTRING)
    end
    print(stuffSTRING)
else
    print(stuffSTRING)
end

--isfolder("PJJStands")
--makefolder("PJJStands")



--[[ deprecated, kept for learning i guess. or to reflect on how shitty my code still is LMAOOO

local function CheckExploit() --checks if exploit has writefile and appendfile
    if writefile and appendfile then
        return true
    end
end

if CheckExploit() then -- checks if exploit has writefile *AND* appendfile
    -- if it has both then it does this
    writefile('\\PJJStands\\'..(funnystring)..".txt", "----------------------------------------------------\n\n") -- makes a file because appendfile doesn't create one

    for i, v in pairs(stuff) do
        appendfile('\\PJJStands\\'..(funnystring)..".txt", stuff[i]..'\n') -- get whats needed for said file, too lazy to make it work for exploits that have JUST writefile
        print(stuff[i]) -- because the console is cool! and also because opening files suck. 
    end
else
    -- if it doesn't have one of them (or none) it just prints
    for i, v in pairs(stuff) do -- the same as above but for exploits without appendfile or writefile
        print(stuff[i]) -- YEAAAAAHHHH CONSOLLE BABBY!!!
    end
end
]]
