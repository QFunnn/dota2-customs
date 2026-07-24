--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_base = class({})

--------------------------------------------------------------------------------
function modifier_chen_base:IsHidden() return true end
function modifier_chen_base:IsDebuff() return false end
function modifier_chen_base:IsPurgable() return false end
function modifier_chen_base:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_chen_base:RemoveOnDeath() return false end

--------------------------------------------------------------------------------
function modifier_chen_base:OnCreated()
	if IsServer() then
		AddModifierEvents(MODIFIER_EVENT_ON_ABILITY_FULLY_CAST, self, self:GetParent())
	end
end
function modifier_chen_base:OnAbilityFullyCast(params)
	if IsValid(params.ability) and IsValid(params.target) and params.ability:GetAbilityName() == "chen_holy_persuasion" then
		local hParent = self:GetParent()
		params.target.by_chen_holy_persuasion = true
		params.target:RemoveModifierByName("modifier_creature_berserk")
		local spawner = GameMode.currentRound:GetTeamSpawner(hParent:GetTeamNumber())
		if spawner then
			spawner:OnEntityKilled({ entindex_attacker = hParent:entindex(), entindex_killed = params.target:entindex() })
		end
		hParent.__summon = hParent.__summon or {}
		hParent.__summon[params.target:entindex()] = true
	end
end