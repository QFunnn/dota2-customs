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
local PRIMARY_EXTRA_DAMAGE_RATE = 8
local BOUNCE_DAMAGE_RATE = 4
local BOUNCE_RADIUS = 450
local FORK_LIGHTNING_PARTICLE = "particles/items_fx/chain_lightning.vpcf"
local FORK_SOUND = "Item.Maelstrom.Chain_Lightning.Jump"
--- 普通技能15 - 被动：普攻命中附带电涌伤害，附近有其他敌人时分叉弹射再打击一次
____exports.normal_015 = __TS__Class()
local normal_015 = ____exports.normal_015
normal_015.name = "normal_015"
__TS__ClassExtends(normal_015, MonsterAbility_CS)
function normal_015.prototype.Precache(self, context)
	PrecacheResource("particle", FORK_LIGHTNING_PARTICLE, context)
end
function normal_015.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_015.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_015"
end
normal_015 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_015)
____exports.normal_015 = normal_015
local modifier_normal_015 = __TS__Class()
modifier_normal_015.name = "modifier_normal_015"
__TS__ClassExtends(modifier_normal_015, MonsterModifier_CS)
function modifier_normal_015.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_015.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	local primary = event.target
	if not primary or not IsValidAlive(nil, primary) then
		return
	end
	local ____opt_0 = primary.GetUnitType
	local unitType = ____opt_0 and ____opt_0(primary)
	if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
		return
	end
	self:PlayForkLightning(parent, primary)
	parent:MonsterDamage({
		victim = primary,
		damage_rate = PRIMARY_EXTRA_DAMAGE_RATE,
		ability = self:GetAbility(),
	})
	local bounce = self:FindBounceTarget(primary)
	if not bounce then
		return
	end
	self:PlayForkLightning(primary, bounce)
	parent:MonsterDamage({
		victim = bounce,
		damage_rate = BOUNCE_DAMAGE_RATE,
		ability = self:GetAbility(),
	})
end
function modifier_normal_015.prototype.PlayForkLightning(self, from, to)
	local pfx = ParticleManager:CreateParticle(FORK_LIGHTNING_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, from)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		from,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		from:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(pfx, 1, to, PATTACH_POINT_FOLLOW, "attach_hitloc", to:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn(FORK_SOUND, to)
end
function modifier_normal_015.prototype.FindBounceTarget(self, primary)
	local parent = self:GetParent()
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		primary:GetAbsOrigin(),
		nil,
		BOUNCE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, u in ipairs(enemies) do
		do
			if u == primary then
				goto __continue15
			end
			if not IsValidAlive(nil, u) then
				goto __continue15
			end
			local ____opt_2 = u.GetUnitType
			local ut = ____opt_2 and ____opt_2(u)
			if ut == UnitType.BUILDING or ut == UnitType.DESTRUCTIBLE then
				goto __continue15
			end
			return u
		end
		::__continue15::
	end
	return nil
end
function modifier_normal_015.prototype.IsHidden(self)
	return true
end
function modifier_normal_015.prototype.IsPurgable(self)
	return false
end
modifier_normal_015 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_015") }, modifier_normal_015)
return ____exports