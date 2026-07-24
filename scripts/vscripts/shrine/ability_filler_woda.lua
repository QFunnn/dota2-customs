--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ability_filler_woda", "shrine/ability_filler_woda", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ability_filler_woda_thinker", "shrine/ability_filler_woda", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ability_filler_woda_regen", "shrine/ability_filler_woda", LUA_MODIFIER_MOTION_NONE)

ability_filler_woda=class({})

function ability_filler_woda:Spawn()
	if not IsServer() then return end
	if not self:IsTrained() then
		self:SetLevel(1)
	end
end

modifier_ability_filler_woda=class({})

function modifier_ability_filler_woda:IsHidden()
	return true 
end

function modifier_ability_filler_woda:IsPurgable()
	return false 
end

function modifier_ability_filler_woda:DestroyOnExpire()
	return false
end

function modifier_ability_filler_woda:OnCreated()
    if IsClient() then
        ParticleManager:CreateParticle("particles/world_shrine/radiant_shrine_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        local particle = ParticleManager:CreateParticle("particles/experience_border_shrine.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
        self:AddParticle(particle, false, false, -1, false, false)
    end
	if not IsServer() then return end
	--self.radius = self:GetAbility():GetSpecialValueFor("radius")
	--self.duration_point = self:GetAbility():GetSpecialValueFor("duration")
	--self.health = self:GetAbility():GetSpecialValueFor("health")
	--self.mana = self:GetAbility():GetSpecialValueFor("mana")
	self:StartIntervalThink(0.02)
	local Origin=self:GetParent():GetAbsOrigin()
	local Capture = CreateUnitByName("npc_dummy_unit", Origin, false, nil, nil, DOTA_TEAM_NEUTRALS)
	Capture:SetAbsOrigin(Origin)
	self:GetParent().modifier_capture = Capture:AddNewModifier(self:GetParent(), nil, "modifier_ability_filler_woda_thinker", {})
	Capture:AddNewModifier(Capture, nil, "modifier_invulnerable", {})
	Capture:AddNewModifier(Capture, nil, "modifier_magic_immune", {})
	Capture:AddNewModifier(Capture, nil, "modifier_no_healthbar", {})
end

function modifier_ability_filler_woda:DeclareFunctions()
    local decFuncs = 
    {
        MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
    }
    return decFuncs
end

function modifier_ability_filler_woda:CheckState()
  	return 
  	{
    	[MODIFIER_STATE_PROVIDES_VISION] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = self:GetStackCount() == 0,
  	}
end

function modifier_ability_filler_woda:GetModifierProvidesFOWVision()
  	return 1
end

function modifier_ability_filler_woda:OnIntervalThink()
end

modifier_ability_filler_woda_thinker=class({})

modifier_ability_filler_woda_thinker.m_TeamColors = {}
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 }
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_BADGUYS]  = { 243, 201, 9 }
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 }
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 }
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 }
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 }
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 }
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 }
modifier_ability_filler_woda_thinker.m_TeamColors[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }

function modifier_ability_filler_woda_thinker:OnCreated()
	if not IsServer() then return end
	self.CaptureProgress = 0
	self.ReCaptureTime = 0 
	self.MovingTime = 0 
	self.LiveTime = 0
	self.CurrentTeam = nil
	self.CaptureTeam = nil
    self.start_pos = self:GetParent():GetAbsOrigin()
    self.pfx_list = {}
    for player_id, data in pairs(_G.PLAYERS) do
        self:UpdateParticleForPlayer(player_id)
    end
	self:StartIntervalThink(FrameTime())
end

function modifier_ability_filler_woda_thinker:UpdateParticleForPlayer(player_id)
    if self.pfx_list[player_id] then
        ParticleManager:DestroyParticle(self.pfx_list[player_id], true)
        self.pfx_list[player_id] = nil
    end
    local player = PlayerResource:GetPlayer(player_id)
    if player then
        self.pfx_list[player_id] = ParticleManager:CreateParticleForPlayer("particles/shrine/capture_point_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), player)
        ParticleManager:SetParticleControl(self.pfx_list[player_id], 3, Vector(255,255,255))
        ParticleManager:SetParticleControl(self.pfx_list[player_id], 9, Vector(350,0,0))
    end
end

function modifier_ability_filler_woda_thinker:OnIntervalThink()
	if not IsServer() then return end
    self:GetParent():SetAbsOrigin(self.start_pos)
	local units=FindUnitsInRadius(DOTA_TEAM_NEUTRALS, self:GetParent():GetAbsOrigin(), nil, 350, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE +
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS+DOTA_UNIT_TARGET_FLAG_NOT_SUMMONED+DOTA_UNIT_TARGET_FLAG_NOT_DOMINATED+DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO+DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
	if #units <= 0 then
		self:UpdateClock(self.CaptureTeam)
		return
	end
	local teams={}
	for _,unit in pairs(units) do
        if not unit:HasModifier("modifier_disconnect_player_no_damage") and not unit:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") and not unit:HasModifier("modifier_fountain_invulnerability") then
		    teams[unit:GetTeamNumber()] = 1
        end
	end
	--if self:GetCaster():GetTeamNumber() == units[1]:GetTeamNumber() then
	--	if self.CaptureProgressParticle then 
	--		ParticleManager:DestroyParticle(self.CaptureProgressParticle, false)
	--		self.CaptureProgressParticle = nil
	--	end
	--	if self.CaptureClockParticle then 
	--		ParticleManager:DestroyParticle(self.CaptureClockParticle, false)
	--		self.CaptureClockParticle = nil
	--	end
	--	return
	--end
	local teamcount = 0
	for _,team in pairs(teams) do
		teamcount = teamcount + 1
	end
	if string.find(GetMapName(), "rating") then
		if teamcount > 1 then
			if self.CaptureProgress >= 2 then
				if self.CaptureClockParticle then 
					ParticleManager:DestroyParticle(self.CaptureClockParticle, false)
					self.CaptureClockParticle = nil
				end
			end
			if not self.Clown then 
				self.Clown = ParticleManager:CreateParticle("particles/shrine_mark.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())
				if self.CurrentTeam ~= nil then
					ParticleManager:SetParticleControl(self.Clown, 2, Vector(self.m_TeamColors[self.CurrentTeam][1],self.m_TeamColors[self.CurrentTeam][2],self.m_TeamColors[self.CurrentTeam][3]))
				else
					ParticleManager:SetParticleControl(self.Clown, 2, Vector(255,255,255))
				end
			end
			return
		end
	end
	if self.Clown then 
		ParticleManager:DestroyParticle(self.Clown, true)
		self.Clown = nil
	end
	if self.CurrentTeam ~= nil and self.CaptureProgress >= 2 then 
		local alyunits = FindUnitsInRadius(self.CurrentTeam, self:GetParent():GetAbsOrigin(), nil, 350, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
		for _,hero in pairs(alyunits) do
			hero:AddNewModifier(hero, nil, "modifier_ability_filler_woda_regen", {})
		end
		if self.CaptureClockParticle then 
			ParticleManager:DestroyParticle(self.CaptureClockParticle, true)
			self.CaptureClockParticle = nil
		end
	end
	if self.CurrentTeam ~= nil and self.CurrentTeam ~= units[1]:GetTeamNumber() then self:UpdateClock(self.CaptureTeam) return end
	if self.CaptureTeam ~= nil and self.CaptureTeam ~= units[1]:GetTeamNumber() then self:UpdateClock(self.CaptureTeam) return end
	self:StartCapturePoint(units[1]:GetTeamNumber())
end

function modifier_ability_filler_woda_thinker:UpdateClock(team)
	if self.CaptureProgressParticle then 
		ParticleManager:DestroyParticle(self.CaptureProgressParticle, false)
		self.CaptureProgressParticle = nil
	end
	if self.CaptureProgress > 0 then
		if self.ReCaptureTime > 0 then
			self.CaptureProgress = self.ReCaptureTime
		end
		self.CaptureProgress = math.max(self.CaptureProgress-FrameTime(),0)
		self.ReCaptureTime = 0
		self:StartClock(team)
	else
		if self.CaptureClockParticle then 
			ParticleManager:DestroyParticle(self.CaptureClockParticle, false)
			self.CaptureClockParticle = nil
			self.CurrentTeam = nil
			self.CaptureTeam = nil
			self:GetCaster():SetTeam(DOTA_TEAM_NOTEAM)
			self:SetRingColor(nil)
		end
		if self.CaptureProgress > 0 then
			if self.ReCaptureTime > 0 then
				self.CaptureProgress = self.ReCaptureTime
			end
			self.CaptureProgress = math.max(self.CaptureProgress-FrameTime(),0)
			self.ReCaptureTime = 0
			self.StartClock(nil)
		else
			if self.CaptureClockParticle then
				ParticleManager:DestroyParticle(self.CaptureClockParticle, false)
				self.CaptureClockParticle = nil
				self.CurrentTeam = nil
				self.CaptureTeam = nil
				self:GetCaster():SetTeam(DOTA_TEAM_NOTEAM)
				self:SetRingColor(nil)
			end
		end
	end
end

function modifier_ability_filler_woda_thinker:StopPoint(team)
	if self.CaptureClockParticle then 
		ParticleManager:DestroyParticle(self.CaptureClockParticle, false)
		self.CaptureClockParticle = nil
	end
	if self.CaptureProgressParticle then
		ParticleManager:DestroyParticle(self.CaptureProgressParticle, false)
		self.CaptureProgressParticle = nil
	end
	self:GetCaster():SetTeam(team)
	self.CurrentTeam = team
end

function modifier_ability_filler_woda_thinker:StartCapturePoint(team)
	self.CaptureTeam = team
	if not self.CaptureProgressParticle then 
		self.CaptureProgressParticle = ParticleManager:CreateParticle("particles/shrine/capture_point_ring_capturing.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	end
	ParticleManager:SetParticleControl(self.CaptureProgressParticle, 9, Vector(350,0,0))
	if self.CurrentTeam ~= nil and team == nil then
		ParticleManager:SetParticleControl(self.CaptureProgressParticle, 3, Vector(self.m_TeamColors[self.CurrentTeam][1],self.m_TeamColors[self.CurrentTeam][2],self.m_TeamColors[self.CurrentTeam][3]))
	elseif team == nil then
		ParticleManager:SetParticleControl(self.CaptureProgressParticle, 3, Vector(255,255,255))
	else
		ParticleManager:SetParticleControl(self.CaptureProgressParticle, 3, Vector(self.m_TeamColors[team][1],self.m_TeamColors[team][2],self.m_TeamColors[team][3]))
	end
	if self.ReCaptureTime <= 0 then
		if self.CaptureProgress < 2 then
		self.CaptureProgress = self.CaptureProgress + FrameTime()
	end
		self:SetRingColor(team)
		if self.CaptureProgress >= 2 then
			self:StopPoint(team)
		end
	else
		self.ReCaptureTime = self.ReCaptureTime - FrameTime()
		self.CaptureProgress = self.CaptureProgress - FrameTime()
		if self.ReCaptureTime <= 0 then
			self.CaptureProgress = 0
			self:SetRingColor(team)
		end
	end
	self:StartClock(team)
end

function modifier_ability_filler_woda_thinker:SetRingColor(team)
	if self.CurrentTeam ~= nil and team == nil then 
		for _, particle in pairs(self.pfx_list) do
            ParticleManager:SetParticleControl(particle, 3, Vector(self.m_TeamColors[self.CurrentTeam][1],self.m_TeamColors[self.CurrentTeam][2],self.m_TeamColors[self.CurrentTeam][3]))
        end
		return
	end
	if team == nil then
        for _, particle in pairs(self.pfx_list) do
            ParticleManager:SetParticleControl(particle, 3, Vector(255,255,255))
        end
		return
	end
    for _, particle in pairs(self.pfx_list) do
        ParticleManager:SetParticleControl(particle, 3, Vector(self.m_TeamColors[team][1],self.m_TeamColors[team][2],self.m_TeamColors[team][3]))
    end
end

function modifier_ability_filler_woda_thinker:StartClock(team)
	if self.CaptureProgress >= 2 then
		if self.CaptureClockParticle then 
			ParticleManager:DestroyParticle(self.CaptureClockParticle, true)
			self.CaptureClockParticle = nil
		end
		return
	end
	if not self.CaptureClockParticle then
		self.CaptureClockParticle = ParticleManager:CreateParticle("particles/shrine/capture_point_ring_clock.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(self.CaptureClockParticle, 9, Vector(350,0,0))
	end
	if self.CaptureProgress == 0 then 
		if self.CaptureClockParticle then 
			ParticleManager:DestroyParticle(self.CaptureClockParticle, false)
		end
		self.CaptureClockParticle = nil 
		self.CaptureClockParticle = ParticleManager:CreateParticle("particles/shrine/capture_point_ring_clock.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(self.CaptureClockParticle, 9, Vector(350,0,0))
		self:SetRingColor(team)
	end
	if self.CaptureClockParticle then
		ParticleManager:SetParticleControl(self.CaptureClockParticle, 11, Vector(0,0,1))
		if self.CurrentTeam ~= nil and team == nil then
			ParticleManager:SetParticleControl(self.CaptureClockParticle, 3, Vector(self.m_TeamColors[self.CurrentTeam][1],self.m_TeamColors[self.CurrentTeam][2],self.m_TeamColors[self.CurrentTeam][3]))
		elseif team == nil then
			ParticleManager:SetParticleControl(self.CaptureClockParticle, 3, Vector(255,255,255))
		else
			ParticleManager:SetParticleControl(self.CaptureClockParticle, 3, Vector(self.m_TeamColors[team][1],self.m_TeamColors[team][2],self.m_TeamColors[team][3]))
		end
		local ntime = self.CaptureProgress
		if self.ReCaptureTime > 0 then 
			ntime = self.ReCaptureTime
		end
		local theta = ntime / 2
		ParticleManager:SetParticleControl(self.CaptureClockParticle, 17, Vector(theta,0,0))
		--ParticleManager:SetParticleControlForward(self.CaptureClockParticle, 1, Vector(math.cos(theta), math.sin(theta), 0))
	end
end

modifier_ability_filler_woda_regen=class({})

function modifier_ability_filler_woda_regen:IsPurchasable()
	return false
end

function modifier_ability_filler_woda_regen:GetTexture()
	return "fountain_regen"
end

function modifier_ability_filler_woda_regen:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
    }

    return funcs
end

function modifier_ability_filler_woda_regen:GetModifierTotalPercentageManaRegen( params )
    return 9
end

function modifier_ability_filler_woda_regen:GetModifierHealthRegenPercentage( params )
    return 9
end

function modifier_ability_filler_woda_regen:GetEffectName()
	return "particles/generic_gameplay/radiant_fountain_regen.vpcf"
end

function modifier_ability_filler_woda_regen:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modifier_ability_filler_woda_regen:OnRefresh()
	if not IsServer() then return end
    for i=0,6 do
        local item = self:GetParent():GetItemInSlot(i)
        if item and item:GetName() == "item_bottle" then
            if item:GetCurrentCharges() < 3 then
                item:SetCurrentCharges(3)
            end
        end
    end
	self:StartIntervalThink(0.5)
end

function modifier_ability_filler_woda_regen:OnIntervalThink()
	if not IsServer() then return end
	self:Destroy()
end