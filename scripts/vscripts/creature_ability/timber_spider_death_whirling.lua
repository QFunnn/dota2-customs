--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


timber_spider_death_whirling = class({}) ---@class timber_spider_death_whirling : CDOTA_Ability_Lua

function timber_spider_death_whirling:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Shredder.WhirlingDeath.Cast")


	local nParticle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_shredder/shredder_whirling_death.vpcf", PATTACH_CENTER_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(nParticle, 1, self:GetCaster(), PATTACH_CENTER_FOLLOW, "attach_hitloc",
		self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(nParticle)


	local flRadius = self:GetSpecialValueFor("whirling_radius")
	local trees = GridNav:GetAllTreesAroundPoint(self:GetCaster():GetAbsOrigin(), flRadius, false)
	local nTreeNumber = #trees

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetAbsOrigin(),
		nil,
		flRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, hEnemy in pairs(enemies) do
		local flDamage = self:GetSpecialValueFor("damage")

		if nTreeNumber > 0 then
			flDamage = self:GetSpecialValueFor("damage_with_tree")
			hEnemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {
				duration = self:GetSpecialValueFor("stun_with_tree")
			})
		end

		ApplyDamage({
			victim       = hEnemy,
			damage       = flDamage,
			damage_type  = self:GetAbilityDamageType(),
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			attacker     = self:GetCaster(),
			ability      = self
		})
	end
	GridNav:DestroyTreesAroundPoint(self:GetCaster():GetAbsOrigin(), self:GetSpecialValueFor("whirling_radius"), false)
end