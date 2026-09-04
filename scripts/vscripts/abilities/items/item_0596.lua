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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0596 = __TS__Class()
local item_0596 = ____exports.item_0596
item_0596.name = "item_0596"
__TS__ClassExtends(item_0596, BaseItem_CS)
function item_0596.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0596_mutex.name
end
function item_0596.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0596.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local rolledBurn = self:GetSpecialValueFor("ability_value_c_burn_current_pct")
	local ____math_max_1 = math.max
	local ____temp_0
	if rolledBurn > 0 then
		____temp_0 = rolledBurn
	else
		____temp_0 = self:GetSpecialValueFor("ability_c_burn_current_pct")
	end
	local burnPct = ____math_max_1(0, ____temp_0)
	if burnPct > 0 then
		caster:CostHeal(
			caster:GetHealth() * burnPct / 100,
			{ ability = self, source = { source_name = "item_0596:血祭" } }
		)
	end
	local duration = math.max(0.1, self:GetSpecialValueFor("ability_duration"))
	caster:AddNewModifier(caster, self, ____exports.modifier_item_0596_ritual.name, { duration = duration })
	caster:EmitSound("DOTA_Item.Armlet.Activate")
end
item_0596 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0596)
____exports.item_0596 = item_0596
--- 门禁常驻（隐藏·仅用于史诗/传说互斥）：与史诗下级 item_0630 同 key，传说 200 > 史诗 100。
____exports.modifier_item_0596_mutex = __TS__Class()
local modifier_item_0596_mutex = ____exports.modifier_item_0596_mutex
modifier_item_0596_mutex.name = "modifier_item_0596_mutex"
__TS__ClassExtends(modifier_item_0596_mutex, BaseModifier_CS)
function modifier_item_0596_mutex.prototype.IsHidden(self)
	return true
end
function modifier_item_0596_mutex.prototype.IsPurgable(self)
	return false
end
function modifier_item_0596_mutex.prototype.GetMutexKey(self)
	return "item_0596_mutex"
end
function modifier_item_0596_mutex.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0596" and 200 or 100
end
modifier_item_0596_mutex = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0596_mutex)
____exports.modifier_item_0596_mutex = modifier_item_0596_mutex
--- 血祭状态：全域增伤；生命值被钳在燃烧后的水位线以下（烧掉的血找不回，其余治疗照常）。
____exports.modifier_item_0596_ritual = __TS__Class()
local modifier_item_0596_ritual = ____exports.modifier_item_0596_ritual
modifier_item_0596_ritual.name = "modifier_item_0596_ritual"
__TS__ClassExtends(modifier_item_0596_ritual, BaseModifier_CS)
function modifier_item_0596_ritual.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.capHealth = 0
end
function modifier_item_0596_ritual.GetLocalizationCN(self)
	return {
		name = "血祭",
		description = "造成的伤害提高；燃烧消失的生命值在持续期间无法找回。",
	}
end
function modifier_item_0596_ritual.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_HEAL_RECEIVED }
end
function modifier_item_0596_ritual.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecordCap()
	self:StartIntervalThink(0.2)
end
function modifier_item_0596_ritual.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RecordCap()
end
function modifier_item_0596_ritual.prototype.RecordCap(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self.capHealth = parent:GetHealth()
end
function modifier_item_0596_ritual.prototype.OnHealReceived_CS(self, event)
	if not IsServer() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	self:ClampToCap()
end
function modifier_item_0596_ritual.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:ClampToCap()
end
function modifier_item_0596_ritual.prototype.ClampToCap(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or self.capHealth <= 0 then
		return
	end
	if parent:GetHealth() > self.capHealth then
		parent:SetHealth(self.capHealth)
	end
end
function modifier_item_0596_ritual.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local rolledAmp = ability:GetSpecialValueFor("ability_value_damage_amp_pct")
	local ____math_max_3 = math.max
	local ____temp_2
	if rolledAmp > 0 then
		____temp_2 = rolledAmp
	else
		____temp_2 = ability:GetSpecialValueFor("ability_damage_amp_pct")
	end
	local ampPct = ____math_max_3(0, ____temp_2)
	return { outgoing_damage_pct = ampPct }
end
function modifier_item_0596_ritual.prototype.IsHidden(self)
	return false
end
function modifier_item_0596_ritual.prototype.IsDebuff(self)
	return false
end
function modifier_item_0596_ritual.prototype.IsPurgable(self)
	return false
end
function modifier_item_0596_ritual.prototype.GetTexture(self)
	return "item_blood_grenade"
end
modifier_item_0596_ritual = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0596_ritual)
____exports.modifier_item_0596_ritual = modifier_item_0596_ritual
return ____exports