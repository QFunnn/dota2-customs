--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_orbs_shrine_custom_animation_active",
	"modifiers/map_mods/modifier_orbs_shrine_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_orbs_shrine_custom_animation_captured",
	"modifiers/map_mods/modifier_orbs_shrine_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_orbs_shrine_custom_hero",
	"modifiers/map_mods/modifier_orbs_shrine_custom",
	LUA_MODIFIER_MOTION_NONE
)

modifier_orbs_shrine_custom = class(mod_hidden)
function modifier_orbs_shrine_custom:DestroyOnExpire()
	return false
end
function modifier_orbs_shrine_custom:OnCreated(params)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.center = self.parent:GetAbsOrigin()

	self.orbs_max = 0
	self.start_wave = orb_shrines_wave

	self.interval = 0.1
	self.radius = 250

	self.orbs_left = 0
	self.waiting_reset = false
	self.reset_timer = 0
	self.reset_max = test and 5 or 25

	self.team_captured = nil
	self.hero_captured = nil
	self.capture_progress = -self.interval
	self.capture_max = 2.5
	self.hero_capturing = nil

	self.parent:SetModelScale(0.75)
	local abs = GetGroundPosition(self.parent:GetAbsOrigin(), nil)
	abs = abs + Vector(0, 0, 20)
	self.parent:SetAbsOrigin(abs)

	self:StartIntervalThink(self.interval)
end

function modifier_orbs_shrine_custom:Activate(current_wave, activate, instant)
	if not IsServer() then
		return
	end
	if current_wave < self.start_wave then
		return
	end

	self.orbs_left = 0
	self.reset_timer = 0
	self.waiting_reset = false

	if not activate then
		return
	end

	self.orbs_max = ShrineTicks
	self.gold_tick = math.floor((ShrineGold + ShrineGoldWave * current_wave) / ShrineTicks)
	self.waiting_reset = true

	if instant then
		self.reset_timer = self.reset_max
	end

	self:StartIntervalThink(self.interval)
end

function modifier_orbs_shrine_custom:ResetCapture()
	if not IsServer() then
		return
	end

	if self.capture_particle then
		self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
		ParticleManager:DestroyParticle(self.capture_particle, false)
		ParticleManager:ReleaseParticleIndex(self.capture_particle)
		self.capture_particle = nil
	end
	self.parent:StopSound("OrbsShrine.capture")
	self.capture_progress = 0
	self.hero_capturing = nil
end

function modifier_orbs_shrine_custom:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self.waiting_reset then
		self.reset_timer = self.reset_timer + self.interval
		if self.reset_timer >= self.reset_max then
			local thinker = self.parent.duel_thinker
			if not IsValid(thinker) or not thinker:HasModifier("modifier_duel_field_active_thinker") then
				self.waiting_reset = false
				self.orbs_left = self.orbs_max
			end
		end
	end

	if self.orbs_left == 0 then
		self.team_captured = nil
		self.hero_captured = nil
		self:ResetCapture()
		self.parent:RemoveModifierByName("modifier_orbs_shrine_custom_animation_active")
		self.parent:RemoveModifierByName("modifier_orbs_shrine_custom_animation_captured")
		if not self.waiting_reset then
			self:StartIntervalThink(-1)
		end
		return
	else
		if not self.parent:HasModifier("modifier_orbs_shrine_custom_animation_active") then
			self.parent:AddNewModifier(self.parent, nil, "modifier_orbs_shrine_custom_animation_active", {})
		end
	end

	local cant_capture = true
	local hero_inside = nil

	for team, tower in pairs(towers) do
		AddFOWViewer(team, self.center, self.radius, self.interval * 2, true)

		local has_players = false
		local last_hero = nil
		if tower.ids then
			for _, id in pairs(tower.ids) do
				local player = players[id]
				if
					player
					and player:IsAlive()
					and (team == self.team_captured or not player:HasModifier("modifier_orbs_shrine_custom_hero"))
					and (player:GetAbsOrigin() - self.center):Length2D() <= self.radius
				then
					has_players = true
					last_hero = player
				end
			end
		end
		if has_players then
			if not hero_inside then
				hero_inside = last_hero
				cant_capture = false
			else
				cant_capture = true
			end
		end
	end

	if self.team_captured and hero_inside and hero_inside:GetTeamNumber() == self.team_captured then
		cant_capture = true
	end

	if cant_capture then
		self:ResetCapture()
	else
		self.hero_capturing = hero_inside
		self.capture_progress = self.capture_progress + self.interval
		if not self.capture_particle then
			self.parent:EmitSound("OrbsShrine.capture")
			self.capture_particle = ParticleManager:CreateParticle(
				"particles/base_static/experience_shrine_active.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self.parent
			)
			ParticleManager:SetParticleControl(self.capture_particle, 0, self.parent:GetAbsOrigin())
			self:AddParticle(self.capture_particle, false, false, -1, false, false)
			self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_1)
		end
		ParticleManager:SetParticleControl(
			self.capture_particle,
			1,
			Vector(self.radius, self.radius * (self.capture_progress / self.capture_max) * 1.2, 0)
		)

		if self.capture_progress >= self.capture_max then
			self.team_captured = self.hero_capturing:GetTeamNumber()
			self.hero_captured = self.hero_capturing

			local mod = self.parent:FindModifierByName("modifier_orbs_shrine_custom_animation_captured")
			if not mod then
				mod = self.parent:AddNewModifier(
					self.parent,
					nil,
					"modifier_orbs_shrine_custom_animation_captured",
					{ orbs_max = self.orbs_left }
				)
			end
			mod:ChangeOwner(self.hero_captured)
		end
	end
end

function modifier_orbs_shrine_custom:CheckState()
	return {
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		--[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = not self.parent:HasModifier("modifier_orbs_shrine_custom_animation_active"),
	}
end

modifier_orbs_shrine_custom_animation_active = class(mod_hidden)
function modifier_orbs_shrine_custom_animation_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_orbs_shrine_custom_animation_active:GetActivityTranslationModifiers()
	return "active"
end

function modifier_orbs_shrine_custom_animation_active:GetOverrideAnimation()
	return ACT_DOTA_IDLE
end

function modifier_orbs_shrine_custom_animation_active:CheckState()
	return {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}
end

function modifier_orbs_shrine_custom_animation_active:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.parent:StartGesture(ACT_DOTA_SPAWN)
	self.parent:EmitSound("OrbsShrine.activate")

	self:OnIntervalThink()
	self:StartIntervalThink(90)
end

function modifier_orbs_shrine_custom_animation_active:OnIntervalThink()
	if not IsServer() then
		return
	end

	if self.active_particle then
		ParticleManager:DestroyParticle(self.active_particle, true)
		ParticleManager:ReleaseParticleIndex(self.active_particle)
		self.capture_particle = nil
	end

	self.active_particle = ParticleManager:CreateParticle(
		"particles/base_static/experience_shrine_ambient.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(self.active_particle, 0, self.parent:GetAbsOrigin())
	self:AddParticle(self.active_particle, false, false, -1, false, false)
end

function modifier_orbs_shrine_custom_animation_active:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:StopSound("OrbsShrine.activate")
	self.parent:StartGesture(ACT_DOTA_DIE)
end

modifier_orbs_shrine_custom_animation_captured = class(mod_hidden)
function modifier_orbs_shrine_custom_animation_captured:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.mod = self.parent:FindModifierByName("modifier_orbs_shrine_custom")
	self.center = self.parent:GetAbsOrigin()

	self.orbs_max = table.orbs_max
	self.max_time = 50
	self.interval = self.max_time / self.orbs_max
	self.orbs_tick = 1
	self.tick_interval = 0.5
	self.timer = 0

	self.hero_mods = {}

	self.radius = self.mod.radius
	self.clock_radius = self.radius
	self.clock_particle = {}
	self.progress = 1

	self:StartIntervalThink(self.tick_interval)
end

function modifier_orbs_shrine_custom_animation_captured:ChangeOwner(new_owner)
	if not IsServer() then
		return
	end
	for _, mod in pairs(self.hero_mods) do
		if IsValid(mod) then
			mod:Destroy()
		end
	end
	self.hero_mods = {}

	self.hero_captured = new_owner
	self.team_captured = new_owner:GetTeamNumber()

	self:GiveHeroMods()

	if self.particle_hero_icon then
		ParticleManager:DestroyParticle(self.particle_hero_icon, true)
		ParticleManager:ReleaseParticleIndex(self.particle_hero_icon)
		self.particle_hero_icon = nil
	end

	self.parent:GenericParticle("particles/base_static/experience_shrine_ambient_endcap.vpcf")
	self.parent:EmitSound("OrbsShrine.trigger")
	self.parent:EmitSound("OrbsShrine.trigger2")

	self.particle_hero_icon =
		ParticleManager:CreateParticle("particles/generic/blue_shrine_icon.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent)
	if self.hero_captured then
		local name = dota1x6:GetHeroIcon(self.hero_captured:GetId())
		if not name then
			name = self.hero_captured:GetUnitName()
		end
		local width_table = Vector(1, 1, 0)
		if icon_hero_width[name] then
			width_table = Vector(icon_hero_width[name][1], icon_hero_width[name][2], 0)
		end

		ParticleManager:SetParticleControl(self.particle_hero_icon, 1, Vector(icon_hero_id[name], 0, 0))
		ParticleManager:SetParticleControl(self.particle_hero_icon, 2, width_table)
	end
	self:AddParticle(self.particle_hero_icon, false, false, -1, false, false)

	for _, particle in pairs(self.clock_particle) do
		ParticleManager:DestroyParticle(particle, true)
		ParticleManager:ReleaseParticleIndex(particle)
	end
	self.clock_particle = {}
	self:UpdateParticle()
end

function modifier_orbs_shrine_custom_animation_captured:GiveHeroMods()
	if not IsServer() then
		return
	end
	if not self.team_captured then
		return
	end

	local heroes = dota1x6:FindPlayers(self.team_captured, nil, true)
	if not heroes then
		return
	end

	local duration = (self.mod.orbs_left / self.orbs_tick) * self.interval - self.timer + self.tick_interval

	for _, hero in pairs(heroes) do
		if hero:IsAlive() and not hero:HasModifier("modifier_orbs_shrine_custom_hero") then
			local mod = hero:AddNewModifier(
				hero,
				nil,
				"modifier_orbs_shrine_custom_hero",
				{ duration = duration, gold = self.mod.gold_tick * self.orbs_max }
			)
			if mod then
				table.insert(self.hero_mods, mod)
			end
		end
	end
end

function modifier_orbs_shrine_custom_animation_captured:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not IsValid(self.mod) or self.mod.orbs_left <= 0 then
		self:Destroy()
		return
	end

	self:GiveHeroMods()

	self.timer = self.timer + self.tick_interval
	self.progress = (self.mod.orbs_left - self.timer / self.interval) / self.orbs_max
	self:UpdateParticle()

	if self.timer % 1 == 0 then
		for _, hero in pairs(dota1x6:FindPlayers(self.team_captured, false, true)) do
			hero:AddPoints("white", 1, "sanctuary")
		end
	end

	if self.timer < self.interval then
		return
	end
	self.timer = 0

	local tick = math.min(self.orbs_tick, self.mod.orbs_left)
	self.mod.orbs_left = self.mod.orbs_left - tick

	if not self.team_captured then
		return
	end
	local heroes = dota1x6:FindPlayers(self.team_captured, false, true)
	if heroes then
		for _, hero in pairs(heroes) do
			hero:GiveGold(self.mod.gold_tick, nil, false, "sanctuary")
		end
	end
end

function modifier_orbs_shrine_custom_animation_captured:UpdateParticle()
	if not IsServer() then
		return
	end

	for team, _ in pairs(towers) do
		if not self.clock_particle[team] then
			self.clock_particle[team] = ParticleManager:CreateParticleForTeam(
				"particles/shrine/capture_point_ring_clock_overthrow.vpcf",
				PATTACH_WORLDORIGIN,
				self.parent,
				team
			)
			ParticleManager:SetParticleControl(self.clock_particle[team], 0, self.center + Vector(0, 0, 5))
			ParticleManager:SetParticleControl(self.clock_particle[team], 11, Vector(0, 0, 1))
			self:AddParticle(self.clock_particle[team], false, false, -1, false, false)
		end

		if self.team_captured == team then
			ParticleManager:SetParticleControl(self.clock_particle[team], 3, Vector(114, 75, 224))
			ParticleManager:SetParticleControl(self.clock_particle[team], 9, Vector(self.clock_radius, 0, 0))
		else
			ParticleManager:SetParticleControl(self.clock_particle[team], 3, Vector(255, 79, 22))
			ParticleManager:SetParticleControl(self.clock_particle[team], 9, Vector(self.clock_radius, 0, 0))
		end
		ParticleManager:SetParticleControl(self.clock_particle[team], 17, Vector(self.progress, 0, 0))
	end
end

function modifier_orbs_shrine_custom_animation_captured:OnDestroy()
	if not IsServer() then
		return
	end
	for _, mod in pairs(self.hero_mods) do
		if IsValid(mod) then
			mod:Destroy()
		end
	end
end

modifier_orbs_shrine_custom_hero = class(mod_visible)
function modifier_orbs_shrine_custom_hero:RemoveOnDeath()
	return false
end
function modifier_orbs_shrine_custom_hero:GetTexture()
	return "buffs/generic/orbs_shrine"
end
function modifier_orbs_shrine_custom_hero:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_orbs_shrine_custom_hero:OnCreated(table)
	if not IsServer() then
		return
	end
	self.gold = table.gold

	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end

function modifier_orbs_shrine_custom_hero:AddCustomTransmitterData()
	return {
		gold = self.gold,
	}
end

function modifier_orbs_shrine_custom_hero:HandleCustomTransmitterData(data)
	self.gold = data.gold
end

function modifier_orbs_shrine_custom_hero:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_orbs_shrine_custom_hero:OnTooltip()
	return self.gold
end