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
local COMMAND_INTERVAL = 8
local COMMAND_RADIUS = 600
local COMMAND_DURATION = 3
local COMMAND_ATTACK_SPEED_PCT = 30
local COMMAND_PARTICLE = "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
local COMMAND_CAST_SOUND = "Hero_OgreMagi.Bloodlust.Cast"
local COMMAND_TARGET_SOUND = "Hero_OgreMagi.Bloodlust.Target"
--- 普通技能28：督军号令，周期性提升周围友军攻击速度
____exports.normal_028 = __TS__Class()
local normal_028 = ____exports.normal_028
normal_028.name = "normal_028"
__TS__ClassExtends(normal_028, MonsterAbility_CS)
function normal_028.prototype.Precache(self, context)
	PrecacheResource("particle", COMMAND_PARTICLE, context)
end
function normal_028.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_028.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_028"
end
normal_028 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_028)
____exports.normal_028 = normal_028
local modifier_normal_028 = __TS__Class()
modifier_normal_028.name = "modifier_normal_028"
__TS__ClassExtends(modifier_normal_028, MonsterModifier_CS)
function modifier_normal_028.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(COMMAND_INTERVAL)
end
function modifier_normal_028.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local allies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		COMMAND_RADIUS,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	EmitSoundOn(COMMAND_CAST_SOUND, parent)
	for ____, ally in ipairs(allies) do
		do
			if not IsValidAlive(nil, ally) then
				goto __continue11
			end
			EmitSoundOn(COMMAND_TARGET_SOUND, ally)
			ally:AddNewModifier(parent, ability, "modifier_normal_028_command", { duration = COMMAND_DURATION })
		end
		::__continue11::
	end
end
function modifier_normal_028.prototype.IsHidden(self)
	return true
end
function modifier_normal_028.prototype.IsPurgable(self)
	return false
end
modifier_normal_028 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_028") }, modifier_normal_028)
local modifier_normal_028_command = __TS__Class()
modifier_normal_028_command.name = "modifier_normal_028_command"
__TS__ClassExtends(modifier_normal_028_command, MonsterModifier_CS)
function modifier_normal_028_command.prototype.GetAttributeBonus(self)
	return { attack_speed_pct = COMMAND_ATTACK_SPEED_PCT }
end
function modifier_normal_028_command.prototype.GetEffectName(self)
	return COMMAND_PARTICLE
end
function modifier_normal_028_command.prototype.IsPurgable(self)
	return false
end
modifier_normal_028_command =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_028_command") }, modifier_normal_028_command)
return ____exports