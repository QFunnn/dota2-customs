--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


modifier_ward_attack_range = class(mod_hidden)
function modifier_ward_attack_range:OnCreated(table)
	self.parent = self:GetParent()
	self.range = 200

	if not IsServer() then
		return
	end
	self.RemoveForDuel = true
	self.parent.ward_attack_mod = self
	self.wards = {}
	self:OnRefresh(table)
	self:StartIntervalThink(0.2)
end

function modifier_ward_attack_range:OnRefresh(table)
	if not IsServer() then
		return
	end
	local ward = EntIndexToHScript(table.ward)
	if not IsValid(ward) then
		return
	end
	self.wards[ward] = true
end

function modifier_ward_attack_range:OnIntervalThink()
	if not IsServer() then
		return
	end

	for ward, _ in pairs(self.wards) do
		if not IsValid(ward) or not ward:IsAlive() then
			self.wards[ward] = nil
		end
	end

	if next(self.wards) == nil then
		self:Destroy()
		return
	end

	local aggro = self.parent:GetAggroTarget()
	if not aggro then
		return
	end
	if self.wards[aggro] then
		return
	end

	self:Destroy()
end

function modifier_ward_attack_range:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end

function modifier_ward_attack_range:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

function modifier_ward_attack_range:GetModifierAttackRangeBonus()
	if self.parent:IsRangedAttacker() then
		return
	end
	return self.range
end