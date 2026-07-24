--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



--  Original Dota
--	"DOTA_HighFive_Completed"	"%s1 and %s2 just High Fived."
--	"DOTA_HighFive_LeftHanging"	"%s1 tried to High Five but was left hanging."

high_five_custom = high_five_custom or class({})
LinkLuaModifier("modifier_high_five_custom_search", "libraries/webapi/cosmetic_abilities/high_five_custom", LUA_MODIFIER_MOTION_NONE)


function high_five_custom:GetHero()
	local caster = self:GetCaster()
	local player_id = caster:GetPlayerOwnerID()
	return PlayerResource:GetSelectedHeroEntity(player_id)
end

function high_five_custom:OnSpellStart()
	if not IsServer() then return end

	local hero = self:GetHero()
	local duration = self:GetSpecialValueFor("request_duration")

	hero:AddNewModifier(hero, self, "modifier_high_five_custom_search", {duration = duration or 10})
	EmitSoundOn("high_five.cast", hero)

	self:UseResources(false, false, false, true)
end


function high_five_custom:OnProjectileHit(target, location)
	if not IsServer() then return end

	local hero = self:GetHero()

	local equipped_high_five = Equipment:GetItemInSlot(hero:GetPlayerOwnerID(), INVENTORY_SLOTS.HIGH_FIVE)
	local impact_particle = "particles/econ/events/diretide_2020/high_five/high_five_impact.vpcf"
	if equipped_high_five then
		local impact_particle_variant = Equipment:GetParticleVariant(equipped_high_five.name, "impact")
		if impact_particle_variant then impact_particle = impact_particle_variant.path end
	end

	local impact_p_id = ParticleManager:CreateParticle(impact_particle, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(impact_p_id, 0, location)
	ParticleManager:SetParticleControl(impact_p_id, 3, location)
	ParticleManager:ReleaseParticleIndex(impact_p_id)

	EmitSoundOnLocationWithCaster(location, "high_five.impact", hero)
end



modifier_high_five_custom_search = modifier_high_five_custom_search or class({})


function modifier_high_five_custom_search:IsPurgable() return false end
function modifier_high_five_custom_search:IsHidden() return true end

function modifier_high_five_custom_search:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_high_five_custom_search:GetEffectName()
	if self.wave_particle_path then return self.wave_particle_path end
end


function modifier_high_five_custom_search:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.search_radius = self.ability:GetSpecialValueFor("acknowledge_range")
	self.base_velocity = self.ability:GetSpecialValueFor("high_five_speed")
	self.interval = self.ability:GetSpecialValueFor("think_interval")

	self:SetHasCustomTransmitterData(true)

	if not IsServer() then return end

	self:StartIntervalThink(self.interval)
	-- item definitions and equipment only exist on server
	-- get particle name here and transmit to client to display
	local equipped_high_five = Equipment:GetItemInSlot(self.parent:GetPlayerOwnerID(), INVENTORY_SLOTS.HIGH_FIVE)
	self.wave_particle_path = "particles/cosmetic/high_five/high_five_default.vpcf"
	if equipped_high_five then
		self.equipped_high_five = equipped_high_five
		-- variant 0 of high five type contains wave effect path
		local wave_particle_variant = Equipment:GetParticleVariant(equipped_high_five.name, "wave")
		if wave_particle_variant then self.wave_particle_path = wave_particle_variant.path end
	end

	self:SendBuffRefreshToClients()
end


function modifier_high_five_custom_search:AddCustomTransmitterData()
	return {
		wave_particle_path = self.wave_particle_path
	}
end


function modifier_high_five_custom_search:HandleCustomTransmitterData(data)
	self.wave_particle_path = data.wave_particle_path
end


function modifier_high_five_custom_search:LaunchTowards(target)
	if self._proc then return end
	self._proc = true

	local travel_particle = "particles/econ/events/ti10/high_five/high_five_travel.vpcf"
	if self.equipped_high_five then
		-- variant 1 refers to travel particle
		local travel_particle_variant = Equipment:GetParticleVariant(self.equipped_high_five.name, "travel")
		if travel_particle_variant then travel_particle = travel_particle_variant.path end
	end

	-- launch travel particle to middlepoint between parent and target
	-- this is performed on target behalf at the same time

	local origin = self.parent:GetAbsOrigin()
	local center = (target:GetAbsOrigin() + origin) / 2
	local distance_vector = center - origin

	ProjectileManager:CreateLinearProjectile({
		Source = self.parent,
		Ability = self.ability,
		vSpawnOrigin = self.parent:GetAbsOrigin(),

	    EffectName = travel_particle,
	    fDistance = distance_vector:Length2D(),
	    fStartRadius = 10,
	    fEndRadius = 10,
		vVelocity = distance_vector:Normalized() * self.base_velocity,
	})

	self:Destroy()
end


function modifier_high_five_custom_search:OnIntervalThink()
	local units = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetOrigin(),
		self.parent,
		self.search_radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)

	for _, unit in pairs(units) do
		if IsValidEntity(unit) and unit ~= self.parent then
			local high_five_modifier = unit:FindModifierByName("modifier_high_five_custom_search")

			if high_five_modifier and not high_five_modifier._proc then
				high_five_modifier:LaunchTowards(self.parent)
				self:LaunchTowards(unit)

				local player_1 = self.parent:GetPlayerOwnerID()
				local team_1 = self.parent:GetTeam()

				local player_2 = unit:GetPlayerOwnerID()
				local team_2 = unit:GetTeam()

				local is_ally = team_1 == team_2

				local message_tokens =  {
					hard_replace = {
						["%s1"] = "<font color='{s:player_color_1}'>{s:player_name_1}</font>",
						["%s2"] = "<font color='{s:player_color_2}'>{s:player_name_2}</font>",
					},
					players = {
						[player_1] = C_CHAT_PRESETS.PLAYER(1),
						[player_2] = C_CHAT_PRESETS.PLAYER(2),
					},
				}

				if is_ally then
					CustomChat:MessageToTeam(-1, team_1, "DOTA_HighFive_Completed", message_tokens)
				else
					CustomChat:MessageToAll(-1, "DOTA_HighFive_Completed", message_tokens)
				end

				return
			end
		end
	end
end


function modifier_high_five_custom_search:OnDestroy()
	if not IsServer() then return end
	if self._proc then return end
	GameRules:SendCustomMessage("#DOTA_HighFive_LeftHanging", self.parent:GetPlayerOwnerID(), 0)
end