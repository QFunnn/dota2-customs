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
____exports.item_0209 = __TS__Class()
local item_0209 = ____exports.item_0209
item_0209.name = "item_0209"
__TS__ClassExtends(item_0209, BaseItem_CS)
function item_0209.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0209_spellblade.name
end
item_0209 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0209)
____exports.item_0209 = item_0209
____exports.modifier_item_0209_spellblade = __TS__Class()
local modifier_item_0209_spellblade = ____exports.modifier_item_0209_spellblade
modifier_item_0209_spellblade.name = "modifier_item_0209_spellblade"
__TS__ClassExtends(modifier_item_0209_spellblade, BaseModifier_CS)
function modifier_item_0209_spellblade.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0209_spellblade.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_damage_per_second = self:GetSpellbladeDotDamage(parent, ability)
	local shouldApplyDoom = self:ShouldApplyDoom(ability)
	if ability_damage_per_second == nil and not shouldApplyDoom then
		return
	end
	local ____temp_0
	if ability_damage_per_second ~= nil then
		____temp_0 = ____exports.modifier_item_0209_spellblade_dot.name
	else
		____temp_0 = ____exports.modifier_item_0209_doom.name
	end
	local modifierName = ____temp_0
	if not NotifyCustomDebuffApplyQuery(nil, target, parent, ability, modifierName) then
		return
	end
	if ability_damage_per_second ~= nil then
		self:ApplySpellbladeDot(target, parent, ability, ability_damage_per_second)
	end
	if shouldApplyDoom then
		target:AddNewModifier(parent, ability, ____exports.modifier_item_0209_doom.name, {})
	end
end
function modifier_item_0209_spellblade.prototype.IsHidden(self)
	return true
end
function modifier_item_0209_spellblade.prototype.IsPurgable(self)
	return false
end
function modifier_item_0209_spellblade.prototype.GetSpellbladeDotDamage(self, parent, ability)
	local ability_dot_trigger_chance_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_dot_trigger_chance_pct"))
	if ability_dot_trigger_chance_pct <= 0 or not RollPercentage(ability_dot_trigger_chance_pct) then
		return nil
	end
	local ability_all_stats_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_all_stats_damage_pct"))
	local ability_dot_duration = math.max(0, ability:GetSpecialValueFor("ability_dot_duration"))
	local ability_damage_per_second = self:GetAllStats(parent) * (ability_all_stats_damage_pct / 100)
	if ability_dot_duration <= 0 or ability_damage_per_second <= 0 then
		return nil
	end
	return ability_damage_per_second
end
function modifier_item_0209_spellblade.prototype.ApplySpellbladeDot(
	self,
	target,
	parent,
	ability,
	ability_damage_per_second
)
	local ability_dot_duration = math.max(0, ability:GetSpecialValueFor("ability_dot_duration"))
	target:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0209_spellblade_dot.name,
		{ duration = ability_dot_duration, ability_damage_per_second = ability_damage_per_second }
	)
	self:PlayEffects1(target)
end
function modifier_item_0209_spellblade.prototype.ShouldApplyDoom(self, ability)
	local ability_trigger_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_value_trigger_chance_pct"))
	return ability_trigger_chance_pct > 0 and RollPercentage(ability_trigger_chance_pct)
end
function modifier_item_0209_spellblade.prototype.GetAllStats(self, parent)
	local strength = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
function modifier_item_0209_spellblade.prototype.PlayEffects1(self, target)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning", target)
end
modifier_item_0209_spellblade = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0209_spellblade)
____exports.modifier_item_0209_spellblade = modifier_item_0209_spellblade
____exports.modifier_item_0209_spellblade_dot = __TS__Class()
local modifier_item_0209_spellblade_dot = ____exports.modifier_item_0209_spellblade_dot
modifier_item_0209_spellblade_dot.name = "modifier_item_0209_spellblade_dot"
__TS__ClassExtends(modifier_item_0209_spellblade_dot, BaseModifier_CS)
function modifier_item_0209_spellblade_dot.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ability_damage_per_second = 0
end
function modifier_item_0209_spellblade_dot.GetLocalizationCN(self)
	return {
		name = "咒棱连击",
		description = "每秒受到基于施加者全属性的魔法伤害，重复施加时立即结算一次。",
	}
end
function modifier_item_0209_spellblade_dot.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:UpdateDamage(params)
	self:StartIntervalThink(1)
end
function modifier_item_0209_spellblade_dot.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:ApplyDamageTick()
	self:UpdateDamage(params)
	self:StartIntervalThink(1)
end
function modifier_item_0209_spellblade_dot.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:ApplyDamageTick()
end
function modifier_item_0209_spellblade_dot.prototype.IsDebuff(self)
	return true
end
function modifier_item_0209_spellblade_dot.prototype.IsPurgable(self)
	return true
end
function modifier_item_0209_spellblade_dot.prototype.GetTexture(self)
	return "item_witch_blade"
end
function modifier_item_0209_spellblade_dot.prototype.ApplyDamageTick(self)
	local target = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if self.ability_damage_per_second <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = caster,
		damage = self.ability_damage_per_second,
		damage_type = 2,
		ability = ability,
		extra_data = {
			custom_tag = "item_0209_spellblade_dot",
			source_name = "咒棱连击",
			damage_tags = DamageTag.DOT,
		},
	})
end
function modifier_item_0209_spellblade_dot.prototype.UpdateDamage(self, params)
	self.ability_damage_per_second = math.max(0, tonumber(params.ability_damage_per_second or 0))
end
modifier_item_0209_spellblade_dot = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0209_spellblade_dot)
____exports.modifier_item_0209_spellblade_dot = modifier_item_0209_spellblade_dot
____exports.modifier_item_0209_doom = __TS__Class()
local modifier_item_0209_doom = ____exports.modifier_item_0209_doom
modifier_item_0209_doom.name = "modifier_item_0209_doom"
__TS__ClassExtends(modifier_item_0209_doom, BaseModifier_CS)
function modifier_item_0209_doom.GetLocalizationCN(self)
	return { name = "厄运", description = "每层使受到的魔法伤害增加，并随时间逐层流逝。" }
end
function modifier_item_0209_doom.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	self:StartDecay()
end
function modifier_item_0209_doom.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local ability_max_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_max_stacks")))
	self:SetStackCount(math.min(self:GetStackCount() + 1, ability_max_stacks))
	self:RefreshAttributes()
end
function modifier_item_0209_doom.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStacks = self:GetStackCount() - 1
	if nextStacks <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
function modifier_item_0209_doom.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0209_doom.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_magic_resistance_reduce_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_magic_resistance_reduce_pct"))
	return { base_magic_resistance = -self:GetStackCount() * ability_magic_resistance_reduce_pct }
end
function modifier_item_0209_doom.prototype.IsDebuff(self)
	return true
end
function modifier_item_0209_doom.prototype.IsPurgable(self)
	return true
end
function modifier_item_0209_doom.prototype.GetTexture(self)
	return "item_witch_blade"
end
function modifier_item_0209_doom.prototype.StartDecay(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local ability_decay_interval = math.max(0.1, ability:GetSpecialValueFor("ability_decay_interval"))
	self:StartIntervalThink(ability_decay_interval)
end
modifier_item_0209_doom = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0209_doom)
____exports.modifier_item_0209_doom = modifier_item_0209_doom
return ____exports