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
local modifier_boss_night_008_pool, modifier_boss_night_008_boss_aura, modifier_boss_night_008_hero_aura, modifier_boss_night_008_boss_heal, modifier_boss_night_008_hero_debuff
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local SEARCH_RANGE = 1800
local CAST_POINT = 0.45
local WARNING_DURATION = 0.9
local POOL_RADIUS = 540
local POOL_DURATION = 8
local HEAL_TICK_INTERVAL = 0.5
local HEAL_MAX_HEALTH_PCT_PER_SECOND = 1.6
local HERO_DAMAGE_RATE_PER_SECOND = 4
local POOL_WARNING_PARTICLE = "particles/nightstalker_crippling_fear_aura_burst.vpcf"
local POOL_PARTICLE = "particles/dd/ghand_nightstalker_ti10.vpcf"
local POOL_HEAL_PARTICLE = "particles/units/heroes/hero_night_stalker/nightstalker_void.vpcf"
local POOL_SILENCE_PARTICLE = "particles/generic_gameplay/generic_silenced.vpcf"
--- 暗血回流：制造暗血池，Boss 站在池中时持续回血。
____exports.boss_night_008 = __TS__Class()
local boss_night_008 = ____exports.boss_night_008
boss_night_008.name = "boss_night_008"
__TS__ClassExtends(boss_night_008, MonsterAbility_CS)
function boss_night_008.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.lockedTarget = nil
end
function boss_night_008.prototype.Precache(self, context)
	PrecacheResource("particle", POOL_WARNING_PARTICLE, context)
	PrecacheResource("particle", POOL_PARTICLE, context)
	PrecacheResource("particle", POOL_HEAL_PARTICLE, context)
	PrecacheResource("particle", POOL_SILENCE_PARTICLE, context)
end
function boss_night_008.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = SEARCH_RANGE,
		castPoint = CAST_POINT,
		castDuration = WARNING_DURATION,
		castAnimation = ACT_DOTA_TELEPORT,
		animationPlaybackRate = 1,
		isNotMove = true,
		castColor = Vector(35, 0, 80),
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, self:FindNearestEnemy(caster)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			return self:PreparePools()
		end,
		OnInterrupt = function()
			self.lockedTarget = nil
			local caster = self:GetCaster()
			caster:StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT_END, 1)
		end,
		OnStart = function()
			return self:StartPools()
		end,
	}
end
function boss_night_008.prototype.PreparePools(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindNearestEnemy(caster)
	local ____IsValidAlive_result_1
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_1 = target
	else
		____IsValidAlive_result_1 = nil
	end
	self.lockedTarget = ____IsValidAlive_result_1
	if self.lockedTarget then
		caster:LockTargetForSpeed(self.lockedTarget, CAST_POINT, 8)
	end
	EmitSoundOn("Hero_Nightstalker.Darkness.Team", caster)
end
function boss_night_008.prototype.StartPools(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.lockedTarget = nil
	local points = self:CreatePoolWarnings(caster)
	self:Timer(WARNING_DURATION, function()
		return self:CreatePools(caster, points)
	end)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_TELEPORT_END, 1)
end
function boss_night_008.prototype.CreatePoolWarnings(self, caster)
	local center = self:ResolvePoolCenter(caster)
	local points = { center }
	for ____, rawPoint in ipairs(points) do
		local point = GetGroundPosition(rawPoint, caster)
		self:WarningRingEffect(point, POOL_RADIUS, WARNING_DURATION)
		self:PlayWarningParticle(point)
		EmitSoundOnLocationWithCaster(point, "Hero_Nightstalker.Void", caster)
	end
	return points
end
function boss_night_008.prototype.CreatePools(self, caster, points)
	if not IsValidAlive(nil, caster) then
		return
	end
	for ____, point in ipairs(points) do
		CreateModifierThinker(
			caster,
			self,
			modifier_boss_night_008_pool.name,
			{ duration = POOL_DURATION, radius = POOL_RADIUS },
			point,
			caster:GetTeamNumber(),
			false
		)
	end
end
function boss_night_008.prototype.ResolvePoolCenter(self, caster)
	return GetGroundPosition(caster:GetAbsOrigin(), caster)
end
function boss_night_008.prototype.FindNearestEnemy(self, caster)
	return caster:GetMinDistanceUnit(SEARCH_RANGE)
end
function boss_night_008.prototype.PlayWarningParticle(self, point)
	local pfx = ParticleManager:CreateParticle(POOL_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point)
	Timers:CreateTimer(WARNING_DURATION, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
boss_night_008 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_night_008)
____exports.boss_night_008 = boss_night_008
modifier_boss_night_008_pool = __TS__Class()
modifier_boss_night_008_pool.name = "modifier_boss_night_008_pool"
__TS__ClassExtends(modifier_boss_night_008_pool, MonsterModifier_CS)
function modifier_boss_night_008_pool.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.radius = POOL_RADIUS
end
function modifier_boss_night_008_pool.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.radius = params.radius or POOL_RADIUS
	self:CreatePoolParticle()
	local parent = self:GetParent()
	local duration = self:GetDuration()
	modifier_boss_night_008_boss_aura:applys(
		parent,
		self:GetCaster(),
		self:GetAbility(),
		{ duration = duration, radius = self.radius }
	)
	modifier_boss_night_008_hero_aura:applys(
		parent,
		self:GetCaster(),
		self:GetAbility(),
		{ duration = duration, radius = self.radius }
	)
end
function modifier_boss_night_008_pool.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyPoolParticle()
end
function modifier_boss_night_008_pool.prototype.CreatePoolParticle(self)
	local pool = self:GetParent()
	self:DestroyPoolParticle()
	self.poolParticle = ParticleManager:CreateParticle(POOL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, pool)
	local origin = pool:GetAbsOrigin()
	ParticleManager:SetParticleControl(self.poolParticle, 0, origin)
	ParticleManager:SetParticleControl(self.poolParticle, 1, origin)
	ParticleManager:SetParticleControl(self.poolParticle, 2, origin)
	ParticleManager:SetParticleControl(self.poolParticle, 3, origin)
end
function modifier_boss_night_008_pool.prototype.DestroyPoolParticle(self)
	if self.poolParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.poolParticle, false)
	ParticleManager:ReleaseParticleIndex(self.poolParticle)
	self.poolParticle = nil
end
function modifier_boss_night_008_pool.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_008_pool.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_008_pool = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_008_pool)
modifier_boss_night_008_boss_aura = __TS__Class()
modifier_boss_night_008_boss_aura.name = "modifier_boss_night_008_boss_aura"
__TS__ClassExtends(modifier_boss_night_008_boss_aura, MonsterModifier_CS)
function modifier_boss_night_008_boss_aura.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.radius = POOL_RADIUS
end
function modifier_boss_night_008_boss_aura.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.radius = params.radius or POOL_RADIUS
end
function modifier_boss_night_008_boss_aura.prototype.IsAura(self)
	return true
end
function modifier_boss_night_008_boss_aura.prototype.GetModifierAura(self)
	return modifier_boss_night_008_boss_heal.name
end
function modifier_boss_night_008_boss_aura.prototype.GetAuraRadius(self)
	return self.radius
end
function modifier_boss_night_008_boss_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_boss_night_008_boss_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_OTHER
end
function modifier_boss_night_008_boss_aura.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_boss_night_008_boss_aura.prototype.GetAuraDuration(self)
	return 0.1
end
function modifier_boss_night_008_boss_aura.prototype.GetAuraEntityReject(self, target)
	return target ~= self:GetCaster()
end
function modifier_boss_night_008_boss_aura.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_008_boss_aura.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_008_boss_aura = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_008_boss_aura)
modifier_boss_night_008_hero_aura = __TS__Class()
modifier_boss_night_008_hero_aura.name = "modifier_boss_night_008_hero_aura"
__TS__ClassExtends(modifier_boss_night_008_hero_aura, MonsterModifier_CS)
function modifier_boss_night_008_hero_aura.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.radius = POOL_RADIUS
end
function modifier_boss_night_008_hero_aura.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.radius = params.radius or POOL_RADIUS
end
function modifier_boss_night_008_hero_aura.prototype.IsAura(self)
	return true
end
function modifier_boss_night_008_hero_aura.prototype.GetModifierAura(self)
	return modifier_boss_night_008_hero_debuff.name
end
function modifier_boss_night_008_hero_aura.prototype.GetAuraRadius(self)
	return self.radius
end
function modifier_boss_night_008_hero_aura.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_boss_night_008_hero_aura.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO
end
function modifier_boss_night_008_hero_aura.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_boss_night_008_hero_aura.prototype.GetAuraDuration(self)
	return 0.1
end
function modifier_boss_night_008_hero_aura.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_008_hero_aura.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_008_hero_aura = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_008_hero_aura)
modifier_boss_night_008_boss_heal = __TS__Class()
modifier_boss_night_008_boss_heal.name = "modifier_boss_night_008_boss_heal"
__TS__ClassExtends(modifier_boss_night_008_boss_heal, MonsterModifier_CS)
function modifier_boss_night_008_boss_heal.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.nextPulseEffectTime = 0
end
function modifier_boss_night_008_boss_heal.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(HEAL_TICK_INTERVAL)
end
function modifier_boss_night_008_boss_heal.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local healAmount = parent:GetMaxHealth() * (HEAL_MAX_HEALTH_PCT_PER_SECOND / 100) * HEAL_TICK_INTERVAL
	parent:CustomHeal(healAmount, {
		ability = self:GetAbility(),
		source = "spell",
	})
	self:PlayHealPulse(parent)
end
function modifier_boss_night_008_boss_heal.prototype.PlayHealPulse(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local now = GameRules:GetGameTime()
	if now < self.nextPulseEffectTime then
		return
	end
	self.nextPulseEffectTime = now + 1
	local pfx = ParticleManager:CreateParticle(POOL_HEAL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	Timers:CreateTimer(0.8, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
	EmitSoundOn("Hero_Nightstalker.Void.Nihility", caster)
end
function modifier_boss_night_008_boss_heal.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_008_boss_heal.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_008_boss_heal = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_008_boss_heal)
modifier_boss_night_008_hero_debuff = __TS__Class()
modifier_boss_night_008_hero_debuff.name = "modifier_boss_night_008_hero_debuff"
__TS__ClassExtends(modifier_boss_night_008_hero_debuff, MonsterModifier_CS)
function modifier_boss_night_008_hero_debuff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(HEAL_TICK_INTERVAL)
end
function modifier_boss_night_008_hero_debuff.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) or not ability or ability:IsNull() then
		return
	end
	caster:MonsterDamage({
		victim = parent,
		damage_rate = HERO_DAMAGE_RATE_PER_SECOND * HEAL_TICK_INTERVAL,
		ability = ability,
	})
end
function modifier_boss_night_008_hero_debuff.prototype.CheckState(self)
	return { [MODIFIER_STATE_SILENCED] = true }
end
function modifier_boss_night_008_hero_debuff.prototype.GetEffectName(self)
	return POOL_SILENCE_PARTICLE
end
function modifier_boss_night_008_hero_debuff.prototype.IsDebuff(self)
	return true
end
function modifier_boss_night_008_hero_debuff.prototype.IsPurgable(self)
	return true
end
function modifier_boss_night_008_hero_debuff.prototype.GetTexture(self)
	return "silencer_global_silence"
end
modifier_boss_night_008_hero_debuff =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_008_hero_debuff)
return ____exports