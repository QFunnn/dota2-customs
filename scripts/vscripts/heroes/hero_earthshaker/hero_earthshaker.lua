--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_earthshaker_fissure_lua_thinker",
	"heroes/hero_earthshaker/hero_earthshaker",
	LUA_MODIFIER_MOTION_NONE
)

earthshaker_fissure_lua = class({})

function earthshaker_fissure_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	local damage = self:GetSpecialValueFor("AbilityDamage")
	local distance = self:GetSpecialValueFor("AbilityCastRange")
	local duration = self:GetSpecialValueFor("fissure_duration")
	local radius = self:GetSpecialValueFor("fissure_radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	local block_width = 24
	local block_delta = 8.25

	local direction = point - caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()
	local wall_vector = direction * distance

	local block_spacing = (block_delta + 2 * block_width)
	local blocks = distance / block_spacing
	local block_pos = caster:GetHullRadius() + block_delta + block_width
	local start_pos = caster:GetOrigin() + direction * block_pos

	for i = 1, blocks do
		local block_vec = caster:GetOrigin() + direction * block_pos
		local blocker = CreateModifierThinker(
			caster, -- player source
			self, -- ability source
			"modifier_earthshaker_fissure_lua_thinker", -- modifier name
			{ duration = duration }, -- kv
			block_vec,
			caster:GetTeamNumber(),
			true
		)
		blocker:SetHullRadius(block_width)
		block_pos = block_pos + block_spacing
	end

	-- find units in line
	local end_pos = start_pos + wall_vector
	local units = FindUnitsInLine(
		caster:GetTeamNumber(),
		start_pos,
		end_pos,
		-- caster:GetOrigin() + direction*caster:GetHullRadius(),
		-- caster:GetOrigin() + direction*caster:GetHullRadius() + wall_vector,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0
	)

	local damageTable = {
		-- victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_earthshaker_4")
	if talent ~= nil and talent:GetLevel() > 0 then
		local count = 0
		Timers:CreateTimer(0, function()
			count = count + 1
			local sound_cast = "Hero_EarthShaker.Totem.Attack"
			EmitSoundOn(sound_cast, self:GetCaster())
			-- пересканируем линию каждый тик, чтобы зашедшие позже крипы тоже получали урон
			local tick_units = FindUnitsInLine(
				caster:GetTeamNumber(),
				start_pos,
				end_pos,
				nil,
				radius,
				DOTA_UNIT_TARGET_TEAM_BOTH,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				0
			)
			for _, unit in pairs(tick_units) do
				FindClearSpaceForUnit(unit, unit:GetOrigin(), true)
				if unit:GetTeamNumber() ~= caster:GetTeamNumber() then
					damageTable.victim = unit
					ApplyDamage(damageTable)

					unit:AddNewModifier(
						caster, -- player source
						self, -- ability source
						"modifier_stunned", -- modifier name
						{ duration = stun_duration } -- kv
					)
				end
			end
			self:PlayEffects(start_pos, end_pos, duration)
			if count < 3 then
				return 1
			else
				return nil
			end
		end)
	else
		for _, unit in pairs(units) do
			FindClearSpaceForUnit(unit, unit:GetOrigin(), true)

			if unit:GetTeamNumber() ~= caster:GetTeamNumber() then
				damageTable.victim = unit
				ApplyDamage(damageTable)

				unit:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_stunned", -- modifier name
					{ duration = stun_duration } -- kv
				)
			end
		end
		self:PlayEffects(start_pos, end_pos, duration)
	end
end

function earthshaker_fissure_lua:PlayEffects(start_pos, end_pos, duration)
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf"
	local sound_cast = "Hero_EarthShaker.Fissure"

	local caster = self:GetCaster()

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, start_pos)
	ParticleManager:SetParticleControl(effect_cast, 1, end_pos)
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(duration, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	-- Create Sound
	-- EmitSoundOnLocationWithCaster( start_pos, sound_cast, caster )
	EmitSoundOn(sound_cast, caster)
	-- EmitSoundOnLocationWithCaster( end_pos, sound_cast, caster )
	EmitSoundOn(sound_cast, caster)
end

--------------------------------------------------------------------------------

modifier_earthshaker_fissure_lua_thinker = class({})

function modifier_earthshaker_fissure_lua_thinker:IsHidden()
	return true
end

function modifier_earthshaker_fissure_lua_thinker:IsPurgable()
	return false
end

function modifier_earthshaker_fissure_lua_thinker:OnCreated(kv) end

function modifier_earthshaker_fissure_lua_thinker:OnRefresh(kv) end

function modifier_earthshaker_fissure_lua_thinker:OnDestroy(kv)
	if IsServer() then
		local sound_cast = "Hero_EarthShaker.FissureDestroy"
		-- EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
		EmitSoundOn(sound_cast, self:GetCaster())
		UTIL_Remove(self:GetParent())
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_earthshaker_enchant_totem_lua",
	"heroes/hero_earthshaker/hero_earthshaker",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_generic_arc_lua", "heroes/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH)

earthshaker_enchant_totem_lua = class({})

function earthshaker_enchant_totem_lua:HasFixedCooldownTalent()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_earthshaker_6")
	return talent ~= nil and talent:GetLevel() > 0
end

function earthshaker_enchant_totem_lua:GetCooldown(level)
	if self:HasFixedCooldownTalent() then
		return 1.0 * (1 / self:GetCaster():GetCooldownReduction())
	end

	return self.BaseClass.GetCooldown(self, level)
end

function earthshaker_enchant_totem_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetDuration()

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_earthshaker_enchant_totem_lua", -- modifier name
		{ duration = duration } -- kv
	)

	local sound_cast = "Hero_EarthShaker.Totem"
	EmitSoundOn(sound_cast, caster)

	if self:HasFixedCooldownTalent() then
		self:EndCooldown()
		self:StartCooldown(1.0)
	end
end

--------------------------------------------------------------------------------

modifier_earthshaker_enchant_totem_lua = class({})

function modifier_earthshaker_enchant_totem_lua:IsHidden()
	return false
end

function modifier_earthshaker_enchant_totem_lua:IsDebuff()
	return false
end

function modifier_earthshaker_enchant_totem_lua:IsPurgable()
	return true
end

function modifier_earthshaker_enchant_totem_lua:OnCreated(kv)
	self.bonus = self:GetAbility():GetSpecialValueFor("totem_damage_percentage") -- special value
	self.range = self:GetAbility():GetSpecialValueFor("bonus_attack_range") -- special value
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_earthshaker_enchant_totem_lua:OnRefresh(kv)
	self.bonus = self:GetAbility():GetSpecialValueFor("totem_damage_percentage") -- special value
	self.range = self:GetAbility():GetSpecialValueFor("bonus_attack_range") -- special value
end

function modifier_earthshaker_enchant_totem_lua:OnDestroy(kv) end

function modifier_earthshaker_enchant_totem_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
	return funcs
end

function modifier_earthshaker_enchant_totem_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.bonus
end

function modifier_earthshaker_enchant_totem_lua:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		local sound_cast = "Hero_EarthShaker.Totem.Attack"
		EmitSoundOn(sound_cast, params.target)
		local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_earthshaker_7")
		if talent ~= nil and talent:GetLevel() > 0 then
			if
				params.attacker == self:GetParent()
				and (not self:GetParent():IsIllusion())
				and not self:GetParent():PassivesDisabled()
			then
				if params.target ~= nil and params.target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
					DoCleaveAttack(
						self:GetParent(),
						params.target,
						self:GetAbility(),
						params.damage,
						360,
						150,
						360,
						"particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf"
					)
				end
			end
		end
		self:Destroy()
	end
end

function modifier_earthshaker_enchant_totem_lua:GetModifierAttackRangeBonus()
	return self.range
end

function modifier_earthshaker_enchant_totem_lua:CheckState()
	local state = {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}

	return state
end

function modifier_earthshaker_enchant_totem_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_totem_buff.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT_FOLLOW, self:GetParent())

	local attach = "attach_attack1"
	if self:GetCaster():ScriptLookupAttachment("attach_totem") ~= 0 then
		attach = "attach_totem"
	end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(effect_cast, false, false, -1, false, false)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_earthshaker_aftershock_lua",
	"heroes/hero_earthshaker/hero_earthshaker",
	LUA_MODIFIER_MOTION_NONE
)

earthshaker_aftershock_lua = class({})

function earthshaker_aftershock_lua:GetIntrinsicModifierName()
	return "modifier_earthshaker_aftershock_lua"
end

--------------------------------------------------------------------------------

modifier_earthshaker_aftershock_lua = class({})

function modifier_earthshaker_aftershock_lua:IsHidden()
	return true
end

function modifier_earthshaker_aftershock_lua:IsPurgable()
	return false
end

function modifier_earthshaker_aftershock_lua:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("aftershock_range") -- special value

	if IsServer() then
		local damage = self:GetAbility():GetSpecialValueFor("AbilityDamage")
		self.duration = self:GetAbility():GetDuration() -- special value

		self.damageTable = {
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}
	end
end

function modifier_earthshaker_aftershock_lua:OnRefresh(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("aftershock_range") -- special value

	if IsServer() then
		local damage = self:GetAbility():GetSpecialValueFor("AbilityDamage")
		self.duration = self:GetAbility():GetDuration() -- special value

		self.damageTable.damage = damage
	end
end

function modifier_earthshaker_aftershock_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

local ignoredAbilityNames = {
	["techies_focused_detonate_lua"] = true,
	["ability_capture_lua"] = true,
	["new_year_snowball"] = true,
}

function modifier_earthshaker_aftershock_lua:OnAbilityFullyCast(params)
	if IsServer() then
		if
			params.unit ~= self:GetParent()
			or params.ability:IsItem()
			or ignoredAbilityNames[params.ability:GetName()]
		then
			return
		end

		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(), -- int, your team number
			self:GetCaster():GetOrigin(), -- point, center point
			self:GetCaster(), -- handle, cacheUnit. (not known)
			self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
			0, -- int, flag filter
			0, -- int, order filter
			false -- bool, can grow cache
		)

		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"modifier_stunned", -- modifier name
				{ duration = self.duration * (1 - enemy:GetStatusResistance()) }
			)

			self.damageTable.victim = enemy
			ApplyDamage(self.damageTable)
		end
		self:PlayEffects()
	end
end

function modifier_earthshaker_aftershock_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_aftershock.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

earthshaker_echo_slam_lua = class({})

function earthshaker_echo_slam_lua:OnSpellStart()
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("AbilityDamage")
	local damage_range = self:GetSpecialValueFor("echo_slam_damage_range")

	local range = self:GetSpecialValueFor("range")
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_earthshaker_5")

	local projectile_name = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam.vpcf"
	local projectile_speed = 600

	local info = {
		-- Target = target,
		-- Source = caster,
		Ability = self,

		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true, -- Optional

		-- vSourceLoc = caster:GetAbsOrigin(),                -- Optional (HOW)
		bReplaceExisting = false, -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)

	-- find echoing units
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(), -- int, your team number
		caster:GetOrigin(), -- point, center point
		caster, -- handle, cacheUnit. (not known)
		range, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	-- if no unit, echo slam?
	if #enemies < 1 then
		self:PlayEffects(0)
		return
	end

	local echoes = 0
	for _, enemy in pairs(enemies) do
		-- initial damage (deprecated)
		if not enemy:IsMagicImmune() then
			local damageTable = {
				victim = enemy,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self, --Optional.
			}
			ApplyDamage(damageTable)

			if talent ~= nil and talent:GetLevel() > 0 then
				enemy:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_stunned", -- modifier name
					{ duration = 3 } -- kv
				)
			end
		end

		-- Find echoed units
		local targets = FindUnitsInRadius(
			caster:GetTeamNumber(), -- int, your team number
			enemy:GetOrigin(), -- point, center point
			enemy, -- handle, cacheUnit. (not known)
			range, -- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
			FIND_CLOSEST, -- int, order filter
			false -- bool, can grow cache
		)

		-- echo to enemies other than self
		for _, target in pairs(targets) do
			if target ~= enemy then
				info.Target = target
				info.Source = enemy
				ProjectileManager:CreateTrackingProjectile(info)
				echoes = echoes + 1

				-- twice if real heroes
				if enemy:IsRealHero() then
					ProjectileManager:CreateTrackingProjectile(info)
					echoes = echoes + 1
				end
			end
		end
	end

	-- effects
	self:PlayEffects(echoes)
end

function earthshaker_echo_slam_lua:OnProjectileHit(target, location)
	local damage = self:GetSpecialValueFor("echo_slam_echo_damage")
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

function earthshaker_echo_slam_lua:PlayEffects(echoes)
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf"
	local sound_cast = "Hero_EarthShaker.EchoSlam"

	if echoes < 1 then
		sound_cast = "Hero_EarthShaker.EchoSlamSmall"
	end

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(echoes, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
end