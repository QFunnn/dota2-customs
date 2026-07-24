--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_repair", "upgrade/item_upgrade_repair.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_upgrade_repair_cd", "upgrade/item_upgrade_repair.lua", LUA_MODIFIER_MOTION_NONE)

item_upgrade_repair = class({})


function item_upgrade_repair:OnAbilityPhaseStart()
if not IsServer() then return end

local target = self:GetCursorTarget()

if target:HasModifier("modifier_upgrade_repair_cd") then 
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = "#cant_repair"})
   return false
end

return true
end


function item_upgrade_repair:OnSpellStart()
if not IsServer() then return end

self:GetCursorTarget():AddNewModifier(self:GetCaster(), self, "modifier_upgrade_repair_cd", {duration = self:GetSpecialValueFor("cd")})
self:GetCursorTarget():AddNewModifier(self:GetCaster(), self, "modifier_repair", {duration = self:GetSpecialValueFor("duration")})
self:GetCursorTarget():EmitSound("DOTA_Item.RepairKit.Target")
self:SpendCharge(0)
end


modifier_repair = class({})

function modifier_repair:IsHidden() return false end
function modifier_repair:IsPurgable() return false end
function modifier_repair:OnCreated(table)

self.heal = self:GetAbility():GetSpecialValueFor("heal_shrine")

if self:GetParent():GetUnitName() == "npc_towerdire" or self:GetParent():GetUnitName() == "npc_towerradiant" then 
	self.heal = self:GetAbility():GetSpecialValueFor("heal")
end

self.particle = ParticleManager:CreateParticle("particles/items5_fx/repair_kit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 1, self:GetParent():GetAbsOrigin())

end
function modifier_repair:OnDestroy()
ParticleManager:DestroyParticle(self.particle , false)
ParticleManager:ReleaseParticleIndex(self.particle)
end

function modifier_repair:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
}
end

function modifier_repair:GetTexture() return "item_repair_kit" end
function modifier_repair:GetModifierHealthRegenPercentage() return self.heal end


modifier_upgrade_repair_cd = class({})

function modifier_upgrade_repair_cd:IsHidden() return false end
function modifier_upgrade_repair_cd:IsPurgable() return false end
function modifier_upgrade_repair_cd:IsDebuff() return true end
function modifier_upgrade_repair_cd:GetTexture() return "item_repair_kit" end