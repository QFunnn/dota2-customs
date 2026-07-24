--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_custom_sentry_ward", "abilities/ui/sentry", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_custom_sentry_ward_charges", "abilities/ui/sentry", LUA_MODIFIER_MOTION_NONE)

custom_ability_sentry = class({})

function custom_ability_sentry:Spawn()
    if not IsServer() then return end
    if self and not self:IsTrained() then
        self:SetLevel(1)
    end
end

function custom_ability_sentry:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_custom_sentry_ward_charges"
end


function custom_ability_sentry:OnInventoryContentsChanged()
    if not IsServer() then return end
    for i=0, 8 do
        local item = self:GetCaster():GetItemInSlot(i)
        if item then
            if item:GetName() == "item_ward_sentry" and not item.use_ui then
                if self:GetCaster():IsRealHero() then
                    local modifier_sentry = self:GetCaster():FindModifierByName("modifier_item_custom_sentry_ward_charges")
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

function custom_ability_sentry:OnAbilityPhaseStart()

    local mod_stacks = self:GetCaster():GetModifierStackCount("modifier_item_custom_sentry_ward_charges", self:GetCaster())
    if mod_stacks and mod_stacks <= 0 then
        local player = PlayerResource:GetPlayer( self:GetCaster():GetPlayerOwnerID() )
        CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message = "#dota_hud_error_no_charges"})
        return false
    end
    return true
end

function custom_ability_sentry:OnSpellStart()
local caster = self:GetCaster()

self:GetCaster():EmitSound("DOTA_Item.ObserverWard.Activate")

local hWard = CreateUnitByName("npc_dota_sentry_wards", self:GetCursorPosition(), true, caster, caster, caster:GetTeamNumber())
hWard:SetMaterialGroup("1")
hWard:AddNewModifier(caster, self, "modifier_item_custom_sentry_ward", {})
hWard:AddNewModifier(caster, self, "modifier_kill", {duration = 480})

AddFOWViewer(caster:GetTeamNumber(), self:GetCursorPosition(), 50, 10, false)
local mod = caster:FindModifierByName("modifier_item_custom_sentry_ward_charges")
if mod then
    mod:DecrementStackCount()
end

end


modifier_item_custom_sentry_ward = class({})
function modifier_item_custom_sentry_ward:IsHidden() return true end
function modifier_item_custom_sentry_ward:IsAura() return true end
function modifier_item_custom_sentry_ward:IsPurgable() return false end
function modifier_item_custom_sentry_ward:RemoveOnDeath() return true end
function modifier_item_custom_sentry_ward:GetAuraRadius() return 700 end
function modifier_item_custom_sentry_ward:GetModifierAura() return "modifier_truesight" end
function modifier_item_custom_sentry_ward:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_custom_sentry_ward:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_item_custom_sentry_ward:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_item_custom_sentry_ward:GetAuraDuration() return 0.1 end

function modifier_item_custom_sentry_ward:CheckState()
return 
{
    [MODIFIER_STATE_INVISIBLE] = true,
    [MODIFIER_STATE_SPECIALLY_DENIABLE] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
}
end


function modifier_item_custom_sentry_ward:OnCreated(params)
self.destroy_attacks            = 8
self.hero_attack_multiplier     = 4

self.parent = self:GetParent()
self.caster = self:GetCaster()

if not IsServer() then return end

self.parent:AddAttackEvent_inc(self)

self.health_increments = self.parent:GetMaxHealth() / self.destroy_attacks

self.particle_hero_icon = ParticleManager:CreateParticle("particles/hero_capture_icon/hero_capture_icon_ward.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
if self.caster then 
    local name = dota1x6:GetHeroIcon(self.caster:GetId())
    if not name then
        name = self.caster:GetUnitName()
    end
    local width_table = Vector(1, 1, 0)
    if icon_hero_width[name] then
        width_table = Vector(icon_hero_width[name][1], icon_hero_width[name][2], 0)
    end

    ParticleManager:SetParticleControl(self.particle_hero_icon, 1, Vector(icon_hero_id[name],0,0))
    ParticleManager:SetParticleControl(self.particle_hero_icon, 2, width_table)
end

self:AddParticle( self.particle_hero_icon, false, false, -1, false, false  )
end

function modifier_item_custom_sentry_ward:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    MODIFIER_PROPERTY_HEALTHBAR_PIPS,
}
end

function modifier_item_custom_sentry_ward:GetModifierHealthBarPips() return self.destroy_attacks/self.hero_attack_multiplier end
function modifier_item_custom_sentry_ward:GetAbsoluteNoDamageMagical() return 1 end
function modifier_item_custom_sentry_ward:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_item_custom_sentry_ward:GetAbsoluteNoDamagePure() return 1 end
function modifier_item_custom_sentry_ward:AttackEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.target then return end
local attacker = params.attacker

if attacker:GetTeamNumber() == self.parent:GetTeamNumber() then
    if self.parent:GetHealthPercent() > 50 then
        self.parent:SetHealth(self.parent:GetHealth() - 10)
    else 
        self.parent:Kill(nil, attacker)
        self:Destroy()
    end
    return
end

if attacker:IsRealHero() or attacker:HasModifier("modifier_life_stealer_infest_custom_legendary_creep") then
    if self.parent:GetHealth() - (self.health_increments * self.hero_attack_multiplier) <= 0 then
        self.parent:Kill(nil, attacker)
        self:Destroy()
    else 
        self.parent:SetHealth(self.parent:GetHealth() - (self.health_increments * self.hero_attack_multiplier))
    end
else
    if self.parent:GetHealth() - self.health_increments <= 0 then
        self.parent:Kill(nil, attacker)
        self:Destroy()
    else 
        self.parent:SetHealth(self.parent:GetHealth() - self.health_increments)
    end
end

end




modifier_item_custom_sentry_ward_charges = class({})
function modifier_item_custom_sentry_ward_charges:IsHidden() return true end
function modifier_item_custom_sentry_ward_charges:DestroyOnExpire() return false end
function modifier_item_custom_sentry_ward_charges:IsPurgable() return false end


function modifier_item_custom_sentry_ward_charges:OnCreated()

self.parent = self:GetParent()
self.ability = self:GetAbility()

self:SetStackCount(1)
self.cooldown = self.ability:GetSpecialValueFor("cd")
self.max = self.ability:GetSpecialValueFor("max")

if not IsSoloMode() then
    self.cooldown = self.ability:GetSpecialValueFor("cd_duo")
    self.max = self.ability:GetSpecialValueFor("max_duo")
end

self.duration = self.cooldown
self:SetDuration(self.duration, true)

self.max_stack = false

self.interval = 0.5
self:StartIntervalThink(self.interval)
end

function modifier_item_custom_sentry_ward_charges:OnIntervalThink()
if not IsServer() then return end
if self:GetStackCount() >= self.max then
    self.max_stack = true
    return
elseif self.max_stack == true then
    self:SetDuration(self.cooldown, true)
    self.max_stack = false
end

if self.duration <= 0 then
    self:IncrementStackCount()
    self:SetDuration(self.cooldown, true)
    self.duration = self:GetRemainingTime()
    return
end
self.duration = self:GetRemainingTime()
end