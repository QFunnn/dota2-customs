--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "triggers/trigger_event"
local b = require("lualib_bundle")
local c = b.__TS__StringSplit
function OnStartTouch(d)
	if not IsValid(d.activator) or not IsValid(d.caller) then
		return
	end
	if not d.activator:IsBaseNPC() then
		return
	end
	if d.activator:IsBuilding() then
		return
	end
	if d.activator:IsInvulnerable() then
		return
	end
	if not d.caller:LoadData("enabled", true) then
		return
	end
	local e = d.activator
	local f = thisEntity:GetName()
	local g = c(f, "_")[1]
	local h = Entities:FindAllByName(g .. "_trap_floor_model")
	local i = thisEntity:GetSpawnGroupHandle()
	d.caller:SaveData("enabled", false)
	d.caller:GameTimer(2, function()
		d.caller:SaveData("enabled", true)
	end)
	for j, k in ipairs(h) do
		if k:GetSpawnGroupHandle() == i then
			Event:Fire("trap_floor", { caster = e, trap = k })
		end
	end
end
function OnEndTouch(d)
	local f = thisEntity:GetName()
end