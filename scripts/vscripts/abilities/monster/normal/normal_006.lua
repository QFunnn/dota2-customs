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
local ROT_RADIUS = 150
local ROT_INTERVAL = 0.25
local ROT_DAMAGE_RATE = 2
local ROT_PARTICLE = "particles/units/heroes/hero_pudge/pudge_rot.vpcf"
local ROT_SOUND = "Hero_Pudge.Rot"
--- 普通技能6 - 被动：持续腐烂，对周围敌人造成范围伤害
____exports.normal_006 = __TS__Class()
local normal_006 = ____exports.normal_006
normal_006.name = "normal_006"
__TS__ClassExtends(normal_006, MonsterAbility_CS)
function normal_006.prototype.Precache(self, context)
	PrecacheResource("particle", ROT_PARTICLE, context)
end
function normal_006.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_006.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_006_rot"
end
normal_006 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_006)
____exports.normal_006 = normal_006
local modifier_normal_006_rot = __TS__Class()
modifier_normal_006_rot.name = "modifier_normal_006_rot"
__TS__ClassExtends(modifier_normal_006_rot, MonsterModifier_CS)
function modifier_normal_006_rot.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	EmitSoundOn(ROT_SOUND, self:GetParent())
	self:CreateRotParticle()
	self:StartIntervalThink(ROT_INTERVAL)
end
function modifier_normal_006_rot.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	StopSoundOn(ROT_SOUND, self:GetParent())
end
function modifier_normal_006_rot.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		ROT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue12
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = ROT_DAMAGE_RATE, ability = ability })
		end
		::__continue12::
	end
end
function modifier_normal_006_rot.prototype.CreateRotParticle(self)
	local parent = self:GetParent()
	local pid = ParticleManager:CreateParticle(ROT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pid,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(pid, 1, Vector(ROT_RADIUS, ROT_RADIUS, ROT_RADIUS))
	self:AddParticle(pid, false, false, -1, false, false)
end
function modifier_normal_006_rot.prototype.IsHidden(self)
	return true
end
function modifier_normal_006_rot.prototype.IsPurgable(self)
	return false
end
modifier_normal_006_rot =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_006_rot") }, modifier_normal_006_rot)
return ____exports