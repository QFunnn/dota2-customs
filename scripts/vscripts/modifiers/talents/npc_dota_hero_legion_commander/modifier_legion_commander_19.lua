--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_legion_commander_19=class({})

function modifier_legion_commander_19:IsHidden() return true end
function modifier_legion_commander_19:IsPurgable() return false end
function modifier_legion_commander_19:IsPurgeException() return false end
function modifier_legion_commander_19:RemoveOnDeath() return false end

function modifier_legion_commander_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:SetHasCustomTransmitterData(true)
	self:StartIntervalThink(FrameTime())
end

function modifier_legion_commander_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_legion_commander_19:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_legion_commander_19:AddCustomTransmitterData()
    return 
    {
        attackspeed = self.attackspeed,
    }
end

function modifier_legion_commander_19:HandleCustomTransmitterData( data )
    self.attackspeed = data.attackspeed
end

function modifier_legion_commander_19:OnIntervalThink()
	if not IsServer() then return end
	local intellect = self:GetCaster():GetIntellect(false) / 10
	local bonus = {4,8}
	local add_at_int = intellect * bonus[self:GetStackCount()]
	self.attackspeed = add_at_int
	self:SendBuffRefreshToClients()
end

function modifier_legion_commander_19:GetModifierAttackSpeedBonus_Constant()
	return self.attackspeed
end