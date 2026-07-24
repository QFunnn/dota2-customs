--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_generic_repair = class({})
function modifier_generic_repair:IsHidden() return false end
function modifier_generic_repair:IsPurgable() return false end
function modifier_generic_repair:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_generic_repair:GetTexture() return "item_repair_kit" end

function modifier_generic_repair:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.heal = 0

if table.tower_heal then 
	self.heal = table.tower_heal
end

if self.parent:GetUnitName() ~= "npc_towerradiant" and self.parent:GetUnitName() ~= "npc_towerdire" and table.heal_shrine then 
    self.heal = table.heal_shrine
end

self.particle = ParticleManager:CreateParticle("particles/items5_fx/repair_kit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, self.parent:GetAbsOrigin())
self:AddParticle(self.particle, false, false, -1, false, false)

self.heal = (self.heal*self.parent:GetMaxHealth()/100)/self:GetRemainingTime()

self:OnIntervalThink()
self:StartIntervalThink(1)
self:SetHasCustomTransmitterData(true)
end


function modifier_generic_repair:AddCustomTransmitterData() return 
{
    heal = self.heal,
} 
end

function modifier_generic_repair:HandleCustomTransmitterData(data)
self.heal = data.heal
end


function modifier_generic_repair:OnIntervalThink()
if not IsServer() then return end
self.parent:GenericParticle("particles/generic_gameplay/generic_lifesteal.vpcf")
SendOverheadEventMessage(self.parent, 10, self.parent, self.heal, nil)
end


function modifier_generic_repair:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
}
end

function modifier_generic_repair:GetModifierConstantHealthRegen()
return self.heal
end

