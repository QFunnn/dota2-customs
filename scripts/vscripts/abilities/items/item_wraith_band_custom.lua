--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_wraith_band_custom", "abilities/items/item_wraith_band_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_wraith_band_custom_speed", "abilities/items/item_wraith_band_custom", LUA_MODIFIER_MOTION_NONE)

item_wraith_band_custom = class({})

function item_wraith_band_custom:GetIntrinsicModifierName()
return "modifier_item_wraith_band_custom"
end

function item_wraith_band_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/wb_bif.vpcf", context )
end

function item_wraith_band_custom:OnSpellStart()

local caster = self:GetCaster()

if test then 
    dota1x6:ActivateOrbShrines(6)

    dota1x6:FindDuelPairs()

    --dota1x6:WinTeam(self:GetCaster())

    for team,hero in pairs(players) do 
        if hero ~= caster then 
         --   dota1x6:InitDuel(caster, hero, 0)
            return
        end 
    end 
end 


caster:EmitSound("DOTA_Item.Butterfly")
caster:AddNewModifier(caster, self, "modifier_item_wraith_band_custom_speed", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_wraith_band_custom = class({})

function modifier_item_wraith_band_custom:IsHidden() return true end
function modifier_item_wraith_band_custom:IsPurgable() return false end
function modifier_item_wraith_band_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_wraith_band_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end


function modifier_item_wraith_band_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.agi = self.ability:GetSpecialValueFor("agi")
self.str = self.ability:GetSpecialValueFor("str")
self.int = self.ability:GetSpecialValueFor("int")
self.speed = self.ability:GetSpecialValueFor("speed")
self.armor = self.ability:GetSpecialValueFor("armor")

if not IsServer() then return end
if not self.parent:IsRealHero() or self.parent:IsTempestDouble() then return end
start_quest:CheckQuest({quest_name = "Quest_1", id = self.parent:GetId(), item = self.ability:GetName()})
end

function modifier_item_wraith_band_custom:GetModifierBonusStats_Strength()
return self.str
end

function modifier_item_wraith_band_custom:GetModifierBonusStats_Agility()
return self.agi
end

function modifier_item_wraith_band_custom:GetModifierBonusStats_Intellect()
return self.int
end

function modifier_item_wraith_band_custom:GetModifierAttackSpeedBonus_Constant()
return self.speed
end

function modifier_item_wraith_band_custom:GetModifierPhysicalArmorBonus()
return self.armor
end


modifier_item_wraith_band_custom_speed = class({})
function modifier_item_wraith_band_custom_speed:IsHidden() return false end
function modifier_item_wraith_band_custom_speed:IsPurgable() return true end

function modifier_item_wraith_band_custom_speed:OnCreated(table)

self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.ability:GetSpecialValueFor("speed_buf")
self.max_stack = self.ability:GetSpecialValueFor("max_stack")
if not IsServer() then return end
self.parent:GenericParticle("particles/wb_bif.vpcf", self)

for _,mod in pairs(self.parent:FindAllModifiers()) do 
    if mod:GetName() == "modifier_item_wraith_band_custom" and self:GetStackCount() < self.max_stack then 
        self:IncrementStackCount()
    end
end

end

function modifier_item_wraith_band_custom_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}

end

function modifier_item_wraith_band_custom_speed:GetModifierAttackSpeedBonus_Constant()
return self.speed*self:GetStackCount()
end
