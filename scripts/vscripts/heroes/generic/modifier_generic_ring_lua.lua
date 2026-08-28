--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_generic_ring_lua = class({})

function modifier_generic_ring_lua:IsHidden()
	return true
end

function modifier_generic_ring_lua:IsDebuff()
	return false
end

function modifier_generic_ring_lua:IsStunDebuff()
	return false
end

function modifier_generic_ring_lua:IsPurgable()
	return false
end

function modifier_generic_ring_lua:RemoveOnDeath()
	return false
end

function modifier_generic_ring_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_generic_ring_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.start_radius = kv.start_radius or 0
	self.end_radius = kv.end_radius or 0
	self.width = kv.width or 100
	self.speed = kv.speed or 0
	self.outward = self.end_radius >= self.start_radius
	if not self.outward then
		self.speed = -self.speed
	end

	self.target_team = kv.target_team or 0
	self.target_type = kv.target_type or 0
	self.target_flags = kv.target_flags or 0

	self.IsCircle = kv.IsCircle or 1
	self.targets = {}
end

function modifier_generic_ring_lua:OnDestroy()
	if self.EndCallback then
		self.EndCallback()
	end
	if not IsServer() then
		return
	end

	if self:GetParent():GetClassname() == "npc_dota_thinker" then
		UTIL_Remove(self:GetParent())
	end
end

function modifier_generic_ring_lua:SetCallback(callback)
	self.Callback = callback

	self:StartIntervalThink(0.03)
	self:OnIntervalThink()
end

function modifier_generic_ring_lua:SetEndCallback(callback)
	self.EndCallback = callback
end

function modifier_generic_ring_lua:OnIntervalThink()
	local radius = self.start_radius + self.speed * self:GetElapsedTime()
	if not self.outward and radius < self.end_radius then
		self:Destroy()
		return
	elseif self.outward and radius > self.end_radius then
		self:Destroy()
		return
	end

	-- Find targets in ring
	local targets = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		self:GetParent(), -- handle, cacheUnit. (not known)
		radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		self.target_team, -- int, team filter
		self.target_type, -- int, type filter
		self.target_flags, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _, target in pairs(targets) do
		if not self.targets[target] then
			if
				not self.IsCircle
				or (target:GetOrigin() - self:GetParent():GetOrigin()):Length2D() > (radius - self.width)
			then
				self.targets[target] = true
				self.Callback(target)
			end
		end
	end
end