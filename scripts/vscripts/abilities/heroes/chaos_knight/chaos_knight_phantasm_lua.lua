--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


chaos_knight_phantasm_lua = chaos_knight_phantasm_lua or class({})
LinkLuaModifier("modifier_chaos_knight_phantasm_lua_shard", "abilities/heroes/chaos_knight/modifier_chaos_knight_phantasm_lua_shard", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_chaos_knight_phantasm_lua", "abilities/heroes/chaos_knight/modifier_chaos_knight_phantasm_lua", LUA_MODIFIER_MOTION_NONE)


function chaos_knight_phantasm_lua:GetIntrinsicModifierName()
	return "modifier_chaos_knight_phantasm_lua_shard"
end


function chaos_knight_phantasm_lua:OnSpellStart()
	local caster = self:GetCaster()

	local vision_radius = self:GetSpecialValueFor("vision_radius")
	local invulnerability_duration = self:GetSpecialValueFor("invuln_duration")

	local illusion_duration = self:GetSpecialValueFor("illusion_duration")

	local ally_image_count = self:GetSpecialValueFor("ally_image_count")

	AddFOWViewer(caster:GetTeamNumber(), caster:GetAbsOrigin(), vision_radius, invulnerability_duration, false)

	caster:AddNewModifier(caster, self, "modifier_chaos_knight_phantasm_lua", {
		duration = invulnerability_duration
	})

	if ally_image_count <= 0 then return end

	local delay = 0
	local delay_increment = self:GetSpecialValueFor("delay_increment")

	local particle_name = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf", caster)

	-- WARNING: it is generally not advised to use game loop logic inside abilities
	-- as it creates dependency that makes it hard to export this ability somewhere
	-- but it serves great to cut corners in this case!

	for _, hero in pairs(GameLoop.heroes_by_team[caster:GetTeamNumber()] or {}) do
		-- skip caster himself, since that bonus is already accounted
		if caster ~= hero then
			-- stagger illusion creation, split in 2 phases - initial delay, and particle visual delay
			Timers:CreateTimer(delay, function()
				if not IsValidEntity(self) or not IsValidEntity(hero) then return end

				local ally_particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN, hero)
				ParticleManager:SetParticleControl(ally_particle, 0, hero:GetAbsOrigin())

				Timers:CreateTimer(invulnerability_duration, function()
					ParticleManager:DestroyParticle(ally_particle, false)
					ParticleManager:ReleaseParticleIndex(ally_particle)

					if not IsValidEntity(self) or not IsValidEntity(hero) then print("exit 1") return end

					-- hero:EmitSound("Hero_ChaosKnight.Phantasm.Plus")
					hero:Purge(false, true, false, false, false)

					local illusions = self:CreateIllusionsAt(hero, ally_image_count, illusion_duration, true)

					-- vanilla modifier records illusions on it's own, we only need to track scepter illusions
					table.extend(self.illusions, illusions)
				end)
			end)


			delay = delay + delay_increment
		end
	end
end


function chaos_knight_phantasm_lua:CreateIllusionsAt(source, illusion_count, illusion_duration, place_at_source)
	local caster = self:GetCaster()

	local outgoing_damage = self:GetSpecialValueFor("outgoing_damage")
	local incoming_damage = self:GetSpecialValueFor("incoming_damage")

	local illusions = CreateIllusions(
		caster,
		source,
		{
			outgoing_damage = outgoing_damage,
			incoming_damage = incoming_damage,
			duration = illusion_duration,
		},
		illusion_count,
		128,
		false,
		true
	)

	for _, illusion in pairs(illusions or {}) do
		if IsValidEntity(illusion) then
			illusion:AddNewModifier(caster, self, "modifier_chaos_knight_phantasm_illusion", {
				duration = illusion_duration
			})

			if place_at_source then
				FindClearRandomPositionAroundUnit(illusion, source, 150)
			end
		end
	end

	return illusions
end