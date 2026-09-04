--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0190 = __TS__Class()
local item_0190 = ____exports.item_0190
item_0190.name = "item_0190"
__TS__ClassExtends(item_0190, BaseItem_CS)
function item_0190.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0190.prototype.GetCastRange(self, location, target)
	return self:GetSpecialValueFor("ability_cast_range")
end
function item_0190.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_push_distance = math.max(0, self:GetSpecialValueFor("ability_push_distance"))
	local ability_push_duration = math.max(0, self:GetSpecialValueFor("ability_push_duration"))
	local ability_damage_reduction_pct = math.max(0, self:GetSpecialValueFor("ability_damage_reduction_pct"))
	if ability_push_distance <= 0 or ability_push_duration <= 0 then
		return
	end
	local destination = caster:GetAbsOrigin() + caster:GetForwardVector() * ability_push_distance
	caster:Mover(destination, ability_push_duration)
	caster:AddNewModifier(
		caster,
		self,
		"modifier_cs_damage_reduction",
		{ duration = ability_push_duration, damage_reduction_pct = ability_damage_reduction_pct }
	)
	self:PlayEffects1(caster)
end
function item_0190.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.ForceStaff.Activate")
end
item_0190 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0190)
____exports.item_0190 = item_0190
return ____exports