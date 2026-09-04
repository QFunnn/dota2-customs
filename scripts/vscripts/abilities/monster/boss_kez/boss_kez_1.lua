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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local BOSS_KEZ_1_DAMAGE_RATE = 15
local BOSS_KEZ_1_CAST_POINT = 1
local BOSS_KEZ_1_AOE_RADIUS = 600
local BOSS_KEZ_1_THINK_INTERVAL = 0.25
local BOSS_KEZ_1_PULL_RADIUS = 1500
local BOSS_KEZ_1_PULL_SPEED = 300
local BOSS_KEZ_1_PULL_FRONT_DISTANCE = 200
local BOSS_KEZ_1_PULL_PARTICLE = "particles/units/kez_003.vpcf"
____exports.boss_kez_1 = __TS__Class()
local boss_kez_1 = ____exports.boss_kez_1
boss_kez_1.name = "boss_kez_1"
__TS__ClassExtends(boss_kez_1, MonsterAbility_CS)
function boss_kez_1.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/units/heroes/hero_kez/kez_hungering_blades_channel.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_kez/kez_hungering_blades.vpcf", context)
	PrecacheResource("particle", BOSS_KEZ_1_PULL_PARTICLE, context)
end
function boss_kez_1.prototype.GetMosnterAbilityConfig(self)
	return {
		castDuration = 2,
		castPoint = BOSS_KEZ_1_CAST_POINT,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CHANNEL_ABILITY_4,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			____exports.modifier_boss_kez_1_pull:applys(caster, caster, self, { duration = BOSS_KEZ_1_CAST_POINT })
			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kez/kez_hungering_blades_channel.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				caster
			)
			ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
			ParticleManager:SetParticleControlTransformForward(pfx, 0, caster:GetAbsOrigin(), caster:GetForwardVector())
			ParticleManager:SetParticleControl(pfx, 2, Vector(BOSS_KEZ_1_AOE_RADIUS, 1, 1))
			ParticleManager:ReleaseParticleIndex(pfx)
			self.pullPfx = ParticleManager:CreateParticle(BOSS_KEZ_1_PULL_PARTICLE, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(self.pullPfx, 0, caster:GetAbsOrigin())
			ParticleManager:SetParticleControl(self.pullPfx, 1, Vector(1000, 1000, 1000))
		end,
		OnStart = function()
			local caster = self:GetCaster()
			____exports.modifier_boss_kez_1:applys(caster, caster, self, { duration = 2 })
		end,
		OnFinish = function()
			if self.pullPfx then
				ParticleManager:DestroyParticle(self.pullPfx, false)
				ParticleManager:ReleaseParticleIndex(self.pullPfx)
				self.pullPfx = nil
			end
		end,
	}
end
boss_kez_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_kez_1)
____exports.boss_kez_1 = boss_kez_1
____exports.modifier_boss_kez_1_pull = __TS__Class()
local modifier_boss_kez_1_pull = ____exports.modifier_boss_kez_1_pull
modifier_boss_kez_1_pull.name = "modifier_boss_kez_1_pull"
__TS__ClassExtends(modifier_boss_kez_1_pull, BaseModifier_CS)
function modifier_boss_kez_1_pull.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_kez_1_pull.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local pullPoint = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(BOSS_KEZ_1_PULL_FRONT_DISTANCE))
	pullPoint.z = GetGroundHeight(pullPoint, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		BOSS_KEZ_1_PULL_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local step = BOSS_KEZ_1_PULL_SPEED * FrameTime()
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue13
			end
			local ____opt_0 = enemy.GetUnitType
			local unitType = ____opt_0 and ____opt_0(enemy)
			if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
				goto __continue13
			end
			local enemyPos = enemy:GetAbsOrigin()
			local toPullPoint = pullPoint:__sub(enemyPos)
			local distance = toPullPoint:Length2D()
			if distance <= 1 then
				goto __continue13
			end
			local moveDistance = math.min(step, distance)
			local nextPos = enemyPos:__add(toPullPoint:Normalized():__mul(moveDistance))
			nextPos.z = GetGroundHeight(nextPos, enemy)
			enemy:SetAbsOrigin(nextPos)
		end
		::__continue13::
	end
end
function modifier_boss_kez_1_pull.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
end
function modifier_boss_kez_1_pull.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
modifier_boss_kez_1_pull = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_1_pull)
____exports.modifier_boss_kez_1_pull = modifier_boss_kez_1_pull
____exports.modifier_boss_kez_1 = __TS__Class()
local modifier_boss_kez_1 = ____exports.modifier_boss_kez_1
modifier_boss_kez_1.name = "modifier_boss_kez_1"
__TS__ClassExtends(modifier_boss_kez_1, BaseModifier_CS)
function modifier_boss_kez_1.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._activity = {
		ACT_DOTA_KEZ_KATANA_ULT_START,
		ACT_DOTA_KEZ_KATANA_ULT_CHAIN_A,
		ACT_DOTA_KEZ_KATANA_ULT_CHAIN_B,
		ACT_DOTA_KEZ_KATANA_ULT_END,
	}
end
function modifier_boss_kez_1.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(BOSS_KEZ_1_THINK_INTERVAL)
	EmitSoundOn("Hero_Kez.RaptorDance.Katana.Cast", self:GetCaster())
	self:OnIntervalThink()
end
function modifier_boss_kez_1.prototype.OnIntervalThink(self)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	local attackCount = self:GetStackCount() + 1
	if attackCount > 4 then
		self:Destroy()
		return
	end
	self:IncrementStackCount()
	self:PlayEffect(attackCount)
	self:DealAoEDamage()
end
function modifier_boss_kez_1.prototype.PlayEffect(self, attackCount)
	local caster = self:GetCaster()
	local cp2_y = { 1, 0, 0, 1 }
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_kez/kez_hungering_blades.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControlTransformForward(pfx, 0, caster:GetAbsOrigin(), caster:GetForwardVector())
	ParticleManager:SetParticleControl(pfx, 2, Vector(BOSS_KEZ_1_AOE_RADIUS, cp2_y[attackCount], 1))
	ParticleManager:ReleaseParticleIndex(pfx)
	caster:StartGestureWithPlaybackRate(self._activity[attackCount], 1)
	EmitSoundOn("Hero_Kez.RaptorDance.Katana.Slash", caster)
	EmitSoundOn("Hero_Kez.RaptorDance.Katana.Slash.Layer", caster)
end
function modifier_boss_kez_1.prototype.DealAoEDamage(self)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		BOSS_KEZ_1_AOE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		caster:MonsterDamage({ victim = enemy, damage_rate = BOSS_KEZ_1_DAMAGE_RATE, ability = ability })
	end
end
function modifier_boss_kez_1.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
modifier_boss_kez_1 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_1)
____exports.modifier_boss_kez_1 = modifier_boss_kez_1
return ____exports