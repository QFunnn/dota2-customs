--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

creep_ether_shock_lua = class({})

function creep_ether_shock_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_shadowshaman/shadowshaman_ether_shock.vpcf", context)
end

function creep_ether_shock_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_ether_shock_lua:OnSpellStart()
	local target = self:GetCursorTarget()
	local count = self:GetSpecialValueFor("targets")
	local end_distance = self:GetSpecialValueFor("end_distance")

	if not IsServer() then
		return
	end
	local damage = self:GetSpecialValueFor("damage")
	local boost_damage = self:GetSpecialValueFor("diff_boost_damage")

	if target:TriggerSpellAbsorb(self) then
		return
	end

	self:GetCaster():EmitSound("Hero_ShadowShaman.EtherShock")

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		end_distance,
		self:GetAbilityTargetTeam(),
		self:GetAbilityTargetType(),
		self:GetAbilityTargetFlags(),
		FIND_CLOSEST,
		false
	)

	local enemies_hit = 0
	local attachment = "attach_attack1"

	for _, enemy in pairs(enemies) do
		if enemies_hit < count then
			enemy:EmitSound("Hero_ShadowShaman.EtherShock.Target")

			local ether_shock_particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_shadowshaman/shadowshaman_ether_shock.vpcf",
				PATTACH_POINT_FOLLOW,
				self:GetCaster()
			)
			ParticleManager:SetParticleControlEnt(
				ether_shock_particle,
				0,
				self:GetCaster(),
				PATTACH_POINT_FOLLOW,
				attachment,
				self:GetCaster():GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControl(ether_shock_particle, 1, enemy:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(ether_shock_particle)

			ApplyDamage({
				victim = enemy,
				damage = damage + boost_damage,
				damage_type = self:GetAbilityDamageType(),
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				attacker = self:GetCaster(),
				ability = self,
			})

			enemies_hit = enemies_hit + 1
		end
	end
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_earthbind_lua", "abilities/creeps/zone_1/zone_1", LUA_MODIFIER_MOTION_NONE)

creep_earthbind_lua = class({})

function creep_earthbind_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_meepo/meepo_earthbind_projectile_fx.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_meepo/meepo_earthbind.vpcf", context)
end

function creep_earthbind_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not target or target:IsNull() then
		return
	end

	local projectile_speed = self:GetSpecialValueFor("net_speed")

	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_meepo/meepo_earthbind_projectile_fx.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
	}
	ProjectileManager:CreateTrackingProjectile(info)

	caster:EmitSound("Hero_Meepo.Earthbind.Cast")
end

function creep_earthbind_lua:OnProjectileHit_ExtraData(target, location, data)
	if not target or target:IsNull() then
		return
	end

	if target:IsMagicImmune() or target:TriggerSpellAbsorb(self) then
		return
	end

	local duration = self:GetSpecialValueFor("duration")

	target:AddNewModifier(self:GetCaster(), self, "modifier_creep_earthbind_lua", { duration = duration })

	target:EmitSound("Hero_Meepo.Earthbind.Target")

	return true
end

-----------------------------------------------------------------------------------------

modifier_creep_earthbind_lua = class({})

function modifier_creep_earthbind_lua:IsHidden()
	return false
end

function modifier_creep_earthbind_lua:IsDebuff()
	return true
end

function modifier_creep_earthbind_lua:IsStunDebuff()
	return false
end

function modifier_creep_earthbind_lua:IsPurgable()
	return true
end

function modifier_creep_earthbind_lua:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_creep_earthbind_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
		[MODIFIER_STATE_ROOTED] = true,
	}
	return state
end

function modifier_creep_earthbind_lua:GetEffectName()
	return "particles/units/heroes/hero_meepo/meepo_earthbind.vpcf"
end

function modifier_creep_earthbind_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

creep_shockwave_lua = class({})

function creep_shockwave_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_creeps.vsndevts", context)
end

function creep_shockwave_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_shockwave_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target_loc = self:GetCursorPosition()

	if self:GetCursorTarget() then
		target_loc = self:GetCursorTarget():GetAbsOrigin()
	end

	local direction = (target_loc - caster:GetAbsOrigin()):Normalized()
	direction.z = 0

	local speed = self:GetSpecialValueFor("speed")
	local distance = self:GetSpecialValueFor("distance")
	local radius_start = self:GetSpecialValueFor("radius_start")
	local radius_end = self:GetSpecialValueFor("radius_end")

	local projectile_info = {
		EffectName = "particles/neutral_fx/satyr_hellcaller.vpcf",
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		fDistance = distance,
		fStartRadius = radius_start,
		fEndRadius = radius_end,
		Source = caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		vVelocity = direction * speed,
		bProvidesVision = false,
	}

	ProjectileManager:CreateLinearProjectile(projectile_info)
	caster:EmitSound("n_creep_SatyrHellcaller.Shockwave")
end

function creep_shockwave_lua:OnProjectileHit(target, location)
	if not target then
		return
	end

	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("damage")
	local boost = self:GetSpecialValueFor("diff_boost_damage")

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage + boost,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	})

	target:EmitSound("n_caster.Shockwave.Target")

	return false
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

creep_mana_burn = class({})

function creep_mana_burn:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_creeps.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf", context)
end

function creep_mana_burn:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_mana_burn:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb(self) then
		return
	end

	caster:EmitSound("n_creep_SatyrSoulstealer.ManaBurn")

	local burn_amount = self:GetSpecialValueFor("burn_amount")
	local diff_boost_damage = self:GetSpecialValueFor("diff_boost_damage")
	local int_multiplier = self:GetSpecialValueFor("int_multiplier")

	local total_burn = burn_amount + diff_boost_damage
	if target:IsHero() then
		total_burn = burn_amount + (target:GetIntellect(false) * int_multiplier)
	end

	local target_mana = target:GetMana()
	local mana_to_burn = math.min(target_mana, total_burn)

	target:Script_ReduceMana(mana_to_burn, nil)

	local damageTable = {
		victim = target,
		attacker = caster,
		damage = mana_to_burn,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}
	ApplyDamage(damageTable)

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControl(pfx, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx)

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_MANA_LOSS, target, mana_to_burn, nil)
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

creep_thunder_clap = class({})

LinkLuaModifier("modifier_creep_thunder_clap_debuff", "abilities/creeps/zone_1/zone_1", LUA_MODIFIER_MOTION_NONE)

function creep_thunder_clap:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_thunder_clap:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_creeps.vsndevts", context)
	PrecacheResource("particle", "particles/neutral_fx/ursa_thunderclap.vpcf", context)
end

function creep_thunder_clap:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")
	local diff_boost = self:GetSpecialValueFor("diff_boost_damage")
	local duration = self:GetSpecialValueFor("duration")

	caster:EmitSound("n_creep_Ursa.Clap")

	local pfx =
		ParticleManager:CreateParticle("particles/neutral_fx/ursa_thunderclap.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(pfx)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
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
			damage = damage + diff_boost,
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		})

		enemy:AddNewModifier(caster, self, "modifier_creep_thunder_clap_debuff", { duration = duration })
	end
end

--------------------------------------------------------------------------------

modifier_creep_thunder_clap_debuff = class({})

function modifier_creep_thunder_clap_debuff:IsHidden()
	return false
end
function modifier_creep_thunder_clap_debuff:IsDebuff()
	return true
end
function modifier_creep_thunder_clap_debuff:IsPurgable()
	return true
end

function modifier_creep_thunder_clap_debuff:OnCreated()
	self.ms_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow")
	self.as_slow = self:GetAbility():GetSpecialValueFor("attackspeed_slow")
end

function modifier_creep_thunder_clap_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_creep_thunder_clap_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end

function modifier_creep_thunder_clap_debuff:GetModifierAttackSpeedBonus_Constant()
	return -self.as_slow
end

function modifier_creep_thunder_clap_debuff:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_earthshock_modifier.vpcf"
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_howl_lua_debuff", "abilities/creeps/zone_1/zone_1", LUA_MODIFIER_MOTION_NONE)

creep_howl_lua = class({})

function creep_howl_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lycan.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_lycan/lycan_howl_cast.vpcf", context)
end

function creep_howl_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_howl_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("howl_duration")

	caster:EmitSound("Hero_Lycan.Howl")

	local cast_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_lycan/lycan_howl_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(cast_pfx)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_creep_howl_lua_debuff", { duration = duration })
	end
end

--------------------------------------------------------------------------------

modifier_creep_howl_lua_debuff = class({})

function modifier_creep_howl_lua_debuff:IsHidden()
	return false
end
function modifier_creep_howl_lua_debuff:IsDebuff()
	return true
end
function modifier_creep_howl_lua_debuff:IsPurgable()
	return true
end

function modifier_creep_howl_lua_debuff:OnCreated(kv)
	self.damage_reduce = self:GetAbility():GetSpecialValueFor("attack_damage_reduction")
	self.total_armor_reduction = self:GetAbility():GetSpecialValueFor("armor")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
end

function modifier_creep_howl_lua_debuff:AddCustomTransmitterData()
	return {
		damage_reduce = self.damage_reduce,
		total_armor_reduction = self.total_armor_reduction,
	}
end

function modifier_creep_howl_lua_debuff:HandleCustomTransmitterData(data)
	self.damage_reduce = data.damage_reduce
	self.total_armor_reduction = data.total_armor_reduction
end

function modifier_creep_howl_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_creep_howl_lua_debuff:GetModifierBaseDamageOutgoing_Percentage()
	return -self.damage_reduce
end

function modifier_creep_howl_lua_debuff:GetModifierPhysicalArmorBonus()
	return -self.total_armor_reduction
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_critical_strike_effect", "abilities/creeps/zone_1/zone_1", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_critical_strike_passive", "abilities/creeps/zone_1/zone_1", LUA_MODIFIER_MOTION_NONE)

creep_critical_strike = class({})

function creep_critical_strike:GetIntrinsicModifierName()
	return "modifier_creep_critical_strike_passive"
end

function creep_critical_strike:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lycan.vsndevts", context)
end

--------------------------------------------------------------------------------

modifier_creep_critical_strike_passive = class({})

function modifier_creep_critical_strike_passive:IsHidden()
	return true
end

function modifier_creep_critical_strike_passive:OnCreated()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
end

function modifier_creep_critical_strike_passive:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_creep_critical_strike_passive:OnAttackLanded(keys)
	if not IsServer() then
		return
	end
	if keys.attacker ~= self:GetParent() or keys.attacker:IsIllusion() or keys.target:IsBuilding() then
		return
	end

	local ability = self:GetAbility()
	local chance = ability:GetSpecialValueFor("maim_chance")
	local duration = ability:GetSpecialValueFor("maim_duration")

	if RollPercentage(chance) then
		keys.target:AddNewModifier(
			keys.attacker,
			ability,
			"modifier_creep_critical_strike_effect",
			{ duration = duration }
		)
	end
end

--------------------------------------------------------------------------------

modifier_creep_critical_strike_effect = class({})

function modifier_creep_critical_strike_effect:IsHidden()
	return false
end
function modifier_creep_critical_strike_effect:IsDebuff()
	return true
end
function modifier_creep_critical_strike_effect:IsPurgable()
	return true
end

function modifier_creep_critical_strike_effect:OnCreated()
	local ability = self:GetAbility()
	self.ms_slow = ability:GetSpecialValueFor("maim_movement_speed")
	self.as_slow = ability:GetSpecialValueFor("maim_attack_speed")
	self.damage_per_sec = ability:GetSpecialValueFor("maim_damage")
	self.diff_boost_damage = ability:GetSpecialValueFor("diff_boost_damage")

	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end

function modifier_creep_critical_strike_effect:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage_per_sec + self.diff_boost_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})
end

function modifier_creep_critical_strike_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_creep_critical_strike_effect:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end

function modifier_creep_critical_strike_effect:GetModifierAttackSpeedBonus_Constant()
	return -self.as_slow
end