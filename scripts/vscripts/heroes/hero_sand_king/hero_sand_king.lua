--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sand_caustic_debuff", "heroes/hero_sand_king/hero_sand_king", LUA_MODIFIER_MOTION_NONE)

sand_stun = class({})

function sand_stun:Precache(context)
	PrecacheResource("particle", "particles/sandking.vpcf", context)
end

function sand_stun:GetCastRange()
	return self:GetSpecialValueFor("radius")
end

function sand_stun:OnSpellStart()
	self.radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("stomp_damage")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetOrigin(),
		self:GetCaster(),
		self.radius,
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
			{ duration = stun_duration * (1 - enemy:GetStatusResistance()) }
		)

		local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_sand_king_6")
		if talent ~= nil and talent:GetLevel() > 0 then
			local ability = self:GetCaster():FindAbilityByName("sand_caustic")
			if ability ~= nil and ability:IsTrained() then
				enemy:AddNewModifier(self:GetCaster(), ability, "modifier_sand_caustic_debuff", { duration = 5 })
			end
		end
	end
	self:PlayEffects()
end

function sand_stun:PlayEffects()
	local effect_cast =
		ParticleManager:CreateParticle("particles/sandking.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, self.radius, self.radius))
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

	local sound_cast = "Hero_Leshrac.Split_Earth"
	-- EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_sand_king_sand_storm_lua", "heroes/hero_sand_king/hero_sand_king", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_sand_king_sand_storm_lua_debuff",
	"heroes/hero_sand_king/hero_sand_king",
	LUA_MODIFIER_MOTION_NONE
)

sand_king_sand_storm_lua = class({})

function sand_king_sand_storm_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/instanced/pudge_desert_sequence/shot3b2/sandking_sandstorm_eruption_dust_low_instanced.vpcf",
		context
	)
end

sand_king_sand_storm_lua.mod = nil

function sand_king_sand_storm_lua:OnSpellStart()
	local caster = self:GetCaster()
	local position = self:GetCaster():GetOrigin()
	local duration = self:GetSpecialValueFor("duration")

	if sand_king_sand_storm_lua.mod ~= nil then
		sand_king_sand_storm_lua.mod:Destroy()
	end

	sand_king_sand_storm_lua.mod = CreateModifierThinker(
		caster,
		self,
		"modifier_sand_king_sand_storm_lua",
		{ duration = duration },
		position,
		caster:GetTeamNumber(),
		false
	)

	EmitSoundOn("Ability.SandKing_SandStorm.start", caster)
end

------------------------------------------------------------------------------

modifier_sand_king_sand_storm_lua = class({})

function modifier_sand_king_sand_storm_lua:IsHidden()
	return false
end

function modifier_sand_king_sand_storm_lua:IsDebuff()
	return false
end

function modifier_sand_king_sand_storm_lua:IsPurgable()
	return false
end

function modifier_sand_king_sand_storm_lua:OnCreated(kv)
	if IsServer() then
		self.damage_counter = 0
		self.damage = self:GetAbility():GetSpecialValueFor("damage")
		self.radius = self:GetAbility():GetSpecialValueFor("radius")
		self.interval = 0.03

		if IsServer() then
			self.damageTable = {
				attacker = self:GetCaster(),
				damage = self.damage * 0.5,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self:GetAbility(),
			}

			self:StartIntervalThink(self.interval)
			self:PlayEffects(self.radius)
		end
	end
end

function modifier_sand_king_sand_storm_lua:OnDestroy(kv)
	if IsServer() then
		self:StopEffects()
		sand_king_sand_storm_lua.mod = nil
	end
end

function modifier_sand_king_sand_storm_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	self.damage_counter = self.damage_counter + 1

	if self.damage_counter == 16 then
		self.damage_counter = 0
		local enemies = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			self:GetCaster():GetOrigin(),
			self:GetCaster(),
			self.radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			0,
			0,
			false
		)
		for _, enemy in pairs(enemies) do
			self.damageTable.victim = enemy
			ApplyDamage(self.damageTable)

			local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_sand_king_4")
			if talent ~= nil and talent:GetLevel() > 0 then
				enemy:AddNewModifier(
					self:GetCaster(),
					self,
					"modifier_sand_king_sand_storm_lua_debuff",
					{ duration = 3 }
				)
			end
		end
	end

	if self.effect_cast then
		ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetCaster():GetOrigin())
	end
end

function modifier_sand_king_sand_storm_lua:PlayEffects(radius)
	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_sandstorm.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(radius, radius, radius))
	EmitSoundOn("Ability.SandKing_SandStorm.loop", self:GetCaster())
end

function modifier_sand_king_sand_storm_lua:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
	StopSoundOn("Ability.SandKing_SandStorm.loop", self:GetCaster())
end

-----------------

modifier_sand_king_sand_storm_lua_debuff = class({})

function modifier_sand_king_sand_storm_lua_debuff:IsHidden()
	return true
end

function modifier_sand_king_sand_storm_lua_debuff:IsPurgable()
	return false
end

function modifier_sand_king_sand_storm_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end

function modifier_sand_king_sand_storm_lua_debuff:GetModifierMagicalResistanceBonus(params)
	return -15
end

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

LinkLuaModifier("modifier_sand_caustic", "heroes/hero_sand_king/hero_sand_king", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sand_caustic_debuff", "heroes/hero_sand_king/hero_sand_king", LUA_MODIFIER_MOTION_NONE)

sand_caustic = class({})

function sand_caustic:GetIntrinsicModifierName()
	return "modifier_sand_caustic"
end

------------------------------------------------------------------

modifier_sand_caustic = class({})

function modifier_sand_caustic:IsHidden()
	return true
end

function modifier_sand_caustic:IsPurgable()
	return false
end

function modifier_sand_caustic:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
	return funcs
end

function modifier_sand_caustic:GetModifierProcAttack_Feedback(params)
	if IsServer() then
		if self:GetParent():PassivesDisabled() then
			return
		end
		if params.target:GetTeamNumber() == self:GetParent():GetTeamNumber() then
			return
		end

		if params.target:IsMagicImmune() then
			return
		end
		local modifier = params.target:FindModifierByNameAndCaster("modifier_sand_caustic_debuff", self:GetParent())
		if not modifier then
			params.target:AddNewModifier(
				self:GetParent(), -- player source
				self:GetAbility(), -- ability source
				"modifier_sand_caustic_debuff", -- modifier name
				{ duration = self:GetAbility():GetSpecialValueFor("duration") } -- kv
			)
		end
	end
end

---------------------------------------------------------------

modifier_sand_caustic_debuff = class({})

function modifier_sand_caustic_debuff:IsHidden()
	return false
end

function modifier_sand_caustic_debuff:IsDebuff()
	return true
end

function modifier_sand_caustic_debuff:IsPurgable()
	return true
end

function modifier_sand_caustic_debuff:DestroyOnExpire()
	return true
end

function modifier_sand_caustic_debuff:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	if IsServer() then
		self:StartIntervalThink(1)
	end
end

function modifier_sand_caustic_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_sand_caustic_debuff:OnDeath(params)
	if IsServer() then
		if params.unit ~= self:GetParent() then
			return
		end
		if params.unit:GetTeamNumber() == params.attacker:GetTeamNumber() then
			return
		end
		self:DealDamage(true)
		self:Destroy()
	end
end

function modifier_sand_caustic_debuff:OnIntervalThink()
	self:DealDamage()
end

function modifier_sand_caustic_debuff:DealDamage(explosion)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	if explosion then
		self.damage = self.damage * 2
	end
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		self:GetParent(),
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	local damageTable = {
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	}
	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
	end
	self:PlayEffects()
end

function modifier_sand_caustic_debuff:GetEffectName()
	return "particles/units/heroes/hero_sandking/sandking_caustic_finale_debuff.vpcf"
end

function modifier_sand_caustic_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sand_caustic_debuff:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_caustic_finale_explode.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Ability.SandKing_CausticFinale", self:GetParent())
end

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------

LinkLuaModifier(
	"modifier_sandking_custom_trembling_waves",
	"heroes/hero_sand_king/hero_sand_king",
	LUA_MODIFIER_MOTION_NONE
)

sandking_custom_trembling_waves = class({})

function sandking_custom_trembling_waves:GetIntrinsicModifierName()
	return "modifier_sandking_custom_trembling_waves"
end

function sandking_custom_trembling_waves:GetCooldown(level)
	local abil = self:GetCaster():FindAbilityByName("special_bonus_unique_sand_king_8")
	if abil ~= nil and abil:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 1
	end
	return self.BaseClass.GetCooldown(self, level)
end

function sandking_custom_trembling_waves:IsRefreshable()
	return false
end

----------------------------------------------------------------------------

modifier_sandking_custom_trembling_waves = class({})

function modifier_sandking_custom_trembling_waves:IsHidden()
	return true
end

function modifier_sandking_custom_trembling_waves:IsPurgable()
	return false
end

function modifier_sandking_custom_trembling_waves:OnCreated(kv)
	self.caster = self:GetCaster()
	self:StartIntervalThink(0.1)
end

function modifier_sandking_custom_trembling_waves:OnIntervalThink()
	if
		IsServer()
		and self:GetAbility()
		and self.caster:IsRealHero()
		and self.caster:IsAlive()
		and not self.caster:PassivesDisabled()
		and self:GetAbility():IsCooldownReady()
	then
		local point = self.caster:GetAbsOrigin()
		local radius = self:GetAbility():GetSpecialValueFor("radius")
		local sand_ult_damage = self:GetAbility():GetSpecialValueFor("damage")
		local str_damage = self:GetAbility():GetSpecialValueFor("str_damage")

		local try_damage = sand_ult_damage + self.caster:GetStrength() / 100 * str_damage

		local damageTable = {
			attacker = self.caster,
			damage = try_damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self,
		}

		local enemies = FindUnitsInRadius(
			self.caster:GetTeamNumber(),
			point,
			self.caster,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			0,
			false
		)

		EmitSoundOn("Ability.SandKing_Epicenter.spell", self.caster)
		Timers:CreateTimer(0.1, function()
			StopSoundOn("Ability.SandKing_Epicenter.spell", self.caster)
		end)

		Timers:CreateTimer(0.01, function()
			self.caster.ShieldParticle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_sandking/sandking_epicenter.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self.caster
			)
			ParticleManager:SetParticleControl(self.caster.ShieldParticle, 1, Vector(radius, 0, radius))
			ParticleManager:SetParticleControlEnt(
				self.caster.ShieldParticle,
				0,
				self.caster,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				self.caster:GetAbsOrigin(),
				true
			)
		end)

		for _, enemy in pairs(enemies) do
			damageTable.victim = enemy
			ApplyDamage(damageTable)
		end

		self:GetAbility():UseResources(false, false, false, true)
	end
end