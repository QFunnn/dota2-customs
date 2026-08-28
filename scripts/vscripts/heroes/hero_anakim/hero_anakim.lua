--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_shadow_fiend_anakim_pulse_lua", "heroes/hero_anakim/hero_anakim", LUA_MODIFIER_MOTION_NONE)

anakim_pulse = class({})

function anakim_pulse:Precache(context)
	PrecacheResource("particle", "particles/anakim/anakim_pulse.vpcf", context)
end

function anakim_pulse:OnSpellStart()
	local caster = self:GetCaster()
	local distance = self:GetSpecialValueFor("range")
	local count = self:GetSpecialValueFor("count")
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")
	local delay = self:GetSpecialValueFor("delay")

	local start_position = caster:GetAbsOrigin()
	local right_vector = caster:GetRightVector()
	local forward = caster:GetForwardVector():Normalized()
	local step = distance / count

	local pulse = 0
	Timers:CreateTimer(0, function()
		if pulse < count then
			pulse = pulse + 1
			local point = (start_position + forward * (step * pulse)) + right_vector * RandomInt(-100, 100)
			point.z = GetGroundHeight(point, nil)

			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				point,
				nil,
				radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)

			for _, enemy in pairs(enemies) do
				ApplyDamage({
					victim = enemy,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self,
				})
			end

			-- Вызываем эффекты без передачи юнита
			self:PlayEffects(point)

			return delay
		else
			return nil
		end
	end)
end

function anakim_pulse:PlayEffects(position)
	local effect_cast = ParticleManager:CreateParticle("particles/anakim/anakim_pulse.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, position)
	ParticleManager:SetParticleControl(effect_cast, 1, position)
	ParticleManager:SetParticleControl(effect_cast, 5, position)
	ParticleManager:SetParticleControl(effect_cast, 6, position)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Hero_Luna.LucentBeam.Target"
	-- EmitSoundOnLocationWithCaster(position, sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------------------

LinkLuaModifier("modifier_anakim_chaos", "heroes/hero_anakim/hero_anakim", LUA_MODIFIER_MOTION_NONE)

anakim_chaos = class({})

function anakim_chaos:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function anakim_chaos:Precache(context)
	PrecacheResource("particle", "particles/anakim/anakim_chaos.vpcf", context)
end

function anakim_chaos:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_anakim_chaos", { duration = duration })
	end
	self:PlayEffects(point)
end

function anakim_chaos:PlayEffects(point)
	local radius = self:GetSpecialValueFor("radius")
	local effect_cast = ParticleManager:CreateParticle("particles/anakim/anakim_chaos.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	self:GetCaster():EmitSound("DOTA_Item.VeilofDiscord.Activate")
end

----------------------------------------------------------------------------

modifier_anakim_chaos = class({})

function modifier_anakim_chaos:IsDebuff()
	return true
end
function modifier_anakim_chaos:IsHidden()
	return false
end
function modifier_anakim_chaos:IsPurgable()
	return false
end

function modifier_anakim_chaos:OnCreated()
	if not IsServer() then
		return
	end
	self.spell_amp = self:GetAbility():GetSpecialValueFor("spell_amp")
end

function modifier_anakim_chaos:CheckState()
	local state = {
		[MODIFIER_STATE_BLIND] = true,
	}
	return state
end

function modifier_anakim_chaos:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_anakim_chaos:GetModifierIncomingDamage_Percentage(keys)
	if keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL and keys.attacker == self:GetCaster() then
		return self.spell_amp
	end
end

----------------------------------------------------------------------------
----------------------------------------------------------------------------

LinkLuaModifier("modifier_anakim_wisp", "heroes/hero_anakim/hero_anakim", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_anakim_wisp_handler", "heroes/hero_anakim/hero_anakim", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_anakim_wisp_debuff", "heroes/hero_anakim/hero_anakim", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_anakim_wisp_projectile", "heroes/hero_anakim/hero_anakim", LUA_MODIFIER_MOTION_NONE)

anakim_wisp = class({})

function anakim_wisp:Precache(context)
	PrecacheResource("particle", "particles/anakim/anakim_wisp.vpcf", context)
end

function anakim_wisp:GetIntrinsicModifierName()
	return "modifier_anakim_wisp"
end

function anakim_wisp:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local modifier = caster:FindModifierByName("modifier_anakim_wisp")

	if modifier and #modifier.spirits > 0 then
		local spirits_to_send = modifier.spirits
		modifier.spirits = {}
		modifier:SetStackCount(0)
		modifier.kill_count = 0

		for _, spirit in pairs(spirits_to_send) do
			if spirit and not spirit:IsNull() then
				spirit:AddNewModifier(
					caster,
					self,
					"modifier_anakim_wisp_projectile",
					{ target_entindex = target:entindex() }
				)
			end
		end

		caster:EmitSound("Hero_Wisp.Spirits.Target")
	end
end

----------------------------------------------------------------------------

modifier_anakim_wisp = class({})

function modifier_anakim_wisp:IsHidden()
	return false
end
function modifier_anakim_wisp:IsPurgable()
	return false
end
function modifier_anakim_wisp:RemoveOnDeath()
	return false
end

function modifier_anakim_wisp:OnCreated(kv)
	self:update_talents()
	self.kill_count = 0
	self.spirits = {}

	self:StartIntervalThink(0.03)
	if IsServer() then
		self:SetStackCount(0)
	end
end

function modifier_anakim_wisp:OnRefresh(kv)
	self:update_talents()
end

function modifier_anakim_wisp:update_talents()
	self.soul_ampl = self:GetAbility():GetSpecialValueFor("soul_ampl")
	self.kills = self:GetAbility():GetSpecialValueFor("kills")
	self.max_souls = self:GetAbility():GetSpecialValueFor("max_souls")
end

function modifier_anakim_wisp:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_anakim_wisp:GetModifierSpellAmplify_Percentage()
	return self.soul_ampl * self:GetStackCount()
end

function modifier_anakim_wisp:OnDeath(params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()

	if params.unit == parent then
		self:SetStackCount(0)
		self.kill_count = 0
		for _, spirit in pairs(self.spirits) do
			if spirit and not spirit:IsNull() then
				UTIL_Remove(spirit)
			end
		end
		self.spirits = {}
		return
	end

	if parent:PassivesDisabled() or params.unit:IsIllusion() then
		return
	end
	if not params.unit:FindModifierByNameAndCaster("modifier_anakim_wisp_debuff", parent) then
		return
	end

	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] or parent:HasModifier("modifier_guild_event") then
		return
	end

	self.kill_count = self.kill_count + 1
	if self.kill_count >= self.kills and self:GetStackCount() < self.max_souls then
		self.kill_count = 0
		self:IncrementStackCount()
		self:CreateNewSpirit()
	end
end

function modifier_anakim_wisp:CreateNewSpirit()
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return
	end

	local newSpirit =
		CreateUnitByName("npc_spitit_wisp", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeam())
	newSpirit:AddNewModifier(caster, self:GetAbility(), "modifier_anakim_wisp_handler", {})

	local pfx = ParticleManager:CreateParticle("particles/anakim/anakim_wisp.vpcf", PATTACH_ABSORIGIN_FOLLOW, newSpirit)
	newSpirit.spirit_pfx_silence = pfx

	Timers:CreateTimer(1.0, function()
		table.insert(self.spirits, newSpirit)
		return nil
	end)
end

function modifier_anakim_wisp:OnIntervalThink()
	if IsServer() then
		local caster = self:GetCaster()
		if caster:IsAlive() then
			self:RearrangeSpirits()
		end
	end
end

function modifier_anakim_wisp:RearrangeSpirits()
	local count = #self.spirits
	if count == 0 then
		return
	end

	local caster = self:GetCaster()
	local radius = 120
	local angle_step = 30
	local height = 140
	local backward = -caster:GetForwardVector()
	local total_arc = (count - 1) * angle_step
	local start_angle = -total_arc / 2

	for i, spirit in ipairs(self.spirits) do
		if spirit and not spirit:IsNull() and spirit:IsAlive() then
			local rotation = QAngle(0, start_angle + (i - 1) * angle_step, 0)
			local offset = RotatePosition(Vector(0, 0, 0), rotation, backward * radius)
			local targetPos = caster:GetAbsOrigin() + offset
			targetPos.z = targetPos.z + height
			spirit:SetAbsOrigin(targetPos)
		end
	end
end

function modifier_anakim_wisp:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end
function modifier_anakim_wisp:GetModifierAura()
	return "modifier_anakim_wisp_debuff"
end
function modifier_anakim_wisp:GetAuraRadius()
	return 800
end
function modifier_anakim_wisp:GetAuraDuration()
	return 0.5
end
function modifier_anakim_wisp:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_anakim_wisp:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end
function modifier_anakim_wisp:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
function modifier_anakim_wisp:IsAuraActiveOnDeath()
	return false
end
function modifier_anakim_wisp:GetAuraEntityReject(hEntity)
	return hEntity == self:GetCaster()
end

-----------------------------------------------------------------------------------------

modifier_anakim_wisp_debuff = class({})
function modifier_anakim_wisp_debuff:IsHidden()
	return true
end
function modifier_anakim_wisp_debuff:IsPurgable()
	return false
end

-----------------------------------------------------------------------------------------

modifier_anakim_wisp_handler = class({})
function modifier_anakim_wisp_handler:CheckState()
	return {
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING] = true,
	}
end

function modifier_anakim_wisp_handler:OnRemoved()
	if IsServer() then
		local spirit = self:GetParent()
		if spirit.spirit_pfx_silence then
			ParticleManager:DestroyParticle(spirit.spirit_pfx_silence, true)
		end
		UTIL_Remove(spirit)
	end
end

-----------------------------------------------------------------------------------------

modifier_anakim_wisp_projectile = class({})

function modifier_anakim_wisp_projectile:IsHidden()
	return true
end

function modifier_anakim_wisp_projectile:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.target = EntIndexToHScript(kv.target_entindex)
	self.speed = 1300
	self:StartIntervalThink(0.03)
end

function modifier_anakim_wisp_projectile:OnIntervalThink()
	local parent = self:GetParent()
	if not self.target or self.target:IsNull() or not self.target:IsAlive() then
		UTIL_Remove(parent)
		self:Destroy()
		return
	end

	local current_pos = parent:GetAbsOrigin()
	local target_pos = self.target:GetAbsOrigin() + Vector(0, 0, 100)
	local diff = target_pos - current_pos
	local direction = diff:Normalized()
	local distance = diff:Length2D()

	if distance < 60 then
		self:Hit()
	else
		parent:SetAbsOrigin(current_pos + direction * (self.speed * 0.03))
	end
end

function modifier_anakim_wisp_projectile:Hit()
	local caster = self:GetCaster()
	local target = self.target

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = self:GetAbility():GetSpecialValueFor("soul_damage"),
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})

	target:EmitSound("Hero_Wisp.Spirits.Target")
	UTIL_Remove(self:GetParent())
	self:Destroy()
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

LinkLuaModifier("modifier_anakim_final_sacrifice", "heroes/hero_anakim/hero_anakim", LUA_MODIFIER_MOTION_NONE)

anakim_final_sacrifice = class({})

function anakim_final_sacrifice:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf", context)
end

function anakim_final_sacrifice:GetIntrinsicModifierName()
	return "modifier_anakim_final_sacrifice"
end

--------------------------------------------------------------------------------

modifier_anakim_final_sacrifice = class({})

function modifier_anakim_final_sacrifice:IsHidden()
	return false
end
function modifier_anakim_final_sacrifice:IsPurgable()
	return false
end

function modifier_anakim_final_sacrifice:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_anakim_final_sacrifice:GetMinHealth()
	if self:GetAbility():IsCooldownReady() and not self:GetCaster():IsIllusion() then
		return 1
	end
	return 0
end

function modifier_anakim_final_sacrifice:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_anakim_final_sacrifice:OnTakeDamage(params)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local ability = self:GetAbility()

	if params.unit ~= parent then
		return
	end
	if parent:PassivesDisabled() then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end

	if parent:GetHealth() <= 1 then
		ability:UseResources(false, false, false, true)
		parent:EmitSound("Hero_Abaddon.AphoticShield.Destroy")
		parent:AddNewModifier(parent, ability, "modifier_invulnerable", { duration = 3 })

		local hero_pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			parent
		)
		ParticleManager:SetParticleControl(hero_pfx, 0, parent:GetAbsOrigin())

		Timers:CreateTimer(3.0, function()
			ParticleManager:DestroyParticle(hero_pfx, false)
			ParticleManager:ReleaseParticleIndex(hero_pfx)
		end)

		local wisp_mod = parent:FindModifierByName("modifier_anakim_wisp")

		if wisp_mod and #wisp_mod.spirits > 0 then
			local count = #wisp_mod.spirits
			local heal_per_wisp = ability:GetSpecialValueFor("heal_per_wisp")

			local total_heal = parent:GetMaxHealth() * (heal_per_wisp * count / 100)

			for _, spirit in pairs(wisp_mod.spirits) do
				if spirit and not spirit:IsNull() then
					UTIL_Remove(spirit)
				end
			end

			wisp_mod.spirits = {}
			wisp_mod:SetStackCount(0)
			wisp_mod.kill_count = 0
			parent:Heal(total_heal, ability)
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

anakim_pulse_line = class({})

function anakim_pulse_line:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_sunray.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/elder_titan/elder_titan_ti7/elder_titan_echo_stomp_cast_combined_detail_ti7.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_physical.vpcf",
		context
	)
end

function anakim_pulse_line:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	self.cast_particle = ParticleManager:CreateParticle(
		"particles/econ/items/elder_titan/elder_titan_ti7/elder_titan_echo_stomp_cast_combined_detail_ti7.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	EmitSoundOn("Hero_ElderTitan.EchoStomp.Channel", caster)
	return true
end

function anakim_pulse_line:OnAbilityPhaseInterrupted()
	if self.cast_particle then
		ParticleManager:DestroyParticle(self.cast_particle, true)
		ParticleManager:ReleaseParticleIndex(self.cast_particle)
	end
	StopSoundOn("Hero_ElderTitan.EchoStomp.Channel", self:GetCaster())
end

function anakim_pulse_line:OnSpellStart()
	local caster = self:GetCaster()
	local cursor_point = self:GetCursorPosition()
	local start_pos = caster:GetAbsOrigin()
	local range = 1200

	local direction = (cursor_point - start_pos):Normalized()
	if cursor_point == start_pos then
		direction = caster:GetForwardVector()
	end
	local target_point = start_pos + direction * range
	target_point.z = start_pos.z

	if self.cast_particle then
		ParticleManager:DestroyParticle(self.cast_particle, false)
		ParticleManager:ReleaseParticleIndex(self.cast_particle)
	end

	local base_damage = self:GetSpecialValueFor("damage")
	local mana_pct = self:GetSpecialValueFor("mana_damage") / 100

	local current_mana = caster:GetMana()
	local max_mana = caster:GetMaxMana()
	local desired_burn = max_mana * mana_pct

	local actual_burned = math.min(current_mana, desired_burn)

	caster:Script_ReduceMana(actual_burned, self)
	local final_damage = base_damage + actual_burned

	local radius_stomp = self:GetSpecialValueFor("radius")
	local particle_stomp_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_physical.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle_stomp_fx, 0, start_pos)
	ParticleManager:SetParticleControl(particle_stomp_fx, 1, Vector(radius_stomp, 1, 1))
	ParticleManager:SetParticleControl(particle_stomp_fx, 2, start_pos)
	ParticleManager:ReleaseParticleIndex(particle_stomp_fx)

	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phoenix/phoenix_sunray.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, start_pos + Vector(0, 0, 100))
	ParticleManager:SetParticleControl(effect_cast, 1, target_point + Vector(0, 0, 100))

	Timers:CreateTimer(0.3, function()
		ParticleManager:DestroyParticle(effect_cast, true)
		ParticleManager:ReleaseParticleIndex(effect_cast)
	end)

	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		start_pos,
		target_point,
		nil,
		radius_stomp,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = final_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	end

	EmitSoundOn("Hero_Phoenix.SunRay.Cast", caster)
	EmitSoundOn("Hero_ElderTitan.EchoStomp", caster)
end