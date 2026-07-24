--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


 LinkLuaModifier( "modifier_generic_arc_lua_tidehunter", "heroes/npc_dota_hero_tidehunter_custom/tidehunter_ravage_custom", LUA_MODIFIER_MOTION_BOTH )

tidehunter_arm_of_the_deep_custom = class({})

function tidehunter_arm_of_the_deep_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_arm_of_the_deep_projectile.vpcf", context )
end

function tidehunter_arm_of_the_deep_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end
	local direction = point - self:GetCaster():GetAbsOrigin()
	direction.z = 0
	direction = direction:Normalized()
	self:StartMiniRavage(direction)
end

function tidehunter_arm_of_the_deep_custom:StartMiniRavage(direction)
	if not IsServer() then return end
	local speed = self:GetSpecialValueFor("speed_scepter")
	local radius = self:GetSpecialValueFor("aoe_scepter")
    local radius = self:GetSpecialValueFor("radius")
	local tidehunter_ravage_custom = self:GetCaster():FindAbilityByName("tidehunter_ravage_custom")
	if tidehunter_ravage_custom and tidehunter_ravage_custom:GetLevel() > 0 then
		local info = {
			Source = self:GetCaster(),
			Ability = self,
			vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
			bDeleteOnHit = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			EffectName = "particles/units/heroes/hero_tidehunter/tidehunter_arm_of_the_deep_projectile.vpcf",
			fDistance = (tidehunter_ravage_custom:GetSpecialValueFor("radius") / 100 * self:GetSpecialValueFor("range_pct")) + self:GetCaster():GetCastRangeBonus(),
			fStartRadius = radius,
			fEndRadius = radius,
			vVelocity = direction * 725,
			ExtraData = {
				scepter = 1,
			}
		}
		self:GetCaster():EmitSound("Hero_Tidehunter.ArmsOfTheDeep")
		ProjectileManager:CreateLinearProjectile( info )
	end
end

function tidehunter_arm_of_the_deep_custom:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	local tidehunter_ravage_custom = self:GetCaster():FindAbilityByName("tidehunter_ravage_custom")
	if tidehunter_ravage_custom then
		local knockback = target:AddNewModifier( self:GetCaster(), self, "modifier_generic_arc_lua_tidehunter", { duration = 0.5, height = 350 } )
        target:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = (tidehunter_ravage_custom:GetSpecialValueFor("duration") / 100 * self:GetSpecialValueFor("duration_pct")) + 0.5 } )

		local damage = tidehunter_ravage_custom:GetAbilityDamage() / 100 * self:GetSpecialValueFor("damage_pct")

		if self:GetCaster():HasModifier("modifier_tidehunter_6") then
			damage = damage + ( self:GetCaster():GetStrength() / 100 * tidehunter_ravage_custom.modifier_tidehunter_6[self:GetCaster():GetTalentLevel("modifier_tidehunter_6")])
		end

		knockback:SetEndCallback( function()
			ApplyDamage({ victim = target, attacker = self:GetCaster(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
			target:EmitSound("Hero_Tidehunter.RavageDamage")
		end)

		target:EmitSound("Hero_Tidehunter.ArmsOfTheDeep.Stun")

	end
	
	return false
end