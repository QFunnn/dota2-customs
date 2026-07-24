--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ancient_apparition_16_shield", "modifiers/talents/npc_dota_hero_ancient_apparition/modifier_ancient_apparition_16", LUA_MODIFIER_MOTION_NONE)

modifier_ancient_apparition_16=class({})

function modifier_ancient_apparition_16:IsHidden() return true end
function modifier_ancient_apparition_16:IsPurgable() return false end
function modifier_ancient_apparition_16:IsPurgeException() return false end
function modifier_ancient_apparition_16:RemoveOnDeath() return false end

function modifier_ancient_apparition_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_ancient_apparition_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_ancient_apparition_16:DeclareFunctions()
    return
    {
         
    }
end

function modifier_ancient_apparition_16:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    local ability = params.ability
    local manacost = ability:GetManaCost(ability:GetLevel())
    self:ApplyShield(manacost)
end

function modifier_ancient_apparition_16:ApplyShield(manacost)
    if not IsServer() then return end
    if manacost~= nil and manacost > 0 then
        self:GetCaster():AddNewModifier(self:GetCaster(), nil, "modifier_ancient_apparition_16_shield", {duration = 10, manacost = manacost})
    end
end

modifier_ancient_apparition_16_shield = class({})
function modifier_ancient_apparition_16_shield:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_ancient_apparition_16_shield:IsHidden() return true end
function modifier_ancient_apparition_16_shield:IsPurgable() return false end
function modifier_ancient_apparition_16_shield:OnCreated(params)
    if not IsServer() then return end
    local percent = {20,40,60}
    local shield = params.manacost / 100 * percent[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_16")]
    self.has_shield = true
    self.barrier = shield
    self.max_shield = self.barrier
    self.current_shield = self.barrier
    self:SetHasCustomTransmitterData( true )
end
function modifier_ancient_apparition_16_shield:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT
    }
    return funcs
end

function modifier_ancient_apparition_16_shield:AddCustomTransmitterData()
    local data = 
    {
        max_shield = self.max_shield,
        current_shield = self.current_shield,
        has_shield = self.has_shield
    }
    return data
end

function modifier_ancient_apparition_16_shield:HandleCustomTransmitterData( data )
    self.max_shield = data.max_shield
    self.current_shield = data.current_shield
    self.has_shield = data.has_shield
end

function modifier_ancient_apparition_16_shield:GetModifierIncomingDamageConstant( params )
    if not self.has_shield then return end
    if not IsServer() then
        if params.report_max then
            return self.max_shield
        else
            return self.current_shield
        end
    end
    if params.damage >= self.current_shield then
        local dodge = self.current_shield
        self.current_shield = 0
        self:SendBuffRefreshToClients()
        self:Destroy()
        return -dodge
    else
        self.current_shield = self.current_shield-params.damage
        self:SendBuffRefreshToClients()
        return -params.damage
    end
end