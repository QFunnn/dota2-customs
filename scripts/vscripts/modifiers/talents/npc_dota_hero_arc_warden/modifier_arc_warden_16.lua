--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_16=class({})

function modifier_arc_warden_16:IsHidden() return true end
function modifier_arc_warden_16:IsPurgable() return false end
function modifier_arc_warden_16:IsPurgeException() return false end
function modifier_arc_warden_16:RemoveOnDeath() return false end

function modifier_arc_warden_16:OnCreated()
	if not IsServer() then return end
    local shield = 500
    self.has_shield = true
    self.barrier = shield
    self.max_shield = self.barrier
    self.current_shield = self.barrier
    self:SetHasCustomTransmitterData( true )
	self:SetStackCount(1)
    self:StartIntervalThink(0.1)
end

function modifier_arc_warden_16:OnIntervalThink()
    if not IsServer() then return end
    local heal_shield = (self:GetParent():GetLevel() * 2) * 0.1
    self.current_shield = math.min(self.current_shield+heal_shield, self.max_shield)
    self:SendBuffRefreshToClients()
end

function modifier_arc_warden_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_arc_warden_16:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT
    }
    return funcs
end

function modifier_arc_warden_16:AddCustomTransmitterData()
    local data = 
    {
        max_shield = self.max_shield,
        current_shield = self.current_shield,
        has_shield = self.has_shield
    }
    return data
end

function modifier_arc_warden_16:HandleCustomTransmitterData( data )
    self.max_shield = data.max_shield
    self.current_shield = data.current_shield
    self.has_shield = data.has_shield
end

function modifier_arc_warden_16:GetModifierIncomingDamageConstant( params )
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
        return -dodge
    else
        self.current_shield = self.current_shield-params.damage
        self:SendBuffRefreshToClients()
        return -params.damage
    end
end