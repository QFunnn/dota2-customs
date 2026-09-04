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
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local VULNERABLE_MODIFIER_NAME = "modifier_generic_vulnerable"
local VULNERABLE_BASE_MAX_STACK = 5
local VULNERABLE_MAX_STACK_BONUS_KEY = "axe_012_vulnerable_max_stack_bonus"
local EFFECT_PARTICLE_NAME = "particles/dd/engy_faceless_void_arcana_time_lock_v2_bash_hit.vpcf"
--- 引爆伤害自带标签，便于伤害日志识别来源。
local CUSTOM_TAG = "item_0528_feng_xu"
____exports.item_0528 = __TS__Class()
local item_0528 = ____exports.item_0528
item_0528.name = "item_0528"
__TS__ClassExtends(item_0528, BaseItem_CS)
function item_0528.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0528.name
end
item_0528 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0528)
____exports.item_0528 = item_0528
____exports.modifier_item_0528 = __TS__Class()
local modifier_item_0528 = ____exports.modifier_item_0528
modifier_item_0528.name = "modifier_item_0528"
__TS__ClassExtends(modifier_item_0528, BaseModifier_CS)
function modifier_item_0528.GetLocalizationCN(self)
	return {
		name = "锋蓄",
		description = "你施加易伤时概率额外增加1层；目标易伤达到最大层数时，引爆并移除全部易伤。",
	}
end
function modifier_item_0528.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEBUFF_STATUS_APPLY_QUERY }
end
function modifier_item_0528.prototype.IsHidden(self)
	return true
end
function modifier_item_0528.prototype.IsPurgable(self)
	return false
end
function modifier_item_0528.prototype.OnDebuffStatusApplyQuery_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.caster ~= parent then
		return
	end
	if event.status ~= DebuffStatusType.VULNERABLE then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, event.target) then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local p = event.params
	p.stack = math.max(1, math.floor(p.stack or 1))
	local maxStacks = self:GetVulnerableMaxStacks(parent)
	local stacksBefore = self:GetVulnerableStacks(event.target)
	local ability_extra_stack_chance_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_extra_stack_chance_pct"))
	if ability_extra_stack_chance_pct > 0 and RollPercentage(math.min(100, ability_extra_stack_chance_pct)) then
		p.stack = p.stack + 1
	end
	self:ScheduleDetonateIfReachedMax(parent, event.target, ability, stacksBefore, maxStacks)
end
function modifier_item_0528.prototype.GetVulnerableStacks(self, target)
	local vulnerable = target:FindModifierByName(VULNERABLE_MODIFIER_NAME)
	return math.max(0, vulnerable and vulnerable:GetStackCount() or 0)
end
function modifier_item_0528.prototype.GetVulnerableMaxStacks(self, parent)
	local ____math_max_6 = math.max
	local ____math_floor_5 = math.floor
	local ____tonumber_4 = tonumber
	local ____this_3
	____this_3 = parent
	local ____opt_2 = ____this_3.GetCustomValue
	local maxStackBonus = ____math_max_6(
		0,
		____math_floor_5(____tonumber_4(____opt_2 and ____opt_2(____this_3, VULNERABLE_MAX_STACK_BONUS_KEY) or 0) or 0)
	)
	return VULNERABLE_BASE_MAX_STACK + maxStackBonus
end
function modifier_item_0528.prototype.ScheduleDetonateIfReachedMax(
	self,
	parent,
	target,
	ability,
	stacksBefore,
	maxStacks
)
	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(nil, self) or self:IsNull() then
			return nil
		end
		if not IsValid(nil, ability) or ability:IsNull() then
			return nil
		end
		if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, target) then
			return nil
		end
		if stacksBefore >= maxStacks then
			return nil
		end
		if self:GetVulnerableStacks(target) < maxStacks then
			return nil
		end
		self:DetonateVulnerable(parent, target, ability)
		return nil
	end)
end
function modifier_item_0528.prototype.DetonateVulnerable(self, parent, target, ability)
	local effect =
		MyGameHeroParticleManager:CreateParticle(EFFECT_PARTICLE_NAME, PATTACH_ABSORIGIN_FOLLOW, target, parent)
	MyGameHeroParticleManager:SetParticleControlEnt(
		effect,
		0,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOn("Hero_Lion.ImpaleHitTarget", target)
	local ability_detonate_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_detonate_damage_pct"))
	local damage = GetTotalAttackDamage(nil, parent) * (ability_detonate_damage_pct / 100)
	if damage > 0 then
		Damage:ApplyDamage({
			attacker = parent,
			victim = target,
			damage = damage,
			damage_type = 1,
			ability = ability,
			extra_data = {
				damage_tags = DamageTag.NO_PROC,
				custom_tag = CUSTOM_TAG,
				source_name = "item_0528:锋蓄引爆",
			},
		})
	end
	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(nil, target) or not IsValidEntity(target) then
			return nil
		end
		target:RemoveModifierByName(VULNERABLE_MODIFIER_NAME)
		return nil
	end)
end
modifier_item_0528 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0528)
____exports.modifier_item_0528 = modifier_item_0528
return ____exports