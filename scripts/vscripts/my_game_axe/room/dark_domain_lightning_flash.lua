--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local ____dark_domain = require("my_game_axe.room.dark_domain")
local DARK_DOMAIN_ENABLED = ____dark_domain.DARK_DOMAIN_ENABLED
local IsDarkDomainRoomId = ____dark_domain.IsDarkDomainRoomId
local DEFAULT_LIGHTNING_FLASH_RADIUS = 180
local DEFAULT_LIGHTNING_FLASH_DURATION = 1.25
function ____exports.TriggerDarkDomainLightningFlash(self, attacker, target, options)
	if not IsServer() or not DARK_DOMAIN_ENABLED then
		return
	end
	if not attacker or not IsValid(nil, attacker) or attacker:IsNull() then
		return
	end
	local ____this_1
	____this_1 = attacker
	local ____opt_0 = ____this_1.GetPlayerOwnerID
	local playerId = ____opt_0 and ____opt_0(____this_1)
	if playerId == nil or playerId < 0 then
		return
	end
	local room = MyGameRoomManager:GetPlayerRoom(playerId)
	if not room or not IsDarkDomainRoomId(nil, room:GetRoomId()) then
		return
	end
	if not room.AddDarkDomainSuppression then
		return
	end
	local radius = math.max(0, options and options.radius or DEFAULT_LIGHTNING_FLASH_RADIUS)
	local duration = math.max(0, options and options.duration or DEFAULT_LIGHTNING_FLASH_DURATION)
	if radius <= 0 or duration <= 0 then
		return
	end
	room:AddDarkDomainSuppression(attacker:GetAbsOrigin(), radius, duration)
	if not target or not IsValid(nil, target) or target:IsNull() then
		return
	end
	room:AddDarkDomainSuppression(target:GetAbsOrigin(), radius, duration)
end
return ____exports