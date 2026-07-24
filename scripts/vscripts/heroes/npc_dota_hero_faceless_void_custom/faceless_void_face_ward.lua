--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_faceless_void_face_ward", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_face_ward", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_faceless_void_face_ward_handler", "heroes/npc_dota_hero_faceless_void_custom/faceless_void_face_ward", LUA_MODIFIER_MOTION_NONE)

faceless_void_face_ward = class({})
faceless_void_face_ward.modifier_faceless_void_19 = {10,20,30}

function faceless_void_face_ward:Precache(context)
    PrecacheResource("model", "models/items/wards/bane_ward/bane_ward.vmdl", context)
end

function faceless_void_face_ward:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function faceless_void_face_ward:GetIntrinsicModifierName()
    return "modifier_faceless_void_face_ward_handler"
end

function faceless_void_face_ward:OnAbilityPhaseStart()
    self.vTargetPosition = self:GetCursorPosition()

    if not GridNav:IsTraversable( self.vTargetPosition ) then
        self:DisplayError(self:GetCaster():GetPlayerOwnerID(), "#dota_hud_error_no_wards_here")
        return false
    end

    return true;
end

function faceless_void_face_ward:DisplayError(playerID, message)
    local player = PlayerResource:GetPlayer(playerID)
    if player then
        CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", {message=message, })
    end
end


function faceless_void_face_ward:OnSpellStart()
    if not IsServer() then return end


    local point = self:GetCursorPosition()
    self:GetCaster():EmitSound("DOTA_Item.ObserverWard.Activate")
    local hWard = CreateUnitByName("npc_dota_observer_wards", point, false, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
    hWard:AddNewModifier(self:GetCaster(), self, "modifier_faceless_void_face_ward", {})
    hWard:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = self:GetSpecialValueFor("duration")})
    hWard:SetDayTimeVisionRange(self:GetSpecialValueFor("radius"))
    hWard:SetNightTimeVisionRange(self:GetSpecialValueFor("radius"))
    hWard:SetOriginalModel("models/items/wards/bane_ward/bane_ward.vmdl")
    hWard:SetModel("models/items/wards/bane_ward/bane_ward.vmdl")
end

modifier_faceless_void_face_ward = class({})
function modifier_faceless_void_face_ward:IsHidden() return true end
function modifier_faceless_void_face_ward:IsPurgable() return false end
function modifier_faceless_void_face_ward:IsPurgeException() return false end

function modifier_faceless_void_face_ward:CheckState()
    local state = 
    {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true
    }
    return state
end

function modifier_faceless_void_face_ward:OnCreated(params)
    if not IsServer() then return end
    self.destroy_attacks = self:GetAbility():GetSpecialValueFor("attack_destroy")
    self.health_increments = self:GetParent():GetMaxHealth() / self.destroy_attacks
    local modifier_faceless_void_face_ward_handler = self:GetCaster():FindModifierByName("modifier_faceless_void_face_ward_handler")
    if modifier_faceless_void_face_ward_handler then
        modifier_faceless_void_face_ward_handler:IncrementStackCount()
        self:GetCaster():CalculateStatBonus(true)
    end
end

function modifier_faceless_void_face_ward:OnDestroy()
    if not IsServer() then return end
    local modifier_faceless_void_face_ward_handler = self:GetCaster():FindModifierByName("modifier_faceless_void_face_ward_handler")
    if modifier_faceless_void_face_ward_handler then
        modifier_faceless_void_face_ward_handler:DecrementStackCount()
        self:GetCaster():CalculateStatBonus(true)
    end
end

function modifier_faceless_void_face_ward:DeclareFunctions()
    local decFuncs = 
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_EVENT_ON_ATTACKED,
        MODIFIER_PROPERTY_HEALTHBAR_PIPS,
    }
    return decFuncs
end

function modifier_faceless_void_face_ward:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_faceless_void_face_ward:GetModifierHealthBarPips()
    return 2
end

function modifier_faceless_void_face_ward:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_faceless_void_face_ward:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_faceless_void_face_ward:OnAttacked(params)
    if not IsServer() then return end
    if params.target == self:GetParent() then
        if params.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then
            if self:GetParent():GetHealthPercent() > 50 then
                self:GetParent():SetHealth(self:GetParent():GetHealth() - 10)
            else 
                self:GetParent():Kill(nil, params.attacker)
            end
            return
        end
        local new_health = self:GetParent():GetHealth() - self.health_increments
        if new_health <= 0 then
            self:GetParent():Kill(nil, params.attacker)
        else
            self:GetParent():SetHealth(new_health)
        end
        if self:GetCaster():HasModifier("modifier_faceless_void_19") then
            local faceless_void_time_lock_custom = self:GetCaster():FindAbilityByName("faceless_void_time_lock_custom")
            if faceless_void_time_lock_custom and faceless_void_time_lock_custom:GetLevel() > 0 then
                faceless_void_time_lock_custom:TimeLock(params.attacker, true)
            end
        end
    end
end

modifier_faceless_void_face_ward_handler = class({})
function modifier_faceless_void_face_ward_handler:IsHidden() return self:GetStackCount() == 0 or not self:GetCaster():HasModifier("modifier_faceless_void_19") end
function modifier_faceless_void_face_ward_handler:IsPurgable() return false end
function modifier_faceless_void_face_ward_handler:IsPurgeException() return false end
function modifier_faceless_void_face_ward_handler:RemoveOnDeath() return false end
function modifier_faceless_void_face_ward_handler:GetTexture() return "faceless_void_face_ward" end
function modifier_faceless_void_face_ward_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end
function modifier_faceless_void_face_ward_handler:GetModifierBonusStats_Intellect()
    if not self:GetCaster():HasModifier("modifier_faceless_void_19") then return end
    return self:GetStackCount() * self:GetAbility().modifier_faceless_void_19[self:GetCaster():GetTalentLevel("modifier_faceless_void_19")]
end