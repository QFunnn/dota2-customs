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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__Iterator = ____lualib.__TS__Iterator
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0365 = __TS__Class()
local item_0365 = ____exports.item_0365
item_0365.name = "item_0365"
__TS__ClassExtends(item_0365, BaseItem_CS)
function item_0365.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0365_poison_blade.name
end
item_0365 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0365)
____exports.item_0365 = item_0365
____exports.modifier_item_0365_poison_blade = __TS__Class()
local modifier_item_0365_poison_blade = ____exports.modifier_item_0365_poison_blade
modifier_item_0365_poison_blade.name = "modifier_item_0365_poison_blade"
__TS__ClassExtends(modifier_item_0365_poison_blade, BaseModifier_CS)
function modifier_item_0365_poison_blade.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.corrosionTargets = __TS__New(Set)
end
function modifier_item_0365_poison_blade.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0365_poison_blade.prototype.IsHidden(self)
	return true
end
function modifier_item_0365_poison_blade.prototype.IsPurgable(self)
	return false
end
function modifier_item_0365_poison_blade.prototype.OnAttackLanded_CS(self, event)
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
	local ability_poison_trigger_chance_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_poison_trigger_chance_pct"))
	if ability_poison_trigger_chance_pct > 0 and RollPercentage(ability_poison_trigger_chance_pct) then
		local ability_poison_stack = math.max(1, math.floor(ability:GetSpecialValueFor("ability_poison_stack")))
		AddDeBuffStatus(
			nil,
			target,
			parent,
			ability,
			DebuffStatusType.POISON,
			{ stack = ability_poison_stack, effect_name = "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf" }
		)
		local ability_all_stats_damage_pct =
			math.max(0, ability:GetSpecialValueFor("ability_value_all_stats_damage_pct"))
		local damage = self:GetAllStats(parent) * (ability_all_stats_damage_pct / 100)
		if damage > 0 then
			Damage:ApplyDamage({
				victim = target,
				attacker = parent,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = {
					debuff_status = DebuffStatusType.POISON,
					source_name = self:GetName(),
				},
			})
		end
	end
	target:AddNewModifier(parent, ability, ____exports.modifier_item_0365_corrosion.name, {})
	self.corrosionTargets:add(target:GetEntityIndex())
end
function modifier_item_0365_poison_blade.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	for ____, targetIndex in __TS__Iterator(self.corrosionTargets) do
		do
			local target = EntIndexToHScript(targetIndex)
			if not target or not IsValid(nil, target) or not target.FindAllModifiers then
				goto __continue16
			end
			local modifiers = target:FindAllModifiers()
			for ____, modifier in ipairs(modifiers) do
				do
					if modifier:GetName() ~= ____exports.modifier_item_0365_corrosion.name then
						goto __continue18
					end
					if modifier:GetCaster() ~= parent then
						goto __continue18
					end
					modifier:Destroy()
				end
				::__continue18::
			end
		end
		::__continue16::
	end
	self.corrosionTargets:clear()
end
function modifier_item_0365_poison_blade.prototype.GetAllStats(self, parent)
	local strength = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
modifier_item_0365_poison_blade = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0365_poison_blade)
____exports.modifier_item_0365_poison_blade = modifier_item_0365_poison_blade
____exports.modifier_item_0365_corrosion = __TS__Class()
local modifier_item_0365_corrosion = ____exports.modifier_item_0365_corrosion
modifier_item_0365_corrosion.name = "modifier_item_0365_corrosion"
__TS__ClassExtends(modifier_item_0365_corrosion, BaseModifier_CS)
function modifier_item_0365_corrosion.GetLocalizationCN(self)
	return { name = "侵蚀", description = "每层中毒都会提高受到的魔法伤害。" }
end
function modifier_item_0365_corrosion.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshPoisonStacks()
	self:StartIntervalThink(0.2)
end
function modifier_item_0365_corrosion.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshPoisonStacks()
end
function modifier_item_0365_corrosion.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RefreshPoisonStacks()
end
function modifier_item_0365_corrosion.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0365_corrosion.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_magical_damage_increase_pct_per_stack =
		math.max(0, ability:GetSpecialValueFor("ability_magical_damage_increase_pct_per_stack"))
	local poisonStacks = math.max(0, self:GetStackCount())
	if poisonStacks <= 0 then
		return {}
	end
	return {
		incoming_magical_damage_increase_pct = math.min(
			30,
			poisonStacks * ability_magical_damage_increase_pct_per_stack
		),
	}
end
function modifier_item_0365_corrosion.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0365_corrosion.prototype.IsDebuff(self)
	return true
end
function modifier_item_0365_corrosion.prototype.IsPurgable(self)
	return true
end
function modifier_item_0365_corrosion.prototype.GetTexture(self)
	return "venomancer_poison_sting"
end
function modifier_item_0365_corrosion.prototype.RefreshPoisonStacks(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local poisonStacks = self:GetTotalPoisonStacks(parent)
	if poisonStacks <= 0 then
		self:Destroy()
		return
	end
	if self:GetStackCount() == poisonStacks then
		return
	end
	self:SetStackCount(poisonStacks)
	self:RefreshAttributes()
end
function modifier_item_0365_corrosion.prototype.GetTotalPoisonStacks(self, target)
	if not target.FindAllModifiers then
		return 0
	end
	local stacks = 0
	local modifiers = target:FindAllModifiers()
	for ____, modifier in ipairs(modifiers) do
		do
			if modifier:GetName() ~= "modifier_generic_poison" then
				goto __continue46
			end
			stacks = stacks + modifier:GetStackCount()
		end
		::__continue46::
	end
	return stacks
end
modifier_item_0365_corrosion = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0365_corrosion)
____exports.modifier_item_0365_corrosion = modifier_item_0365_corrosion
return ____exports