--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


terrorblade_reflection_lua = terrorblade_reflection_lua or class({})
LinkLuaModifier("modifier_terrorblade_reflection_lua_controller", "abilities/heroes/terrorblade/modifier_terrorblade_reflection_lua_controller", LUA_MODIFIER_MOTION_NONE)


function terrorblade_reflection_lua:GetAOERadius()
	return self:GetSpecialValueFor("range")
end


function terrorblade_reflection_lua:OnSpellStart()
	local caster = self:GetCaster()
	local cast_origin = self:GetCursorPosition()

	local radius = self:GetSpecialValueFor("range")
	local delay_increment = self:GetSpecialValueFor("delay_increment")

	local enemies = FindUnitsInRadius(
		caster:GetTeam(),
		cast_origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)

	local delay = 0

	for _, enemy in pairs(enemies or {}) do
		if IsValidEntity(enemy) and not enemy:IsIllusion() and not enemy:IsCreepHero() and not enemy:IsDebuffImmune() then
			self:ApplySlowAndCreateIllusion(enemy, delay)

			delay = delay + delay_increment
		end
	end

	caster:EmitSound("Hero_Terrorblade.Reflection")
end


function terrorblade_reflection_lua:ApplySlowAndCreateIllusion(enemy, delay)
	local caster = self:GetCaster()
	local illusion_duration = self:GetSpecialValueFor("illusion_duration")
	local illusion_outgoing_damage = self:GetSpecialValueFor("illusion_outgoing_damage")

	Timers:CreateTimer(delay, function()
		if not IsValidEntity(enemy) then return end

		enemy:AddNewModifier(caster, self, "modifier_terrorblade_reflection_slow", {
			duration = illusion_duration
		})

		local existing_modifier = enemy:FindModifierByNameAndCaster("modifier_terrorblade_reflection_lua_controller", caster)

		if existing_modifier then
			existing_modifier:SetDuration(illusion_duration, true)
			return
		end

		local illusion = CreateIllusions(
			caster,
			enemy,
			{
				outgoing_damage = illusion_outgoing_damage,
				incoming_damage = -100,
				-- actual lifespan is controlled by _controller modifier, this serves to ensure illusion lives long enough with refresher
				-- without having to somehow adjust it's duration manually
				-- (but still is limited to a sane duration in case controller or anythin adjacent fails)
				duration = illusion_duration * 2,
			},
			1,
			72,
			false,
			true
		)[1]

		illusion:SetControllableByPlayer(caster:GetPlayerOwnerID(), false)

		illusion:AddNewModifier(caster, self, "modifier_terrorblade_reflection_invulnerability", {
			duration = illusion_duration
		})

		enemy:AddNewModifier(caster, self, "modifier_terrorblade_reflection_lua_controller", {
			duration = illusion_duration,
			controlled_illusion = illusion:GetEntityIndex()
		})

		FindClearRandomPositionAroundUnit(illusion, enemy, 108)
	end)
end