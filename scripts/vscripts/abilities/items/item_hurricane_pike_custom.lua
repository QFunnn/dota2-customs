--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_hurricane_pike_custom", "abilities/items/item_hurricane_pike_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_hurricane_pike_custom_active", "abilities/items/item_hurricane_pike_custom", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_item_hurricane_pike_custom_range", "abilities/items/item_hurricane_pike_custom", LUA_MODIFIER_MOTION_NONE )

item_hurricane_pike_custom = class({})

function item_hurricane_pike_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/force_staff.vpcf", context )
end

function item_hurricane_pike_custom:GetIntrinsicModifierName()
return "modifier_item_hurricane_pike_custom"
end

function item_hurricane_pike_custom:Spawn()
self.bonus_intellect = self:GetSpecialValueFor("bonus_intellect")
self.bonus_health = self:GetSpecialValueFor("bonus_health")
self.bonus_agility = self:GetSpecialValueFor("bonus_agility")
self.bonus_strength = self:GetSpecialValueFor("bonus_strength")
self.base_attack_range  = self:GetSpecialValueFor("base_attack_range")
self.push_length  = self:GetSpecialValueFor("push_length")
self.enemy_length = self:GetSpecialValueFor("enemy_length")
self.range_duration  = self:GetSpecialValueFor("range_duration")
self.cast_range_enemy = self:GetSpecialValueFor("cast_range_enemy")
self.max_attacks = self:GetSpecialValueFor("max_attacks")
self.bonus_attack_speed = self:GetSpecialValueFor("bonus_attack_speed")
self.push_time = self:GetSpecialValueFor("push_time")
end

function item_hurricane_pike_custom:GetCastRange(vec, target)
if target and target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
	return self.cast_range_enemy and self.cast_range_enemy or 0
end
return self.BaseClass.GetCastRange(self, vec , target)
end

function item_hurricane_pike_custom:CastFilterResultTarget(target)
if not IsServer() then return end
if target and target:GetTeamNumber() == self:GetCaster():GetTeamNumber() and (target:IsRooted() or target:IsLeashed()) then 
	return UF_FAIL_CUSTOM 
end
return UnitFilter( target, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
end

function item_hurricane_pike_custom:GetCustomCastErrorTarget(target)
return "#dota_hud_error_target_cannot_be_moved"
end

function item_hurricane_pike_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local is_pike = 0

if caster:GetTeamNumber() ~= target:GetTeamNumber() then
	is_pike = 1
	caster:RemoveModifierByName("modifier_item_hurricane_pike_custom_range")
	caster:AddNewModifier(caster, self, "modifier_item_hurricane_pike_custom_active", {duration = self.push_time, is_pike = 1, x = target:GetAbsOrigin().x, y = target:GetAbsOrigin().y})
	caster:AddNewModifier(caster, self, "modifier_item_hurricane_pike_custom_range", {duration = self.range_duration, target = target:entindex()})
end

target:AddNewModifier(caster, self, "modifier_item_hurricane_pike_custom_active", {duration = self.push_time, is_pike = is_pike, x = caster:GetAbsOrigin().x, y = caster:GetAbsOrigin().y})
end

modifier_item_hurricane_pike_custom = class(mod_hidden)
function modifier_item_hurricane_pike_custom:RemoveOnDeath() return false end
function modifier_item_hurricane_pike_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
}
end

function modifier_item_hurricane_pike_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

end

function modifier_item_hurricane_pike_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_hurricane_pike_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end

function modifier_item_hurricane_pike_custom:GetModifierBonusStats_Strength()
return self.ability.bonus_strength
end

function modifier_item_hurricane_pike_custom:GetModifierBonusStats_Agility()
return self.ability.bonus_agility
end

function modifier_item_hurricane_pike_custom:GetModifierAttackRangeBonus()
if self.parent:HasModifier("modifier_item_dragon_lance") then return end
if not self.parent:IsRangedAttacker() then return end
return self.ability.base_attack_range
end


modifier_item_hurricane_pike_custom_active = class(mod_hidden)
function modifier_item_hurricane_pike_custom_active:GetStatusEffectName() return "particles/status_fx/status_effect_forcestaff.vpcf" end
function modifier_item_hurricane_pike_custom_active:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_item_hurricane_pike_custom_active:OnCreated(params)
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
self.parent:StartGesture(ACT_DOTA_FLAIL)

self.is_pike = params.is_pike

self.dir = self.parent:GetForwardVector()

self.path = 0
self.dist = self.ability.push_length
self.speed = self.dist/self.ability.push_time
local sound = "DOTA_Item.ForceStaff.Activate"

if self.is_pike == 1 then
	self.dist = self.ability.enemy_length
	local point = self.parent:CastPosition(GetGroundPosition(Vector(params.x, params.y, 0), nil))
	self.dir = (self.parent:GetAbsOrigin() - point)
	self.speed = self.speed*1.5
	sound = "DOTA_Item.HurricanePike.Activate"
end

self.parent:EmitSound(sound)
self.dir.z = 0

if self:ApplyHorizontalMotionController() == false then
  self:Destroy()
end

end

function modifier_item_hurricane_pike_custom_active:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_item_hurricane_pike_custom_active:GetActivityTranslationModifiers()
if self.is_enemy then return end
if self.is_pike == 1 then return end
return "forcestaff_friendly"
end

function modifier_item_hurricane_pike_custom_active:OnDestroy()
if not IsServer() then return end

if not self.parent:IsDebuffImmune() or not self.is_enemy then
	self.parent:InterruptMotionControllers( true )
	ResolveNPCPositions(self.parent:GetAbsOrigin(), 128)
	self.parent:FacePoint()
end

self.parent:FadeGesture(ACT_DOTA_FLAIL)
end

function modifier_item_hurricane_pike_custom_active:UpdateHorizontalMotion( me, dt )
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

function modifier_item_hurricane_pike_custom_active:OnHorizontalMotionInterrupted()
self:Destroy()
end



modifier_item_hurricane_pike_custom_range = class(mod_visible)
function modifier_item_hurricane_pike_custom_range:IsPurgable() return true end
function modifier_item_hurricane_pike_custom_range:OnCreated(params)
if not IsServer() then return end
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.ability.bonus_attack_speed
self.target = EntIndexToHScript(params.target)
self:SetStackCount(self.ability.max_attacks)

self.parent:MoveToTargetToAttack(self.target)
self.parent:AddAttackStartEvent_out(self)
end

function modifier_item_hurricane_pike_custom_range:AttackStartEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end

local target = params.target
if not target:IsUnit() then return end
if target ~= self.target then return end

self:DecrementStackCount()
if self:GetStackCount() <= 0 then
	self:Destroy()
end

end

function modifier_item_hurricane_pike_custom_range:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_item_hurricane_pike_custom_range:GetModifierAttackSpeedBonus_Constant(params)
if not IsServer() then return end
if not params.target or params.target ~= self.target then return end

return self.speed
end

function modifier_item_hurricane_pike_custom_range:GetModifierAttackRangeBonus(params)
if not IsServer() then return end
if not params.target or params.target ~= self.target then return end
if not self.parent:IsRangedAttacker() then return end

return 99999
end