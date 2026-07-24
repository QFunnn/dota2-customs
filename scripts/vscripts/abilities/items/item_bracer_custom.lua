--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_bracer_custom", "abilities/items/item_bracer_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_bracer_custom_heal", "abilities/items/item_bracer_custom", LUA_MODIFIER_MOTION_NONE)

item_bracer_custom = class({})


function item_bracer_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items/bracer_active.vpcf", context )
end

function item_bracer_custom:GetIntrinsicModifierName()
return "modifier_item_bracer_custom"
end

function item_bracer_custom:OnSpellStart()
local caster = self:GetCaster()

if test then 
    Timers:CreateTimer(0.5, function()

        for _,mod in pairs(caster:FindAllModifiers()) do 
            print(mod:GetName())
        end

    end)
end

if false and test then 
    for team,tower in pairs(towers) do 
        if team ~= caster:GetTeamNumber() then 

            dota1x6:InitDuel(caster:GetTeamNumber(), team, 1, false)
            return
        end 
    end 
end 

caster:EmitSound("Item.Bracer")
caster:AddNewModifier(caster, self, "modifier_item_bracer_custom_heal", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_bracer_custom = class({})

function modifier_item_bracer_custom:IsHidden() return true end
function modifier_item_bracer_custom:IsPurgable() return false end
function modifier_item_bracer_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_bracer_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_item_bracer_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.str = self.ability:GetSpecialValueFor("str")
self.agi = self.ability:GetSpecialValueFor("agi")
self.int = self.ability:GetSpecialValueFor("int")
self.health = self.ability:GetSpecialValueFor("health")
self.regen = self.ability:GetSpecialValueFor("regen")
if not IsServer() then return end
if not self.parent:IsRealHero() or self.parent:IsTempestDouble() then return end
start_quest:CheckQuest({quest_name = "Quest_1", id = self.parent:GetId(), item = self.ability:GetName()})
end

function modifier_item_bracer_custom:GetModifierBonusStats_Strength()
return self.str
end

function modifier_item_bracer_custom:GetModifierBonusStats_Agility()
return self.agi
end

function modifier_item_bracer_custom:GetModifierBonusStats_Intellect()
return self.int
end

function modifier_item_bracer_custom:GetModifierHealthBonus()
return self.health
end

function modifier_item_bracer_custom:GetModifierConstantHealthRegen()
return self.regen
end



modifier_item_bracer_custom_heal = class({})
function modifier_item_bracer_custom_heal:IsHidden() return false end
function modifier_item_bracer_custom_heal:IsPurgable() return true end

function modifier_item_bracer_custom_heal:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.str = self.ability:GetSpecialValueFor("str_active")
self.max_stack = self.ability:GetSpecialValueFor("max_stack")
if not IsServer() then return end

self.parent:GenericParticle("particles/items/bracer_active.vpcf", self)

for _,mod in pairs(self.parent:FindAllModifiers()) do 
    if mod:GetName() == "modifier_item_bracer_custom" and self:GetStackCount() < self.max_stack then 
        self:IncrementStackCount()
    end
end

self.parent:CalculateStatBonus(true)
end


function modifier_item_bracer_custom_heal:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_item_bracer_custom_heal:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
}

end

function modifier_item_bracer_custom_heal:GetModifierBonusStats_Strength()
return self.str*self:GetStackCount()
end
