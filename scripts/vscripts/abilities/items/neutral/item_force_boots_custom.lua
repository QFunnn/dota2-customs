--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_force_boots_custom_active", "abilities/items/neutral/item_force_boots_custom", LUA_MODIFIER_MOTION_HORIZONTAL)

item_force_boots_custom = class({})

function item_force_boots_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle","particles/items_fx/harpoon_pull.vpcf", context )
end

function item_force_boots_custom:OnSpellStart()
local caster = self:GetCaster()

caster:Purge(false, true, false, false, false)
caster:EmitSound("DOTA_Item.Force_Boots.Cast")
caster:AddNewModifier(caster, self, "modifier_item_force_boots_custom_active", {duration = self:GetSpecialValueFor("push_duration")})
end





modifier_item_force_boots_custom_active = class({})

function modifier_item_force_boots_custom_active:IsDebuff() return false end
function modifier_item_force_boots_custom_active:IsHidden() return true end

function modifier_item_force_boots_custom_active:OnCreated()
if not IsServer() then return end

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.parent:GenericParticle("particles/items_fx/force_staff.vpcf", self)
self.parent:GenericParticle("particles/items_fx/harpoon_pull.vpcf", self)

self.parent:StartGesture(ACT_DOTA_FLAIL)
self.angle = self.parent:GetForwardVector():Normalized()

self.distance = self.ability:GetSpecialValueFor("push_length") / ( self:GetDuration() / FrameTime())

if self:ApplyHorizontalMotionController() == false then
    self:Destroy()
end

end

function modifier_item_force_boots_custom_active:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_item_force_boots_custom_active:StatusEffectPriority() return MODIFIER_PRIORITY_NORMAL end

function modifier_item_force_boots_custom_active:OnDestroy()
if not IsServer() then return end

self.parent:InterruptMotionControllers( true )
self.parent:FadeGesture(ACT_DOTA_FLAIL)

local vec = self.parent:GetForwardVector()
vec.z = 0
self.parent:SetForwardVector(vec)
self.parent:FaceTowards(self.parent:GetAbsOrigin() + vec*10)

ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
end


function modifier_item_force_boots_custom_active:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end

local pos = self.parent:GetAbsOrigin()
GridNav:DestroyTreesAroundPoint(pos, 80, false)
local pos_p = self.angle * self.distance
local next_pos = GetGroundPosition(pos + pos_p,self:GetParent())
self.parent:SetAbsOrigin(next_pos)
end

function modifier_item_force_boots_custom_active:OnHorizontalMotionInterrupted()
self:Destroy()
end