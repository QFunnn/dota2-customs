--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_furion_force_of_nature_custom", "heroes/hero_furion/furion_force_of_nature_custom", LUA_MODIFIER_MOTION_NONE)

furion_force_of_nature_custom = class({})

function furion_force_of_nature_custom:GetAOERadius()
	return self:GetSpecialValueFor( "area_of_effect" )
end

function furion_force_of_nature_custom:GetCooldown(level)
    return self.BaseClass.GetCooldown( self, level )
end

function furion_force_of_nature_custom:OnSpellStart()
	if not IsServer() then return end
	local area_of_effect = self:GetSpecialValueFor( "area_of_effect" )
	local max_treants = self:GetSpecialValueFor( "max_treants" )
	local duration = self:GetSpecialValueFor( "treant_duration" )
	local treant_health_tooltip = self:GetSpecialValueFor("treant_health_tooltip")
	local treant_dmg_tooltip = self:GetSpecialValueFor("treant_dmg_tooltip")
	local point = self:GetCursorPosition()
	local trees = GridNav:GetAllTreesAroundPoint( point, area_of_effect, true )
	local nTreeCount = #trees

	for _, warlock_gl in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)) do
        if (warlock_gl:GetUnitName() == "npc_dota_furion_treant" or warlock_gl:GetUnitName() == "npc_dota_furion_treant_large") and warlock_gl:GetOwner() == self:GetCaster() then
            warlock_gl:Destroy()             
       	end
    end

	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_force_of_nature_cast.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_staff_base", self:GetCaster():GetOrigin(), true )
	ParticleManager:SetParticleControl( nFXIndex, 1, point )
	ParticleManager:SetParticleControl( nFXIndex, 2, Vector( area_of_effect, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	GridNav:DestroyTreesAroundPoint( point, area_of_effect, true )

	local nTreantsToSpawn = max_treants

	while nTreantsToSpawn > 0 do
		local name = "npc_dota_furion_treant"
		local hTreant = CreateUnitByName( name, point, true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber() )
		if hTreant ~= nil then
			hTreant:SetControllableByPlayer( self:GetCaster():GetPlayerID(), false )
			hTreant:SetOwner( self:GetCaster() )
			hTreant:AddNewModifier( self:GetCaster(), self, "modifier_kill", {duration = duration} )
			hTreant:AddNewModifier(self:GetCaster(), self, "modifier_furion_force_of_nature_custom", {})
		end
		nTreantsToSpawn = nTreantsToSpawn - 1
	end

	self:GetCaster():EmitSound("Hero_Furion.ForceOfNature")
end

modifier_furion_force_of_nature_custom = class({})

function modifier_furion_force_of_nature_custom:IsHidden() return true end
function modifier_furion_force_of_nature_custom:IsPurgable() return false end

function modifier_furion_force_of_nature_custom:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end

function modifier_furion_force_of_nature_custom:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("treant_movespeed_bonus")
end

function modifier_furion_force_of_nature_custom:OnCreated()
	if not IsServer() then return end
	local bonus = 0
	local treant_damage_min = self:GetAbility():GetSpecialValueFor("treant_damage_min")
	local treant_damage_max = self:GetAbility():GetSpecialValueFor("treant_damage_max")

	self:GetParent():SetBaseDamageMin(treant_damage_min)
	self:GetParent():SetBaseDamageMax(treant_damage_max)
	local total_hp = self:GetAbility():GetSpecialValueFor("treant_health") + bonus
	self:GetParent():SetBaseMaxHealth(total_hp)
	self:GetParent():SetMaxHealth(total_hp)
	self:GetParent():SetHealth(total_hp)
end