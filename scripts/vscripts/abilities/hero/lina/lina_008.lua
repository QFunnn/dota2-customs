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
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local LINA_008_PFX = "particles/hero/lina_006_1.vpcf"
--- 丽娜技能 008（被动/隐藏）：释放其它技能后，锁定最近敌人并延迟引爆
____exports.lina_008 = __TS__Class()
local lina_008 = ____exports.lina_008
lina_008.name = "lina_008"
__TS__ClassExtends(lina_008, BaseHeroAbility)
function lina_008.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_008_PFX, context)
end
function lina_008.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN }
end
function lina_008.prototype.GetIntrinsicModifierName(self)
	return "modifier_lina_008_intrinsic"
end
lina_008 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_008)
____exports.lina_008 = lina_008
____exports.modifier_lina_008_intrinsic = __TS__Class()
local modifier_lina_008_intrinsic = ____exports.modifier_lina_008_intrinsic
modifier_lina_008_intrinsic.name = "modifier_lina_008_intrinsic"
__TS__ClassExtends(modifier_lina_008_intrinsic, BaseModifier_CS)
function modifier_lina_008_intrinsic.prototype.IsHidden(self)
	return true
end
function modifier_lina_008_intrinsic.prototype.IsPurgable(self)
	return false
end
function modifier_lina_008_intrinsic.prototype.IsPurgeException(self)
	return false
end
function modifier_lina_008_intrinsic.prototype.IsPermanent(self)
	return true
end
function modifier_lina_008_intrinsic.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_lina_008_intrinsic.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	if castAbility.IsItem and castAbility:IsItem() and not event.is_trigger then
		return
	end
	if castAbility:GetAbilityName() == "lina_008" then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	local searchRadius = self:GetSpecialValue("lina_008", "search_radius")
	local ____opt_0 = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		searchRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local target = ____opt_0
		and __TS__ArrayFind(
			FindUnitsInRadius(parent:GetTeamNumber(), parent:GetAbsOrigin(), nil, searchRadius, 2, 19, 0, 0, false),
			function(____, e)
				return IsValidAlive(nil, e)
			end
		)
	if not target then
		return
	end
	local origin = parent:GetAbsOrigin()
	local targetPoint = target:GetAbsOrigin()
	local pid = MyGameHeroParticleManager:CreateParticle(LINA_008_PFX, PATTACH_WORLDORIGIN, parent, parent)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, origin)
	MyGameHeroParticleManager:SetParticleControl(pid, 1, targetPoint)
	MyGameHeroParticleManager:SetParticleControl(pid, 2, Vector(3, 3, 3))
	MyGameHeroParticleManager:ReleaseParticleIndex(pid)
	local delay = self:GetSpecialValue("lina_008", "impact_delay")
	local hitRadius = self:GetSpecialValue("lina_008", "hit_radius")
	local damageMultiplierPct = self:GetSpecialValue("lina_008", "damage_multiplier_pct")
	local baseDamage = self:GetSpecialValue("lina_008", "base_damage")
	local damage = self:GetAllAttackDamage() * damageMultiplierPct / 100 + baseDamage
	Timers:CreateTimer(delay, function()
		if not IsValidAlive(nil, parent) then
			return
		end
		if not ability or ability:IsNull() then
			return
		end
		if MyGameDestructibleManager ~= nil then
			MyGameDestructibleManager:BreakCircleForHero(parent, targetPoint, hitRadius, ability)
		end
		local enemies = FindUnitsInRadius(
			parent:GetTeamNumber(),
			targetPoint,
			nil,
			hitRadius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue23
				end
				local ____opt_4 = enemy.GetUnitType
				local ut = ____opt_4 and ____opt_4(enemy)
				if ut == UnitType.BUILDING or ut == UnitType.DESTRUCTIBLE then
					goto __continue23
				end
				if damage > 0 then
					Damage:ApplyDamage({
						attacker = parent,
						victim = enemy,
						damage = damage,
						damage_type = 2,
						ability = ability,
						extra_data = { source_name = ability:GetAbilityName() },
					})
				end
			end
			::__continue23::
		end
	end)
end
modifier_lina_008_intrinsic =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_lina_008_intrinsic") }, modifier_lina_008_intrinsic)
____exports.modifier_lina_008_intrinsic = modifier_lina_008_intrinsic
return ____exports