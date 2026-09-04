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
local modifier_elite_144_empowered_attacks
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local EMPOWERED_ATTACK_COUNT = 3
local EMPOWERED_ATTACK_SPEED_PCT = 50
local EMPOWERED_ATTACK_HEAL_MAX_HEALTH_PCT = 15
--- 精英技能1 - 蓄力一段时间后使用冲向敌人并且进行重击
____exports.elite_144 = __TS__Class()
local elite_144 = ____exports.elite_144
elite_144.name = "elite_144"
__TS__ClassExtends(elite_144, MonsterAbility_CS)
function elite_144.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.damageOverTime = 0
end
function elite_144.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 600,
		castPoint = 0.7,
		castDuration = 0.8,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = "",
		animationPlaybackRate = 0.6,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(800)
			local forward = caster:GetForwardVector()
			if target then
				forward = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
				caster:LockTargetForSpeed(target, 0.65)
			end
			caster:SetAnimation("golem_attack2")
			self.damageOverTime = 0
			caster:Mover(caster:GetAbsOrigin():__add(forward:__mul(-150)), 0.2)
			caster:EmitSound("Hero_Weaver.Swarm.Cast")
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			caster:EmitSound("Hero_Windrunner.ShackleshotCast")
			caster:AddNewModifier(caster, self, "modifier_elite_144", { duration = 0.25 })
			caster:SetAnimation("golem_attack")
			caster:Mover(origin:__add(caster:GetForwardVector():__mul(850)), 0.25, function(____, pos)
				if self.damageOverTime == 1 then
					if GetDistance(nil, pos, origin) > 300 then
						self:PlayAttack()
						return true
					end
					return
				end
				local forward = pos:__add(caster:GetForwardVector():__mul(80))
				self:DamageArea(forward, 120, 25)
			end)
			self:Timer(0.26, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				if self.damageOverTime ~= 1 then
					self:PlayAttack()
				end
			end)
		end,
	}
end
function elite_144.prototype.PlayAttack(self)
	local caster = self:GetCaster()
	if self.damageOverTime == 1 then
		modifier_elite_144_empowered_attacks:applys(caster, caster, self)
	end
	local pfx = ParticleManager:CreateParticle("particles/dd/attack_01.vpcf", PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(pfx, 4, caster:GetAbsOrigin())
	Timers:CreateTimer(0.2, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_144.prototype.DamageArea(self, origin, radius, damage)
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
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.45 })
		self.damageOverTime = 1
	end)
end
elite_144 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_144)
____exports.elite_144 = elite_144
____exports.modifier_elite_144 = __TS__Class()
local modifier_elite_144 = ____exports.modifier_elite_144
modifier_elite_144.name = "modifier_elite_144"
__TS__ClassExtends(modifier_elite_144, MonsterModifier_CS)
function modifier_elite_144.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
end
modifier_elite_144 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_144)
____exports.modifier_elite_144 = modifier_elite_144
modifier_elite_144_empowered_attacks = __TS__Class()
modifier_elite_144_empowered_attacks.name = "modifier_elite_144_empowered_attacks"
__TS__ClassExtends(modifier_elite_144_empowered_attacks, MonsterModifier_CS)
function modifier_elite_144_empowered_attacks.prototype.OnCreated(self)
	self:SetStackCount(EMPOWERED_ATTACK_COUNT)
end
function modifier_elite_144_empowered_attacks.prototype.OnRefresh(self)
	self:SetStackCount(EMPOWERED_ATTACK_COUNT)
	self:RefreshAttributes()
end
function modifier_elite_144_empowered_attacks.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_144_empowered_attacks.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack or event.is_base_attack == false then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, event.target) then
		return
	end
	if event.target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	self:PlayHealEffect()
	local healAmount = parent:GetMaxHealth() * EMPOWERED_ATTACK_HEAL_MAX_HEALTH_PCT / 100
	if healAmount > 0 then
		parent:CustomHeal(healAmount, {
			ability = self:GetAbility(),
			source = "spell",
		})
	end
	local remaining = self:GetStackCount() - 1
	if remaining <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(remaining)
end
function modifier_elite_144_empowered_attacks.prototype.PlayHealEffect(self)
	local caster = self:GetParent()
	local pfx = ParticleManager:CreateParticle(
		"particles/radiant_fountain_regen_summerrewardline_2026_health_initial_cough.vpcf",
		PATTACH_POINT_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	Timers:CreateTimer(0.25, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function modifier_elite_144_empowered_attacks.prototype.GetAttributeBonus(self)
	return { attack_speed_pct = EMPOWERED_ATTACK_SPEED_PCT }
end
function modifier_elite_144_empowered_attacks.prototype.IsHidden(self)
	return false
end
function modifier_elite_144_empowered_attacks.prototype.IsDebuff(self)
	return false
end
function modifier_elite_144_empowered_attacks.prototype.IsPurgable(self)
	return false
end
function modifier_elite_144_empowered_attacks.GetLocalizationCN(self)
	return {
		name = "重击余势",
		description = "接下来3次攻击获得50%攻击速度，并在命中时恢复自身15%最大生命值。",
	}
end
function modifier_elite_144_empowered_attacks.prototype.GetEffectName(self)
	return "particles/ogre_ti8_immortal_bloodlust_buff.vpcf"
end
modifier_elite_144_empowered_attacks = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_144_empowered_attacks") },
	modifier_elite_144_empowered_attacks
)
return ____exports