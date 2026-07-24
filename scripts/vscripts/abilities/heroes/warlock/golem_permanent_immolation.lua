--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


warlock_golem_permanent_immolation_lua = class({})
LinkLuaModifier( "modifier_warlock_golem_permanent_immolation_lua", "abilities/heroes/warlock/golem_permanent_immolation", LUA_MODIFIER_MOTION_NONE )

function warlock_golem_permanent_immolation_lua:GetAOERadius()
	return self:GetSpecialValueFor("aura_radius") or 0
end

function warlock_golem_permanent_immolation_lua:GetIntrinsicModifierName()
	return "modifier_warlock_golem_permanent_immolation_lua"
end


------------------------------------------------------------------------------------------------------------------------------------------------


modifier_warlock_golem_permanent_immolation_lua = class({})

function modifier_warlock_golem_permanent_immolation_lua:IsHidden() return true end
function modifier_warlock_golem_permanent_immolation_lua:IsDebuff() return false end
function modifier_warlock_golem_permanent_immolation_lua:IsPurgable() return false end


function modifier_warlock_golem_permanent_immolation_lua:OnCreated(kv)
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	if not IsValidEntity(self.parent) or not IsValidEntity(self.ability) then return end

	self:OnRefresh()

	if not IsServer() then return end

	self.owner = self.parent:GetOwner()

	self:StartIntervalThink(self.tick_interval)
end


function modifier_warlock_golem_permanent_immolation_lua:OnRefresh(kv)
	self.tick_interval = self.ability:GetSpecialValueFor("tick_interval")
	self.aura_radius = self.ability:GetSpecialValueFor("aura_radius")
	self.aura_damage = self.ability:GetSpecialValueFor("aura_damage")
	self.manahealthboost = self.ability:GetSpecialValueFor("manahealthboost") / 100.0
end


function modifier_warlock_golem_permanent_immolation_lua:OnIntervalThink()
	local damage = self.aura_damage

	if self.owner:GetHeroFacetID() == 1 and not self.owner:HasModifier("modifier_fountain_rejuvenation_effect_lua") then
		damage = damage + self.manahealthboost * self.owner:GetHealthRegen() + self.manahealthboost * self.owner:GetManaRegen()
	end

	local damage_table = {
		damage 			= damage * self.tick_interval,
		damage_type		= DAMAGE_TYPE_MAGICAL,
		damage_flags	= DOTA_DAMAGE_FLAG_NONE,
		attacker		= self.parent,
		ability			= self.ability
	}

	local enemies = FindUnitsInRadius(
		self.parent:GetTeam(),
		self.parent:GetAbsOrigin(),
		nil,
		self.aura_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		if IsValidEntity(enemy) then
			damage_table.victim = enemy
			ApplyDamage(damage_table)
		end
	end
end