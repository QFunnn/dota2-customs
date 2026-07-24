--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_techies_spoons_stash_custom", "heroes/hero_techies/stash", LUA_MODIFIER_MOTION_NONE )

if techies_spoons_stash_custom == nil then
	techies_spoons_stash_custom = class({})
end
function techies_spoons_stash_custom:GetIntrinsicModifierName()
	return "modifier_techies_spoons_stash_custom"
end

modifier_techies_spoons_stash_custom = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE end,

	CheckState		        = function(self)
		return {
			[MODIFIER_STATE_CAN_USE_BACKPACK_ITEMS] = true,
		}
	end,

    OnCreated               = function(self)
        if not IsServer() then return end
        self:StartIntervalThink(0.5)
    end,

    OnIntervalThink         = function(self)
        local hero = self:GetParent()
        
        -- Слоты 6 и 7 - активные дополнительные слоты от Spoons Stash
        -- Убираем кулдауны с предметов в этих слотах
        local Slots = {DOTA_ITEM_SLOT_7, DOTA_ITEM_SLOT_8}
        for _, Slot in ipairs(Slots) do
            local hItem = hero:GetItemInSlot(Slot)
            if hItem and hItem.GetCooldownTimeRemaining then
                local flRemaining = hItem:GetCooldownTimeRemaining()
                if 0.5 < flRemaining then
                    hItem:StartCooldown(flRemaining - 0.5)
                end
            end
        end
        
        -- Проверяем слот 8 (DOTA_ITEM_SLOT_9) - если там torture_pipe, удаляем ТОЛЬКО ЕГО модификатор
        local Slot8Item = hero:GetItemInSlot(DOTA_ITEM_SLOT_9)
        if Slot8Item and not Slot8Item:IsNull() then
            local itemName = Slot8Item:GetAbilityName()
            -- Удаляем только тот модификатор, который соответствует предмету в слоте 8
            if itemName == "item_torture_pipe_1_datadriven" then
                if hero:HasModifier("modifier_torture_pipe_1_datadriven") then
                    hero:RemoveModifierByName("modifier_torture_pipe_1_datadriven")
                end
            elseif itemName == "item_torture_pipe_2_datadriven" then
                if hero:HasModifier("modifier_torture_pipe_2_datadriven") then
                    hero:RemoveModifierByName("modifier_torture_pipe_2_datadriven")
                end
            end
        end
    end,
})