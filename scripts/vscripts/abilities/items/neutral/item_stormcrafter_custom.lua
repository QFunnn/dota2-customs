--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_stormcrafter_custom", "abilities/items/neutral/item_stormcrafter_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_stormcrafter_custom_slow", "abilities/items/neutral/item_stormcrafter_custom", LUA_MODIFIER_MOTION_NONE)

item_stormcrafter_custom = class({})

function item_stormcrafter_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_stormcrafter_custom"
end

modifier_item_stormcrafter_custom = class(mod_hidden)
function modifier_item_stormcrafter_custom:RemoveOnDeath() return false end
function modifier_item_stormcrafter_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability:GetSpecialValueFor("damage")
self.ability.slow = self.ability:GetSpecialValueFor("slow")
self.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
self.max = self.ability:GetSpecialValueFor("max")
self.radius = self.ability:GetSpecialValueFor("radius")
self.heal = self.ability:GetSpecialValueFor("heal")

self.damageTable = {attacker = self.parent, ability = self.ability, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL}

if not IsServer() then return end
self:OnIntervalThink()
end

function modifier_item_stormcrafter_custom:OnIntervalThink()
if not IsServer() then return end
local count = 0
local heal = 0

if self.ability:IsFullyCastable() and self.parent:IsAlive() then
    for _,target in pairs(self.parent:FindTargets(self.radius)) do
        if self.parent:CanEntityBeSeenByMyTeam(target) then
            count = count + 1

            self.damageTable.victim = target
            local real_damage = DoDamage(self.damageTable)

            local result = self.parent:CanLifesteal(target)
            if result then
                heal = heal + result*real_damage
            end

            local nParticleIndex = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_POINT_FOLLOW, self.parent)
            ParticleManager:SetParticleControlEnt(nParticleIndex, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(nParticleIndex, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(nParticleIndex)

            target:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")
            target:AddNewModifier(self.parent, self.ability, "modifier_item_stormcrafter_custom_slow", {duration = self.slow_duration})

            if count >= self.max then
                break
            end
        end
    end
end

if count > 0 then
    if heal > 0 then
        self.parent:GenericHeal(heal, self.ability, true, "particles/items3_fx/octarine_core_lifesteal.vpcf")
    end
    self.ability:UseResources(false, false, false, true)
    self:StartIntervalThink(self.ability:GetCooldownTimeRemaining())
else
    self:StartIntervalThink(0.2)
end

end


function modifier_item_stormcrafter_custom:DealDamage(target)
if not IsServer() then return end



end





modifier_item_stormcrafter_custom_slow = class({})
function modifier_item_stormcrafter_custom_slow:IsHidden() return true end
function modifier_item_stormcrafter_custom_slow:IsPurgable() return true end
function modifier_item_stormcrafter_custom_slow:OnCreated()
self.slow = self:GetAbility().slow
end

function modifier_item_stormcrafter_custom_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_stormcrafter_custom_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end