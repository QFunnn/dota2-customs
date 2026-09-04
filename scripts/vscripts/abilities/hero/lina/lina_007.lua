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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local LINA_007_EXPLODE_PFX = "particles/bb/huskar_inner_fire_test_1.vpcf"
--- 与
--
-- @registerModifier 类名一致，供 GetIntrinsicModifierName 使用
local LINA_007_INTRINSIC_MODIFIER = "modifier_lina_007_kill_explode"
--- 丽娜技能 007（被动）：击杀敌人时概率触发爆炸
____exports.lina_007 = __TS__Class()
local lina_007 = ____exports.lina_007
lina_007.name = "lina_007"
__TS__ClassExtends(lina_007, BaseHeroAbility)
function lina_007.prototype.Precache(self, context)
	PrecacheResource("particle", LINA_007_EXPLODE_PFX, context)
end
function lina_007.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function lina_007.prototype.GetIntrinsicModifierName(self)
	return LINA_007_INTRINSIC_MODIFIER
end
lina_007 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_007)
____exports.lina_007 = lina_007
____exports.modifier_lina_007_kill_explode = __TS__Class()
local modifier_lina_007_kill_explode = ____exports.modifier_lina_007_kill_explode
modifier_lina_007_kill_explode.name = "modifier_lina_007_kill_explode"
__TS__ClassExtends(modifier_lina_007_kill_explode, BaseHeroModifier)
function modifier_lina_007_kill_explode.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH, target = { scope = "global" } } }
end
function modifier_lina_007_kill_explode.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_lina_007_kill_explode.prototype.IsPermanent(self)
	return true
end
function modifier_lina_007_kill_explode.prototype.OnUnitDeath_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	local ____event_entindex_attacker_0
	if event.entindex_attacker then
		____event_entindex_attacker_0 = EntIndexToHScript(event.entindex_attacker)
	else
		____event_entindex_attacker_0 = nil
	end
	local attacker = ____event_entindex_attacker_0
	if not attacker or not IsValid(nil, attacker) or attacker:IsNull() or attacker ~= parent then
		return
	end
	local ____event_entindex_killed_1
	if event.entindex_killed then
		____event_entindex_killed_1 = EntIndexToHScript(event.entindex_killed)
	else
		____event_entindex_killed_1 = nil
	end
	local killed = ____event_entindex_killed_1
	if not killed or not IsValid(nil, killed) or killed:IsNull() then
		return
	end
	if killed == parent then
		return
	end
	if killed:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if killed:IsBuilding() then
		return
	end
	local chance = self:GetSpecialValue("lina_007", "trigger_chance_pct")
	if not RollPseudoRandomPercentage(chance, DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1, parent) then
		return
	end
	local origin = killed:GetAbsOrigin()
	local radius = self:GetSpecialValue("lina_007", "radius")
	local damagePct = self:GetSpecialValue("lina_007", "max_health_damage_pct")
	local damage = killed:GetMaxHealth() * damagePct * 0.01
	local pid = MyGameHeroParticleManager:CreateParticle(LINA_007_EXPLODE_PFX, PATTACH_WORLDORIGIN, parent, parent)
	MyGameHeroParticleManager:SetParticleControl(pid, 0, origin)
	MyGameHeroParticleManager:SetParticleControl(pid, 1, origin)
	MyGameHeroParticleManager:ReleaseParticleIndex(pid)
	EmitSoundOnLocationWithCaster(origin, "Hero_Snapfire.MortimerBlob.Impact", parent)
	if MyGameDestructibleManager ~= nil then
		MyGameDestructibleManager:BreakCircleForHero(parent, origin, radius, ability)
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue18
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = ability,
			})
		end
		::__continue18::
	end
end
modifier_lina_007_kill_explode = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_lina_007_kill_explode)
____exports.modifier_lina_007_kill_explode = modifier_lina_007_kill_explode
return ____exports