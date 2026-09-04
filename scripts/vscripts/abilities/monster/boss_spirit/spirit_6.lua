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
local modifier_spirit_6_hit_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local SPIRIT_6_HIT_SLOW_DURATION = 3
local SPIRIT_6_HIT_SLOW_PCT = 50
local spirit_6 = __TS__Class()
spirit_6.name = "spirit_6"
__TS__ClassExtends(spirit_6, MonsterAbility_CS)
function spirit_6.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.8,
		castDuration = 0.7,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_TELEPORT_END,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_Riki.Blink_Strike")
			local forward = caster:GetForwardVector()
			local target = caster:GetMinDistanceUnit(3500)
			local ____ = target and caster:LockTargetForSpeed(target, 1, 3)
			caster:Mover(caster:GetAbsOrigin():__add(forward:__mul(-200)), 0.3)
		end,
		OnStart = function()
			return self:SpellStart()
		end,
	}
end
function spirit_6.prototype.SpellStart(self)
	local caster = self:GetCaster()
	local forward = caster:GetForwardVector()
	caster:Mover(caster:GetAbsOrigin():__add(forward:__mul(800)), 0.1)
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
	self:Timer(0.15, function()
		local pfx_name = "particles/_2juggernaut_blade_fury_abyssal_start_p_2x.vpcf"
		ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 3000, 0, true)
		local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
		local dashPfxDone = false
		Timers:CreateTimer(0.45, function()
			if dashPfxDone then
				return nil
			end
			dashPfxDone = true
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			return nil
		end)
		self:DamageArea(caster:GetAbsOrigin(), 325, 15)
		self:Timer(0.2, function()
			self:DamageArea(caster:GetAbsOrigin(), 335, 15)
		end)
	end)
end
function spirit_6.prototype.DamageArea(self, origin, radius, damage)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		caster:MonsterDamage({ victim = enemy, damage_rate = damage, ability = self })
		modifier_spirit_6_hit_slow:applys(enemy, caster, self, { duration = SPIRIT_6_HIT_SLOW_DURATION })
	end)
end
spirit_6 = __TS__DecorateLegacy({ registerAbility(nil) }, spirit_6)
modifier_spirit_6_hit_slow = __TS__Class()
modifier_spirit_6_hit_slow.name = "modifier_spirit_6_hit_slow"
__TS__ClassExtends(modifier_spirit_6_hit_slow, MonsterModifier_CS)
function modifier_spirit_6_hit_slow.prototype.GetModifierConfig(self)
	return { isDebuff = true, isPurgable = true }
end
function modifier_spirit_6_hit_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -SPIRIT_6_HIT_SLOW_PCT }
end
modifier_spirit_6_hit_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_spirit_6_hit_slow)
return ____exports