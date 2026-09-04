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
local REND_DURATION = 5
local REND_ARMOR_PER_STACK = -2
local REND_MAX_STACKS = 10
local REND_PARTICLE = "particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf"
local REND_SOUND = "Hero_Slardar.Amplify_Damage"
--- 普通技能32：每次攻击降低目标护甲，持续5秒，可叠加并刷新持续时间
____exports.normal_032 = __TS__Class()
local normal_032 = ____exports.normal_032
normal_032.name = "normal_032"
__TS__ClassExtends(normal_032, MonsterAbility_CS)
function normal_032.prototype.Precache(self, context)
	PrecacheResource("particle", REND_PARTICLE, context)
end
function normal_032.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_032.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_032"
end
normal_032 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_032)
____exports.normal_032 = normal_032
local modifier_normal_032 = __TS__Class()
modifier_normal_032.name = "modifier_normal_032"
__TS__ClassExtends(modifier_normal_032, MonsterModifier_CS)
function modifier_normal_032.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_normal_032.prototype.OnAttackLanded_CS(self, event)
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
	local target = event.target
	if not IsValidAlive(nil, target) then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	EmitSoundOn(REND_SOUND, target)
	target:AddNewModifier(parent, ability, "modifier_normal_032_rend", { duration = REND_DURATION })
end
function modifier_normal_032.prototype.IsHidden(self)
	return true
end
function modifier_normal_032.prototype.IsPurgable(self)
	return false
end
modifier_normal_032 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_032") }, modifier_normal_032)
local modifier_normal_032_rend = __TS__Class()
modifier_normal_032_rend.name = "modifier_normal_032_rend"
__TS__ClassExtends(modifier_normal_032_rend, MonsterModifier_CS)
function modifier_normal_032_rend.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end
function modifier_normal_032_rend.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local currentStacks = self:GetStackCount()
	if currentStacks < REND_MAX_STACKS then
		self:IncrementStackCount()
	end
end
function modifier_normal_032_rend.prototype.GetAttributeBonus(self)
	return { bonus_armor = REND_ARMOR_PER_STACK * self:GetStackCount() }
end
function modifier_normal_032_rend.prototype.GetEffectName(self)
	return REND_PARTICLE
end
function modifier_normal_032_rend.prototype.IsDebuff(self)
	return true
end
function modifier_normal_032_rend.prototype.IsPurgable(self)
	return true
end
modifier_normal_032_rend =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_032_rend") }, modifier_normal_032_rend)
return ____exports