--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_force_staff_custom", "abilities/items/item_force_staff_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_force_staff_custom_active", "abilities/items/item_force_staff_custom", LUA_MODIFIER_MOTION_HORIZONTAL )

item_force_staff_custom = class({})

function item_force_staff_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/force_staff.vpcf", context )
end

function item_force_staff_custom:GetIntrinsicModifierName()
return "modifier_item_force_staff_custom"
end

function item_force_staff_custom:Spawn()
self.bonus_intellect = self:GetSpecialValueFor("bonus_intellect")
self.bonus_health = self:GetSpecialValueFor("bonus_health")
self.push_length = self:GetSpecialValueFor("push_length")
self.enemy_cast_range = self:GetSpecialValueFor("enemy_cast_range")
self.push_time = self:GetSpecialValueFor("push_time")
end

function item_force_staff_custom:GetCastRange(vec, target)
if target and target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
	return self.enemy_cast_range and self.enemy_cast_range or 0
end
return self.BaseClass.GetCastRange(self, vec , target)
end

function item_force_staff_custom:CastFilterResultTarget(target)
if not IsServer() then return end
if target and (target:IsRooted() or target:IsLeashed()) then 
	return UF_FAIL_CUSTOM 
end
return UnitFilter( target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
end

function item_force_staff_custom:GetCustomCastErrorTarget(target)
return "#dota_hud_error_target_cannot_be_moved"
end

function item_force_staff_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

target:AddNewModifier(caster, self, "modifier_item_force_staff_custom_active", {duration = self.push_time})
end

modifier_item_force_staff_custom = class(mod_hidden)
function modifier_item_force_staff_custom:RemoveOnDeath() return false end
function modifier_item_force_staff_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_item_force_staff_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

end

function modifier_item_force_staff_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_force_staff_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end




modifier_item_force_staff_custom_active = class(mod_hidden)
function modifier_item_force_staff_custom_active:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_item_force_staff_custom_active:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_item_force_staff_custom_active:OnCreated(params)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.is_enemy = self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber()
if not IsServer() then return end
local player_id = self.caster:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_force_staff")
local pfx_name = "particles/items_fx/force_staff.vpcf"
if custom_effect_data then
    pfx_name = custom_effect_data[1]
end
self.parent:GenericParticle(pfx_name, self)
self.parent:EmitSound("DOTA_Item.ForceStaff.Activate")
self.parent:StartGesture(ACT_DOTA_FLAIL)

self.dir = self.parent:GetForwardVector()
self.dir.z = 0

self.path = 0
self.dist = self.ability.push_length
self.speed = self.dist/self.ability.push_time

if self:ApplyHorizontalMotionController() == false then
  self:Destroy()
end

end

function modifier_item_force_staff_custom_active:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_item_force_staff_custom_active:GetActivityTranslationModifiers()
if self.is_enemy then return end
return "forcestaff_friendly"
end

function modifier_item_force_staff_custom_active:OnDestroy()
if not IsServer() then return end

if not self.parent:IsDebuffImmune() or not self.is_enemy then
	self.parent:InterruptMotionControllers( true )
	ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
	self.parent:FacePoint()
end

self.parent:FadeGesture(ACT_DOTA_FLAIL)
end

function modifier_item_force_staff_custom_active:UpdateHorizontalMotion( me, dt )
if not IsServer() then return end
local point = me:GetAbsOrigin()
local new_point = GetGroundPosition(point + self.dir:Normalized() * self.speed * dt, nil)

me:SetAbsOrigin(new_point)
self.path = self.path + (self.speed*dt)
if self.path >= self.dist then
	self:Destroy()
	return
end

end

function modifier_item_force_staff_custom_active:OnHorizontalMotionInterrupted()
self:Destroy()
end
