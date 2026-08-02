--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_status_fx = class({})

function modifier_hero_status_fx:IsHidden()
	return true
end
function modifier_hero_status_fx:IsPurgable()
	return false
end
function modifier_hero_status_fx:RemoveOnDeath()
	return false
end

function modifier_hero_status_fx:OnCreated(kv)
	self:SetHasCustomTransmitterData(true)

	if IsServer() then
		self.status_fx_name = kv.status_fx_name
		self:SendBuffRefreshToClients()
	end
end

function modifier_hero_status_fx:GetStatusEffectName()
	if self.status_fx_name then
		return self.status_fx_name
	end
end

function modifier_hero_status_fx:AddCustomTransmitterData()
	return {
		status_fx_name = self.status_fx_name,
	}
end

function modifier_hero_status_fx:HandleCustomTransmitterData(data)
	self.status_fx_name = data.status_fx_name
end