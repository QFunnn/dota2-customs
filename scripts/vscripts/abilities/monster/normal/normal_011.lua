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
local MIN_TRIGGER_INTERVAL = 1
--- normal_011 - 碎裂
-- 每次受到攻击时，反弹固定物理伤害给攻击者。
____exports.normal_011 = __TS__Class()
local normal_011 = ____exports.normal_011
normal_011.name = "normal_011"
__TS__ClassExtends(normal_011, MonsterAbility_CS)
function normal_011.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_011"
end
normal_011 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_011)
____exports.normal_011 = normal_011
____exports.modifier_normal_011 = __TS__Class()
local modifier_normal_011 = ____exports.modifier_normal_011
modifier_normal_011.name = "modifier_normal_011"
__TS__ClassExtends(modifier_normal_011, MonsterModifier_CS)
function modifier_normal_011.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._last_time = 0
end
function modifier_normal_011.prototype.IsHidden(self)
	return true
end
function modifier_normal_011.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED }
end
function modifier_normal_011.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	local parent = self:GetParent()
	local attacker = event.attacker
	local ability = self:GetAbility()
	if GameRules:GetGameTime() - self._last_time < MIN_TRIGGER_INTERVAL then
		return
	end
	if not ability then
		return
	end
	if not IsValidAlive(nil, attacker) or attacker:IsBuilding() then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	self._last_time = GameRules:GetGameTime()
	local damage = 2.5
	local effect = ParticleManager:CreateParticle(
		"particles/spectre_arcana_blademail_v2_streaks_overshoot.vpcf",
		PATTACH_WORLDORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(effect, 0, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		250,
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
			parent:MonsterDamage({ victim = enemy, damage_rate = damage, ability = ability, damage_type = 2 })
			AddDeBuffStatus(nil, enemy, parent, ability, DebuffStatusType.POISON, { stack = 1, duration = 5 })
		end
		::__continue12::
	end
	parent:EmitSound("DOTA_Item.BladeMail.Damage")
end
modifier_normal_011 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_011)
____exports.modifier_normal_011 = modifier_normal_011
return ____exports