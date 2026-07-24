--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_monkey_king_17=class({})

function modifier_monkey_king_17:IsHidden() return true end
function modifier_monkey_king_17:IsPurgable() return false end
function modifier_monkey_king_17:IsPurgeException() return false end
function modifier_monkey_king_17:RemoveOnDeath() return false end

function modifier_monkey_king_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_monkey_king_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

modifier_monkey_king_17_barrier = class({})
function modifier_monkey_king_17_barrier:IsPurgable() return false end
function modifier_monkey_king_17_barrier:IsPurgeException() return false end
function modifier_monkey_king_17_barrier:GetTexture() return "monkey_king_17" end
function modifier_monkey_king_17_barrier:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = {200, 400}
	if not IsServer() then return end
	self.max_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_monkey_king_17")]
	self.current_shield = self.barrier[self:GetCaster():GetTalentLevel("modifier_monkey_king_17")]
	self:SetHasCustomTransmitterData( true )
end

function modifier_monkey_king_17_barrier:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_monkey_king_17_barrier:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_monkey_king_17_barrier:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_monkey_king_17_barrier:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local shield = self.current_shield
		self:Destroy()
		return -shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end