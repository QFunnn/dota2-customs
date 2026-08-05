--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


marci_dispose_lua = class({})

function marci_dispose_lua:OnSpellStart()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("impact_damage")
	stun_duration = self:GetSpecialValueFor("stun_duration")

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		self:GetCaster(),
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
		enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = stun_duration })
	end
	self:PlayEffects()
end

function marci_dispose_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
	local radius = self:GetSpecialValueFor("radius")
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
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

	local sound_cast = "Hero_Marci.Grapple.Stun"
	-- EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_marci_passive_hit", "heroes/hero_marci/hero_marci", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_passive_hit_ready", "heroes/hero_marci/hero_marci", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_passive_hit_armor", "heroes/hero_marci/hero_marci", LUA_MODIFIER_MOTION_NONE)

marci_rebound_lua = class({})

function marci_rebound_lua:GetIntrinsicModifierName()
	return "modifier_marci_passive_hit"
end

----------------------------------------------------------------------------------------------------

modifier_marci_passive_hit = class({})

function modifier_marci_passive_hit:IsHidden()
	return true
end

function modifier_marci_passive_hit:RemoveOnDeath()
	return false
end

function modifier_marci_passive_hit:IsPurgable()
	return false
end

function modifier_marci_passive_hit:OnCreated()
	self:StartIntervalThink(0.1)
end

function modifier_marci_passive_hit:OnIntervalThink()
	if IsServer() and self:GetAbility() and self:GetCaster():IsRealHero() and self:GetCaster():IsAlive() then
		if self:GetAbility():IsCooldownReady() then
			if not self:GetCaster():HasModifier("modifier_marci_passive_hit_ready") then
				self:GetCaster()
					:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_marci_passive_hit_ready", {})
			end
		end
	end
end

--------------------------------------------------------------------------------

modifier_marci_passive_hit_ready = class({})

function modifier_marci_passive_hit_ready:IsHidden()
	return false
end

function modifier_marci_passive_hit_ready:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_marci_passive_hit_ready:OnAttackStart(params)
	if self:GetAbility() then
		local parent = self:GetParent()
		local target = params.target
		if
			(parent == params.attacker)
			and (target:GetTeamNumber() ~= parent:GetTeamNumber())
			and (target.IsCreep or target.IsHero)
		then
			if not parent:PassivesDisabled() then
				self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
			else
				self.bonus_damage = 0
			end
		end
	end
end

function modifier_marci_passive_hit_ready:OnAttackLanded(params)
	if self:GetAbility() then
		local parent = self:GetParent()
		if params.attacker == parent and (not parent:IsIllusion()) then
			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				target:AddNewModifier(
					self:GetCaster(),
					self:GetAbility(),
					"modifier_stunned",
					{ duration = self:GetAbility():GetSpecialValueFor("duration") }
				)
				target:AddNewModifier(
					self:GetCaster(),
					self:GetAbility(),
					"modifier_marci_passive_hit_armor",
					{ duration = self:GetAbility():GetSpecialValueFor("duration") }
				)
				EmitSoundOn("Hero_Tusk.c.Target", parent)
				local particle = ParticleManager:CreateParticle("particles/marci_punch.vpcf", PATTACH_ABSORIGIN, parent)
				ParticleManager:SetParticleControl(particle, 2, parent:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(particle)
			end
			self:GetAbility():UseResources(false, false, false, true)
			self:Destroy()
		end
	end
end

function modifier_marci_passive_hit_ready:GetModifierPreAttack_BonusDamage(params)
	self.bonus_damage = self.bonus_damage or 0
	return self.bonus_damage
end

-----------------------------------------------------

modifier_marci_passive_hit_armor = class({})

function modifier_marci_passive_hit_armor:IsHidden()
	return true
end

function modifier_marci_passive_hit_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_marci_passive_hit_armor:GetModifierPhysicalArmorBonus(params)
	return -self:GetAbility():GetSpecialValueFor("armor")
end

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

LinkLuaModifier("modifier_marci_sidekick_lua", "heroes/hero_marci/hero_marci", LUA_MODIFIER_MOTION_NONE)

marci_sidekick_lua = class({})

function marci_sidekick_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("buff_duration")

	if not target then
		return
	end
	target:AddNewModifier(caster, self, "modifier_marci_sidekick_lua", { duration = duration })
end

--------------------------------------------------------------------------

modifier_marci_sidekick_lua = class({})

function modifier_marci_sidekick_lua:IsHidden()
	return false
end

function modifier_marci_sidekick_lua:IsDebuff()
	return false
end

function modifier_marci_sidekick_lua:IsPurgable()
	return true
end

function modifier_marci_sidekick_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.lifesteal = self:GetAbility():GetSpecialValueFor("lifesteal_pct")

	self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")

	if not IsServer() then
		return
	end
	self:PlayEffects1()
end

function modifier_marci_sidekick_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_marci_sidekick_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	}

	return funcs
end

function modifier_marci_sidekick_lua:GetModifierProcAttack_Feedback(params)
	if not IsServer() then
		return
	end

	if params.target:GetTeamNumber() == self.parent:GetTeamNumber() then
		return
	end
	if params.target:IsBuilding() or params.target:IsOther() then
		return
	end

	self.attack_record = params.record
end

function modifier_marci_sidekick_lua:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if self.attack_record ~= params.record then
		return
	end
	local heal = params.damage * self.lifesteal / 100
	self.parent:Heal(heal, self.ability)
	self:PlayEffects2()
end

function modifier_marci_sidekick_lua:GetModifierBaseAttack_BonusDamage()
	return self.damage
end

function modifier_marci_sidekick_lua:ShouldUseOverheadOffset()
	return true
end

function modifier_marci_sidekick_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_marci_sidekick.vpcf"
end

function modifier_marci_sidekick_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_marci_sidekick_lua:PlayEffects2()
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_marci_sidekick_lua:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf"
	if self.parent ~= self.caster then
		particle_cast = "particles/units/heroes/hero_marci/marci_sidekick_buff.vpcf"
	end

	local sound_target = "Hero_Marci.Guardian.Applied"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_OVERHEAD_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(effect_cast, 1, self.parent:GetOrigin())

	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		1, -- iPriority
		false, -- bHeroEffect
		true -- bOverheadEffect
	)
	EmitSoundOn(sound_target, self.parent)
end

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

LinkLuaModifier("modifier_marci_unleash_lua", "heroes/hero_marci/hero_marci", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_unleash_lua_animation", "heroes/hero_marci/hero_marci", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_unleash_lua_fury", "heroes/hero_marci/hero_marci", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_unleash_lua_debuff", "heroes/hero_marci/hero_marci", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_unleash_lua_recovery", "heroes/hero_marci/hero_marci", LUA_MODIFIER_MOTION_NONE)

marci_unleash_lua = class({})

function marci_unleash_lua:GetCooldown(level)
	local ability = self:GetCaster():FindAbilityByName("special_bonus_marci_4")
	if ability ~= nil and ability:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 20
	end
	return self.BaseClass.GetCooldown(self, level)
end

function marci_unleash_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, self, "modifier_marci_unleash_lua", { duration = duration })
end

-----------------------------------------------------------------

modifier_marci_unleash_lua = class({})

function modifier_marci_unleash_lua:IsHidden()
	return true
end

function modifier_marci_unleash_lua:IsDebuff()
	return false
end

function modifier_marci_unleash_lua:IsPurgable()
	return false
end

function modifier_marci_unleash_lua:OnCreated(kv)
	self.parent = self:GetParent()
	self.bonus_ms = self:GetAbility():GetSpecialValueFor("bonus_movespeed")
	if not IsServer() then
		return
	end
	self.parent:Purge(false, true, false, false, false)

	self.parent:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_marci_unleash_lua_fury", -- modifier name
		{} -- kv
	)

	self:PlayEffects()
	if self:GetCaster():IsRealHero() then
		self.hammer = self:GetCaster():GetTogglableWearable(DOTA_LOADOUT_TYPE_WEAPON)
		if self.hammer then
			self.hammer:AddEffects(EF_NODRAW)
		end
	end
end

function modifier_marci_unleash_lua:OnRefresh(kv)
	self.bonus_ms = self:GetAbility():GetSpecialValueFor("bonus_movespeed")
	if not IsServer() then
		return
	end
	self.parent:Purge(false, true, false, false, false)
	self:PlayEffects()
end

function modifier_marci_unleash_lua:OnRemoved() end

function modifier_marci_unleash_lua:OnDestroy()
	if not IsServer() then
		return
	end
	local fury = self.parent:FindModifierByNameAndCaster("modifier_marci_unleash_lua_fury", self.parent)
	if fury then
		fury:ForceDestroy()
	end

	local recovery = self.parent:FindModifierByNameAndCaster("modifier_marci_unleash_lua_recovery", self.parent)
	if recovery then
		recovery:ForceDestroy()
	end
	if self.hammer then
		self.hammer:RemoveEffects(EF_NODRAW)
	end
end

function modifier_marci_unleash_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
	return funcs
end

function modifier_marci_unleash_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_ms
end

function modifier_marci_unleash_lua:GetActivityTranslationModifiers()
	return "no_hammer"
end

function modifier_marci_unleash_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_marci/marci_unleash_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Marci.Unleash.Cast", self:GetParent())
end

--------------------------------------------------------------------------------

modifier_marci_unleash_lua_animation = class({})

function modifier_marci_unleash_lua_animation:IsHidden()
	return true
end

function modifier_marci_unleash_lua_animation:IsDebuff()
	return false
end

function modifier_marci_unleash_lua_animation:IsPurgable()
	return false
end

function modifier_marci_unleash_lua_animation:OnCreated(kv) end

function modifier_marci_unleash_lua_animation:OnDestroy(kv) end

function modifier_marci_unleash_lua_animation:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
	return funcs
end

function modifier_marci_unleash_lua_animation:GetActivityTranslationModifiers()
	return "unleash"
end

--------------------------------------------------------------------------------

modifier_marci_unleash_lua_debuff = class({})

function modifier_marci_unleash_lua_debuff:IsHidden()
	return false
end

function modifier_marci_unleash_lua_debuff:IsDebuff()
	return true
end

function modifier_marci_unleash_lua_debuff:IsPurgable()
	return true
end

function modifier_marci_unleash_lua_debuff:OnCreated(kv)
	self.as_slow = -self:GetAbility():GetSpecialValueFor("pulse_attack_slow_pct")
	self.ms_slow = -self:GetAbility():GetSpecialValueFor("pulse_move_slow_pct")

	if not IsServer() then
		return
	end
end

function modifier_marci_unleash_lua_debuff:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_marci_unleash_lua_debuff:OnRemoved() end

function modifier_marci_unleash_lua_debuff:OnDestroy() end

function modifier_marci_unleash_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_marci_unleash_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_marci_unleash_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_marci_unleash_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_marci/marci_unleash_pulse_debuff.vpcf"
end

function modifier_marci_unleash_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_marci_unleash_lua_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_marci_unleash_lua_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

--------------------------------------------------------------------------------

modifier_marci_unleash_lua_fury = class({})

function modifier_marci_unleash_lua_fury:IsHidden()
	return false
end

function modifier_marci_unleash_lua_fury:IsDebuff()
	return false
end

function modifier_marci_unleash_lua_fury:IsPurgable()
	return false
end

function modifier_marci_unleash_lua_fury:OnCreated(kv)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.bonus_as = self:GetAbility():GetSpecialValueFor("flurry_bonus_attack_speed")
	self.recovery = self:GetAbility():GetSpecialValueFor("time_between_flurries")
	self.charges = self:GetAbility():GetSpecialValueFor("charges_per_flurry")
	self.timer = self:GetAbility():GetSpecialValueFor("max_time_window_per_hit")

	self.radius = self:GetAbility():GetSpecialValueFor("pulse_radius")
	self.damage = self:GetAbility():GetSpecialValueFor("pulse_damage")
	self.duration = self:GetAbility():GetSpecialValueFor("pulse_debuff_duration")

	if not IsServer() then
		return
	end

	self.counter = self.charges
	self:SetStackCount(self.counter)

	self.success = 0

	-- create anmiation modifier
	self.animation = self.parent:AddNewModifier(
		self.parent, -- player source
		self.ability, -- ability source
		"modifier_marci_unleash_lua_animation", -- modifier name
		{} -- kv
	)

	-- play effects
	self:PlayEffects1()
	self:PlayEffects2(self.parent, self.counter)
end

function modifier_marci_unleash_lua_fury:OnRefresh(kv) end

function modifier_marci_unleash_lua_fury:OnRemoved() end

function modifier_marci_unleash_lua_fury:OnDestroy()
	if not IsServer() then
		return
	end

	-- destroy animation modifier
	if not self.animation:IsNull() then
		self.animation:Destroy()
	end

	-- check main modifier
	local main = self.parent:FindModifierByNameAndCaster("modifier_marci_unleash_lua", self.parent)
	if not main then
		return
	end

	-- check if forced destroy by main modifier
	if self.forced then
		return
	end

	-- create recovery modifier
	self.parent:AddNewModifier(
		self.parent, -- player source
		self.ability, -- ability source
		"modifier_marci_unleash_lua_recovery", -- modifier name
		{
			duration = self.recovery,
			success = self.success,
		} -- kv
	)

	if self.success ~= 1 then
		return
	end
end

function modifier_marci_unleash_lua_fury:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

function modifier_marci_unleash_lua_fury:GetModifierAttackSpeed_Limit()
	return 1
end

function modifier_marci_unleash_lua_fury:GetModifierProcAttack_Feedback(params)
	self:StartIntervalThink(self.timer)

	self.counter = self.counter - 1
	self:SetStackCount(self.counter)

	self:EditEffects2(self.counter)
	self:PlayEffects3(self.parent, params.target)

	if self.counter <= 0 then
		self.success = 1
		self:Pulse(params.target:GetOrigin())
		self:Destroy()
	end
end

function modifier_marci_unleash_lua_fury:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_as
end

function modifier_marci_unleash_lua_fury:GetActivityTranslationModifiers()
	if self:GetStackCount() == 1 then
		return "flurry_pulse_attack"
	end

	if self:GetStackCount() % 2 == 0 then
		return "flurry_attack_b"
	end

	return "flurry_attack_a"
end

function modifier_marci_unleash_lua_fury:OnIntervalThink()
	self:Destroy()
end

function modifier_marci_unleash_lua_fury:Pulse(center)
	-- create pulse
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(), -- int, your team number
		center, -- point, center point
		self.parent, -- handle, cacheUnit. (not known)
		self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		0, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self.parent,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability, --Optional.
	}

	for _, enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		-- slow
		enemy:AddNewModifier(
			self.parent, -- player source
			self.ability, -- ability source
			"modifier_marci_unleash_lua_debuff", -- modifier name
			{ duration = self.duration } -- kv
		)
	end

	-- play effects
	self:PlayEffects4(center, self.radius)
end

function modifier_marci_unleash_lua_fury:ForceDestroy()
	self.forced = true
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_marci_unleash_lua_fury:ShouldUseOverheadOffset()
	return true
end

function modifier_marci_unleash_lua_fury:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_buff.vpcf"
	local sound_cast = "Hero_Marci.Unleash.Charged"
	local sound_cast2 = "Hero_Marci.Unleash.Charged.2D"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"eye_l",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"eye_r",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		4,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		5,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		6,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn(sound_cast, self:GetParent())
	EmitSoundOnClient(sound_cast2, self:GetParent():GetPlayerOwner())
end

function modifier_marci_unleash_lua_fury:PlayEffects2(caster, counter)
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_stack.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_OVERHEAD_FOLLOW, caster)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(0, counter, 0))
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		1, -- iPriority
		false, -- bHeroEffect
		true -- bOverheadEffect
	)

	-- save index for later
	self.effect_cast = effect_cast
end

function modifier_marci_unleash_lua_fury:EditEffects2(counter)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(0, counter, 0))
end

function modifier_marci_unleash_lua_fury:PlayEffects3(caster, target)
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_marci_unleash_lua_fury:PlayEffects4(point, radius)
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf"
	local sound_cast = "Hero_Marci.Unleash.Pulse"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	-- Create Sound
	-- EmitSoundOnLocationWithCaster( point, sound_cast, self:GetParent() )
	EmitSoundOn(sound_cast, self:GetParent())
end

--------------------------------------------------------------------------------
modifier_marci_unleash_lua_recovery = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_marci_unleash_lua_recovery:IsHidden()
	return false
end

function modifier_marci_unleash_lua_recovery:IsDebuff()
	return true
end

function modifier_marci_unleash_lua_recovery:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_marci_unleash_lua_recovery:OnCreated(kv)
	self.parent = self:GetParent()
	-- references
	self.rate = self:GetAbility():GetSpecialValueFor("recovery_fixed_attack_rate")

	if not IsServer() then
		return
	end
	self.success = kv.success == 1
end

function modifier_marci_unleash_lua_recovery:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_marci_unleash_lua_recovery:OnRemoved() end

function modifier_marci_unleash_lua_recovery:OnDestroy()
	if not IsServer() then
		return
	end

	-- check main modifier
	local main = self.parent:FindModifierByNameAndCaster("modifier_marci_unleash_lua", self.parent)
	if not main then
		return
	end

	-- check if forced destroy by main modifier
	if self.forced then
		return
	end

	-- add fury charge
	self.parent:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_marci_unleash_lua_fury", -- modifier name
		{} -- kv
	)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_marci_unleash_lua_recovery:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_FIXED_ATTACK_RATE,
	}

	return funcs
end

function modifier_marci_unleash_lua_recovery:GetModifierFixedAttackRate(params)
	return self.rate
end

--------------------------------------------------------------------------------
-- Helper
function modifier_marci_unleash_lua_recovery:ForceDestroy()
	self.forced = true
	self:Destroy()
end