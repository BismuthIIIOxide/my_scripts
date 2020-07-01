local PLAYER = ""

-->> PJJ Storage Stealer
-->> ValentinesDayAlone / rC5J / GiveMeDaBong, big thank you to DaBong for helping me out with tables <3
-->> June 30, 2020
-->> finally made this, messy as all hell so im gonna have to clean it ;(
-->> ROBLOX has a stroke if you use custom functions, shouldn't be a suprise though
local function GetPlayerFromString(s)
    s = s:lower() -- Remove this if you want case sensitivity
    for _, player in ipairs(game.Players:GetPlayers()) do
        if s == player.Name:lower():sub(1, #s) then
            return player
        end
    end
    return nil
end
local template
local plr2 = GetPlayerFromString(PLAYER)
plr2 = plr2.Name
--[[
    1 = stand name
    2 = req
    3 = hamon
    4 = vamp
    5 = rock
    6 = b2m 1?
    7 = b2m 2?
    8 = b2m 3?
    9 = b2m 4?
    10 = potency
    11 = resilience
    12 = speed
    13 = ulf
    14 = stand level
    15 = blessing
    16 = sub fusion
    17 = trait
    18 = spin
    19 = ID
    ]]
local blessings = {
    -- all the blessings
    ["Holy"] = "All cooldowns are halved.",
    ["Divine"] = "Chance to do critical damage [3.5x] to an opponent. (1/3)",
    ["Blessed"] = "Redirects 20% of damage taken towards the attacker.",
    ["Sanctified"] = "Chance to take 3.5x less damage from an attack.",
    ["Saintly"] = "Chance to inflict the Holy Flames. (1/4) - Saintly deals 19-20 tick damage that is 17.8% of the base damage of the attack used.",
    ["Heavenly"] = "Chance to summon heaven orbs that fly at the target being damaged. (1/5)",
    ["Angelic"] = "All damage triggers a minor stun effect and all damage bypasses dodge/damage counters, including: RTZ, sanctified, blessed, love train and others.",
    ["Hallowed"] = "On kill, enemies will explode around the killed player. Hallowed Explosion damage is based on proximity to the source. Users will have to be near the source to be effected by this Blessing. (Still pretty effective at the edge of the AoE) It just does much less. Damage is based off the Original Subjects' HP.",
    ["Righteous"] = "Pull in all nearby targets while constantly damaging them while posing. (Random chance of activating) In addition, this will double your on-damage proc rate. (Example: twice as likely for a WS sub to proc)",
    ["Anointed"] = "Outputted damage will always deal slight percentage damage to your opponent.",
    ["Transcendent"] = "Grants immunity to all knockback/stun (similar to GER's passive), plus additional immunity to White Album's freeze. Effects like Harvest's Drunkenness does not count as a Stun, it is a Status Effect.",
    ["Almighty"] = "Repel all nearby targets while constantly damaging them while posing. (Random chance of activating) In addition, this will double your on-damage proc rate. (Example: twice as likely for a WS sub to proc)",
    ["Exalted"] = "Block nearly all damage from opponents while posing. (Has a chance to be bypassed) [Random chance of activating] In addition, this will double your on-damage proc rate. (Example: twice as likely for a WS sub to proc)",
    ["None"] = "" -- although i could just check for this in a "normal" way, i dont give a shit because im a dumbass
}

local fusions = {
    -- fusions, of course PJJ sucks and some of them probably dont wont (like GE/GER and all the AU ones). I also dont know why the it's not in the order it was in, but whatever.
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
    ["Tusk"] = 'Damage done that is 30% or more of the target\'s max hp applies the infinite spin debuff to them. (This will NOT increase their damage.) Gives the ability to use "Fingernail Shotgun". Turns Basic punches into Tusk punches, scaling off of Power.',
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
local exploitWrite = false
if writefile then
    exploitWrite = true
end -- writefile check
local ss1, ss1T = game.Players[plr2].storedstand1.Value, {}
local ss2, ss2T = game.Players[plr2].storedstand2.Value, {}
local ss3, ss3T = game.Players[plr2].storedstand3.Value, {}
local ss4, ss4T = game.Players[plr2].storedstand4.Value, {}
local ss5, ss5T = game.Players[plr2].storedstand5.Value, {}
local ss6, ss6T = game.Players[plr2].storedstand6.Value, {}
local ss7, ss7T = game.Players[plr2].storedstand7.Value, {}
local ss8, ss8T = game.Players[plr2].storedstand8.Value, {}
local ss9, ss9T = game.Players[plr2].storedstand9.Value, {}
local ss10, ss10T = game.Players[plr2].storedstand10.Value, {}
local ss11, ss11T = game.Players[plr2].storedstand11.Value, {}
local ss12, ss12T = game.Players[plr2].storedstand12.Value, {}
local ss13, ss13T = game.Players[plr2].storedstand13.Value, {}
local ss14, ss14T = game.Players[plr2].storedstand14.Value, {}
local ss15, ss15T = game.Players[plr2].storedstand15.Value, {}
local ss16, ss16T = game.Players[plr2].storedstand16.Value, {}
local ss17, ss17T = game.Players[plr2].storedstand17.Value, {}
local ss18, ss18T = game.Players[plr2].storedstand18.Value, {}
local s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18 =
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18"
local caps = string.upper(plr2)
local funnystring = ""
local blessing = ""
local fusion = ""
local function AddToTable(STR, TBL)
    for word in string.gmatch(STR, "([^/]+)") do
        table.insert(TBL, word)
    end
end
local function lol(FINAL, TBL)
    -- print(type(TBL))
    -- warn("!"..FINAL)
    if TBL[1] ~= "None" then -- no no-stand:(
        template = {
            "USER: " .. plr2 .. "\n",
            "--------------------------------------------------\n",
            "STAND: " .. TBL[1],
            "FUSION: " .. TBL[16],
            "TRAIT: " .. TBL[17],
            "BLESSING: " .. TBL[15],
            "STAND LEVEL: " .. TBL[14],
            "--------------------------------------------------\n",
            "REQ: " .. TBL[2],
            "SPIN: " .. TBL[18],
            "HAMON: " .. TBL[3],
            "ULF: " .. TBL[13],
            "VAMP: " .. TBL[4],
            "ROCK: " .. TBL[5],
            "--------------------------------------------------\n",
            "ABILITY 1: " .. TBL[6],
            "ABILITY 2: " .. TBL[7],
            "ABILITY 3: " .. TBL[8],
            "ABILITY 4: " .. TBL[9]
        }
        local FName = FINAL:gsub("%D+", "")
        if TBL[16] ~= "None" then -- checks if fusion exists
            funnystring = FName .. " " .. TBL[1] .. " + " .. TBL[16] .. caps
        else
            funnystring = FName .. " " .. TBL[1] .. caps
        end
        for i, v in pairs(blessings) do
            if string.find(TBL[15], i) then -- find the blessing the user has
                print(TBL[15]) -- for debugging
                if TBL[15] == "None" then
                    blessing = TBL[15]
                else
                    blessing = TBL[15] .. " -- " .. v -- adds what the blessing does, because opening the trello is dumb and takes too long. fuck you
                end
            end
        end
        for i, v in pairs(fusions) do
            --warn(i, v) --this is dumb so ignore it
            if string.find(TBL[16], i) then -- find the fusion the user has
                warn(TBL[16]) -- for debugging
                if TBL[16] == "None" then
                    fusion = TBL[16]
                else
                    fusion = TBL[16] .. " -- " .. v -- adds what the fusion does, because opening the trello is dumb and takes even longer than blessings. i FUCKING HATE YOU TRELLO MANAGERS
                end
            end
        end
        for i, v in pairs(template) do
            FINAL = FINAL .. template[i] .. "\n"
        end
        if exploitWrite then
            if syn then --fuck you thats why
                if isfolder("PJJStorage") then
                    writefile(
                        "\\PJJStorage\\" .. (funnystring) .. ".txt",
                        "----------------------------------------------------\n\n"
                    )
                else
                    print(false)
                    makefolder("PJJStorage")
                    wait(.5)
                    writefile(
                        "\\PJJStorage\\" .. (funnystring) .. ".txt",
                        "----------------------------------------------------\n\n"
                    )
                end
                writefile("\\PJJStorage\\" .. (funnystring) .. ".txt", FINAL)
            else
                writefile(PJJStorage .. ".txt", "----------------------------------------------------\n\n")
                wait()
                writefile((PJJStorage) .. ".txt", FINAL)
            end
            print(FINAL)
        else
            print(FINAL)
        end
        print("--------------------------------------------------\n")
    else
        print(FINAL, "-none")
    end
end

AddToTable(ss1, ss1T)
AddToTable(ss2, ss2T)
AddToTable(ss3, ss3T)
AddToTable(ss4, ss4T)
AddToTable(ss5, ss5T)
AddToTable(ss6, ss6T)
AddToTable(ss7, ss7T)
AddToTable(ss8, ss8T)
AddToTable(ss9, ss9T)
AddToTable(ss10, ss10T)
AddToTable(ss11, ss11T)
AddToTable(ss12, ss12T)
AddToTable(ss13, ss13T)
AddToTable(ss14, ss14T)
AddToTable(ss15, ss15T)
AddToTable(ss16, ss16T)
AddToTable(ss17, ss17T)
AddToTable(ss18, ss18T)

lol(s1, ss1T)
lol(s2, ss2T)
lol(s3, ss3T)
lol(s4, ss4T)
lol(s5, ss5T)
lol(s6, ss6T)
lol(s7, ss7T)
lol(s8, ss8T)
lol(s9, ss9T)
lol(s10, ss10T)
lol(s11, ss11T)
lol(s12, ss12T)
lol(s13, ss13T)
lol(s14, ss14T)
lol(s15, ss15T)
lol(s16, ss16T)
lol(s17, ss17T)
lol(s18, ss18T)
warn("---------------------------------------------")
