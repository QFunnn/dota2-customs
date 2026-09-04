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
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__Delete = ____lualib.__TS__Delete
local ____exports = {}
local modifier_elite_070_ice_guard
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local AURA_RADIUS = 1300
local HEALTH_TRIGGER_PCT = 30
local PROTECT_DURATION = 4
local HEAL_MAX_HEALTH_PCT_PER_SECOND = 20
local CHECK_INTERVAL = 0.1
local PROJECTILE_SPEED = 2000
local PROJECTILE_EFFECT = "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf"
local PROTECT_EFFECT = "particles/econ/items/winter_wyvern/winter_wyvern_ti7/wyvern_cold_embrace_ti7buff.vpcf"
local AURA_LINK_EFFECT = "particles/unit/pugna_life_drain_beam_give.vpcf"
local PROTECT_STATUS_EFFECT =
	"particles/econ/items/winter_wyvern/winter_wyvern_ti7/status_effect_winter_wyvern_cold_embrace_ti7.vpcf"
local PROTECT_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_winter_wyvern.vsndevts"
local PROTECT_FREEZE_SOUND = "Hero_Winter_Wyvern.ColdEmbrace.Cast"
--- 精英技能70 - 霜谷护咒：低生命友军触发一次冰封守护，眩晕、物理免疫并持续回血
____exports.elite_070 = __TS__Class()
local elite_070 = ____exports.elite_070
elite_070.name = "elite_070"
__TS__ClassExtends(elite_070, MonsterAbility_CS)
function elite_070.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
	PrecacheResource("particle", PROTECT_EFFECT, context)
	PrecacheResource("particle", AURA_LINK_EFFECT, context)
	PrecacheResource("particle", PROTECT_STATUS_EFFECT, context)
	PrecacheResource("soundfile", PROTECT_SOUND_EVENTS, context)
end
function elite_070.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_070_guard_aura"
end
function elite_070.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE,
		castRange = AURA_RADIUS,
		castPoint = 0,
		castDuration = 0,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
	}
end
elite_070 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_070)
____exports.elite_070 = elite_070
local modifier_elite_070_guard_aura = __TS__Class()
modifier_elite_070_guard_aura.name = "modifier_elite_070_guard_aura"
__TS__ClassExtends(modifier_elite_070_guard_aura, MonsterModifier_CS)
function modifier_elite_070_guard_aura.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.triggeredTargets = {}
	self.auraLinkParticles = {}
end
function modifier_elite_070_guard_aura.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.triggeredTargets = {}
	self.auraLinkParticles = {}
	self:StartIntervalThink(CHECK_INTERVAL)
end
function modifier_elite_070_guard_aura.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	self:UpdateAuraLinks(caster)
	local target = self:FindProtectTarget(caster)
	if not IsValidAlive(nil, target) then
		return
	end
	self.triggeredTargets[target:entindex()] = true
	self:DestroyAuraLinkByEntIndex(target:entindex())
	if target == caster then
		modifier_elite_070_ice_guard:applys(target, caster, ability, { duration = PROTECT_DURATION })
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
	local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 96))
	CreateProjectile(nil, {
		ability = ability,
		caster = caster,
		projectile_type = "tracking",
		effect_name = PROJECTILE_EFFECT,
		target = target,
		projectile_speed = PROJECTILE_SPEED,
		start_point = startPoint,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				modifier_elite_070_ice_guard:applys(hitTarget, caster, ability, { duration = PROTECT_DURATION })
			end
			return true
		end,
	})
end
function modifier_elite_070_guard_aura.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:DestroyAllAuraLinks()
end
function modifier_elite_070_guard_aura.prototype.UpdateAuraLinks(self, caster)
	local currentTargets = {}
	if not IsValidAlive(nil, caster) then
		return
	end
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		AURA_RADIUS,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, ally in ipairs(allies) do
		do
			if not IsValidAlive(nil, ally) then
				goto __continue18
			end
			if not self:CanReceiveAuraLink(caster, ally) then
				goto __continue18
			end
			local entIndex = ally:entindex()
			currentTargets[entIndex] = true
			if self.auraLinkParticles[entIndex] ~= nil then
				goto __continue18
			end
			self.auraLinkParticles[entIndex] = self:CreateAuraLink(caster, ally)
		end
		::__continue18::
	end
	for ____, key in ipairs(__TS__ObjectKeys(self.auraLinkParticles)) do
		do
			local entIndex = tonumber(key)
			if entIndex ~= nil and currentTargets[entIndex] then
				goto __continue23
			end
			self:DestroyAuraLink(key)
		end
		::__continue23::
	end
end
function modifier_elite_070_guard_aura.prototype.CreateAuraLink(self, caster, target)
	local particle = ParticleManager:CreateParticle(AURA_LINK_EFFECT, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	return particle
end
function modifier_elite_070_guard_aura.prototype.CanReceiveAuraLink(self, caster, unit)
	if not IsValidAlive(nil, unit) or unit == caster then
		return false
	end
	if self.triggeredTargets[unit:entindex()] then
		return false
	end
	if modifier_elite_070_ice_guard:find_on(unit) then
		return false
	end
	return true
end
function modifier_elite_070_guard_aura.prototype.DestroyAuraLinkByEntIndex(self, entIndex)
	local particle = self.auraLinkParticles[entIndex]
	if particle == nil then
		return
	end
	ParticleManager:DestroyParticle(particle, false)
	ParticleManager:ReleaseParticleIndex(particle)
	__TS__Delete(self.auraLinkParticles, entIndex)
end
function modifier_elite_070_guard_aura.prototype.DestroyAuraLink(self, key)
	self:DestroyAuraLinkByEntIndex(tonumber(key) or -1)
end
function modifier_elite_070_guard_aura.prototype.DestroyAllAuraLinks(self)
	for ____, key in ipairs(__TS__ObjectKeys(self.auraLinkParticles)) do
		self:DestroyAuraLink(key)
	end
end
function modifier_elite_070_guard_aura.prototype.FindProtectTarget(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	if self:CanProtect(caster) then
		return caster
	end
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		AURA_RADIUS,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, ally in ipairs(allies) do
		if self:CanProtect(ally) then
			return ally
		end
	end
	return nil
end
function modifier_elite_070_guard_aura.prototype.CanProtect(self, unit)
	if not IsValidAlive(nil, unit) then
		return false
	end
	if self.triggeredTargets[unit:entindex()] then
		return false
	end
	if modifier_elite_070_ice_guard:find_on(unit) then
		return false
	end
	local maxHealth = unit:GetMaxHealth()
	if maxHealth <= 0 then
		return false
	end
	return unit:GetHealth() / maxHealth * 100 <= HEALTH_TRIGGER_PCT
end
function modifier_elite_070_guard_aura.prototype.IsHidden(self)
	return true
end
function modifier_elite_070_guard_aura.prototype.IsPurgable(self)
	return false
end
modifier_elite_070_guard_aura =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_070_guard_aura") }, modifier_elite_070_guard_aura)
modifier_elite_070_ice_guard = __TS__Class()
modifier_elite_070_ice_guard.name = "modifier_elite_070_ice_guard"
__TS__ClassExtends(modifier_elite_070_ice_guard, MonsterModifier_CS)
function modifier_elite_070_ice_guard.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_elite_070_ice_guard.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	EmitSoundOn(PROTECT_FREEZE_SOUND, self:GetParent())
	self:StartIntervalThink(1)
end
function modifier_elite_070_ice_guard.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local healAmount = parent:GetMaxHealth() * (HEAL_MAX_HEALTH_PCT_PER_SECOND / 100)
	parent:CustomHeal(healAmount, {
		ability = self:GetAbility(),
		source = "spell",
	})
end
function modifier_elite_070_ice_guard.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	if event.ctx.spec.damage_type ~= 1 then
		return
	end
	event.prevent_apply = true
end
function modifier_elite_070_ice_guard.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_elite_070_ice_guard.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end
function modifier_elite_070_ice_guard.prototype.GetEffectName(self)
	return PROTECT_EFFECT
end
function modifier_elite_070_ice_guard.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_elite_070_ice_guard.prototype.GetStatusEffectName(self)
	return PROTECT_STATUS_EFFECT
end
function modifier_elite_070_ice_guard.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_HIGH
end
function modifier_elite_070_ice_guard.prototype.IsHidden(self)
	return false
end
function modifier_elite_070_ice_guard.prototype.IsDebuff(self)
	return false
end
function modifier_elite_070_ice_guard.prototype.IsPurgable(self)
	return false
end
function modifier_elite_070_ice_guard.GetLocalizationCN(self)
	return {
		name = "霜谷护咒",
		description = "被冰封保护，无法行动，免疫物理伤害并持续恢复生命。",
	}
end
modifier_elite_070_ice_guard =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_070_ice_guard") }, modifier_elite_070_ice_guard)
return ____exports