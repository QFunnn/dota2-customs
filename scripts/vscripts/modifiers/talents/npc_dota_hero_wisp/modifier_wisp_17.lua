--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wisp_17 = class({})
function modifier_wisp_17:IsHidden() return true end
function modifier_wisp_17:IsPurgable() return false end
function modifier_wisp_17:IsPurgeException() return false end
function modifier_wisp_17:RemoveOnDeath() return false end

function modifier_wisp_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self.max_shield_percent = {7,14}
    self.max_shield = self:GetParent():GetMaxMana() / 100 * self.max_shield_percent[self:GetStackCount()]
	self.current_shield = 0
    self.shield_regen_cooldown = 0
	self:SetHasCustomTransmitterData( true )
    self:StartIntervalThink(FrameTime())
end

function modifier_wisp_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_wisp_17:OnIntervalThink()
    if not IsServer() then return end
    self.max_shield = self:GetParent():GetMaxMana() / 100 * self.max_shield_percent[self:GetStackCount()]
    if self:GetParent():GetMana() >= self:GetParent():GetMaxMana() then
        if self.current_shield > self.max_shield then
            self.current_shield = self.max_shield
        end
        self.current_shield = math.min(self.current_shield + (self:GetParent():GetManaRegen() * 0.5 * FrameTime()), self.max_shield)
    end
    self:SendBuffRefreshToClients()
end

function modifier_wisp_17:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_wisp_17:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_wisp_17:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
end

function modifier_wisp_17:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local ignore_damage = self.current_shield
        self.current_shield = 0
        self:SendBuffRefreshToClients()
		return -ignore_damage
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end