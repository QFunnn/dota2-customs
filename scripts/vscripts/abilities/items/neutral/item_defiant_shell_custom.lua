--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_defiant_shell_custom", "abilities/items/neutral/item_defiant_shell_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_defiant_shell_custom_damage", "abilities/items/neutral/item_defiant_shell_custom", LUA_MODIFIER_MOTION_NONE)

item_defiant_shell_custom = class({})

function item_defiant_shell_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_defiant_shell_custom"
end

function item_defiant_shell_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items8_fx/foragers_kit_buff_mana.vpcf", context )

end

modifier_item_defiant_shell_custom = class(mod_hidden)
function modifier_item_defiant_shell_custom:RemoveOnDeath() return false end
function modifier_item_defiant_shell_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.armor = self.ability:GetSpecialValueFor("armor")
self.ability.counter_damage = self.ability:GetSpecialValueFor("counter_damage")
if not self.parent:IsRealHero() then return end
self.parent:AddAttackStartEvent_inc(self, true)
end

function modifier_item_defiant_shell_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_item_defiant_shell_custom:GetModifierPhysicalArmorBonus()
return self.armor
end

function modifier_item_defiant_shell_custom:AttackStartEvent_inc(params)
if not IsServer() then return end
if not self.ability:IsFullyCastable() then return end
if params.no_attack_cooldown then return end
if self.parent ~= params.target then return end
local target = params.attacker

if not target:IsUnit() then return end
if (target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > (self.parent:Script_GetAttackRange() + 100) then return end

self.parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 2)
self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_defiant_shell_custom_damage", {})
self.parent:PerformAttack(target, true, false, true, true, true, false, false)
self.parent:RemoveModifierByName("modifier_item_defiant_shell_custom_damage")

self.ability:UseResources(false, false, false, true)
end



modifier_item_defiant_shell_custom_damage = class(mod_hidden)
function modifier_item_defiant_shell_custom_damage:OnCreated()
self.damage = self:GetAbility().counter_damage - 100
end

function modifier_item_defiant_shell_custom_damage:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_item_defiant_shell_custom_damage:GetModifierTotalDamageOutgoing_Percentage(params)
if params.inflictor then return end
return self.damage
end