--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_moon_yasha", "items/item_moon_yasha", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_moon_yasha_buff", "items/item_moon_yasha", LUA_MODIFIER_MOTION_NONE )

item_moon_yasha = class({})

function item_moon_yasha:GetIntrinsicModifierName()
    return "modifier_item_moon_yasha"
end

function item_moon_yasha:OnAbilityPhaseStart()
    local target = self:GetCursorTarget()
    if target:HasModifier("modifier_item_moon_yasha_buff") then
        local player = PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID())
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message="#dota_hud_error_cant_cast_twice", })
        end
        return false
    end
    return true
end

function item_moon_yasha:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    target:EmitSound("Item.MoonShard.Consume")
    target:AddNewModifier(self:GetCaster(), self, "modifier_item_moon_yasha_buff", {})
    local item_duplicate = CreateItem( "item_moon_yasha", self:GetCaster(), self:GetCaster() )
    local DropItem = CreateItemOnPositionForLaunch( Vector(-999999,-99999,-99999), item_duplicate )
    item_duplicate:LaunchLootInitialHeight( false, 0, 0, 0.1, Vector(-999999,-99999,-99999) )
    self:Destroy()
end

modifier_item_moon_yasha = class({})

function modifier_item_moon_yasha:IsHidden() return true end
function modifier_item_moon_yasha:IsPurgable() return false end
function modifier_item_moon_yasha:IsPurgeException() return false end
function modifier_item_moon_yasha:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_moon_yasha:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    } 
end

function modifier_item_moon_yasha:GetModifierMoveSpeedBonus_Percentage_Unique()
    return self:GetAbility():GetSpecialValueFor("movespeed_bonus")
end

function modifier_item_moon_yasha:GetModifierBonusStats_Agility()
    return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_moon_yasha:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end

modifier_item_moon_yasha_buff = class({})

function modifier_item_moon_yasha_buff:IsPurgable() return false end
function modifier_item_moon_yasha_buff:RemoveOnDeath() return false end
function modifier_item_moon_yasha_buff:GetTexture() return "item_moon_yasha" end

function modifier_item_moon_yasha_buff:OnCreated()
    self.movespeed_bonus = 15
end

function modifier_item_moon_yasha_buff:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_item_moon_yasha_buff:GetModifierMoveSpeedBonus_Percentage()
    return self.movespeed_bonus
end