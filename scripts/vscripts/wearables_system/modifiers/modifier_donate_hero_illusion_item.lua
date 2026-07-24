--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_donate_hero_illusion_item = class({})
function modifier_donate_hero_illusion_item:IsHidden() return true end
function modifier_donate_hero_illusion_item:IsPurgable() return false end
function modifier_donate_hero_illusion_item:IsPurgeException() return false end
function modifier_donate_hero_illusion_item:RemoveOnDeath() return false end
function modifier_donate_hero_illusion_item:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_donate_hero_illusion_item:CheckState()
return
{
    [MODIFIER_STATE_OUT_OF_GAME] = true,
    [MODIFIER_STATE_INVULNERABLE] = true,
    [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
    [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    [MODIFIER_STATE_PROVIDES_VISION] = true,
}
end

function modifier_donate_hero_illusion_item:OnCreated(table)
self.caster = self:GetCaster()
self.parent = self:GetParent()
if not IsServer() then return end
self.invis_counter = 0
self:SetHasCustomTransmitterData(true)
end

function modifier_donate_hero_illusion_item:UpdateState(state)
if not IsServer() then return end
self.invis_counter = state
self:SendBuffRefreshToClients()
end

function modifier_donate_hero_illusion_item:AddCustomTransmitterData()
return 
{
    invis_counter = self.invis_counter,
}
end

function modifier_donate_hero_illusion_item:HandleCustomTransmitterData( data )
self.invis_counter = data.invis_counter
end

function modifier_donate_hero_illusion_item:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
}
end

function modifier_donate_hero_illusion_item:GetModifierInvisibilityLevel()
return self.invis_counter
end