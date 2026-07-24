--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_magic_stick_custom", "abilities/items/item_magic_stick_custom", LUA_MODIFIER_MOTION_NONE)

item_magic_stick_custom = class({})

function item_magic_stick_custom:GetIntrinsicModifierName()
return "modifier_item_magic_stick_custom"
end

function item_magic_stick_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/magic_stick.vpcf", context )
end

function item_magic_stick_custom:OnSpellStart()

local caster = self:GetCaster()

local mana = self:GetSpecialValueFor("restore_per_charge")*self:GetCurrentCharges()
local heal = self:GetSpecialValueFor("restore_per_charge")*self:GetCurrentCharges()

caster:GenericHeal(heal, self, false, "")
caster:GiveMana(mana)

caster:EmitSound("DOTA_Item.MagicWand.Activate")

local particle = ParticleManager:CreateParticle("particles/items2_fx/magic_stick.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
ParticleManager:SetParticleControl(particle, 1, Vector(self:GetCurrentCharges()/10, 0, 0))
ParticleManager:DestroyParticle(particle, false)
ParticleManager:ReleaseParticleIndex(particle)

local mod = caster:FindModifierByName("modifier_item_magic_stick_custom")
if mod and mod.cooldown then
    mod:StartIntervalThink(mod.cooldown)
end

self:SetCurrentCharges(0)

end


modifier_item_magic_stick_custom = class({})

function modifier_item_magic_stick_custom:IsHidden() return true end
function modifier_item_magic_stick_custom:IsPurgable() return false end
function modifier_item_magic_stick_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("charge_radius")
self.cooldown = self.ability:GetSpecialValueFor("passive_cooldown")
self.max = self.ability:GetSpecialValueFor("max_charges")

if not IsServer() then return end
if not self.parent:IsRealHero() then return end

self.parent:AddSpellEvent(self, true)
--self:StartIntervalThink(self.cooldown)
end


function modifier_item_magic_stick_custom:OnDestroy()
if not IsServer() then return end
local charges = self.ability:GetCurrentCharges()

Timers:CreateTimer(0.1, function()
    if not self.parent:IsNull() and self.ability:IsNull() then
        local item_wand = self.parent:FindItemInInventory("item_magic_wand_custom")
        if item_wand then
            item_wand:SetCurrentCharges(math.max(charges, item_wand:GetCurrentCharges()))
        end
    end
end)

end


function modifier_item_magic_stick_custom:OnIntervalThink()
if not IsServer() then return end
self:AddStack()
end


function modifier_item_magic_stick_custom:AddStack()
if not IsServer() then return end
if self.parent:HasModifier("modifier_item_magic_wand_custom") then return end
if self.parent:HasModifier("modifier_item_holy_locket_custom") then return end
if self.ability:GetCurrentCharges() >= self.max then return end

self.ability:SetCurrentCharges(self.ability:GetCurrentCharges() + 1)
end


function modifier_item_magic_stick_custom:SpellEvent(params)
if not IsServer() then return end
if not self.parent:IsAlive() then return end
if (self.parent ~= params.unit) and params.unit:GetTeamNumber() == self.parent:GetTeamNumber() then return end
if not self.parent:CanEntityBeSeenByMyTeam(params.unit) then return end
if params.ability:IsItem() then return end
if not params.unit:IsHero() then return end
if (params.unit:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then return end

self:AddStack()
end