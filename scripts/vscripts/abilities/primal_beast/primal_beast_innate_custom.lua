--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_primal_beast_innate_custom", "abilities/primal_beast/primal_beast_innate_custom", LUA_MODIFIER_MOTION_NONE )


primal_beast_innate_custom = class({})


function primal_beast_innate_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end 
return "modifier_primal_beast_innate_custom"
end


function primal_beast_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_primal_beast.vsndevts", context )
dota1x6:PrecacheShopItems("npc_dota_hero_primal_beast", context)
end


modifier_primal_beast_innate_custom = class({})
function modifier_primal_beast_innate_custom:IsHidden() return false end
function modifier_primal_beast_innate_custom:IsPurgable() return false end
function modifier_primal_beast_innate_custom:RemoveOnDeath() return false end
function modifier_primal_beast_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.str = self.ability:GetSpecialValueFor("str")
self.move = self.ability:GetSpecialValueFor("move")
self.model = self.ability:GetSpecialValueFor("model")
self.range = self.ability:GetSpecialValueFor("range")
self.cleave = self.ability:GetSpecialValueFor("cleave")/100

self.parent:AddAttackEvent_out(self)
self:StartIntervalThink(0.5)
end

function modifier_primal_beast_innate_custom:OnIntervalThink()
if not IsServer() then return end 

local bonus = ((self.parent:GetStrength()/self.str)*self.model)/100
if self.parent:HasModifier("modifier_item_black_king_bar_custom_active") then 
	bonus = bonus + 0.15
end
if self.parent:HasModifier("modifier_item_giants_ring_custom") then 
	bonus = bonus + 0.3
end
self.parent:SetModelScale(1 + bonus)
end

function modifier_primal_beast_innate_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
}
end


function modifier_primal_beast_innate_custom:GetModifierMoveSpeedBonus_Percentage()
return (self.parent:GetStrength()/self.str)*self.move
end 

function modifier_primal_beast_innate_custom:GetModifierAttackRangeBonus()
return (self.parent:GetStrength()/self.str)*self.range
end 


function modifier_primal_beast_innate_custom:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

params.target:EmitSound("Hero_Sven.GreatCleave")
DoCleaveAttack( self.parent, params.target, self.ability, self.cleave*params.damage, 150, 360, 500, "particles/items_fx/battlefury_cleave.vpcf" )
end