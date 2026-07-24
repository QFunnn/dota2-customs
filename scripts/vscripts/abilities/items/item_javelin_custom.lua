--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_javelin_custom", "abilities/items/item_javelin_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_javelin_custom_proc", "abilities/items/item_javelin_custom", LUA_MODIFIER_MOTION_NONE)

item_javelin_custom = class({})

function item_javelin_custom:GetIntrinsicModifierName()
return "modifier_item_javelin_custom"
end

modifier_item_javelin_custom	= class(mod_hidden)
function modifier_item_javelin_custom:RemoveOnDeath() return false end
function modifier_item_javelin_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.records = {}

self.ability.bonus_chance = self.ability:GetSpecialValueFor("bonus_chance")
self.ability.health_bonus = self.ability:GetSpecialValueFor("health_bonus")
self.ability.bonus_chance_damage = self.ability:GetSpecialValueFor("bonus_chance_damage")

if not IsServer() then return end
if not self.parent:IsRealHero() then return end
self:RollProc()

self.parent:AddRecordDestroyEvent(self, true)
self.parent:AddAttackStartEvent_out(self)
self.parent:AddAttackEvent_out(self, true)
end

function modifier_item_javelin_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
	MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_javelin_custom:GetModifierHealthBonus()
return self.ability.health_bonus
end

function modifier_item_javelin_custom:CheckState()
if not IsValid(self.parent) then return end
if not self.parent:HasModifier("modifier_item_javelin_custom_proc") then return end 
return
{
    [MODIFIER_STATE_CANNOT_MISS] = true
}
end

function modifier_item_javelin_custom:RecordDestroyEvent( params )
if not self.records[params.record] then return end
self.records[params.record] = nil
end

function modifier_item_javelin_custom:RollProc()
if not IsServer() then return end
if not RollPseudoRandomPercentage(self.ability.bonus_chance, 4161, self.parent) then return end 
self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_javelin_custom_proc", {duration = 3})
end

function modifier_item_javelin_custom:AttackStartEvent_out(params)
if not IsServer() then return end 
if not params.target:IsUnit() then return end 
if self.parent ~= params.attacker then return end 

if self.parent:HasModifier("modifier_item_javelin_custom_proc") then 
    self.records[params.record] = true
end

self.parent:RemoveModifierByName("modifier_item_javelin_custom_proc")
self:RollProc()
end

function modifier_item_javelin_custom:GetModifierProcAttack_BonusDamage_Magical(params)
if not IsServer() then return end 
if not params.target:IsUnit() then return end 
if self.parent ~= params.attacker then return end 
if not self.records[params.record] then return end

params.target:SendNumber(4, self.ability.bonus_chance_damage)
return self.ability.bonus_chance_damage
end

modifier_item_javelin_custom_proc = class(mod_hidden)