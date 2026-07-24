--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_moon_kaya", "items/item_moon_kaya", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_moon_kaya_buff", "items/item_moon_kaya", LUA_MODIFIER_MOTION_NONE )

item_moon_kaya = class({})

function item_moon_kaya:GetIntrinsicModifierName()
    return "modifier_item_moon_kaya"
end

function item_moon_kaya:OnAbilityPhaseStart()
    local target = self:GetCursorTarget()
    if target:HasModifier("modifier_item_moon_kaya_buff") then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message="#dota_hud_error_cant_cast_twice", })
        end
        return false
    end
    return true
end

function item_moon_kaya:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    target:EmitSound("Item.MoonShard.Consume")
    target:AddNewModifier(self:GetCaster(), self, "modifier_item_moon_kaya_buff", {})
    local item_duplicate = CreateItem( "item_moon_kaya", self:GetCaster(), self:GetCaster() )
    local DropItem = CreateItemOnPositionForLaunch( Vector(-999999,-99999,-99999), item_duplicate )
    item_duplicate:LaunchLootInitialHeight( false, 0, 0, 0.1, Vector(-999999,-99999,-99999) )
    self:Destroy()
end

modifier_item_moon_kaya = class({})

function modifier_item_moon_kaya:IsHidden() return true end
function modifier_item_moon_kaya:IsPurgable() return false end
function modifier_item_moon_kaya:IsPurgeException() return false end
function modifier_item_moon_kaya:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_moon_kaya:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE_UNIQUE,
        MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE
    } 
end

function modifier_item_moon_kaya:GetModifierSpellAmplify_PercentageUnique()
    return self:GetAbility():GetSpecialValueFor("spell_amplify")
end

function modifier_item_moon_kaya:GetModifierBonusStats_Intellect()
    return self:GetAbility():GetSpecialValueFor("bonus_int")
end

function modifier_item_moon_kaya:GetModifierMPRegenAmplify_Percentage_Unique()
    return self:GetAbility():GetSpecialValueFor("mana_regen_amplify")
end

function modifier_item_moon_kaya:GetModifierSpellLifestealRegenAmplify_Percentage()
    return self:GetAbility():GetSpecialValueFor("spell_lifesteal_amplify")
end

modifier_item_moon_kaya_buff = class({})

function modifier_item_moon_kaya_buff:IsPurgable() return false end
function modifier_item_moon_kaya_buff:RemoveOnDeath() return false end
function modifier_item_moon_kaya_buff:GetTexture() return "item_moon_kaya" end

function modifier_item_moon_kaya_buff:OnCreated()
    self.spell_amplify = 15
end

function modifier_item_moon_kaya_buff:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    } 
end

function modifier_item_moon_kaya_buff:GetModifierSpellAmplify_Percentage()
    return self.spell_amplify
end