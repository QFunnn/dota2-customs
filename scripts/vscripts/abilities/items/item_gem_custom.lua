--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gem_custom", "abilities/items/item_gem_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gem_custom_cd", "abilities/items/item_gem_custom", LUA_MODIFIER_MOTION_NONE)

item_gem_custom = class({})

function item_gem_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items/gem_activate.vpcf", context )
end

function item_gem_custom:OnAbilityPhaseStart()
if not IsServer() then return end
local caster = self:GetCaster()
local error = nil

if caster:HasModifier("modifier_item_gem_custom_cd") then
   error = "#gem_cd"
end

if caster:HasModifier("modifier_item_gem_custom") then 
   error = "#gem_active"
end

if error then
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(caster:GetPlayerOwnerID()), "CreateIngameErrorMessage", {message = error})
	return false
end
return true
end

function item_gem_custom:OnSpellStart()
local caster = self:GetCaster()

if caster:HasModifier("modifier_item_gem_custom") then return end
if caster:HasModifier("modifier_item_gem_custom_cd") then return end

caster:EmitSound("Items.Gem_consume")
caster:EmitSound("Item.PickUpGemShop")
caster:AddNewModifier(caster, self, "modifier_item_gem_custom", {})
caster:AddNewModifier(caster, self, "modifier_item_gem_custom_cd", {})
self:Destroy()
end



modifier_item_gem_custom = class(mod_visible)
function modifier_item_gem_custom:GetTexture() return "item_gem" end
function modifier_item_gem_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("radius")

self.parent:AddDeathEvent(self, true)
if not IsServer() then return end

self.particle = ParticleManager:CreateParticle( "particles/items/gem_activate.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
ParticleManager:SetParticleControl( self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl( self.particle, 1, Vector(3, self.radius, 0))
self:AddParticle(self.particle,false, false, -1, false, false)
end

function modifier_item_gem_custom:DeathEvent(params)
if not IsServer() then return end
if self.parent ~= params.unit or self.parent:IsReincarnating() then return end
self:Destroy()
end

function modifier_item_gem_custom:OnDestroy()
if not IsServer() then return end

self.parent:EmitSound("Item.DropGemShop")
local mod = self.parent:FindModifierByName("modifier_item_gem_custom_cd")
if mod then
	mod:StartCd()
end

end

function modifier_item_gem_custom:GetAuraRadius() return self.radius end
function modifier_item_gem_custom:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_item_gem_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_gem_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_item_gem_custom:GetModifierAura() return "modifier_truesight" end
function modifier_item_gem_custom:IsAura() return true end


modifier_item_gem_custom_cd = class(mod_visible)
function modifier_item_gem_custom_cd:IsHidden() return self:GetStackCount() == 1 end
function modifier_item_gem_custom_cd:GetTexture() return "item_gem" end
function modifier_item_gem_custom_cd:RemoveOnDeath() return false end
function modifier_item_gem_custom_cd:IsDebuff() return true end
function modifier_item_gem_custom_cd:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.cd = self.ability:GetSpecialValueFor("cd")*60
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_item_gem_custom_cd:StartCd()
if not IsServer() then return end
self:SetStackCount(0)
self:SetDuration(self.cd, true)
end