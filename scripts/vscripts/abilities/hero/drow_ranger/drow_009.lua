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
--- 自身冰冻层数轮询间隔（秒）：层数变化驱动闪避/移速词条刷新
local DROW_009_STACK_POLL_INTERVAL = 0.25
--- 自身凝结冰冻视觉（与霜冻之箭一致的全项目冰冻语义）
local DROW_009_FREEZE_EFFECT = "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf"
local DROW_009_FREEZE_STATUS_EFFECT = "particles/status_fx/status_effect_drow_frost_arrow.vpcf"
--- 卓尔游侠技能 009 - 霜雾
-- 被动（E 槽）：对敌人施加冰冻时，自身也凝结 1 层真冰冻（modifier_generic_slow，层数即联动接口）。
-- 自身每层冰冻（不限来源）额外提供闪避与移动速度——霜雾掩身形。
____exports.drow_009 = __TS__Class()
local drow_009 = ____exports.drow_009
drow_009.name = "drow_009"
__TS__ClassExtends(drow_009, BaseHeroAbility)
function drow_009.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function drow_009.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_drow_009_frost_veil.name
end
function drow_009.prototype.GetSelfFreezeStacks(self)
	return math.floor(self:GetSpecialValue("drow_009", "self_freeze_stacks"))
end
function drow_009.prototype.GetSelfFreezeDuration(self)
	return self:GetSpecialValue("drow_009", "self_freeze_duration")
end
function drow_009.prototype.GetEvasionPerStack(self)
	return self:GetSpecialValue("drow_009", "evasion_per_stack")
end
function drow_009.prototype.GetMovespeedPerStack(self)
	return self:GetSpecialValue("drow_009", "movespeed_per_stack")
end
drow_009 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_009)
____exports.drow_009 = drow_009
____exports.modifier_drow_009_frost_veil = __TS__Class()
local modifier_drow_009_frost_veil = ____exports.modifier_drow_009_frost_veil
modifier_drow_009_frost_veil.name = "modifier_drow_009_frost_veil"
__TS__ClassExtends(modifier_drow_009_frost_veil, BaseHeroModifier)
function modifier_drow_009_frost_veil.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.lastStacks = 0
end
function modifier_drow_009_frost_veil.GetLocalizationCN(self)
	return {
		name = "霜雾",
		description = "周身霜雾掩藏身形，每层冰冻提供闪避与移动速度加成。",
	}
end
function modifier_drow_009_frost_veil.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_DEBUFF_STATUS_APPLIED, target = { scope = "global" } } }
end
function modifier_drow_009_frost_veil.prototype.GetModifierConfig(self)
	return { isHidden = self.lastStacks <= 0, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_drow_009_frost_veil.prototype.IsPermanent(self)
	return true
end
function modifier_drow_009_frost_veil.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.lastStacks = 0
	self:StartIntervalThink(DROW_009_STACK_POLL_INTERVAL)
end
function modifier_drow_009_frost_veil.prototype.OnDebuffStatusApplied_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent then
		return
	end
	if event.status ~= DebuffStatusType.ICE_SLOW then
		return
	end
	local target = event.target
	if not target or target == parent then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local stacks = ability:GetSelfFreezeStacks()
	if stacks <= 0 then
		return
	end
	AddDeBuffStatus(nil, parent, parent, ability, DebuffStatusType.ICE_SLOW, {
		stack = stacks,
		duration = ability:GetSelfFreezeDuration(),
		effect_name = DROW_009_FREEZE_EFFECT,
		status_effect_name = DROW_009_FREEZE_STATUS_EFFECT,
	})
end
function modifier_drow_009_frost_veil.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local stacks = self:GetSelfFreezeStackTotal(parent)
	if stacks == self.lastStacks then
		return
	end
	self.lastStacks = stacks
	self:RefreshAttributes()
end
function modifier_drow_009_frost_veil.prototype.GetSelfFreezeStackTotal(self, parent)
	local modifiers = parent:FindAllModifiersByName("modifier_generic_slow") or {}
	local total = 0
	for ____, modifier in ipairs(modifiers) do
		do
			if not IsValid(nil, modifier) then
				goto __continue27
			end
			total = total + math.max(modifier:GetStackCount(), 0)
		end
		::__continue27::
	end
	return total
end
function modifier_drow_009_frost_veil.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	return {
		evasion_pct = self.lastStacks * ability:GetEvasionPerStack(),
		bonus_movespeed_pct = self.lastStacks * ability:GetMovespeedPerStack(),
	}
end
function modifier_drow_009_frost_veil.prototype.GetTexture(self)
	return "drow_09"
end
modifier_drow_009_frost_veil = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_009_frost_veil)
____exports.modifier_drow_009_frost_veil = modifier_drow_009_frost_veil
return ____exports