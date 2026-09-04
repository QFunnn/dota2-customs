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
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local GetTotalAttackDamage = ____item_0409_shared.GetTotalAttackDamage
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
____exports.item_0503 = __TS__Class()
local item_0503 = ____exports.item_0503
item_0503.name = "item_0503"
__TS__ClassExtends(item_0503, BaseItem_CS)
function item_0503.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/cc/assass_hit_core_goldb.vpcf", context)
end
function item_0503.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0503_tracker.name
end
item_0503 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0503)
____exports.item_0503 = item_0503
____exports.modifier_item_0503_tracker = __TS__Class()
local modifier_item_0503_tracker = ____exports.modifier_item_0503_tracker
modifier_item_0503_tracker.name = "modifier_item_0503_tracker"
__TS__ClassExtends(modifier_item_0503_tracker, BaseModifier_CS)
function modifier_item_0503_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED, BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0503_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0503_tracker.prototype.IsPurgable(self)
	return false
end
function modifier_item_0503_tracker.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not IsRealNonItemAbility(nil, castAbility) then
		return
	end
	local maxCharges = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_max_charges")))
	local charge = parent:FindModifierByName(____exports.modifier_item_0503_charge.name)
		or parent:AddNewModifier(parent, ability, ____exports.modifier_item_0503_charge.name, {})
	if not charge then
		return
	end
	charge:SetStackCount(math.min(charge:GetStackCount() + 1, maxCharges))
end
function modifier_item_0503_tracker.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local target = event.target
	if not IsValidEnemyUnit(nil, parent, target) then
		return
	end
	local charge = parent:FindModifierByName(____exports.modifier_item_0503_charge.name)
	local ____charge_0
	if charge then
		____charge_0 = charge:GetStackCount()
	else
		____charge_0 = 0
	end
	local stacks = ____charge_0
	if not charge or stacks <= 0 then
		return
	end
	local empowerPct = math.max(0, ability:GetSpecialValueFor("ability_value_empower_pct"))
	local damage = GetTotalAttackDamage(nil, parent) * (empowerPct / 100)
	if damage <= 0 then
		return
	end
	local remaining = stacks - 1
	if remaining <= 0 then
		charge:Destroy()
	else
		charge:SetStackCount(remaining)
	end
	self:PlayEffects1(parent, target)
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = damage,
		damage_type = 1,
		ability = ability,
		extra_data = { source_name = "item_0503:蓄势强击" },
	})
	local vulnerableDuration = math.max(0.1, ability:GetSpecialValueFor("ability_vulnerable_duration"))
	AddDeBuffStatus(
		nil,
		target,
		parent,
		ability,
		DebuffStatusType.VULNERABLE,
		{ duration = vulnerableDuration, stack = 1 }
	)
end
function modifier_item_0503_tracker.prototype.PlayEffects1(self, parent, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/cc/assass_hit_core_goldb.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
modifier_item_0503_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0503_tracker)
____exports.modifier_item_0503_tracker = modifier_item_0503_tracker
____exports.modifier_item_0503_charge = __TS__Class()
local modifier_item_0503_charge = ____exports.modifier_item_0503_charge
modifier_item_0503_charge.name = "modifier_item_0503_charge"
__TS__ClassExtends(modifier_item_0503_charge, BaseModifier_CS)
function modifier_item_0503_charge.GetLocalizationCN(self)
	return { name = "蓄势", description = "下一次攻击造成额外物理伤害，可储存多层。" }
end
function modifier_item_0503_charge.prototype.IsHidden(self)
	return false
end
function modifier_item_0503_charge.prototype.IsDebuff(self)
	return false
end
function modifier_item_0503_charge.prototype.IsPurgable(self)
	return false
end
function modifier_item_0503_charge.prototype.GetTexture(self)
	return "item_icon_m50_06"
end
modifier_item_0503_charge = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0503_charge)
____exports.modifier_item_0503_charge = modifier_item_0503_charge
return ____exports