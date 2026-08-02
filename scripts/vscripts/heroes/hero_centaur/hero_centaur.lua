--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


centaur_warrunner_hoof_stomp_lua = class({})

function centaur_warrunner_hoof_stomp_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context)
end

function centaur_warrunner_hoof_stomp_lua:OnSpellStart()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("stomp_damage")
	local duration = self:GetSpecialValueFor("stun_duration")

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	local damageTable = {
		victim = nil,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}

	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
		enemy:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_stunned",
			{ duration = duration * (1 - enemy:GetStatusResistance()) }
		)
	end
	self:PlayEffects()
end

function centaur_warrunner_hoof_stomp_lua:PlayEffects()
	local radius = self:GetSpecialValueFor("radius")
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_centaur/centaur_warstomp.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hoof_L",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hoof_R",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Hero_Centaur.HoofStomp"
	-- EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------
--------------------------------------------------------------
--------------------------------------------------------------
LinkLuaModifier("modifier_return_aura", "heroes/hero_centaur/hero_centaur", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_return_passive", "heroes/hero_centaur/hero_centaur", LUA_MODIFIER_MOTION_NONE)

centaur_return_lua = class({})

function centaur_return_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_return.vpcf", context)
end

function centaur_return_lua:GetCastRange(location, target)
	local abil = self:GetCaster():FindAbilityByName("special_bonus_unique_centaur_lua_8")
	if abil ~= nil and abil:GetLevel() > 0 then
		return 700 - self:GetCaster():GetCastRangeBonus()
	end
	return 0
end

function centaur_return_lua:GetIntrinsicModifierName()
	return "modifier_return_aura"
end

------------------------------------------------

modifier_return_aura = class({})

function modifier_return_aura:OnCreated() end

function modifier_return_aura:GetAuraEntityReject(target)
	if self:GetCaster() == target then
		return false
	else
		local abil = self:GetCaster():FindAbilityByName("special_bonus_unique_centaur_lua_8")
		if abil ~= nil and abil:GetLevel() > 0 then
			return false
		end
	end
	return true
end

function modifier_return_aura:GetAuraRadius()
	return 700
end

function modifier_return_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_return_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_return_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_return_aura:GetModifierAura()
	return "modifier_return_passive"
end

function modifier_return_aura:IsAura()
	return true
end

function modifier_return_aura:IsHidden()
	return true
end

function modifier_return_aura:IsPurgable()
	return false
end

----------------------------------------------------

modifier_return_passive = class({})

function modifier_return_passive:IsHidden()
	return false
end

function modifier_return_passive:IsPurgable()
	return false
end

function modifier_return_passive:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_return_passive:OnTakeDamage(keys)
	if IsServer() and self:GetAbility() then
		local caster = self:GetCaster()
		local parent = self:GetParent()
		local attacker = keys.attacker
		local target = keys.unit

		if not target:IsRealHero() then
			return nil
		end
		if parent:PassivesDisabled() then
			return nil
		end

		local damage = self:GetAbility():GetSpecialValueFor("damage")
		local str_damage = self:GetAbility():GetSpecialValueFor("str_damage")

		if
			attacker
			and attacker:GetTeamNumber() ~= parent:GetTeamNumber()
			and parent == target
			and not attacker:IsOther()
			and attacker:GetName() ~= "npc_dota_unit_undying_zombie"
			and not attacker:IsBuilding()
		then
			if keys.damage_category == 1 then
				local particle_return_fx = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_centaur/centaur_return.vpcf",
					PATTACH_ABSORIGIN,
					parent
				)
				ParticleManager:SetParticleControlEnt(
					particle_return_fx,
					0,
					parent,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					parent:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(
					particle_return_fx,
					1,
					attacker,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					attacker:GetAbsOrigin(),
					true
				)
				ParticleManager:ReleaseParticleIndex(particle_return_fx)

				damage = damage + (self:GetParent():GetStrength() * str_damage / 100)

				ApplyDamage({
					victim = attacker,
					attacker = parent,
					damage = damage,
					damage_type = DAMAGE_TYPE_PHYSICAL,
					damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
					ability = self:GetAbility(),
				})
			end
		end
	end
end

---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

LinkLuaModifier("modifier_centaur_repel_lua", "heroes/hero_centaur/hero_centaur", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_centaur_repel_lua_disarm", "heroes/hero_centaur/hero_centaur", LUA_MODIFIER_MOTION_NONE)

centaur_repel_lua = class({})

function centaur_repel_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_repel_cast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", context)
end

function centaur_repel_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	caster:AddNewModifier(caster, self, "modifier_centaur_repel_lua", { duration = duration })
	self:PlayEffects()
end

function centaur_repel_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_omniknight/omniknight_repel_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

------------------------------------------------------------------

modifier_centaur_repel_lua = class({})

function modifier_centaur_repel_lua:IsHidden()
	return false
end

function modifier_centaur_repel_lua:IsDebuff()
	return false
end

function modifier_centaur_repel_lua:IsPurgable()
	return false
end

function modifier_centaur_repel_lua:OnCreated(kv)
	if IsServer() then
		self.sound_cast = "Hero_omniknight.Repel"
		EmitSoundOn(self.sound_cast, self:GetParent())
		self.particle_1 = "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf"

		self.buff_particles =
			ParticleManager:CreateParticle(self.particle_1, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:SetParticleControlEnt(
			self.buff_particles,
			1,
			self:GetCaster(),
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			Vector(0, 0, 10),
			false
		) --origin
		self:AddParticle(self.buff_particles, false, false, -1, true, false)
	end
end

function modifier_centaur_repel_lua:OnDestroy(kv)
	if not IsServer() then
		return
	end

	StopSoundOn(self.sound_cast, self:GetParent())
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_centaur_lua_6")
	if talent ~= nil and talent:GetLevel() > 0 then
		local ability = self:GetCaster():FindAbilityByName("centaur_warrunner_hoof_stomp_lua")
		if ability ~= nil and ability:GetLevel() > 0 then
			ability:OnSpellStart()
		end
	end
end

function modifier_centaur_repel_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

function modifier_centaur_repel_lua:OnTakeDamage(keys)
	if IsServer() and self:GetAbility() then
		local caster = self:GetCaster()
		local parent = self:GetParent()
		local attacker = keys.attacker
		local target = keys.unit

		if not target:IsRealHero() then
			return nil
		end

		if
			attacker
			and attacker:GetTeamNumber() ~= parent:GetTeamNumber()
			and parent == target
			and not attacker:IsOther()
			and attacker:GetName() ~= "npc_dota_unit_undying_zombie"
			and not attacker:IsBuilding()
		then
			if keys.damage_category == 1 then
				parent:Heal(keys.damage, parent)
			end
		end
	end
end

function modifier_centaur_repel_lua:IsAura()
	if self:GetCaster() == self:GetParent() then
		if not self:GetCaster():PassivesDisabled() then
			return true
		end
	end
	return false
end

function modifier_centaur_repel_lua:GetModifierAura()
	return "modifier_centaur_repel_lua_disarm"
end

function modifier_centaur_repel_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_centaur_repel_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_centaur_repel_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS
end

function modifier_centaur_repel_lua:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end

-- function modifier_centaur_repel_lua:GetAuraEntityReject(target)
-- return target ~= self:GetCaster()
-- end

-------------------------------------------------------

modifier_centaur_repel_lua_disarm = class({})

function modifier_centaur_repel_lua_disarm:IsHidden()
	return false
end

function modifier_centaur_repel_lua_disarm:IsDebuff()
	return false
end

function modifier_centaur_repel_lua_disarm:IsPurgable()
	return false
end

function modifier_centaur_repel_lua_disarm:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_centaur_repel_lua_disarm:GetModifierPhysicalArmorBonus(params)
	local armor = self:GetParent():GetPhysicalArmorBaseValue()
	local armor_increase = armor / 100 * self:GetAbility():GetSpecialValueFor("armor")
	return -armor_increase
end

------------------------------------------------------------------------
------------------------------------------------------------------------
------------------------------------------------------------------------

LinkLuaModifier("modifier_centaur_stampede_lua", "heroes/hero_centaur/hero_centaur", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_centaur_stampede_lua_debuff", "heroes/hero_centaur/hero_centaur", LUA_MODIFIER_MOTION_NONE)

centaur_stampede_lua = class({})

function centaur_stampede_lua:OnSpellStart()
	local caster = self:GetCaster()
	local bDuration = self:GetSpecialValueFor("duration")
	self.hitEnemies = {}

	local allies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		caster:GetOrigin(), -- point, center point
		nil, -- handle, cacheUnit. (not known)
		FIND_UNITS_EVERYWHERE, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _, ally in pairs(allies) do
		ally:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_centaur_stampede_lua", -- modifier name
			{ duration = bDuration } -- kv
		)
	end
	self:PlayEffects()
end

function centaur_stampede_lua:HasTrampled(target)
	for _, enemy in pairs(self.hitEnemies) do
		if target == enemy then
			return true
		end
	end
	return false
end

function centaur_stampede_lua:AddTrampled(target)
	table.insert(self.hitEnemies, target)
end

function centaur_stampede_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_centaur/centaur_stampede_cast.vpcf"
	local sound_cast = "Hero_Centaur.Stampede.Cast"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_centaur_stampede_lua = class({})

function modifier_centaur_stampede_lua:IsHidden()
	return false
end

function modifier_centaur_stampede_lua:IsDebuff()
	return false
end

function modifier_centaur_stampede_lua:IsPurgable()
	return false
end

function modifier_centaur_stampede_lua:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius") -- special value
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration") -- special value
	local strength_pct = self:GetAbility():GetSpecialValueFor("strength_damage") -- special value

	self.interval = 0.1
	self.haste = 550

	-- Start interval
	if IsServer() then
		-- Apply Damage
		self.damageTable = {
			-- victim = target,
			attacker = self:GetParent(),
			damage = self:GetCaster():GetStrength() * strength_pct,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(), --Optional.
		}

		-- Stampede
		self:StartIntervalThink(self.interval)

		-- Effects
		self:PlayEffects1()
	end
end

function modifier_centaur_stampede_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}
	return funcs
end

function modifier_centaur_stampede_lua:GetModifierMoveSpeed_AbsoluteMin()
	return self.haste
end

function modifier_centaur_stampede_lua:GetActivityTranslationModifiers()
	return "haste"
end

function modifier_centaur_stampede_lua:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_centaur_stampede_lua:OnIntervalThink()
	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		self:GetParent(), -- handle, cacheUnit. (not known)
		self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		0, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	local target = nil
	for _, enemy in pairs(enemies) do
		if not self:GetAbility():HasTrampled(enemy) then
			target = enemy
			self:GetAbility():AddTrampled(enemy)
		end
	end

	if target then
		-- Damage
		self.damageTable.victim = target
		ApplyDamage(self.damageTable)

		-- Debuff
		target:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_centaur_stampede_lua_debuff",
			{ duration = self.slow_duration }
		)

		-- Effects
		self:PlayEffects2(target)
	end
end

function modifier_centaur_stampede_lua:GetEffectName()
	return "particles/units/heroes/hero_centaur/centaur_stampede_overhead.vpcf"
end

function modifier_centaur_stampede_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_centaur_stampede_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_centaur/centaur_stampede.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_centaur/centaur_stampede_haste.vpcf"
	local sound_cast = "Hero_Centaur.Stampede.Movement"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:AddParticle(effect_cast, false, false, -1, false, false)
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	local effect_cast2 = ParticleManager:CreateParticle(particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:AddParticle(effect_cast2, false, false, -1, false, false)

	-- Create Sound
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_centaur_stampede_lua:PlayEffects2(target)
	local sound_cast = "Hero_Centaur.Stampede.Stun"
	EmitSoundOn(sound_cast, target)
end

---------------------------------------------------------

modifier_centaur_stampede_lua_debuff = class({})

function modifier_centaur_stampede_lua_debuff:IsHidden()
	return false
end

function modifier_centaur_stampede_lua_debuff:IsDebuff()
	return true
end

function modifier_centaur_stampede_lua_debuff:IsPurgable()
	return true
end

function modifier_centaur_stampede_lua_debuff:OnCreated(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("ms_slow_pct")
end

function modifier_centaur_stampede_lua_debuff:OnDestroy(kv) end

function modifier_centaur_stampede_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_centaur_stampede_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end