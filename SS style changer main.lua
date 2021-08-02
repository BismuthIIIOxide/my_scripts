if game.CoreGui:FindFirstChild "FluxBreakMain" then game.CoreGui:FindFirstChild "FluxBreakMain":Remove() end
if not getgenv()["change"] then loadstring(game:HttpGet("https://raw.githubusercontent.com/BismuthIIIOxide/my_scripts/master/changeSS.lua"))() end

local UIS = game:GetService("UserInputService")

local styles = {"boxing","muaythai","karate","judo","sumo","wrestling","kungfu","taekwondo","woozy"}
-- fake binds, shitty way of doing this but i dont know any other way
local Z = 0x64 -- Numpad 4
local X = 0x65 -- Numpad 5
local C = 0x66 -- Numpad 6
_G.ZMove, _G.XMove, _G.CMove = 0,0,0
_G.M1s = 0
local function PressKey(KEY)
	keypress(KEY)
	wait()
	keyrelease(KEY)
end

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "yo", Text = "make sure the AHK script is open"}); for _, v in pairs(styles) do warn(v) end


local L = loadstring(game:HttpGet("https://raw.githubusercontent.com/CreativeHell/public-scripts/master/uilib.lua"))()
local f = L:CreateWindow({text='them fightin herds'})
local s = L:CreateWindow({text='saves'})

f:AddLabel("Z Move")
f:AddDropdown(
    styles,
    function(z)
        _G.ZMove = z
    end
)

f:AddLabel("X Move")
f:AddDropdown(
    styles,
    function(x)
        _G.XMove = x
    end
)

f:AddLabel("C Move")
f:AddDropdown(
    styles,
    function(c)
        _G.CMove = c
    end
)

f:AddLabel("M1 Move")
f:AddDropdown(
    styles, 
    function(m)
        _G.M1s = m; wait()
        change:Style(_G.M1s)
    end
)
UIS.InputBegan:connect(function(plr,gp)
	if not gp then
		if plr.KeyCode == Enum.KeyCode.KeypadOne then
			change:Style(_G.ZMove)
			PressKey(Z)
            wait()
            change:Style(_G.M1s)
		elseif plr.KeyCode == Enum.KeyCode.KeypadTwo then
			change:Style(_G.XMove)
			PressKey(X)
            change:Style(_G.M1s)
		elseif plr.KeyCode == Enum.KeyCode.KeypadThree then
			change:Style(_G.CMove)
			PressKey(C)
            change:Style(_G.M1s)
		end
		
	
	end
end)

