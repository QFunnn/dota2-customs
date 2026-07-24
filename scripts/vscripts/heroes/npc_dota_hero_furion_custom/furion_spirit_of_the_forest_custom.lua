--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_furion_spirit_of_the_forest_custom", "heroes/npc_dota_hero_furion_custom/furion_spirit_of_the_forest_custom", LUA_MODIFIER_MOTION_NONE)

furion_spirit_of_the_forest_custom = class({})
furion_spirit_of_the_forest_custom.modifier_furion_11_radius = 100
furion_spirit_of_the_forest_custom.modifier_furion_11_damage = 1

function furion_spirit_of_the_forest_custom:GetIntrinsicModifierName()
    return "modifier_furion_spirit_of_the_forest_custom"
end

modifier_furion_spirit_of_the_forest_custom = class({})
function modifier_furion_spirit_of_the_forest_custom:IsPurgable() return false end
function modifier_furion_spirit_of_the_forest_custom:IsPurgeException() return false end
function modifier_furion_spirit_of_the_forest_custom:RemoveOnDeath() return false end

function modifier_furion_spirit_of_the_forest_custom:OnCreated()
	if not IsServer() then return end
    self.damage = 0
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
    self:StartIntervalThink(0.1)
end

function modifier_furion_spirit_of_the_forest_custom:OnIntervalThink()
	if not IsServer() then return end
    local damage_per_tree_pct = self:GetAbility():GetSpecialValueFor("damage_per_tree_pct")
    local radius_base = self:GetAbility():GetSpecialValueFor("radius_base")
    local radius_treant = self:GetAbility():GetSpecialValueFor("radius_treant")
    local multiplier = self:GetAbility():GetSpecialValueFor("multiplier")
    if self:GetCaster():HasModifier("modifier_furion_11") then
        damage_per_tree_pct = damage_per_tree_pct + self:GetAbility().modifier_furion_11_damage
        radius_base = radius_base + self:GetAbility().modifier_furion_11_radius
    end
	local trees = GridNav:GetAllTreesAroundPoint(self:GetParent():GetAbsOrigin(), radius_base, false)
    local trees_count = #trees
    for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius_treant, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)) do
        if unit and unit:GetOwner() == self:GetCaster() and (unit:GetUnitName() == "npc_dota_furion_treant_1" or unit:GetUnitName() == "npc_dota_furion_treant_2" or unit:GetUnitName() == "npc_dota_furion_treant_3" or unit:GetUnitName() == "npc_dota_furion_treant_4") then  
            trees_count = trees_count + (1 * multiplier)         
        end
    end
	self.damage = trees_count * damage_per_tree_pct
    self:SetStackCount(self.damage)
    self:SendBuffRefreshToClients()
end

function modifier_furion_spirit_of_the_forest_custom:AddCustomTransmitterData()
    local data = 
    {
        damage = self.damage,
    }
    return data
end

function modifier_furion_spirit_of_the_forest_custom:HandleCustomTransmitterData( data )
    self.damage = data.damage
end

function modifier_furion_spirit_of_the_forest_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_furion_spirit_of_the_forest_custom:GetModifierDamageOutgoing_Percentage()
	return self.damage
end