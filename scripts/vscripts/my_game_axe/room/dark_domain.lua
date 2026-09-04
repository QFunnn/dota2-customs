--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__ArraySome = ____lualib.__TS__ArraySome
local ____exports = {}
--- 暗域总开关：调试时改为 false 可关闭 M010 暗域凝视与怪物暗域增益。
____exports.DARK_DOMAIN_ENABLED = true
____exports.DARK_DOMAIN_ROOM_IDS = __TS__New(Set, { "M010" })
____exports.DARK_DOMAIN_LIGHT_SOURCE_ITEM_NAMES = {
	"item_0266",
	"item_0189",
	"item_0318",
	"item_0405",
	"item_0406",
	"item_0642",
}
____exports.DARK_DOMAIN_LIGHT_SOURCE_DROP_ITEM_NAMES = {
	"item_M112",
	"item_M205",
	"item_M211",
	"item_M214",
	"item_0189",
	"item_0405",
	"item_0406",
	"item_P049",
	"item_0642",
}
____exports.DARK_DOMAIN_LIGHT_SOURCE_MODIFIER_NAMES =
	{ "modifier_item_P007_potion", "item_P049_modifier", "modifier_item_M112_buff" }
--- 后续抗暗域效果可统一挂这些 modifier，避免把判断散落到房间和 debuff 里。
____exports.DARK_DOMAIN_GAZE_BLOCK_MODIFIER_NAMES = { "modifier_env_dark_domain_gaze_block" }
function ____exports.IsDarkDomainRoomId(self, roomId)
	return ____exports.DARK_DOMAIN_ENABLED and roomId ~= nil and ____exports.DARK_DOMAIN_ROOM_IDS:has(roomId)
end
function ____exports.IsDarkDomainUnit(self, unit)
	if not unit or not IsValid(nil, unit) or unit:IsNull() then
		return false
	end
	local ____this_1
	____this_1 = unit
	local ____opt_0 = ____this_1.GetPlayerOwnerID
	local playerId = ____opt_0 and ____opt_0(____this_1)
	if playerId ~= nil and playerId >= 0 then
		local room = MyGameRoomManager:GetPlayerRoom(playerId)
		if room then
			return ____exports.IsDarkDomainRoomId(nil, room:GetRoomId())
		end
	end
	local ____exports_IsDarkDomainRoomId_4 = ____exports.IsDarkDomainRoomId
	local ____this_3
	____this_3 = unit
	local ____opt_2 = ____this_3.GetRoomId
	return ____exports_IsDarkDomainRoomId_4(nil, ____opt_2 and ____opt_2(____this_3))
end
function ____exports.IsDarkDomainLightSource(self, hero)
	if not ____exports.DARK_DOMAIN_ENABLED then
		return false
	end
	return __TS__ArraySome(____exports.DARK_DOMAIN_LIGHT_SOURCE_ITEM_NAMES, function(____, name)
		return hero:FindItemInInventory(name) ~= nil
	end) or __TS__ArraySome(____exports.DARK_DOMAIN_LIGHT_SOURCE_MODIFIER_NAMES, function(____, name)
		return hero:HasModifier(name)
	end)
end
function ____exports.IsDarkDomainLightSourceDropItemName(self, itemName)
	if not ____exports.DARK_DOMAIN_ENABLED or not itemName then
		return false
	end
	return __TS__ArraySome(____exports.DARK_DOMAIN_LIGHT_SOURCE_DROP_ITEM_NAMES, function(____, name)
		return name == itemName
	end)
end
function ____exports.IsDarkDomainGazeBlocked(self, hero)
	if not ____exports.DARK_DOMAIN_ENABLED then
		return false
	end
	return ____exports.IsDarkDomainLightSource(nil, hero)
		or __TS__ArraySome(____exports.DARK_DOMAIN_GAZE_BLOCK_MODIFIER_NAMES, function(____, name)
			return hero:HasModifier(name)
		end)
end
function ____exports.IsDarkDomainMonster(self, unit)
	return ____exports.DARK_DOMAIN_ENABLED and not not unit and unit:HasModifier("modifier_env_monster_darkness")
end
function ____exports.HasDarkDomainMonsterStatusImmunity(self, unit)
	return not not unit
		and ____exports.IsDarkDomainUnit(nil, unit)
		and unit:HasModifier("modifier_env_monster_darkness")
end
function ____exports.CanMonsterUseDarkDomainSkill(self, unit)
	return ____exports.IsDarkDomainMonster(nil, unit)
end
return ____exports