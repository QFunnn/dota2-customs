--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undy_spray_lua", "abilities/bosses/undying/undying", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

undy_spray_lua = class({})

function undy_spray_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function undy_spray_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function undy_spray_lua:OnSpellStart()
	local point = self:GetCursorPosition()

	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_undy_spray_lua",
		{ duration = duration },
		point,
		self:GetCaster():GetTeamNumber(),
		false
	)
end

------------------------------------------------------------------------------------------------

modifier_undy_spray_lua = class({})

function modifier_undy_spray_lua:IsHidden()
	return false
end

function modifier_undy_spray_lua:IsDebuff()
	return true
end

function modifier_undy_spray_lua:IsStunDebuff()
	return false
end

function modifier_undy_spray_lua:IsPurgable()
	return false
end

function modifier_undy_spray_lua:OnCreated(kv)
	local interval = self:GetAbility():GetSpecialValueFor("tick_rate")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.diff_boost_damage = self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.armor = self:GetAbility():GetSpecialValueFor("armor_reduction")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_additional")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.caster = self:GetCaster()
	self.thinker = kv.isProvidedByAura ~= 1

	if not IsServer() then
		return
	end
	if not self.thinker then
		return
	end

	self.damageTable = {
		victim = target,
		attacker = self.caster,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}

	self:StartIntervalThink(interval)

	self.sound_cast = "Hero_Alchemist.AcidSpray.Damage"
	self:PlayEffects()
end

function modifier_undy_spray_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.thinker then
		return
	end

	UTIL_Remove(self:GetParent())
end

function modifier_undy_spray_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_undy_spray_lua:GetModifierPhysicalArmorBonus()
	return -self.armor
end

function modifier_undy_spray_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),
		self:GetParent():GetOrigin(),
		self:GetParent(),
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		self.damageTable.damage = self.damage + self.diff_boost_damage
		ApplyDamage(self.damageTable)
		EmitSoundOn(self.sound_cast, enemy)
	end
end

function modifier_undy_spray_lua:IsAura()
	return self.thinker
end

function modifier_undy_spray_lua:GetModifierAura()
	return "modifier_undy_spray_lua"
end

function modifier_undy_spray_lua:GetAuraRadius()
	return self.radius
end

function modifier_undy_spray_lua:GetAuraDuration()
	return 0.5
end

function modifier_undy_spray_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_undy_spray_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_undy_spray_lua:GetAuraSearchFlags()
	return 0
end

function modifier_undy_spray_lua:GetEffectName()
	return "particles/units/heroes/hero_alchemist/alchemist_acid_spray_debuff.vpcf"
end

function modifier_undy_spray_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_undy_spray_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf"
	local sound_cast = "Hero_Alchemist.AcidSpray"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))

	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
	EmitSoundOn(sound_cast, self:GetParent())
end

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_undy_corrosive_skin_lua", "abilities/bosses/undying/undying", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undy_corrosive_skin_lua_debuff", "abilities/bosses/undying/undying", LUA_MODIFIER_MOTION_NONE)

undy_corrosive_skin_lua = class({})

function undy_corrosive_skin_lua:GetIntrinsicModifierName()
	return "modifier_undy_corrosive_skin_lua"
end

------------------------------------------------------------

modifier_undy_corrosive_skin_lua = class({})

function modifier_undy_corrosive_skin_lua:IsHidden()
	return true
end

function modifier_undy_corrosive_skin_lua:IsPurgable()
	return false
end

function modifier_undy_corrosive_skin_lua:OnCreated(kv)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.max_range = self:GetAbility():GetSpecialValueFor("max_range")

	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
end

function modifier_undy_corrosive_skin_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

function modifier_undy_corrosive_skin_lua:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if params.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then
		return
	end
	local distance = (params.attacker:GetOrigin() - params.unit:GetOrigin()):Length2D()
	if distance > self.max_range then
		return
	end

	params.attacker:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_undy_corrosive_skin_lua_debuff", -- modifier name
		{ duration = self.duration } -- kv
	)
	local sound_cast = "hero_viper.CorrosiveSkin"
	EmitSoundOn(sound_cast, params.attacker)
end

------------------------------------------------------------

modifier_undy_corrosive_skin_lua_debuff = class({})

function modifier_undy_corrosive_skin_lua_debuff:IsHidden()
	return false
end

function modifier_undy_corrosive_skin_lua_debuff:IsDebuff()
	return true
end

function modifier_undy_corrosive_skin_lua_debuff:IsStunDebuff()
	return false
end

function modifier_undy_corrosive_skin_lua_debuff:IsPurgable()
	return true
end

function modifier_undy_corrosive_skin_lua_debuff:OnCreated(kv)
	self.slow = -self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	local damage = self:GetAbility():GetSpecialValueFor("damage")
	local diff_boost_damage = self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage + diff_boost_damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION, --Optional.
	}
	self:StartIntervalThink(1)
end

function modifier_undy_corrosive_skin_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_undy_corrosive_skin_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.slow
end

function modifier_undy_corrosive_skin_lua_debuff:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_undy_corrosive_skin_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_corrosive_debuff.vpcf"
end

function modifier_undy_corrosive_skin_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

------------------------------------------------------------
------------------------------------------------------------

LinkLuaModifier("modifier_undy_skeletons_on_death_lua", "abilities/bosses/undying/undying", LUA_MODIFIER_MOTION_NONE)

undy_skeletons_on_death_lua = class({})

function undy_skeletons_on_death_lua:GetIntrinsicModifierName()
	return "modifier_undy_skeletons_on_death_lua"
end

--------------------------------------------------------------------------------

modifier_undy_skeletons_on_death_lua = class({})

function modifier_undy_skeletons_on_death_lua:IsHidden()
	return true
end

function modifier_undy_skeletons_on_death_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_undy_skeletons_on_death_lua:OnDeath(params)
	if not IsServer() then
		return
	end
	if params.unit:IsRealHero() and params.unit:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
		local distance = (params.unit:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
		local radius = self:GetAbility():GetSpecialValueFor("radius")
		if distance <= radius then
			self:SpawnSkeletons(params.unit:GetAbsOrigin())
		end
	end
end

function modifier_undy_skeletons_on_death_lua:SpawnSkeletons(position)
	local caster = self:GetParent()
	local ability = self:GetAbility()
	local count = ability:GetSpecialValueFor("skeleton_count")

	random_ability = passive[RandomInt(1, #passive)]

	for i = 1, count do
		local unit = CreateUnitByName(
			"npc_dota_boss_undying_minion_" .. i,
			position + RandomVector(100),
			true,
			caster,
			caster,
			caster:GetTeamNumber()
		)
		rules:aura_dif(unit, random_ability)
		unit:AddNewModifier(caster, ability, "modifier_kill", { duration = 600 })
	end

	caster:EmitSound("Undying_Zombie.Spawn")
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_undying_str_steal_lua_debuff", "abilities/bosses/undying/undying", LUA_MODIFIER_MOTION_NONE)

undying_str_steal_lua = class({})

function undying_str_steal_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_undying/undying_soul_rip_damage.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_undying/undying_soul_rip_heal.vpcf", context)
end

function undying_str_steal_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function undying_str_steal_lua:OnAbilityPhaseStart()
	EmitSoundOn("Hero_Undying.SoulRip.Cast", self:GetCaster())
	return true
end

function undying_str_steal_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")

	local strength_to_steal = self:GetSpecialValueFor("str_steal")
	local hp_per_str = self:GetSpecialValueFor("hp_per_str")
	local duration = self:GetSpecialValueFor("duration")

	local extra_hp_per_str = self:GetSpecialValueFor("diff_boost_damage")
	local extra_str = self:GetSpecialValueFor("diff_boost_additional")
	strength_to_steal = strength_to_steal + extra_str
	heal = hp_per_str + extra_hp_per_str

	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	local total_str_stolen = 0

	for _, hero in pairs(heroes) do
		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_undying/undying_soul_rip_damage.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			hero
		)
		ParticleManager:SetParticleControlEnt(
			pfx,
			0,
			hero,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			hero:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			pfx,
			1,
			caster,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			caster:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(pfx)

		hero:AddNewModifier(caster, self, "modifier_undying_str_steal_lua_debuff", {
			duration = duration,
			str_scale = strength_to_steal,
		})

		total_str_stolen = total_str_stolen + strength_to_steal

		EmitSoundOn("Hero_Undying.SoulRip.Enemy", hero)
	end

	if total_str_stolen > 0 then
		local heal_amount = total_str_stolen * heal
		caster:Heal(heal_amount, self)
		local heal_pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_undying/undying_soul_rip_heal.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			caster
		)
		ParticleManager:ReleaseParticleIndex(heal_pfx)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, caster, heal_amount, nil)
	end
end

--------------------------------------------------------------------------------

modifier_undying_str_steal_lua_debuff = class({})

function modifier_undying_str_steal_lua_debuff:IsHidden()
	return false
end
function modifier_undying_str_steal_lua_debuff:IsDebuff()
	return true
end
function modifier_undying_str_steal_lua_debuff:IsPurgable()
	return false
end

function modifier_undying_str_steal_lua_debuff:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.str_per_stack = kv.str_scale
	self:SetStackCount(self.str_per_stack)
end

function modifier_undying_str_steal_lua_debuff:OnRefresh(kv)
	if not IsServer() then
		return
	end
	self.str_per_stack = kv.str_scale
	self:SetStackCount(self:GetStackCount() + self.str_per_stack)
end

function modifier_undying_str_steal_lua_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATS_STRENGTH_BONUS }
end

function modifier_undying_str_steal_lua_debuff:GetModifierBonusStats_Strength()
	return -self:GetStackCount()
end