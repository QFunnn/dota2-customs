--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


TEAMS_COLORS = 
{
	[DOTA_TEAM_GOODGUYS] = Vector(61, 210, 150),
	[DOTA_TEAM_BADGUYS]  = Vector(243, 201, 9),
	[DOTA_TEAM_CUSTOM_1] = Vector(197, 77, 168),
	[DOTA_TEAM_CUSTOM_2] = Vector(255, 108, 0),
	[DOTA_TEAM_CUSTOM_3] = Vector(52, 85, 255),
	[DOTA_TEAM_CUSTOM_4] = Vector(101, 212, 19),
	[DOTA_TEAM_CUSTOM_5] = Vector(129, 83, 54),
	[DOTA_TEAM_CUSTOM_6] = Vector(27, 192, 216),
	[DOTA_TEAM_CUSTOM_7] = Vector(199, 228, 13),
	[DOTA_TEAM_CUSTOM_8] = Vector(140, 42, 244),
	[DOTA_TEAM_NEUTRALS] = Vector(220,220,220),
}

capture_point_area = class({})
function capture_point_area:IsHidden() return false end
function capture_point_area:IsPurgable() return false end
function capture_point_area:DestroyOnExpire() return false end

function capture_point_area:OnCreated(kv)
	if IsServer() then
		local parent = self:GetParent()
		self.rate = 0
		self.progress = 0
		self.current_team = -1
		self.num_heroes = 1
		self.moving_time = 0
		self.life_time = 0
		self.orb_type = kv.orb_type
		self.start_pos = parent:GetAbsOrigin()
		self.end_pos = self.start_pos + RandomVector(RandomInt(200, 1100))
		if not self.end_pos then
			self:StopPoint()
			return
		end
		self.end_pos.z = 0
		local fly_distance = VectorDistance(self.start_pos, self.end_pos)
		self.fly_time = fly_distance / 400
		self.fly_height = fly_distance / 2
		if kv.should_launch == 1 then
			self:ApplyHorizontalMotionController()
			self:ApplyVerticalMotionController()
		else
			self:StartSearch()
		end
	else
		self:StartIntervalThink(0)
	end
end

function capture_point_area:StartSearch()
	if self.ring_fx then return end
	local parent = self:GetParent()
	self.ring_fx = ParticleManager:CreateParticle("particles/shrine/capture_point_ring_overthrow.vpcf", PATTACH_WORLDORIGIN, parent)
	local pos = GetGroundPosition(parent:GetAbsOrigin(), nil)
	ParticleManager:SetParticleControl(self.ring_fx, 0, pos)
	ParticleManager:SetParticleControl(self.ring_fx, 3, Vector(220,220,220))
	ParticleManager:SetParticleControl(self.ring_fx, 9, Vector(250, 0, 0))
	self.vPosition = parent:GetAbsOrigin()
	self:StartIntervalThink(0)
	self:SetHasCustomTransmitterData(true)
end

local function dt(rate)
	return GameRules:GetGameFrameTime() * rate / 3
end

function capture_point_area:ValidCapturingUnit(unit)
	if unit:IsInvulnerable() then return false end
	if unit:IsRealHero() then
		return true
	else
		return false
	end
end

function capture_point_area:OnIntervalThink()
	if IsServer() then
		local targets = FindUnitsInRadius (
			DOTA_TEAM_NEUTRALS,
			self.vPosition,
			nil,
			250,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
			FIND_ANY_ORDER,
			false
		)

		self.heroes_in_radius = {}
		local total_heroes_counts = 0

		for _, target in pairs(targets) do
			if self:ValidCapturingUnit(target) then
				if not self.heroes_in_radius[target:GetTeamNumber()] then
					self.heroes_in_radius[target:GetTeamNumber()] = {}
				end
				table.insert(self.heroes_in_radius[target:GetTeamNumber()], target)
				total_heroes_counts = total_heroes_counts + 1
			end
		end

		local teams_count = 0
		local temp_team = DOTA_TEAM_NEUTRALS
		for team_number, units in pairs(self.heroes_in_radius) do
			temp_team = team_number
			teams_count = teams_count + 1
		end

		local should_refresh = false

		local is_contesting = teams_count > 1
		if self.is_contesting ~= is_contesting then
			self.is_contesting = is_contesting
			should_refresh = true
		end

		local is_capturing = teams_count == 1
		if self.is_capturing ~= is_capturing then
			self.is_capturing = is_capturing
			should_refresh = true
		end

		local is_recapturing = self.current_team ~= temp_team and self.progress > 0
		if self.is_recapturing ~= is_recapturing then
			self.is_recapturing = is_recapturing
			should_refresh = true
		end

		local num_heroes = 0
		if self.heroes_in_radius[temp_team] then
			num_heroes = #self.heroes_in_radius[temp_team]
		end
		if self.num_heroes ~= num_heroes then
			self.num_heroes = num_heroes
			should_refresh = true
		end

		local rate = 0

		if is_contesting then
			if not self.heroes_in_radius[self.current_team] then
				rate = -0.5 - total_heroes_counts
				self.progress = Clamp(self.progress + dt(rate), 0, 1)
			end
		else
			if is_capturing then
				if self.current_team == DOTA_TEAM_NEUTRALS then
					self.current_team = temp_team
					self:UpdateRingColor()
					should_refresh = true
				end

				if is_recapturing then
					rate = -0.5 - total_heroes_counts
					self.progress = Clamp(self.progress + dt(rate), 0, 1)

					if self.progress <= 0 then
						self.current_team = temp_team
						self:UpdateRingColor()
						should_refresh = true
					end
				else
					rate = 1 + (((self.num_heroes or 1) - 1) * 0.5)

					self.progress = self.progress + dt(rate)

					if self.progress >= 1 then
						self:AddRewardForTeam(self.current_team)
					end
				end
			else
				if self.progress > 0 then
					rate = -0.5
					self.progress = Clamp(self.progress + dt(rate), 0, 1)

				end
			end
		end

		if self.progress <= 0 and self.current_team ~= DOTA_TEAM_NEUTRALS then
			self.current_team = DOTA_TEAM_NEUTRALS
			self:UpdateRingColor()
			should_refresh = true
		end

		if rate ~= self.rate then
			self.rate = rate
			should_refresh = true
		end

		if should_refresh then
			self:ForceRefresh()
		end
	else
		if self.clock_fx and self.capturing_fx then
			self.progress = Clamp(self.progress + dt(self.rate), 0, 1)
			if self.progress <= 0 and self.is_recapturing ~= 1 then
				ParticleManager:DestroyParticle(self.capturing_fx, false)
				ParticleManager:ReleaseParticleIndex(self.capturing_fx)
				self.capturing_fx = nil
				ParticleManager:DestroyParticle(self.clock_fx, false)
				ParticleManager:ReleaseParticleIndex(self.clock_fx)
				self.clock_fx = nil
				return
			end
			ParticleManager:SetParticleControl(self.clock_fx, 17, Vector(self.progress, 0, 0))
		end
	end
end

function capture_point_area:AddCustomTransmitterData()
	local data = 
	{
		is_capturing = self.is_capturing,
		is_contesting = self.is_contesting,
		is_recapturing = self.is_recapturing,
		progress = self.progress,
		current_team = self.current_team,
		num_heroes = self.num_heroes,
		rate = self.rate,
	}
	return data
end

function capture_point_area:HandleCustomTransmitterData( data )
	self.is_contesting = data.is_contesting
	self.is_capturing = data.is_capturing
	self.is_recapturing = data.is_recapturing
	self.progress = data.progress
	self.num_heroes = data.num_heroes
	self.rate = data.rate
	if data.is_capturing == 1 and data.current_team ~= -1 then
		if not self.capturing_fx then
			self.capturing_fx = ParticleManager:CreateParticle("particles/shrine/capture_point_ring_capturing.vpcf", PATTACH_ABSORIGIN, self:GetParent())
			ParticleManager:SetParticleControl(self.capturing_fx, 9, Vector(250, 0, 0))
		end
		ParticleManager:SetParticleControl(self.capturing_fx, 3, TEAMS_COLORS[data.current_team])
		if not self.clock_fx then
			self.clock_fx = ParticleManager:CreateParticle("particles/shrine/capture_point_ring_clock_overthrow.vpcf", PATTACH_ABSORIGIN, self:GetParent())
			ParticleManager:SetParticleControl(self.clock_fx, 9, Vector(250, 0, 0))
			ParticleManager:SetParticleControl(self.clock_fx, 11, Vector(0, 0, 1))
		end
		ParticleManager:SetParticleControl(self.clock_fx, 3, TEAMS_COLORS[data.current_team])
		ParticleManager:SetParticleControl(self.clock_fx, 17, Vector(self.progress, 0, 0))
	end
end

function capture_point_area:UpdateRingColor()
	if self.current_team and self.current_team >= DOTA_TEAM_GOODGUYS then
		ParticleManager:SetParticleControl(self.ring_fx, 3, TEAMS_COLORS[self.current_team])
	end
end

function capture_point_area:OnDestroy()
	local particles = 
	{
		self.clock_fx,
		self.capturing_fx,
		self.ring_fx,
	}
	for _, particle in pairs(particles) do
		if particle then
			ParticleManager:DestroyParticle(particle, false)
			ParticleManager:ReleaseParticleIndex(particle)
		end
	end
	if not IsServer() then return end
	local parent = self:GetParent()
end

function capture_point_area:AddRewardForTeam(team_number)
	if not IsServer() then return end
	local parent = self:GetParent()
	if parent.added_reward then return end
	parent.added_reward = true
	arena_system:GiveRewardSphere(team_number, self.orb_type)
	self:StopPoint()
end

function capture_point_area:StopPoint()
	local parent = self:GetParent()
	self:Destroy()
	parent:SetModel("models/development/invisiblebox.vmdl")
	parent:SetOriginalModel("models/development/invisiblebox.vmdl")
	parent:ForceKill(false)
	ParticleManager:DestroyParticle(parent.orb_fx, true)
end

function capture_point_area:CheckState()
	return 
	{
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end

function capture_point_area:UpdateHorizontalMotion( me, dt )
	if not IsServer() then return end
	if not self:GetParent() or not self:GetParent():IsAlive() then
		self:GetParent():InterruptMotionControllers(true)
		return
	end
	self.moving_time = self.moving_time + dt
	if self.moving_time > self.fly_time then
		self.moving_time = self.fly_time
	end
	local pct = self.moving_time / self.fly_time
	pct = (3-2*pct)*pct^2
	local dir = (self.end_pos - self.start_pos):Normalized()
	local distance = (self.end_pos - self.start_pos):Length()
	local pos = self.start_pos + dir*distance*pct
	self:GetParent():SetAbsOrigin(pos)
	if pct >= 1 then
		self:GetParent():InterruptMotionControllers(true)
		self:StartSearch()
	end
end

function capture_point_area:UpdateVerticalMotion( me, dt )
	if not IsServer() then return end
	if not self:GetParent() or not self:GetParent():IsAlive() then
		self:GetParent():InterruptMotionControllers(true)
		return
	end
	self.moving_time = self.moving_time + dt
	if self.moving_time > self.fly_time then
		self.moving_time = self.fly_time
	end
	local pct = self.moving_time / self.fly_time
	local dir = (self.end_pos - self.start_pos):Normalized()
	local distance = (self.end_pos - self.start_pos):Length()
	local pos = self.start_pos + dir*distance*pct
	local offset = (-(2*pct-1)^2 + 1) * self.fly_height
	pos.z = pos.z + offset
	self:GetParent():SetAbsOrigin(pos)
	if pct >= 1 or pos.z <= 100 then
		self:GetParent():InterruptMotionControllers(true)
		self:StartSearch()
	end
end