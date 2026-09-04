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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local WARNING_EFFECT =
	"particles/econ/items/dragon_knight/dk_immortal_dragon/dragon_knight_dragon_tail_dragon_iron_dragon.vpcf"
local CAST_POINT = 0.5
--- 精英技能1 - 蓄力一段时间后使用冲向敌人并且进行重击
____exports.elite_128 = __TS__Class()
local elite_128 = ____exports.elite_128
elite_128.name = "elite_128"
__TS__ClassExtends(elite_128, MonsterAbility_CS)
function elite_128.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.damageOverTime = 0
end
function elite_128.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 700,
		castPoint = CAST_POINT,
		castDuration = 0.8,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(800)
			local forward = caster:GetForwardVector()
			if target then
				forward = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
				caster:LockTargetForSpeed(target, 0.4, 5)
			end
			local origin = caster:GetAbsOrigin()
			local endPos = origin:__add(forward:__mul(900))
			self:WarningEffect(origin, endPos, CAST_POINT + 0.3, {
				startWidth = 220,
				endWidth = 220,
				getDirection = function()
					return caster:GetForwardVector()
				end,
				follow = true,
			})
			self.damageOverTime = 0
			self:StartWarningEffect(caster)
			caster:Mover(caster:GetAbsOrigin():__add(forward:__mul(-80)), 0.2)
			caster:EmitSound("Hero_Weaver.Swarm.Cast")
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
			local origin = caster:GetAbsOrigin()
			self:Timer(0.2, function()
				caster:EmitSound("Hero_Windrunner.ShackleshotCast")
				caster:AddNewModifier(caster, self, "modifier_elite_128", { duration = 0.35 })
				caster:Mover(origin:__add(caster:GetForwardVector():__mul(850)), 0.35, function(____, pos)
					if self.damageOverTime == 1 then
						if GetDistance(nil, pos, origin) > 300 then
							return true
						end
						return
					end
					local forward = pos:__add(caster:GetForwardVector():__mul(80))
					self:DamageArea(forward, 120, 10)
				end)
			end)
		end,
	}
end
function elite_128.prototype.ClearWarningEffect(self)
	if self.warningPfx ~= nil then
		ParticleManager:DestroyParticle(self.warningPfx, false)
		ParticleManager:ReleaseParticleIndex(self.warningPfx)
		self.warningPfx = nil
	end
end
function elite_128.prototype.StartWarningEffect(self, caster)
	self:ClearWarningEffect()
	local pfx = ParticleManager:CreateParticle(WARNING_EFFECT, PATTACH_CENTER_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_CENTER_FOLLOW,
		"attach_attack2",
		caster:GetAbsOrigin(),
		true
	)
	self.warningPfx = pfx
	self:UpdateWarningForward(caster, 0)
end
function elite_128.prototype.UpdateWarningForward(self, caster, elapsed)
	if self.warningPfx == nil or not IsValidAlive(nil, caster) then
		return
	end
	ParticleManager:SetParticleControlForward(self.warningPfx, 0, caster:GetForwardVector())
	if elapsed >= CAST_POINT then
		return
	end
	return self:Timer(FrameTime(), function()
		return self:UpdateWarningForward(caster, elapsed + FrameTime())
	end)
end
function elite_128.prototype.DamageArea(self, origin, radius, damage)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		caster:PerformAttack(enemy, true, true, true, false, true, false, true)
		caster:MonsterDamage({ victim = enemy, damage_rate = damage, ability = self })
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.65 })
		self.damageOverTime = 1
	end)
end
elite_128 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_128)
____exports.elite_128 = elite_128
____exports.modifier_elite_128 = __TS__Class()
local modifier_elite_128 = ____exports.modifier_elite_128
modifier_elite_128.name = "modifier_elite_128"
__TS__ClassExtends(modifier_elite_128, MonsterModifier_CS)
function modifier_elite_128.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test6.vpcf"
end
modifier_elite_128 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_128)
____exports.modifier_elite_128 = modifier_elite_128
return ____exports