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
local registerModifier = ____dota_ts_adapter.registerModifier
local BaseModifier = ____dota_ts_adapter.BaseModifier
--- MG004 展示 Thinker 使用的随机特效列表；每项是一组主特效和状态特效。
local MG004_DISPLAY_EFFECTS = {
	{
		particle = "particles/units/heroes/hero_drow/drow_frost_arrow_debuff.vpcf",
		statusParticle = "particles/status_fx/status_effect_drow_frost_arrow.vpcf",
		duration = 2.2,
	},
	{
		particle = "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_frost_arrow_debuff.vpcf",
		statusParticle = "particles/status_fx/status_effect_drow_frost_arrow.vpcf",
		duration = 2.2,
	},
	{
		particle = "particles/items_fx/ghost.vpcf",
		statusParticle = "particles/status_fx/status_effect_ghost.vpcf",
		duration = 2.4,
	},
	{
		particle = "particles/units/heroes/hero_skeletonking/wraith_king_ghosts_ambient.vpcf",
		statusParticle = "particles/status_fx/status_effect_wraithking_ghosts.vpcf",
		duration = 2.4,
	},
	{
		particle = "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf",
		statusParticle = "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf",
		duration = 2.6,
	},
	{
		particle = "particles/econ/items/winter_wyvern/winter_wyvern_ti7/wyvern_cold_embrace_ti7buff.vpcf",
		statusParticle = "particles/econ/items/winter_wyvern/winter_wyvern_ti7/status_effect_winter_wyvern_cold_embrace_ti7.vpcf",
		duration = 2.6,
	},
	{
		particle = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf",
		statusParticle = "particles/status_fx/status_effect_void_spirit_astral_step_debuff.vpcf",
		duration = 2.3,
	},
	{
		particle = "particles/units/heroes/hero_faceless_void/faceless_void_time_walk.vpcf",
		statusParticle = "particles/status_fx/status_effect_faceless_timewalk.vpcf",
		duration = 2.2,
	},
	{
		particle = "particles/units/heroes/hero_life_stealer/life_stealer_rage.vpcf",
		statusParticle = "particles/status_fx/status_effect_life_stealer_rage.vpcf",
		duration = 2.4,
	},
	{
		particle = "particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf",
		statusParticle = "particles/status_fx/status_effect_pangolier_gyroshell.vpcf",
		duration = 2.5,
	},
	{
		particle = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf",
		statusParticle = "particles/status_fx/status_effect_charge_of_darkness.vpcf",
		duration = 2.2,
	},
	{
		particle = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_blur.vpcf",
		statusParticle = "particles/status_fx/status_effect_phantom_assassin_active_blur.vpcf",
		duration = 2.2,
	},
	{
		particle = "particles/units/heroes/hero_dark_willow/dark_willow_shadow_realm.vpcf",
		statusParticle = "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf",
		duration = 2.4,
	},
	{
		particle = "particles/units/heroes/hero_lich/lich_frost_armor.vpcf",
		statusParticle = "particles/status_fx/status_effect_frost_armor.vpcf",
		duration = 2.3,
	},
	{
		particle = "particles/units/heroes/hero_lich/lich_frost_nova.vpcf",
		statusParticle = "particles/status_fx/status_effect_frost_lich.vpcf",
		duration = 2.2,
	},
}
local MG004_DISPLAY_EFFECT_MIN_DELAY = 1.2
local MG004_DISPLAY_EFFECT_MAX_DELAY = 2.6
--- MG004 展示单位的独立特效 Thinker Modifier。
____exports.modifier_mg004_display_effects = __TS__Class()
local modifier_mg004_display_effects = ____exports.modifier_mg004_display_effects
modifier_mg004_display_effects.name = "modifier_mg004_display_effects"
__TS__ClassExtends(modifier_mg004_display_effects, BaseModifier)
function modifier_mg004_display_effects.prototype.____constructor(self, ...)
	BaseModifier.prototype.____constructor(self, ...)
	self.currentEffectIndex = -1
end
function modifier_mg004_display_effects.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	if (tonumber(params and params.random_effects_enabled or 1) or 0) ~= 1 then
		return
	end
	self:PlayNextEffect()
end
function modifier_mg004_display_effects.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:ClearCurrentEffect()
	self:PlayNextEffect()
end
function modifier_mg004_display_effects.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:ClearCurrentEffect()
end
function modifier_mg004_display_effects.prototype.IsHidden(self)
	return true
end
function modifier_mg004_display_effects.prototype.IsPurgable(self)
	return false
end
function modifier_mg004_display_effects.prototype.RemoveOnDeath(self)
	return false
end
function modifier_mg004_display_effects.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end
function modifier_mg004_display_effects.prototype.PlayNextEffect(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() or #MG004_DISPLAY_EFFECTS <= 0 then
		return
	end
	local effectIndex = self:GetNextEffectIndex()
	local effect = MG004_DISPLAY_EFFECTS[effectIndex + 1]
	if not effect then
		return
	end
	self.currentEffectIndex = effectIndex
	self.particleId = ParticleManager:CreateParticle(effect.particle, PATTACH_ABSORIGIN_FOLLOW, parent)
	self.statusParticleId = ParticleManager:CreateParticle(effect.statusParticle, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:StartIntervalThink(
		effect.duration + RandomFloat(MG004_DISPLAY_EFFECT_MIN_DELAY, MG004_DISPLAY_EFFECT_MAX_DELAY)
	)
end
function modifier_mg004_display_effects.prototype.GetNextEffectIndex(self)
	if #MG004_DISPLAY_EFFECTS <= 1 then
		return 0
	end
	local effectIndex = RandomInt(0, #MG004_DISPLAY_EFFECTS - 1)
	while effectIndex == self.currentEffectIndex do
		effectIndex = RandomInt(0, #MG004_DISPLAY_EFFECTS - 1)
	end
	return effectIndex
end
function modifier_mg004_display_effects.prototype.ClearCurrentEffect(self)
	if self.particleId == nil then
		return
	end
	ParticleManager:DestroyParticle(self.particleId, false)
	ParticleManager:ReleaseParticleIndex(self.particleId)
	self.particleId = nil
	if self.statusParticleId == nil then
		return
	end
	ParticleManager:DestroyParticle(self.statusParticleId, false)
	ParticleManager:ReleaseParticleIndex(self.statusParticleId)
	self.statusParticleId = nil
end
modifier_mg004_display_effects = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_mg004_display_effects)
____exports.modifier_mg004_display_effects = modifier_mg004_display_effects
return ____exports