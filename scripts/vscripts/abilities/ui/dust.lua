--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_custom_dust_charges", "abilities/ui/dust", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_custom_dust_cd", "abilities/ui/dust", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_custom_dust_area", "abilities/ui/dust", LUA_MODIFIER_MOTION_NONE)

custom_ability_dust = class({})

function custom_ability_dust:Spawn()
    if not IsServer() then return end
    if self and not self:IsTrained() then
        self:SetLevel(1)
    end
end


function custom_ability_dust:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
    return "modifier_item_custom_dust_charges"
end

function custom_ability_dust:OnInventoryContentsChanged()
    if not IsServer() then return end
    for i=0, 8 do
        local item = self:GetCaster():GetItemInSlot(i)
        if item then
            if item:GetName() == "item_dust" and not item.use_ui then
                if self:GetCaster():IsRealHero() then
                    local modifier_sentry = self:GetCaster():FindModifierByName("modifier_item_custom_dust_charges")
                    if modifier_sentry then
                        modifier_sentry:SetStackCount(modifier_sentry:GetStackCount() + item:GetCurrentCharges())
                    end
                    item.use_ui = true
                    Timers:CreateTimer(0, function()
                        UTIL_Remove( item )
                    end)
                end
            end
        end
    end
end

function custom_ability_dust:OnSpellStart()
if not IsServer() then return end
if self:GetCaster():HasModifier("modifier_item_custom_dust_cd") then return end

local mod_stacks = self:GetCaster():GetModifierStackCount("modifier_item_custom_dust_charges", self:GetCaster())
if mod_stacks and mod_stacks <= 0 then
    local player = PlayerResource:GetPlayer( self:GetCaster():GetPlayerOwnerID() )
    CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#dota_hud_error_no_charges"})
    self:EndCd(0)
    return
end

self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_custom_dust_cd", {duration = 1})

self:GetCaster():EmitSound("DOTA_Item.DustOfAppearance.Activate")

CreateModifierThinker(self:GetCaster(), self, "modifier_item_custom_dust_area", {duration = self:GetSpecialValueFor("duration")}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)



local mod = self:GetCaster():FindModifierByName("modifier_item_custom_dust_charges")
if mod then
    mod:DecrementStackCount()
end

end

modifier_item_custom_dust_area = class({})
function modifier_item_custom_dust_area:IsHidden() return true end
function modifier_item_custom_dust_area:IsPurgable() return false end
function modifier_item_custom_dust_area:OnCreated()
if not IsServer() then return end

self.caster = self:GetCaster()
self.parent = self:GetParent()
self.targets = {}

self.radius = self:GetAbility():GetSpecialValueFor("radius")
self.duration = self:GetAbility():GetSpecialValueFor("duration_linger")
self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.movespeed = self:GetAbility():GetSpecialValueFor("movespeed")

local particle = ParticleManager:CreateParticle( "particles/items_fx/dust_of_appearance.vpcf", PATTACH_WORLDORIGIN, nil )
ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetAbsOrigin() )
ParticleManager:SetParticleControl( particle, 1, Vector(self.radius, 0, self.radius) )
self:AddParticle(particle,false, false, -1, false, false)


self:StartIntervalThink(0.2)
self:OnIntervalThink()
end 


function modifier_item_custom_dust_area:OnIntervalThink()
if not IsServer() then return end 

local targets = self.caster:FindTargets(self.radius, self.parent:GetAbsOrigin())

for _, unit in pairs(targets) do
    if not self.targets[unit] then 
        DoDamage({ victim = unit, attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility(), }) 
        self.targets[unit] = true
    end 


    unit:AddNewModifier(self.caster, self:GetAbility(), "modifier_item_dustofappearance", {duration = self.duration, movespeed = self.movespeed})
end

end 





modifier_item_custom_dust_charges = class({})
function modifier_item_custom_dust_charges:IsHidden() return true end
function modifier_item_custom_dust_charges:DestroyOnExpire() return false end
function modifier_item_custom_dust_charges:IsPurgable() return false end



modifier_item_custom_dust_cd = class({})
function modifier_item_custom_dust_cd:IsHidden() return true end
function modifier_item_custom_dust_cd:IsPurgable() return false end