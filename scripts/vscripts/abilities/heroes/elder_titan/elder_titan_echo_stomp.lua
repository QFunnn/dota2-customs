--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


elder_titan_echo_stomp_lua = class({})

function elder_titan_echo_stomp_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_cast_combined.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_physical.vpcf", context )
end

function elder_titan_echo_stomp_lua:GetAbilityTextureName()
	if self:GetCaster():GetUnitName() == "npc_dota_elder_titan_ancestral_spirit" then
		return "elder_titan_echo_stomp_spirit"
	end
	return "elder_titan_echo_stomp"
end

function elder_titan_echo_stomp_lua:GetBehavior()
	if self:GetCaster():HasShard() then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_AUTOCAST
	end

	return self.BaseClass.GetBehavior(self)
end

function elder_titan_echo_stomp_lua:OnAbilityPhaseStart()
	if not IsServer() then return end

	self.caster = self:GetCaster()
	if not self.caster or self.caster:IsNull() then return end

	self.owner = self.caster
	if self.caster:GetUnitName() == "npc_dota_elder_titan_ancestral_spirit" then
		self.owner = self.caster:GetOwner()
		self.ancestral_spirit = self.caster
	end
	if not self.owner or self.owner:IsNull() then return end

	-- since both the spirit and the hero have the same spell then we decide if the hero or spirit cast
	local echo_stomp = self.owner:FindAbilityByName(self:GetAbilityName())
	if self.caster == self.ancestral_spirit and not self.ancestral_spirit.is_hidden then
		if echo_stomp and not echo_stomp:IsNull() and not echo_stomp:IsInAbilityPhase() then
			if echo_stomp:IsFullyCastable() then	-- if the hero is disabled from casting, do nothing
				self.owner:CastAbilityNoTarget(echo_stomp, self.owner:GetPlayerOwnerID())
			else
				return false
			end
		end
		return true
	end

	-- Fetch the spirit
	-- if the hero casts then tell the spirit to cast as well
	local ancestral_spirit_ability = self.caster:FindAbilityByName("elder_titan_ancestral_spirit_lua")
	if ancestral_spirit_ability and not ancestral_spirit_ability:IsNull() then
		self.ancestral_spirit = ancestral_spirit_ability:GetAncestralSpirit()		-- does not exist if the caster is the spirit itself
		if self.ancestral_spirit and not self.ancestral_spirit:IsNull() and IsValidEntity(self.ancestral_spirit) and not self.ancestral_spirit.is_hidden then
			local ancestral_spirit_echo_stomp = self.ancestral_spirit:FindAbilityByName(self:GetAbilityName())
			if ancestral_spirit_echo_stomp and not ancestral_spirit_echo_stomp:IsNull() and not ancestral_spirit_echo_stomp:IsInAbilityPhase() then
				-- sometimes spirit does not cast so we need a timer smh
				Timers:CreateTimer(0.01, function()
					if self and self.ancestral_spirit and IsValidEntity(self.ancestral_spirit) and ancestral_spirit_echo_stomp then
						self.ancestral_spirit:RemoveGesture(ACT_DOTA_FLAIL)
						self.ancestral_spirit:CastAbilityNoTarget(ancestral_spirit_echo_stomp, self.ancestral_spirit:GetPlayerOwnerID())
					end
				end)
			end
			return true
		end
	end

	-- Combined particle only if ancestral spirit not cast
	local particle_cast = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_cast_combined.vpcf", self.caster)
	self.particle_echo_stomp_cast_combined = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster)
	return true
end

function elder_titan_echo_stomp_lua:OnAbilityPhaseInterrupted()
	if not IsServer() then return end
	if not self.caster or self.caster:IsNull() then return end
	if not self.owner or self.owner:IsNull() then return end
	self.caster:FadeGesture(ACT_DOTA_CAST_ABILITY_1)

	if self.particle_echo_stomp_cast_combined then
		ParticleManager:DestroyParticle(self.particle_echo_stomp_cast_combined, true)
		ParticleManager:ReleaseParticleIndex(self.particle_echo_stomp_cast_combined)
		self.particle_echo_stomp_cast_combined = nil
	end

	if self.caster == self.ancestral_spirit then
		self.owner:Interrupt()
		return
	else
		if self.ancestral_spirit and not self.ancestral_spirit:IsNull() and IsValidEntity(self.ancestral_spirit) then -- if caster is not a spirit, but a spirit exists
			self.ancestral_spirit:Interrupt()
		end
	end
end

function elder_titan_echo_stomp_lua:OnSpellStart()
	if not IsServer() then return end

	-- precache owner stuff because kvs are changed only for the owner and not the spirit
	local owner_echo_stomp = self.owner:FindAbilityByName("elder_titan_echo_stomp_lua")
	self.radius = owner_echo_stomp:GetSpecialValueFor("radius") or 0
	self.sleep_duration = owner_echo_stomp:GetSpecialValueFor("sleep_duration") or 0
	local stomp_damage = owner_echo_stomp:GetSpecialValueFor("stomp_damage") or 0

	self.damage_table = {
		attacker 		= self.owner,
		ability 		= self,
		damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
		damage 			= stomp_damage,
	}

	EmitSoundOn("Hero_ElderTitan.EchoStomp.Channel", self.caster)
end

function elder_titan_echo_stomp_lua:OnChannelFinish(interrupted)
	if not IsServer() then return end
	if not self.caster or self.caster:IsNull() then return end

	if self.particle_echo_stomp_cast_combined then
		ParticleManager:DestroyParticle(self.particle_echo_stomp_cast_combined, true)
		ParticleManager:ReleaseParticleIndex(self.particle_echo_stomp_cast_combined)
		self.particle_echo_stomp_cast_combined = nil
	end

	if self.caster == self.ancestral_spirit then
		self:EndCooldown()
		self:RefundManaCost()

		if interrupted then
			self.owner:Interrupt()
			return
		end
	elseif interrupted then
		if self.ancestral_spirit and not self.ancestral_spirit:IsNull() and IsValidEntity(self.ancestral_spirit) then -- if caster is not a spirit, but a spirit exists
			self.ancestral_spirit:Interrupt()
		end
		return
	end

	if self.caster and self and IsValidEntity(self.caster) and IsValidEntity(self) then

		EmitSoundOn("Hero_ElderTitan.EchoStomp", self.caster)

		local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), self.caster:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

		for _, enemy in pairs(enemies) do
			-- split the damage into physical and magical components
			-- since both the spirit and the hero have the same spell then we decide if the hero casts both or if it is split among them
			local owner_echo_stomp = self	-- apply the owner's kvs to the vanilla echo stomp modifier
			self.damage_table.victim = enemy
			if self.caster == self.ancestral_spirit then
				owner_echo_stomp = self.owner:FindAbilityByName("elder_titan_echo_stomp_lua")
				-- spirit only casts magical dmg
				self.damage_table.damage_type = DAMAGE_TYPE_MAGICAL
				ApplyDamage(self.damage_table)
			else
				-- heroes cast both only if spirit does not exist
				self.damage_table.damage_type = DAMAGE_TYPE_PHYSICAL
				ApplyDamage(self.damage_table)
				if not self.ancestral_spirit then
					self.damage_table.damage_type = DAMAGE_TYPE_MAGICAL
					ApplyDamage(self.damage_table)
				end
			end

			enemy:AddNewModifier(self.caster, owner_echo_stomp, "modifier_elder_titan_echo_stomp", {duration = self.sleep_duration * (1 - enemy:GetStatusResistance())})
		end

		-- Particles
		-- Magical component, always goes off on the spirit; goes off on the hero only if spirit does not exist
		if (self.caster == self.ancestral_spirit) or (self.caster ~= self.ancestral_spirit and not self.ancestral_spirit) then
			local particle_cast = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf", self.caster)
			local particle_magical_stomp_fx = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self.caster)
			ParticleManager:SetParticleControl(particle_magical_stomp_fx, 1, Vector(self.radius, 1, 1))
			ParticleManager:SetParticleControl(particle_magical_stomp_fx, 2, self.caster:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(particle_magical_stomp_fx)
		end

		if self.caster ~= self.ancestral_spirit then
			-- Particles
			-- Physical component only goes off on the hero
			local particle_cast = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_physical.vpcf", self.caster)
			local particle_physical_stomp_fx = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN, self.caster)
			ParticleManager:SetParticleControl(particle_physical_stomp_fx, 0, self.caster:GetAbsOrigin())
			ParticleManager:SetParticleControl(particle_physical_stomp_fx, 1, Vector(self.radius, 1, 1))
			ParticleManager:SetParticleControl(particle_physical_stomp_fx, 2, self.caster:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(particle_physical_stomp_fx)
		end
	end

	-- Shard effect, depending on which echo stomp is first, the other one moves the hero to the spirit, ensuring that both echo stomps are fully cast
	if self.caster == self.owner then
		if not self.caster:HasShard() then return end
		if not self:GetAutoCastState() then return end
		if not self.ancestral_spirit or self.ancestral_spirit:IsNull() or not IsValidEntity(self.ancestral_spirit) then return end

		local ancestral_spirit_echo_stomp = self.ancestral_spirit:FindAbilityByName("elder_titan_echo_stomp_lua")
		if not ancestral_spirit_echo_stomp or ancestral_spirit_echo_stomp:IsNull() then return end
		if ancestral_spirit_echo_stomp:IsInAbilityPhase() or ancestral_spirit_echo_stomp:IsChanneling() then return end

		self.caster:SetOrigin(self.ancestral_spirit:GetAbsOrigin())
		FindClearSpaceForUnit(self.caster, self.caster:GetAbsOrigin(), true)
	end

	if self.caster == self.ancestral_spirit then
		if not self.owner:HasShard() then return end

		local echo_stomp = self.owner:FindAbilityByName("elder_titan_echo_stomp_lua")
		if not echo_stomp or echo_stomp:IsNull() then return end
		if not echo_stomp:GetAutoCastState() then return end
		if echo_stomp:IsInAbilityPhase() or echo_stomp:IsChanneling() then return end

		self.owner:SetOrigin(self.ancestral_spirit:GetAbsOrigin())
		FindClearSpaceForUnit(self.owner, self.owner:GetAbsOrigin(), true)
	end
end