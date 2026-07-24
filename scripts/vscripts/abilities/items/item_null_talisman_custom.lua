--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_null_talisman_custom", "abilities/items/item_null_talisman_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_null_talisman_custom_mana", "abilities/items/item_null_talisman_custom", LUA_MODIFIER_MOTION_NONE)

item_null_talisman_custom = class({})

function item_null_talisman_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end 
PrecacheResource( "particle","particles/items/null_talisman_active.vpcf", context )
end

function item_null_talisman_custom:GetIntrinsicModifierName()
return "modifier_item_null_talisman_custom"
end

function item_null_talisman_custom:OnSpellStart()

self.parent = self:GetParent()

    -- HTTP.GetItemBuild("npc_dota_hero_muerta", PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()))
if test and towers[self:GetCaster():GetTeamNumber()] then 
    towers[self:GetCaster():GetTeamNumber()]:Kill(nil, nil)
end 

self.parent:EmitSound("Item.Null_talisman")
self.parent:AddNewModifier(self.parent, self, "modifier_item_null_talisman_custom_mana", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_null_talisman_custom = class({})

function modifier_item_null_talisman_custom:IsHidden() return true end
function modifier_item_null_talisman_custom:IsPurgable() return false end
function modifier_item_null_talisman_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_null_talisman_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE
}
end

function modifier_item_null_talisman_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.agi = self.ability:GetSpecialValueFor("agi")
self.str = self.ability:GetSpecialValueFor("str")
self.int = self.ability:GetSpecialValueFor("int")
self.regen = self.ability:GetSpecialValueFor("regen")
self.max_mana = self.ability:GetSpecialValueFor("max_mana")

if not IsServer() then return end
if not self.parent:IsRealHero() or self.parent:IsTempestDouble() then return end
start_quest:CheckQuest({quest_name = "Quest_1", id = self.parent:GetId(), item = self.ability:GetName()})
end

function modifier_item_null_talisman_custom:GetModifierBonusStats_Strength()
return self.str
end

function modifier_item_null_talisman_custom:GetModifierBonusStats_Agility()
return self.agi
end

function modifier_item_null_talisman_custom:GetModifierBonusStats_Intellect()
return self.int
end

function modifier_item_null_talisman_custom:GetModifierExtraManaPercentage()
return self.max_mana
end

function modifier_item_null_talisman_custom:GetModifierConstantManaRegen()
return self.regen
end





modifier_item_null_talisman_custom_mana = class({})
function modifier_item_null_talisman_custom_mana:IsHidden() return false end
function modifier_item_null_talisman_custom_mana:IsPurgable() return true end
function modifier_item_null_talisman_custom_mana:GetEffectName() return "particles/items/null_talisman_active.vpcf" end

function modifier_item_null_talisman_custom_mana:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()
self.damage = self.ability:GetSpecialValueFor("damage")
self.max_stack = self.ability:GetSpecialValueFor("max_stack")
if not IsServer() then return end

for _,mod in pairs(self.parent :FindAllModifiers()) do 
    if mod:GetName() == "modifier_item_null_talisman_custom" and self:GetStackCount() < self.max_stack then 
        self:IncrementStackCount()
    end
end

end

function modifier_item_null_talisman_custom_mana:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_item_null_talisman_custom_mana:GetModifierSpellAmplify_Percentage()
return self.damage*self:GetStackCount()
end