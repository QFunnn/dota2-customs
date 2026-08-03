--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


modifier_ultimate_luna_attack_speed = class({})

function modifier_ultimate_luna_attack_speed:IsHidden()
	return true
end
function modifier_ultimate_luna_attack_speed:IsPurgable()
	return false
end
function modifier_ultimate_luna_attack_speed:RemoveOnDeath()
	return true
end

function modifier_ultimate_luna_attack_speed:OnCreated(kv)
	kv = kv or {}
	self.attack_speed_pct_per_stack = tonumber(kv.attack_speed_pct_per_stack) or 0
	self.max_attack_speed_stacks = math.floor(tonumber(kv.max_attack_speed_stacks) or 1)

	if IsServer() then
		self:SetStackCount(1)
		self:SendBuffRefreshToClients()
	end
end

function modifier_ultimate_luna_attack_speed:OnRefresh(kv)
	kv = kv or {}
	self.attack_speed_pct_per_stack = tonumber(kv.attack_speed_pct_per_stack) or self.attack_speed_pct_per_stack or 0
	self.max_attack_speed_stacks = math.floor(tonumber(kv.max_attack_speed_stacks) or self.max_attack_speed_stacks or 1)

	if IsServer() then
		self:SetStackCount(math.min(self:GetStackCount() + 1, self.max_attack_speed_stacks))
		self:SendBuffRefreshToClients()
	end
end

function modifier_ultimate_luna_attack_speed:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
	}
end

function modifier_ultimate_luna_attack_speed:GetModifierAttackSpeedPercentage()
	return self:GetStackCount() * (self.attack_speed_pct_per_stack or 0)
end