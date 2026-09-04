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
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ITEM_0642_DARK_ROOM_IDS = __TS__New(Set, { "M010", "M012" })
____exports.item_0642 = __TS__Class()
local item_0642 = ____exports.item_0642
item_0642.name = "item_0642"
__TS__ClassExtends(item_0642, BaseItem_CS)
function item_0642.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items3_fx/glimmer_cape_initial.vpcf", context)
	PrecacheResource("particle", "particles/items3_fx/glimmer_cape_initial_flash.vpcf", context)
	PrecacheResource("particle", "particles/dire_creep_banner_ring3.vpcf", context)
end
function item_0642.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0642.name
end
item_0642 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0642)
____exports.item_0642 = item_0642
____exports.modifier_item_0642 = __TS__Class()
local modifier_item_0642 = ____exports.modifier_item_0642
modifier_item_0642.name = "modifier_item_0642"
__TS__ClassExtends(modifier_item_0642, BaseModifier_CS)
function modifier_item_0642.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end
function modifier_item_0642.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0642.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if not self:IsInDarkEnvironment() then
		return
	end
	local ability_dark_regen_pct = math.max(0, ability:GetSpecialValueFor("ability_value_dark_regen_pct"))
	if ability_dark_regen_pct <= 0 then
		return
	end
	local ability_health_restore = parent:GetMaxHealth() * (ability_dark_regen_pct / 100)
	local ability_mana_restore = parent:GetMaxMana() * (ability_dark_regen_pct / 100)
	if ability_health_restore > 0 then
		parent:CustomHeal(ability_health_restore, { ability = ability, source = "item" })
	end
	if ability_mana_restore > 0 then
		parent:GiveMana(ability_mana_restore)
	end
end
function modifier_item_0642.prototype.IsHidden(self)
	return true
end
function modifier_item_0642.prototype.IsPurgable(self)
	return false
end
function modifier_item_0642.prototype.IsInDarkEnvironment(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return false
	end
	local playerId = parent:GetPlayerOwnerID()
	if playerId ~= nil and playerId >= 0 then
		local room = MyGameRoomManager:GetPlayerRoom(playerId)
		if room then
			return ITEM_0642_DARK_ROOM_IDS:has(room:GetRoomId())
		end
	end
	local ____opt_0 = parent.GetRoomId
	local roomId = ____opt_0 and ____opt_0(parent)
	return roomId ~= nil and ITEM_0642_DARK_ROOM_IDS:has(roomId)
end
modifier_item_0642 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0642)
____exports.modifier_item_0642 = modifier_item_0642
return ____exports