--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ward_dispenser_custom_ward", "items/item_ward_dispenser_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_ward_dispenser_custom_sentry_ward", "items/item_ward_dispenser_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_ward_dispenser_custom_observer_ward", "items/item_ward_dispenser_custom", LUA_MODIFIER_MOTION_NONE)

item_ward_dispenser_custom = class({})

function item_ward_dispenser_custom:GetIntrinsicModifierName()
    return "modifier_item_ward_dispenser_custom_ward"
end

function item_ward_dispenser_custom:GetAbilityTextureName()
    local stack = self:GetCaster():GetModifierStackCount("modifier_item_ward_dispenser_custom_ward", self:GetCaster())
    if stack == 0 then
        return "item_ward_dispenser"
    end
    return "item_ward_dispenser_sentry"
end

function item_ward_dispenser_custom:OnAbilityPhaseStart()
    self.vTargetPosition = self:GetCursorPosition()

    if not GridNav:IsTraversable( self.vTargetPosition ) then
        self:DisplayError(self:GetCaster():GetPlayerOwnerID(), "#dota_hud_error_no_wards_here")
        return false
    end

    if self:GetCursorTarget() then
        if self:GetCursorTarget() and self:GetCursorTarget() ~= self:GetCaster() then
            self:DisplayError(self:GetCaster():GetPlayerOwnerID(), "#dota_hud_error_cant_cast_on_other")
            return false
        end
    end

    if self:GetCursorTarget() == nil and Entities:FindByModelWithin(nil, "models/props_structures/radiant_statue001.vmdl", self.vTargetPosition, 600) ~= nil and GetMapName() == "overthrow" then
        self:DisplayError(self:GetCaster():GetPlayerOwnerID(), "#dota_hud_error_no_wards_here")
        return false
    end

    if self:GetCursorTarget() == nil and self:GetCurrentCharges() <= 0 then
        self:DisplayError(self:GetCaster():GetPlayerOwnerID(), "#dota_hud_error_no_charges")
        return false
    end

    return true;
end

function item_ward_dispenser_custom:DisplayError(playerID, message)
    local player = PlayerResource:GetPlayer(playerID)
    if player then
        CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message=message, })
    end
end

function item_ward_dispenser_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()

    if target and target == self:GetCaster() then
        local one_charge = self:GetCurrentCharges()
        local two_charge = self:GetSecondaryCharges()
        self:SetCurrentCharges(two_charge)
        self:SetSecondaryCharges(one_charge)
        if self.type == "observer" then
            self.type = "sentry"
        elseif self.type == "sentry" then
            self.type = "observer"
        end
        local modifier_effect = self:GetCaster():FindModifierByName("modifier_item_ward_dispenser_custom_ward")
        if modifier_effect then
            if self.type == "observer" then
                modifier_effect:SetStackCount(0)
            elseif self.type == "sentry" then
                modifier_effect:SetStackCount(1)
            end
        end
        self:StartCooldown(0.5)
        return
    end

    if self:GetParent():HasModifier("modifier_wodarelax") then return end

    self:GetCaster():EmitSound("DOTA_Item.ObserverWard.Activate")

    local hWard = nil
    if self.type == "observer" then
        hWard = CreateUnitByName("npc_dota_observer_wards", self:GetCursorPosition(), false, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
        hWard:AddNewModifier(self:GetCaster(), self, "modifier_item_ward_dispenser_custom_observer_ward", {})
        hWard:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = self:GetSpecialValueFor("lifetime_observer")})
        hWard:SetDayTimeVisionRange(self:GetSpecialValueFor("observer_vision"))
        hWard:SetNightTimeVisionRange(self:GetSpecialValueFor("observer_vision"))
    elseif self.type == "sentry" then
        hWard = CreateUnitByName("npc_dota_sentry_wards", self:GetCursorPosition(), false, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
        hWard:AddNewModifier(self:GetCaster(), self, "modifier_item_ward_dispenser_custom_sentry_ward", {})
        hWard:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = self:GetSpecialValueFor("lifetime_sentry")})
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetCursorPosition(), 50, 10, false)
        hWard:SetDayTimeVisionRange(0)
        hWard:SetNightTimeVisionRange(0)
        hWard:SetMaterialGroup("1")
    end

    if (self:GetCaster():HasModifier("modifier_wodaduel1") or self:GetCaster():HasModifier("modifier_wodaduel2")) then
        hWard.is_duel_ward = true
    end

    CustomNetTables:SetTableValue('ward_type', tostring(self:entindex()), {type = self.type})
    self:SetCurrentCharges(self:GetCurrentCharges()-1)
end
    
modifier_item_ward_dispenser_custom_ward = class({})

function modifier_item_ward_dispenser_custom_ward:IsHidden()
	return true
end

function modifier_item_ward_dispenser_custom_ward:IsPurgable() return false end
function modifier_item_ward_dispenser_custom_ward:IsPurgeException() return false end

function modifier_item_ward_dispenser_custom_ward:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_item_ward_dispenser_custom_ward:OnCreated()
    if not IsServer() then return end

    if self:GetAbility().init == nil then
        self:GetAbility().init = true
        self:GetAbility().type = "observer"
        self:GetAbility():SetCurrentCharges(3)
        self:GetAbility():SetSecondaryCharges(3)
    end

    if self:GetAbility() and self:GetAbility():entindex() then
        CustomNetTables:SetTableValue('ward_type', tostring(self:GetAbility():entindex()), {type = self:GetAbility().type})
    end

    self:StartIntervalThink(1)
end

function modifier_item_ward_dispenser_custom_ward:OnIntervalThink()
    if not IsServer() then return end
    if self:GetAbility() and self:GetAbility():entindex() then
        CustomNetTables:SetTableValue('ward_type', tostring(self:GetAbility():entindex()), {type = self:GetAbility().type})
    end
end


modifier_item_ward_dispenser_custom_observer_ward = class({})

function modifier_item_ward_dispenser_custom_observer_ward:IsHidden() return true end

function modifier_item_ward_dispenser_custom_observer_ward:CheckState()
    local state = {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true
    }

    return state
end

function modifier_item_ward_dispenser_custom_observer_ward:OnCreated(params)
    if not IsServer() then return end
    self.destroy_attacks            = 8
    self.hero_attack_multiplier     = 4
    self.health_increments          = self:GetParent():GetMaxHealth() / self.destroy_attacks
end

function modifier_item_ward_dispenser_custom_observer_ward:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_EVENT_ON_ATTACKED,
        MODIFIER_PROPERTY_HEALTHBAR_PIPS
    }

    return decFuncs
end

function modifier_item_ward_dispenser_custom_observer_ward:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_item_ward_dispenser_custom_observer_ward:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_item_ward_dispenser_custom_observer_ward:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_item_ward_dispenser_custom_observer_ward:GetModifierHealthBarPips()
    return 2
end

function modifier_item_ward_dispenser_custom_observer_ward:OnAttacked(keys)
    if not IsServer() then return end
    if keys.target == self:GetParent() then
        if keys.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then
            if self:GetParent():GetHealthPercent() > 50 then
                self:GetParent():SetHealth(self:GetParent():GetHealth() - 10)
            else 
                if self:GetParent().is_duel_ward then
                    UTIL_Remove(self:GetParent())
                else
                    self:GetParent():Kill(nil, keys.attacker)
                end
            end
            return
        end
        local new_health = self:GetParent():GetHealth() - self.health_increments
        if keys.attacker:IsRealHero() then
            new_health = self:GetParent():GetHealth() - (self.health_increments * self.hero_attack_multiplier)
        end
        if new_health <= 0 then
            if self:GetParent().is_duel_ward then
                UTIL_Remove(self:GetParent())
            else
                self:GetParent():Kill(nil, keys.attacker)
            end
        else
            self:GetParent():SetHealth(new_health)
        end
    end
end

modifier_item_ward_dispenser_custom_sentry_ward = class({})

function modifier_item_ward_dispenser_custom_sentry_ward:IsHidden() return true end

function modifier_item_ward_dispenser_custom_sentry_ward:CheckState()
    local state = {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true
    }

    return state
end

function modifier_item_ward_dispenser_custom_sentry_ward:OnCreated(params)
    if not IsServer() then return end
    self.destroy_attacks            = 8
    self.hero_attack_multiplier     = 4
    self.health_increments          = self:GetParent():GetMaxHealth() / self.destroy_attacks
end

function modifier_item_ward_dispenser_custom_sentry_ward:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_EVENT_ON_ATTACKED,
        MODIFIER_PROPERTY_HEALTHBAR_PIPS,
    }

    return decFuncs
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetModifierHealthBarPips()
    return 2
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_item_ward_dispenser_custom_sentry_ward:OnAttacked(keys)
    if not IsServer() then return end
    if keys.target == self:GetParent() then
        if keys.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then
            if self:GetParent():GetHealthPercent() > 50 then
                self:GetParent():SetHealth(self:GetParent():GetHealth() - 10)
            else
                if self:GetParent().is_duel_ward then
                    UTIL_Remove(self:GetParent())
                else
                    self:GetParent():Kill(nil, keys.attacker)
                end
            end
            return
        end
        local new_health = self:GetParent():GetHealth() - self.health_increments
        if keys.attacker:IsRealHero() then
            new_health = self:GetParent():GetHealth() - (self.health_increments * self.hero_attack_multiplier)
        end
        if new_health <= 0 then
            if self:GetParent().is_duel_ward then
                UTIL_Remove(self:GetParent())
            else
                self:GetParent():Kill(nil, keys.attacker)
            end
        else
            self:GetParent():SetHealth(new_health)
        end
    end
end

function modifier_item_ward_dispenser_custom_sentry_ward:IsAura()
    return true
end

function modifier_item_ward_dispenser_custom_sentry_ward:IsHidden()
    return false
end

function modifier_item_ward_dispenser_custom_sentry_ward:IsPurgable()
    return false
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("sentry_vision")
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetModifierAura()
    return "modifier_truesight"
end
   
function modifier_item_ward_dispenser_custom_sentry_ward:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetAuraSearchType()
    return DOTA_UNIT_TARGET_ALL
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetAuraDuration()
    return 0.1
end

function modifier_item_ward_dispenser_custom_sentry_ward:GetAuraEntityReject(hEntity)
    if hEntity:IsTrueSightImmune({}) then
        return true
    end
    return false
end