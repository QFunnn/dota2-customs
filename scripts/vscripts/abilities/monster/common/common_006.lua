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
local modifier_common_006_burning
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local COMMON_006_RADIUS = 300
local COMMON_006_AURA_INTERVAL = 0.5
local COMMON_006_BURN_DURATION = 0.75
local COMMON_006_BURN_TICK_INTERVAL = 0.25
local COMMON_006_ATTACK_DAMAGE_PER_SECOND = 0.5
local COMMON_006_BURN_EFFECT = "particles/radiance_owner_fallrewardline_2025.vpcf"
local COMMON_006_HIT_EFFECT =
	"particles/econ/items/doom/doom_2021_immortal_weapon/doom_2021_immortal_weapon_infernalblade_debuff.vpcf"
____exports.common_006 = __TS__Class()
local common_006 = ____exports.common_006
common_006.name = "common_006"
__TS__ClassExtends(common_006, MonsterAbility_CS)
function common_006.prototype.Precache(self, context)
	PrecacheResource("particle", COMMON_006_BURN_EFFECT, context)
end
function common_006.prototype.GetMosnterAbilityConfig(self)
	return { castPoint = 0, castDuration = 0, behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function common_006.prototype.GetIntrinsicModifierName(self)
	return "modifier_common_006"
end
common_006 = __TS__DecorateLegacy({ registerAbility(nil) }, common_006)
____exports.common_006 = common_006
local modifier_common_006 = __TS__Class()
modifier_common_006.name = "modifier_common_006"
__TS__ClassExtends(modifier_common_006, MonsterModifier_CS)
function modifier_common_006.prototype.IsHidden(self)
	return true
end
function modifier_common_006.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:applyBurnAura()
	self:StartIntervalThink(COMMON_006_AURA_INTERVAL)
end
function modifier_common_006.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:applyBurnAura()
end
function modifier_common_006.prototype.applyBurnAura(self)
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		COMMON_006_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue12
			end
			modifier_common_006_burning:applys(enemy, caster, ability, { duration = COMMON_006_BURN_DURATION })
		end
		::__continue12::
	end
end
function modifier_common_006.prototype.GetEffectName(self)
	return COMMON_006_BURN_EFFECT
end
modifier_common_006 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_common_006") }, modifier_common_006)
modifier_common_006_burning = __TS__Class()
modifier_common_006_burning.name = "modifier_common_006_burning"
__TS__ClassExtends(modifier_common_006_burning, MonsterModifier_CS)
function modifier_common_006_burning.prototype.IsDebuff(self)
	return true
end
function modifier_common_006_burning.prototype.IsPurgable(self)
	return true
end
function modifier_common_006_burning.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("Hero_Bloodseeker.Thirst.Cast")
	self:StartIntervalThink(COMMON_006_BURN_TICK_INTERVAL)
end
function modifier_common_006_burning.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local victim = self:GetParent()
	local attacker = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, victim) or not IsValidAlive(nil, attacker) or not ability then
		self:Destroy()
		return
	end
	if not IsValidAlive(nil, self._caster) then
		return
	end
	self._caster:MonsterDamage({ victim = victim, damage_rate = COMMON_006_ATTACK_DAMAGE_PER_SECOND, ability = ability })
end
function modifier_common_006_burning.prototype.GetEffectName(self)
	return COMMON_006_HIT_EFFECT
end
function modifier_common_006_burning.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_common_006_burning.prototype.GetTexture(self)
	return "huskar_burning_spear"
end
modifier_common_006_burning =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_common_006_burning") }, modifier_common_006_burning)
return ____exports