--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_change = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    RemoveOnDeath           = function(self) return false end,
    IsPermanent             = function(self) return true end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_IGNORE_DODGE + MODIFIER_ATTRIBUTE_PERMANENT end,
    GetPriority             = function(self) return 999999 end,

	CheckState              = function(self)
        return {
            [MODIFIER_STATE_INVULNERABLE] = true,
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,
            [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
            [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
            [MODIFIER_STATE_ATTACK_IMMUNE] = true,
            [MODIFIER_STATE_MAGIC_IMMUNE] = true,
            [MODIFIER_STATE_UNSELECTABLE] = true,
            [MODIFIER_STATE_UNTARGETABLE] = true,
            [MODIFIER_STATE_STUNNED] = true,
            [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
            [MODIFIER_STATE_DISARMED] = true,
            [MODIFIER_STATE_SILENCED] = true,
            [MODIFIER_STATE_MUTED] = true,
            [MODIFIER_STATE_HEXED] = true,
            [MODIFIER_STATE_NIGHTMARED] = true,
            [MODIFIER_STATE_ROOTED] = true,
            [MODIFIER_STATE_OUT_OF_GAME] = true,
            [MODIFIER_STATE_PASSIVES_DISABLED] = true,
        }
    end,

    OnCreated               = function(self)
        if not IsServer() then return end

        self.deactivated_abilities = {}
        -- self.deactivated_items = {}
        for i=0, self:GetParent():GetAbilityCount()-1 do
            local hAbility = self:GetParent():GetAbilityByIndex(i)
            if hAbility then
                if hAbility:IsActivated() then
                    table.insert(self.deactivated_abilities, hAbility)
                    hAbility:SetActivated(false)
                end
            end
        end

        -- for i=0,32 do
        --     local hItem=self:GetParent():GetItemInSlot(i)
        --     if hItem and not hItem:IsNull() and hItem:IsActivated() then
        --         table.insert(self.deactivated_items, hItem)
        --         hItem:SetActivated(false)
        --     end
        -- end
    end,

    OnDestroy               = function(self)
        if not IsServer() then return end

        for _, hAbility in ipairs(self.deactivated_abilities) do
            if hAbility and not hAbility:IsNull() then
                hAbility:SetActivated(true)
            end
        end

        -- for _, hItem in ipairs(self.deactivated_items) do
        --     if hItem and not hItem:IsNull() then
        --         hItem:SetActivated(true)
        --     end
        -- end

        self.deactivated_abilities = {}
    end,
})