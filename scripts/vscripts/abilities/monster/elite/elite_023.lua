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
local modifier_elite_023_skewer_pfx
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.9
local CHARGE_DISTANCE = 700
local CHARGE_TIME = 0.5
local CHARGE_WIDTH = 120
local DAMAGE_RATE = 20
local KNOCKBACK_DURATION = 0.2
local KNOCKBACK_DISTANCE = 100
local HIT_COOLDOWN = 0.2
local HIT_PARTICLE = "particles/ursa_thunderclap.vpcf"
local SKEWER_PARTICLE = "particles/units/heroes/hero_magnataur/magnataur_skewer.vpcf"
local HIT_EFFECT = "particles/units/bash/bash_01.vpcf"
local CHARGE_HIT_SOUND = "Hero_Spirit_Breaker.GreaterBash"
local CHARGE_WINDUP_SOUND = "n_creep_Spawnlord.Stomp"
--- 精英技能23 - 预警冲撞：前摇播放 skewer 特效，冲刺对路径敌人造成伤害和击退
____exports.elite_023 = __TS__Class()
local elite_023 = ____exports.elite_023
elite_023.name = "elite_023"
__TS__ClassExtends(elite_023, MonsterAbility_CS)
function elite_023.prototype.Precache(self, context)
	PrecacheResource("particle", SKEWER_PARTICLE, context)
	PrecacheResource("particle", HIT_EFFECT, context)
end
function elite_023.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CHARGE_DISTANCE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CHARGE_TIME,
		castAnimation = ACT_DOTA_RUN,
		animationPlaybackRate = 2,
		OnInterrupt = function()
			local caster = self:GetCaster()
			if IsValidAlive(nil, caster) then
				caster:RemoveModifierByName("modifier_elite_023_skewer_pfx")
			end
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(CHARGE_WINDUP_SOUND, caster)
			local target = caster:GetMinDistanceUnit(3500)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local endPos = origin:__add(forward:__mul(CHARGE_DISTANCE))
			self:WarningEffect(origin, endPos, CAST_POINT, {
				startWidth = CHARGE_WIDTH,
				endWidth = CHARGE_WIDTH,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
			modifier_elite_023_skewer_pfx:applys(caster, caster, self, { duration = CAST_POINT })
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:RemoveModifierByName("modifier_elite_023_skewer_pfx")
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
			local targetPos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(CHARGE_DISTANCE))
			caster:Mover(targetPos, CHARGE_TIME, function(____, pos)
				local checkPos = pos:__add(caster:GetForwardVector():__mul(20))
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					checkPos,
					nil,
					CHARGE_WIDTH * 0.9,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				local hasHitEnemy = false
				for ____, enemy in ipairs(enemies) do
					do
						if not IsValidAlive(nil, enemy) then
							goto __continue13
						end
						local lastHit = enemy:GetCustomValue("elite_023_charge_hit") or 0
						if GameRules:GetGameTime() - lastHit < HIT_COOLDOWN then
							goto __continue13
						end
						caster:MonsterDamage({
							victim = enemy,
							damage_rate = DAMAGE_RATE,
							ability = self,
							effectName = HIT_EFFECT,
						})
						EmitSoundOn(CHARGE_HIT_SOUND, enemy)
						enemy:KnockBack(caster, self, {
							duration = KNOCKBACK_DURATION,
							distance = KNOCKBACK_DISTANCE,
							knockBackForward = caster:GetForwardVector(),
							particleName = "",
							stun = true,
							stunDuration = 1.2,
							destroyTreesType = "onDestroy",
						})
						enemy:SetCustomValue("elite_023_charge_hit", GameRules:GetGameTime())
						hasHitEnemy = true
					end
					::__continue13::
				end
				return hasHitEnemy
			end)
			self:Timer(CHARGE_TIME, function()
				local pos = caster:GetAbsOrigin()
				local checkPos = pos:__add(caster:GetForwardVector():__mul(90))
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					checkPos,
					nil,
					180,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				for ____, enemy in ipairs(enemies) do
					do
						if not IsValidAlive(nil, enemy) then
							goto __continue18
						end
						local lastHit = enemy:GetCustomValue("elite_023_charge_hit") or 0
						if GameRules:GetGameTime() - lastHit < HIT_COOLDOWN then
							goto __continue18
						end
						caster:MonsterDamage({
							victim = enemy,
							damage_rate = 10,
							ability = self,
							effectName = HIT_EFFECT,
						})
						EmitSoundOn(CHARGE_HIT_SOUND, enemy)
						enemy:KnockBack(caster, self, {
							duration = KNOCKBACK_DURATION,
							distance = KNOCKBACK_DISTANCE,
							knockBackForward = caster:GetForwardVector(),
							particleName = "",
							stun = true,
							stunDuration = 1.2,
							destroyTreesType = "onDestroy",
						})
						enemy:SetCustomValue("elite_023_charge_hit", GameRules:GetGameTime())
					end
					::__continue18::
				end
				local effect = ParticleManager:CreateParticle(HIT_PARTICLE, PATTACH_WORLDORIGIN, caster)
				ParticleManager:SetParticleControl(
					effect,
					0,
					caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(90))
				)
				ParticleManager:SetParticleControl(effect, 1, Vector(200, 0, 0))
				ParticleManager:ReleaseParticleIndex(effect)
			end)
		end,
	}
end
elite_023 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_023)
____exports.elite_023 = elite_023
modifier_elite_023_skewer_pfx = __TS__Class()
modifier_elite_023_skewer_pfx.name = "modifier_elite_023_skewer_pfx"
__TS__ClassExtends(modifier_elite_023_skewer_pfx, MonsterModifier_CS)
function modifier_elite_023_skewer_pfx.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:PlayEffect()
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_023_skewer_pfx.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not self.pfxId then
		return
	end
	local cp0 = parent:GetAbsOrigin()
	local cp1 = Vector(cp0.x, cp0.y, cp0.z - 1000)
	ParticleManager:SetParticleControl(self.pfxId, 0, cp0)
	ParticleManager:SetParticleControl(self.pfxId, 1, cp1)
end
function modifier_elite_023_skewer_pfx.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.pfxId ~= nil then
		ParticleManager:DestroyParticle(self.pfxId, false)
		ParticleManager:ReleaseParticleIndex(self.pfxId)
		self.pfxId = nil
	end
end
function modifier_elite_023_skewer_pfx.prototype.PlayEffect(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local cp0 = parent:GetAbsOrigin()
	local cp1 = Vector(cp0.x, cp0.y, cp0.z - 1000)
	self.pfxId = ParticleManager:CreateParticle(SKEWER_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(self.pfxId, 0, cp0)
	ParticleManager:SetParticleControl(self.pfxId, 1, cp1)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxId, false)
end
function modifier_elite_023_skewer_pfx.prototype.IsHidden(self)
	return true
end
modifier_elite_023_skewer_pfx =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_023_skewer_pfx") }, modifier_elite_023_skewer_pfx)
return ____exports