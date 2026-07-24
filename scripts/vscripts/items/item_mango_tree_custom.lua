--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_mango_tree_custom", "items/item_mango_tree_custom", LUA_MODIFIER_MOTION_NONE)

item_mango_tree_custom = class({})

function item_mango_tree_custom:OnSpellStart()
	if not IsServer() then return end

	local point = self:GetCursorPosition()

	local duration = self:GetSpecialValueFor("duration")

	local radius = self:GetSpecialValueFor("radius")

	local mango_count = self:GetSpecialValueFor("mango_count")

	local interval = self:GetSpecialValueFor("interval")

	CreateModifierThinker( self:GetCaster(), self, "modifier_item_mango_tree_custom", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false )
end

modifier_item_mango_tree_custom = class({})

function modifier_item_mango_tree_custom:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.mango_count = self:GetAbility():GetSpecialValueFor("mango_count")
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	self.tree = CreateTempTreeWithModel( self:GetParent():GetAbsOrigin(), duration, "models/props_tree/mango_tree.vmdl" )
	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0,     false     )
    for _,unit in pairs(units) do
        if unit:IsHero() or unit:IsCreep() then
            FindClearSpaceForUnit( unit, unit:GetOrigin(), true )
        end
    end
	for i = 1, self.mango_count do
		local item_name = CreateItem( "item_enchanted_mango_custom", self:GetCaster(), self:GetCaster() )
		local DropItem = CreateItemOnPositionForLaunch( self:GetParent():GetAbsOrigin(), item_name )
		local dropRadiusChest = RandomFloat( 50, 100 )
		item_name:LaunchLootInitialHeight( false, 0, 300, 0.75, self:GetCaster():GetAbsOrigin() + RandomVector( dropRadiusChest ) )
	end

	self:StartIntervalThink(FrameTime())
end

function modifier_item_mango_tree_custom:OnIntervalThink()
	if not IsServer() then return end

	if self.tree:IsNull() then
		self:Destroy()
		return
	end

	AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.radius, FrameTime()*2, false )
end