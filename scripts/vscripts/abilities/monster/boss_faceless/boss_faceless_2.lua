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
local CHRONOSPHERE_HANDLER = "modifier_imba_faceless_void_chronosphere_handler"
local STUN_MODIFIER_NAME = "modifier_boss_faceless_2_stun"
local IMPACT_SOUND = "Hero_FacelessVoid.TimeLockImpact"
local CHRONO_SEARCH_RADIUS = 5000
local BASH_CHANCE = 20
local BASH_DAMAGE = 15
local BASH_DURATION = 0.5
____exports.boss_faceless_2 = __TS__Class()
local boss_faceless_2 = ____exports.boss_faceless_2
boss_faceless_2.name = "boss_faceless_2"
__TS__ClassExtends(boss_faceless_2, MonsterAbility_CS)
function boss_faceless_2.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function boss_faceless_2.prototype.GetIntrinsicModifierName(self)
	return "modifier_boss_faceless_2"
end
boss_faceless_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_faceless_2)
____exports.boss_faceless_2 = boss_faceless_2
____exports.modifier_boss_faceless_2 = __TS__Class()
local modifier_boss_faceless_2 = ____exports.modifier_boss_faceless_2
modifier_boss_faceless_2.name = "modifier_boss_faceless_2"
__TS__ClassExtends(modifier_boss_faceless_2, MonsterModifier_CS)
function modifier_boss_faceless_2.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_boss_faceless_2.prototype.OnCreated(self, params) end
function modifier_boss_faceless_2.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local attacker = event.attacker
	local target = event.target
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, target) or target:IsBuilding() or target:IsOther() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if parent:PassivesDisabled() then
		return
	end
	if not ability or ability:IsNull() then
		return
	end
	if not RollPseudoRandomPercentage(BASH_CHANCE, DOTA_PSEUDO_RANDOM_CUSTOM_GAME_3, parent) then
		return
	end
	if not target:HasModifier(CHRONOSPHERE_HANDLER) then
		self:ApplyTimeLockToTarget(target)
		return
	end
	local enemies = FindUnitsInRadius(
		attacker:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		CHRONO_SEARCH_RADIUS,
		ability:GetAbilityTargetTeam(),
		ability:GetAbilityTargetType(),
		ability:GetAbilityTargetFlags(),
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue15
			end
			if not enemy:HasModifier(CHRONOSPHERE_HANDLER) then
				goto __continue15
			end
			self:ApplyTimeLockToTarget(enemy)
		end
		::__continue15::
	end
end
function modifier_boss_faceless_2.prototype.ApplyTimeLockToTarget(self, victim)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	victim:AddNewModifier(parent, ability, STUN_MODIFIER_NAME, { duration = BASH_DURATION })
	AddDeBuffStatus(nil, victim, parent, ability, DebuffStatusType.STUN, { duration = BASH_DURATION })
	Damage:ApplyDamage({
		attacker = parent,
		victim = victim,
		ability = ability,
		damage = BASH_DAMAGE,
		damage_type = 2,
	})
	victim:EmitSound(IMPACT_SOUND)
end
function modifier_boss_faceless_2.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end
function modifier_boss_faceless_2.prototype.IsHidden(self)
	return true
end
function modifier_boss_faceless_2.prototype.IsPurgable(self)
	return false
end
modifier_boss_faceless_2 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_faceless_2)
____exports.modifier_boss_faceless_2 = modifier_boss_faceless_2
____exports.modifier_boss_faceless_2_stun = __TS__Class()
local modifier_boss_faceless_2_stun = ____exports.modifier_boss_faceless_2_stun
modifier_boss_faceless_2_stun.name = "modifier_boss_faceless_2_stun"
__TS__ClassExtends(modifier_boss_faceless_2_stun, MonsterModifier_CS)
function modifier_boss_faceless_2_stun.prototype.IsPurgable(self)
	return false
end
function modifier_boss_faceless_2_stun.prototype.IsDebuff(self)
	return true
end
function modifier_boss_faceless_2_stun.prototype.IsHidden(self)
	return true
end
function modifier_boss_faceless_2_stun.prototype.IsStunDebuff(self)
	return true
end
function modifier_boss_faceless_2_stun.prototype.IsPurgeException(self)
	return true
end
function modifier_boss_faceless_2_stun.prototype.GetEffectName(self)
	return "particles/generic_gameplay/generic_stunned.vpcf"
end
function modifier_boss_faceless_2_stun.prototype.GetEffectAttachType(self)
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_boss_faceless_2_stun.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:SetRenderColor(128, 128, 255)
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_faceless_void/faceless_void_backtrack02.vpcf",
		PATTACH_ABSORIGIN,
		parent
	)
	ParticleManager:ReleaseParticleIndex(particle)
end
function modifier_boss_faceless_2_stun.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:GetParent():SetRenderColor(255, 255, 255)
end
modifier_boss_faceless_2_stun = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_faceless_2_stun)
____exports.modifier_boss_faceless_2_stun = modifier_boss_faceless_2_stun
return ____exports