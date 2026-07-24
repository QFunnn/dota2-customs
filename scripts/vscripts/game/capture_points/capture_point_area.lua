--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/capture_points/capture_points_const")

capture_point_area = class({})

function capture_point_area:IsHidden() return false end
function capture_point_area:IsPurgable() return false end
function capture_point_area:DestroyOnExpire() return false end


function capture_point_area:OnCreated(kv)
	if not IsServer() then return end
	local parent = self:GetParent()

	self.rate = 0
	self.progress = 0
	self.current_team = -1
	self.num_heroes = 1

	self.moving_time = 0
	self.life_time = 0
	self.orb_type = kv.orb_type
	self.start_pos = parent:GetAbsOrigin()

	self.end_pos = OrbDropManager:SelectRingOrbDropLocation(self.orb_type)
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
end

function capture_point_area:StartSearch()
	if self.ring_fx then return end

	local parent = self:GetParent()

	self.ring_fx = ParticleManager:CreateParticle(CAPTURE_POINT_PATH .. "capture_point_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)

	ParticleManager:SetParticleControlEnt(self.ring_fx, 0, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", GetGroundPosition(parent:GetAbsOrigin(), parent), true)
	ParticleManager:SetParticleControl(self.ring_fx, 3, BASE_COLOR)
	ParticleManager:SetParticleControl(self.ring_fx, 9, Vector(CAPTURE_POINT_RADIUS, 0, 0))

	self.vPosition = parent:GetAbsOrigin()

	self:StartIntervalThink(INTERVAL_THINK)
end

local function dt(rate)
	local frame = GameRules:GetGameFrameTime()
	-- print(frame, rate, TIME_FOR_CAPTURE_POINT, frame * rate / TIME_FOR_CAPTURE_POINT)
	return frame * rate / TIME_FOR_CAPTURE_POINT
end

function capture_point_area:ValidCapturingUnit(unit)
	if unit:IsInvulnerable() and not unit:HasModifier("modifier_naga_siren_song_of_the_siren") then return false end
	if unit:HasModifier("modifier_ringmaster_the_box_buff") then return false end
	if unit:IsSpiritBear() then return false end
	if unit:GetUnitLabel() == "brewmaster_earth" then return false end

	if unit:IsRealHero() then
		if unit:HasModifier("modifier_skeleton_king_reincarnation_scepter_active") then return false end
		if unit:IsTempestDouble() then return false end
		if unit:IsMonkeyClone() then return false end
		return true
	else
		-- if unit:GetUnitName():find("npc_dota_brewmaster_") then return true end
	end

	return false
end

function capture_point_area:OnIntervalThink()
	if GameLoop.game_over then return end

	local targets = FindUnitsInRadius (
		DOTA_TEAM_NEUTRALS,
		self.vPosition,
		nil,
		CAPTURE_POINT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_ANY_ORDER,
		false
	)

	self.heroes_in_radius = {}
	local total_heroes_counts = 0
	local b_meepo_inside = false
	local b_brewmaster_inside = false

	local bear_inside = nil

	for _, target in pairs(targets) do
		if self:ValidCapturingUnit(target) then
			local is_meepo_unit = target:HasModifier("modifier_meepo_divided_we_stand")
			local is_brewmaster_unit = false -- target:GetUnitName():find("_brewmaster")	-- affects both brewmaster and brewlings, only one unit at a time

			if (not is_meepo_unit or not b_meepo_inside) and (not is_brewmaster_unit or not b_brewmaster_inside) then
				if not self.heroes_in_radius[target:GetTeamNumber()] then
					self.heroes_in_radius[target:GetTeamNumber()] = {}
				end

				table.insert(self.heroes_in_radius[target:GetTeamNumber()], target)
				total_heroes_counts = total_heroes_counts + 1
			end

			if is_meepo_unit then b_meepo_inside = true end
			-- if is_brewmaster_unit then b_brewmaster_inside = true end

			-- if target:IsSpiritBear() then bear_inside = target end
		end
	end

	-- if IsValidEntity(bear_inside) then
	-- 	local bear_owner = GetBearOwnerHero(bear_inside)
	-- 	if IsValidEntity(bear_owner) then
	-- 		local targets = self.heroes_in_radius[bear_owner:GetTeamNumber()] or {}
	-- 		local bear_owner_inside = table.contains(targets, bear_owner)

	-- 		-- if lone druid is inside with bear, remove bear from targets
	-- 		if bear_owner_inside then
	-- 			total_heroes_counts = total_heroes_counts - 1
	-- 			table.remove_item(targets, bear_inside)
	-- 		end
	-- 	end
	-- end

	local teams_count = 0
	local temp_team = DOTA_TEAM_NEUTRALS
	for team_number, units in pairs(self.heroes_in_radius) do
		temp_team = team_number
		teams_count = teams_count + 1

		for _, unit in pairs(units) do
			unit:AddNewModifier(unit, self, "modifier_capturing_orb_custom", {duration = 0.2})
			-- player gets 1 point of capturing for every 30 frames inside area (which should roughly be 1 server second)
			-- multiplied by rarity (so capturing rare gives 2 points / 30 frames and epics give 4 points / 30 frames)
			local player_owner = unit:GetPlayerOwnerID()
			MVPController:AddOrbCaptureScore(player_owner, self.orb_type * 1/30)
		end
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

		if is_capturing then
			self:GetParent():EmitSound("custom.orb_capture_start")
		else
			self:GetParent():StopSound("custom.orb_capture_start")
		end
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
				rate = self:ApplyExternalRateModifiers(rate)

				self.progress = self.progress + dt(rate)

				if self.progress >= 1 then
					self:AddRewardForTeam(self.current_team)
				end
			end
		else -- Сapturing progress slowly decay when no one in zone
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

	-- if should_refresh then
	-- 	self:ForceRefresh()
	-- end

	if self.clock_fx and self.capturing_fx then
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

	if self.is_capturing and self.current_team ~= -1 then
		if not self.capturing_fx then
			self.capturing_fx = ParticleManager:CreateParticle(CAPTURE_POINT_PATH .. "capture_point_ring_capturing.vpcf", PATTACH_ABSORIGIN, self:GetParent())
			ParticleManager:SetParticleControl(self.capturing_fx, 9, Vector(CAPTURE_POINT_RADIUS, 0, 0))
			-- print("created capturing fx", self.capturing_fx, IsServer())
		end

		ParticleManager:SetParticleControl(self.capturing_fx, 3, TEAMS_COLORS[self.current_team])

		if not self.clock_fx then
			self.clock_fx = ParticleManager:CreateParticle(CAPTURE_POINT_PATH .. "capture_point_ring_clock.vpcf", PATTACH_ABSORIGIN, self:GetParent())
			ParticleManager:SetParticleControl(self.clock_fx, 9, Vector(CAPTURE_POINT_RADIUS, 0, 0))
			ParticleManager:SetParticleControl(self.clock_fx, 11, Vector(0, 0, 1))
			-- print("created clock fx", self.clock_fx, IsServer())
		end

		ParticleManager:SetParticleControl(self.clock_fx, 3, TEAMS_COLORS[self.current_team] or BASE_COLOR)
		ParticleManager:SetParticleControl(self.clock_fx, 17, Vector(self.progress, 0, 0))
	end
end


function capture_point_area:UpdateRingColor()
	-- required to avoid script error when particle is initialized with a hero in radius on first tick
	if self.current_team and self.current_team >= DOTA_TEAM_GOODGUYS then
		ParticleManager:SetParticleControl(self.ring_fx, 3, TEAMS_COLORS[self.current_team] or BASE_COLOR)
	end
end

function capture_point_area:OnDestroy()
	local particles = {
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
	if parent.on_destroyed_callback then
		parent.on_destroyed_callback()
	end

	parent:StopSound("custom.orb_capture_start")
	if self.orb_type == UPGRADE_RARITY_EPIC then
		parent:EmitSound("custom.orb_capture_finish_epic")
	else
		parent:EmitSound("custom.orb_capture_finish")
	end
end

function capture_point_area:AddRewardForTeam(team_number)
	if not IsServer() then return end

	local parent = self:GetParent()
	if parent.added_reward then return end

	parent.added_reward = true

	Upgrades:QueueSelectionForTeam(team_number, self.orb_type)
	EndGameStats:AddCapturedOrb(team_number, ORB_CAPTURE_TYPE.DROP, self.orb_type)

	if SeasonalEvents:IsAnyEpicEventRunning() then
		for _team, _ in pairs(GameLoop.heroes_by_team) do
			Upgrades:QueueSelectionForTeam(_team, UPGRADE_RARITY_EPIC)
		end
	end

	EventDriver:Dispatch("GameLoop:orb_captured", {
		team = team_number,
		rarity = self.orb_type,
	})

	self:StopPoint()
end

function capture_point_area:StopPoint()
	local parent = self:GetParent()
	self:Destroy()
	parent:SetModel(INVISIBLE_MODEL)
	parent:SetOriginalModel(INVISIBLE_MODEL)
	parent:ForceKill(false)
	ParticleManager:DestroyParticle(parent.orb_fx, true)
end

function capture_point_area:CheckState()
	return {
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

	self:GetParent():SetOrigin(pos)

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

	self:GetParent():SetOrigin(pos)

	if pct >= 1 or pos.z <= 100 then
		self:GetParent():InterruptMotionControllers(true)
		self:StartSearch()
	end
end


function capture_point_area:ApplyExternalRateModifiers(rate)
	if not self.current_team or self.current_team == -1 or self.current_team == DOTA_TEAM_NEUTRALS then
		return rate
	end

	local team_modifiers = {}
	-- only physically present heroes affect rate with Conqueror's Presence
	for _, hero in pairs(self.heroes_in_radius[self.current_team] or {}) do
		if IsValidEntity(hero) then
			table.insert(team_modifiers, WebInventory:GetItemCount(hero:GetPlayerOwnerID(), "bp_conqueror_presence") / 100)
		end
	end

	if #team_modifiers <= 0 then return rate end

	local rate_modifier = 1 + math.max(unpack(team_modifiers))

	return rate * rate_modifier
end