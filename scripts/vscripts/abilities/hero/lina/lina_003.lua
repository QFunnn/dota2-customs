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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 慢热特效：cp0 绑定单位，cp1.x 为层数
local LINA_003_PARTICLE = "particles/units/heroes/hero_lina/lina_fiery_soul.vpcf"
--- 宝石自定义：每层额外移速百分比
local LINA_003_MS_PCT_PER_STACK_CUSTOM_KEY = "lina_003_ms_pct_per_stack"
--- 宝石自定义：每层额外攻击速度
local LINA_003_ATTACK_SPEED_PER_STACK_CUSTOM_KEY = "lina_003_attack_speed_per_stack"
--- 丽娜技能 003 - 慢热（被动）
-- 每次释放非物品技能获得 1 层狂热，层数会按固定间隔自然流逝。
____exports.lina_003 = __TS__Class()
local lina_003 = ____exports.lina_003
lina_003.name = "lina_003"
__TS__ClassExtends(lina_003, BaseHeroAbility)
function lina_003.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_003_PARTICLE, context)
end
function lina_003.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function lina_003.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_lina_003_fiery_soul.name
end
function lina_003.prototype.GetDamagePctPerStack(self)
	return math.max(0, self:GetSpecialValue("lina_003", "per_stack_damage_pct"))
end
function lina_003.prototype.GetMaxStacks(self)
	return math.max(1, math.floor(self:GetSpecialValue("lina_003", "max_stacks")))
end
function lina_003.prototype.GetStackDecayInterval(self)
	return math.max(0.1, self:GetSpecialValue("lina_003", "stack_decay_interval"))
end
function lina_003.prototype.GetMoveSpeedPctPerStack(self)
	local caster = self:GetCaster()
	local ____tonumber_2 = tonumber
	local ____opt_0 = caster.GetCustomValue
	return ____tonumber_2(____opt_0 and ____opt_0(caster, LINA_003_MS_PCT_PER_STACK_CUSTOM_KEY) or 0)
end
function lina_003.prototype.GetAttackSpeedPerStack(self)
	local caster = self:GetCaster()
	local ____tonumber_5 = tonumber
	local ____opt_3 = caster.GetCustomValue
	return ____tonumber_5(____opt_3 and ____opt_3(caster, LINA_003_ATTACK_SPEED_PER_STACK_CUSTOM_KEY) or 0)
end
lina_003 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_003)
____exports.lina_003 = lina_003
--- 慢热被动：监听完整施法，给自己叠加狂热层数。
____exports.modifier_lina_003_fiery_soul = __TS__Class()
local modifier_lina_003_fiery_soul = ____exports.modifier_lina_003_fiery_soul
modifier_lina_003_fiery_soul.name = "modifier_lina_003_fiery_soul"
__TS__ClassExtends(modifier_lina_003_fiery_soul, BaseHeroModifier)
function modifier_lina_003_fiery_soul.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_lina_003_fiery_soul.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_lina_003_fiery_soul.prototype.IsPermanent(self)
	return true
end
function modifier_lina_003_fiery_soul.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_6 = castAbility.IsItem
	if ____opt_6 and ____opt_6(castAbility) and not event.is_trigger then
		return
	end
	local ____opt_8 = castAbility.IsToggle
	if ____opt_8 and ____opt_8(castAbility) then
		return
	end
	if castAbility:GetAbilityName() == ability:GetAbilityName() then
		return
	end
	____exports.modifier_lina_003_fiery_soul_effect:applys(parent, parent, ability)
end
modifier_lina_003_fiery_soul = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_lina_003_fiery_soul)
____exports.modifier_lina_003_fiery_soul = modifier_lina_003_fiery_soul
--- 慢热效果 buff：按层提供增伤与额外移速，每秒流逝 1 层。
____exports.modifier_lina_003_fiery_soul_effect = __TS__Class()
local modifier_lina_003_fiery_soul_effect = ____exports.modifier_lina_003_fiery_soul_effect
modifier_lina_003_fiery_soul_effect.name = "modifier_lina_003_fiery_soul_effect"
__TS__ClassExtends(modifier_lina_003_fiery_soul_effect, BaseHeroModifier)
function modifier_lina_003_fiery_soul_effect.GetLocalizationCN(self)
	return { name = "慢热", description = "层数会随时间流逝，每层提高自身造成的伤害。" }
end
function modifier_lina_003_fiery_soul_effect.prototype.GetModifierConfig(self)
	return {
		isHidden = self:GetStackCount() <= 0,
		isDebuff = false,
		isPurgable = false,
		isPurgeException = false,
	}
end
function modifier_lina_003_fiery_soul_effect.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local stacks = self:GetStackCount()
	if stacks <= 0 then
		return {}
	end
	return {
		outgoing_damage_pct = ability:GetDamagePctPerStack() * stacks,
		bonus_movespeed_pct = ability:GetMoveSpeedPctPerStack() * stacks,
		attack_speed = ability:GetAttackSpeedPerStack() * stacks,
	}
end
function modifier_lina_003_fiery_soul_effect.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	self:StartDecay()
	self:EnsureParticleAndUpdate()
end
function modifier_lina_003_fiery_soul_effect.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local nextStacks = math.min(self:GetStackCount() + 1, ability:GetMaxStacks())
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
	self:EnsureParticleAndUpdate()
end
function modifier_lina_003_fiery_soul_effect.prototype.OnIntervalThink(self)
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
	self:EnsureParticleAndUpdate()
end
function modifier_lina_003_fiery_soul_effect.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_lina_003_fiery_soul_effect.prototype.StartDecay(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	self:StartIntervalThink(ability:GetStackDecayInterval())
end
function modifier_lina_003_fiery_soul_effect.prototype.EnsureParticleAndUpdate(self)
	local count = self:GetStackCount()
	if self._particle_id then
		ParticleManager:SetParticleControl(self._particle_id, 1, Vector(count, 0, 0))
		return
	end
	self:PlayParticle()
end
function modifier_lina_003_fiery_soul_effect.prototype.PlayParticle(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self._particle_id = ParticleManager:CreateParticle(LINA_003_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self._particle_id,
		0,
		parent,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self._particle_id, 1, Vector(self:GetStackCount(), 0, 0))
	self:AddParticle(self._particle_id, false, false, -1, false, false)
end
modifier_lina_003_fiery_soul_effect =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_lina_003_fiery_soul_effect)
____exports.modifier_lina_003_fiery_soul_effect = modifier_lina_003_fiery_soul_effect
return ____exports