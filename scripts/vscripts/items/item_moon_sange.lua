--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_moon_sange", "items/item_moon_sange", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_moon_sange_buff", "items/item_moon_sange", LUA_MODIFIER_MOTION_NONE )

item_moon_sange = class({})

function item_moon_sange:GetIntrinsicModifierName()
    return "modifier_item_moon_sange"
end

function item_moon_sange:OnAbilityPhaseStart()
    local target = self:GetCursorTarget()
    if target:HasModifier("modifier_item_moon_sange_buff") then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message="#dota_hud_error_cant_cast_twice", })
        end
        return false
    end
    return true
end

function item_moon_sange:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    target:EmitSound("Item.MoonShard.Consume")
    target:AddNewModifier(self:GetCaster(), self, "modifier_item_moon_sange_buff", {})
    local item_duplicate = CreateItem( "item_moon_sange", self:GetCaster(), self:GetCaster() )
    local DropItem = CreateItemOnPositionForLaunch( Vector(-999999,-99999,-99999), item_duplicate )
    item_duplicate:LaunchLootInitialHeight( false, 0, 0, 0.1, Vector(-999999,-99999,-99999) )
    self:Destroy()
end

modifier_item_moon_sange = class({})

function modifier_item_moon_sange:IsHidden() return true end
function modifier_item_moon_sange:IsPurgable() return false end
function modifier_item_moon_sange:IsPurgeException() return false end

function modifier_item_moon_sange:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_STATUS_RESISTANCE,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
    } 
end

function modifier_item_moon_sange:GetModifierStatusResistance()
    return self:GetAbility():GetSpecialValueFor("status_resist")
end

function modifier_item_moon_sange:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_moon_sange:GetModifierPropertyRestorationAmplification()
    if self:GetCaster():HasModifier("modifier_item_sange")
    or self:GetCaster():HasModifier("modifier_item_sange_and_yasha")
    or self:GetCaster():HasModifier("modifier_item_heavens_halberd")
    or self:GetCaster():HasModifier("modifier_item_abyssal_blade")
    or self:GetCaster():HasModifier("modifier_item_kaya_and_sange") then return end
    return self:GetAbility():GetSpecialValueFor("hp_regen_amplify")
end

modifier_item_moon_sange_buff = class({})

function modifier_item_moon_sange_buff:IsPurgable() return false end
function modifier_item_moon_sange_buff:RemoveOnDeath() return false end
function modifier_item_moon_sange_buff:GetTexture() return "item_moon_sange" end

function modifier_item_moon_sange_buff:OnCreated()
    self.status_resist = 25
end

function modifier_item_moon_sange_buff:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
    }
end

function modifier_item_moon_sange_buff:GetModifierStatusResistanceStacking()
    return self.status_resist
end