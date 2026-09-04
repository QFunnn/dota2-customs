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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
____exports.ELITE_148_BURROW_CAST_POINT = 1.54
____exports.ELITE_148_BURROW_PARTICLE = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf"
local MOUND_MODEL = "models/heroes/nerubian_assassin/mound.vmdl"
____exports.elite_148 = __TS__Class()
local elite_148 = ____exports.elite_148
elite_148.name = "elite_148"
__TS__ClassExtends(elite_148, MonsterAbility_CS)
function elite_148.prototype.Precache(self, context)
	PrecacheResource("model", MOUND_MODEL, context)
	PrecacheResource("particle", ____exports.ELITE_148_BURROW_PARTICLE, context)
end
function elite_148.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = ____exports.ELITE_148_BURROW_CAST_POINT,
		castDuration = 0.2,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		cooldown = 8,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and not ____exports.modifier_elite_148_mound:find_on(caster) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
			____exports.elite_148:PlayBurrowEffect(caster)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			____exports.elite_148:ApplyMound(caster, self)
		end,
		OnInterrupt = function()
			local caster = self:GetCaster()
			if IsValidAlive(nil, caster) then
				caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
			end
		end,
	}
end
function elite_148.ApplyMound(self, caster, ability)
	____exports.modifier_elite_148_mound:applys(caster, caster, ability, {})
end
function elite_148.StartBurrow(self, caster, ability, onFinished)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
	____exports.elite_148:PlayBurrowEffect(caster)
	ability:Timer(____exports.ELITE_148_BURROW_CAST_POINT, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		____exports.elite_148:ApplyMound(caster, ability)
		if onFinished ~= nil then
			onFinished(nil)
		end
	end)
end
function elite_148.PlayBurrowEffect(self, caster)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local forward = caster:GetForwardVector()
	local particle = ParticleManager:CreateParticle(____exports.ELITE_148_BURROW_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(particle, 0, origin, forward)
	ParticleManager:SetParticleControlForward(particle, 0, forward)
	ParticleManager:ReleaseParticleIndex(particle)
end
elite_148 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_148)
____exports.elite_148 = elite_148
____exports.modifier_elite_148_mound = __TS__Class()
local modifier_elite_148_mound = ____exports.modifier_elite_148_mound
modifier_elite_148_mound.name = "modifier_elite_148_mound"
__TS__ClassExtends(modifier_elite_148_mound, MonsterModifier_CS)
function modifier_elite_148_mound.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE }
end
function modifier_elite_148_mound.prototype.GetModifierModelChange(self)
	return MOUND_MODEL
end
function modifier_elite_148_mound.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function modifier_elite_148_mound.prototype.IsHidden(self)
	return true
end
function modifier_elite_148_mound.prototype.IsPurgable(self)
	return false
end
modifier_elite_148_mound =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_148_mound") }, modifier_elite_148_mound)
____exports.modifier_elite_148_mound = modifier_elite_148_mound
return ____exports