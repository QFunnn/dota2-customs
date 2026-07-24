--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


dark_seer_wall_of_replica_lua = dark_seer_wall_of_replica_lua or class({})

LinkLuaModifier("modifier_dark_seer_wall_of_replica_lua", "abilities/heroes/dark_seer/modifier_dark_seer_wall_of_replica", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dark_seer_wall_of_replica_lua_thinker", "abilities/heroes/dark_seer/modifier_dark_seer_wall_of_replica_lua_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dark_seer_wall_of_replica_lua_empower", "abilities/heroes/dark_seer/modifier_dark_seer_wall_of_replica_lua_empower", LUA_MODIFIER_MOTION_NONE)


function dark_seer_wall_of_replica_lua:Precache( context )
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_dark_seer_illusion.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf", context)
end


function dark_seer_wall_of_replica_lua:GetIntrinsicModifierName()
	return "modifier_dark_seer_wall_of_replica_lua"
end


function dark_seer_wall_of_replica_lua:CastFilterResultLocation(location)
	if IsServer() then print(location) return end

	local player = Entities:GetLocalPlayer()
	local click_behavior = player:GetClickBehaviors()

	--print(location, click_behavior)

	if click_behavior ~= DOTA_CLICK_BEHAVIOR_VECTOR_CAST then
		self.location = location
	elseif click_behavior == DOTA_CLICK_BEHAVIOR_VECTOR_CAST then
		if not self.fx then
			self.fx = ParticleManager:CreateParticle("particles/ui_mouseactions/range_finder_cone_dual.vpcf", PATTACH_WORLDORIGIN, nil)
			self.wall_width = self:GetSpecialValueFor("width") / 2
		end

		ParticleManager:SetParticleControl(self.fx, 1, self.location)
		self.modifier:StartIntervalThink(0.01)

		--If both points close enough to each other wall directed to caster
		if (location - self.location):Length2D() < 32 then
			local forward = (self:GetCaster():GetAbsOrigin() - self.location):Normalized()
			location = self.location + forward
		end

		local direction = (self.location - location):Normalized()

		ParticleManager:SetParticleControl(self.fx, 7, self.location + direction * self.wall_width)
		ParticleManager:SetParticleControl(self.fx, 8, self.location - direction * self.wall_width)
	end
end


function dark_seer_wall_of_replica_lua:OnSpellStart()
	local caster = self:GetCaster()
	local position = self:GetCursorPosition()

	self.vector_target_position = self.vector_target_position or position

	--If both points close enough to each other wall directed to caster
	if (position - self.vector_target_position):Length2D() < 32 then
		local distance = caster:GetAbsOrigin() - position
		local forward

		-- If hero too close to cast points make wall perpendicular to hero forward
		if distance:Length2D() < 1 then
			forward = caster:GetForwardVector()

			local x = forward.x
			forward.x, forward.y = -forward.y, x
		else
			forward = distance:Normalized()
		end

		self.vector_target_position = position + forward
	end

	local direction = (position - self.vector_target_position):Normalized()

	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster,
		self,
		"modifier_dark_seer_wall_of_replica_lua_thinker",
		{
			duration = duration,
			dir_x = direction.x,
			dir_y = direction.y,
		},
		position,
		caster:GetTeamNumber(),
		false
	)

	self.vector_target_position = nil
end