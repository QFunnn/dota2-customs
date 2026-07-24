--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_moon_aghanim", "items/item_moon_aghanim", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_moon_aghanim_buff", "items/item_moon_aghanim", LUA_MODIFIER_MOTION_NONE )

item_moon_aghanim = class({})

function item_moon_aghanim:GetIntrinsicModifierName()
    return "modifier_item_moon_aghanim"
end

function item_moon_aghanim:OnAbilityPhaseStart()
    local target = self:GetCursorTarget()
    if target:HasModifier("modifier_item_moon_aghanim_buff") then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message="#dota_hud_error_cant_cast_twice", })
        end
        return false
    end
    return true
end

function item_moon_aghanim:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    target:EmitSound("Item.MoonShard.Consume")
    target:AddNewModifier(self:GetCaster(), self, "modifier_item_moon_aghanim_buff", {})
    local item_duplicate = CreateItem( "item_moon_aghanim", self:GetCaster(), self:GetCaster() )
    local DropItem = CreateItemOnPositionForLaunch( Vector(-999999,-99999,-99999), item_duplicate )
    item_duplicate:LaunchLootInitialHeight( false, 0, 0, 0.1, Vector(-999999,-99999,-99999) )
    self:Destroy()
end

modifier_item_moon_aghanim = class({})

function modifier_item_moon_aghanim:IsHidden() return true end
function modifier_item_moon_aghanim:IsPurgable() return false end
function modifier_item_moon_aghanim:IsPurgeException() return false end

function modifier_item_moon_aghanim:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    } 
end

function modifier_item_moon_aghanim:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_moon_aghanim:GetModifierBonusStats_Agility()
    return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_moon_aghanim:GetModifierBonusStats_Intellect()
    return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_moon_aghanim:GetModifierIncomingDamage_Percentage()
    if self:GetParent():HasModifier("modifier_item_moon_aghanim_buff") then return end
    local count = self:GetParent():GetStrength() / self:GetAbility():GetSpecialValueFor("str_to_bonus")
    count = math.min(count, 5)
    return self:GetAbility():GetSpecialValueFor("str_damage_reduce") * count * -1
end

function modifier_item_moon_aghanim:GetModifierTotalDamageOutgoing_Percentage()
    if self:GetParent():HasModifier("modifier_item_moon_aghanim_buff") then return end
    local count = self:GetParent():GetAgility() / self:GetAbility():GetSpecialValueFor("agi_to_bonus")
    count = math.min(count, 5)
    return self:GetAbility():GetSpecialValueFor("agi_damage_bonus") * count
end

function modifier_item_moon_aghanim:GetModifierSpellAmplify_Percentage()
    if self:GetParent():HasModifier("modifier_item_moon_aghanim_buff") then return end
    local count = self:GetParent():GetIntellect(false) / self:GetAbility():GetSpecialValueFor("int_to_bonus")
    count = math.min(count, 25)
    return self:GetAbility():GetSpecialValueFor("int_damage_amplify") * count
end

modifier_item_moon_aghanim_buff = class({})

function modifier_item_moon_aghanim_buff:IsPurgable() return false end
function modifier_item_moon_aghanim_buff:RemoveOnDeath() return false end
function modifier_item_moon_aghanim_buff:GetTexture() return "item_moon_aghanim" end

function modifier_item_moon_aghanim_buff:OnCreated()
    self.str_damage_reduce = 1
    self.agi_damage_bonus = 1
    self.int_damage_amplify = 1
    self.str_to_bonus = 60
    self.agi_to_bonus = 60
    self.int_to_bonus = 12
end

function modifier_item_moon_aghanim_buff:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    } 
end

function modifier_item_moon_aghanim_buff:GetModifierIncomingDamage_Percentage()
    local count = self:GetParent():GetStrength() / self.str_to_bonus
    count = math.min(count, 5)
    return self.str_damage_reduce * count * -1
end

function modifier_item_moon_aghanim_buff:GetModifierTotalDamageOutgoing_Percentage()
    local count = self:GetParent():GetAgility() / self.agi_to_bonus
    count = math.min(count, 5)
    return self.agi_damage_bonus * count
end

function modifier_item_moon_aghanim_buff:GetModifierSpellAmplify_Percentage()
    local count = self:GetParent():GetIntellect(false) / self.int_to_bonus
    count = math.min(count, 25)
    return self.int_damage_amplify * count
end