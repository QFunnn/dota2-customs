--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_generic_orb_effect_lua",
	"heroes/generic/modifier_generic_orb_effect_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_drow_ranger_frost_arrows_lua",
	"heroes/hero_drow_ranger/hero_drow_ranger",
	LUA_MODIFIER_MOTION_NONE
)

drow_ranger_frost_arrows_lua = class({})

function drow_ranger_frost_arrows_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

function drow_ranger_frost_arrows_lua:GetProjectileName()
	return "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
end

function drow_ranger_frost_arrows_lua:OnOrbFire(params)
	local sound_cast = "Hero_DrowRanger.FrostArrows"
	EmitSoundOn(sound_cast, self:GetCaster())
end

function drow_ranger_frost_arrows_lua:OnOrbImpact(params)
	local duration = self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("damage")
	params.target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_drow_ranger_frost_arrows_lua",
		{ duration = duration }
	)

	local damageTable = {
		victim = params.target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
	}
	ApplyDamage(damageTable)
end

--------------------------------------------------------------------------------

modifier_drow_ranger_frost_arrows_lua = class({})

function modifier_drow_ranger_frost_arrows_lua:IsHidden()
	return false
end

function modifier_drow_ranger_frost_arrows_lua:IsDebuff()
	return true
end

function modifier_drow_ranger_frost_arrows_lua:IsStunDebuff()
	return false
end

function modifier_drow_ranger_frost_arrows_lua:IsPurgable()
	return true
end

function modifier_drow_ranger_frost_arrows_lua:OnCreated(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("movement_speed")
end

function modifier_drow_ranger_frost_arrows_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_drow_ranger_frost_arrows_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_drow_ranger_frost_arrows_lua:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_drow_ranger_frost_arrows_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_drow_cross_lua_active", "heroes/hero_drow_ranger/hero_drow_ranger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_drow_cross_damage_helper",
	"heroes/hero_drow_ranger/hero_drow_ranger",
	LUA_MODIFIER_MOTION_NONE
)

drow_cross_lua = class({})

function drow_cross_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_drow/drow_glacier_hilltop_ramp_dryice.vpcf", context)
end

function drow_cross_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	caster:EmitSound("Hero_DrowRanger.Multishot.Channel")
	caster:AddNewModifier(caster, self, "modifier_drow_cross_lua_active", { duration = duration })
end

function drow_cross_lua:OnProjectileHit_ExtraData(target, location, data)
	if not target or target:IsInvulnerable() then
		return
	end

	if data.is_cross_pierce == 1 then
		local caster = self:GetCaster()
		local damage_pct = self:GetSpecialValueFor("pierce_damage_pct")
		caster:AddNewModifier(caster, self, "modifier_drow_cross_damage_helper", { duration = 0.03, pct = damage_pct })
		caster:PerformAttack(target, true, true, true, false, true, false, false)
		caster:RemoveModifierByName("modifier_drow_cross_damage_helper")
	end
	return true
end

--------------------------------------------------------------------------------

modifier_drow_cross_lua_active = class({})

function modifier_drow_cross_lua_active:IsHidden()
	return false
end

function modifier_drow_cross_lua_active:IsPurgable()
	return true
end

function modifier_drow_cross_lua_active:OnCreated()
	local caster = self:GetCaster()
	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_drow/drow_glacier_hilltop_ramp_dryice.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(self.pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.pfx, 1, caster:GetAbsOrigin())
end

function modifier_drow_cross_lua_active:OnDestroy()
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end

function modifier_drow_cross_lua_active:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_drow_cross_lua_active:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("attack_speed")
end

-- function drow_cross_lua:OnProjectileHit(target, location)
--     if not target or target:IsInvulnerable() then return end
--     local caster = self:GetCaster()
--     local damage_pct = self:GetSpecialValueFor("pierce_damage_pct")
--     caster:AddNewModifier(caster, self, "modifier_drow_cross_damage_helper", { duration = 0.03, pct = damage_pct })
--     caster:PerformAttack(target, true, true, true, false, false, false, false)
--     caster:RemoveModifierByName("modifier_drow_cross_damage_helper")
--     return true
-- end

function modifier_drow_cross_lua_active:OnAttackLanded(keys)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()

	if keys.attacker ~= parent or keys.target:IsOther() then
		return
	end

	-- ГЛАВНАЯ ПРОВЕРКА: если у атаки есть специальный индекс, значит это уже сплит-атака
	-- Мы не создаем новые стрелы от стрел, которые были созданы этой же способностью
	if keys.no_attack_cooldown then
		return
	end

	local target = keys.target
	local direction = (target:GetAbsOrigin() - parent:GetAbsOrigin()):Normalized()
	local pierce_range = ability:GetSpecialValueFor("pierce_range")
	local pierce_width = ability:GetSpecialValueFor("pierce_width")
	local end_pos = target:GetAbsOrigin() + direction * pierce_range

	local enemies = FindUnitsInLine(
		parent:GetTeamNumber(),
		target:GetAbsOrigin(),
		end_pos,
		nil,
		pierce_width,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		0
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= target then
			local info = {
				Target = enemy,
				Source = target,
				Ability = ability,
				iMoveSpeed = parent:GetProjectileSpeed(),
				EffectName = parent:GetRangedProjectileName(),
				bDodgeable = true,
				-- Передаем флаг в ExtraData, чтобы OnProjectileHit знал, что делать
				ExtraData = { is_cross_pierce = 1 },
			}
			ProjectileManager:CreateTrackingProjectile(info)
		end
	end
end

-- function modifier_drow_cross_lua_active:OnTakeDamage(keys)
--     if not IsServer() then return end

--     local parent = self:GetParent()
--     local ability = self:GetAbility()

--     if keys.attacker ~= parent or keys.unit == parent then return end
--     if keys.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
--     if bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
--     if parent:HasModifier("modifier_drow_cross_damage_helper") then return end

--     local target = keys.unit
--     local target_pos = target:GetAbsOrigin()
--     local parent_pos = parent:GetAbsOrigin()

--     local direction = (target_pos - parent_pos):Normalized()
--     local pierce_range = ability:GetSpecialValueFor("pierce_range")
--     local pierce_width = ability:GetSpecialValueFor("pierce_width")

--     local end_pos = target_pos + direction * pierce_range

--     local enemies = FindUnitsInLine(parent:GetTeamNumber(), target_pos, end_pos, nil, pierce_width, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0)

--     for _, enemy in pairs(enemies) do
--         if enemy ~= target then
--             local arrow_projectile = {
--                 Target = enemy,
--                 Source = target,
--                 Ability = ability,
--                 iMoveSpeed = parent:GetProjectileSpeed(),
--                 EffectName = parent:GetRangedProjectileName(),
--                 bDodgeable = true,
--                 bReplaceExisting = false,
--                 flExpireTime = GameRules:GetGameTime() + 10,
--                 bProvidesVision = false,
--             }
--             ProjectileManager:CreateTrackingProjectile(arrow_projectile)
--         end
--     end
-- end

--------------------------------------------------------------------------------

modifier_drow_cross_damage_helper = class({})

function modifier_drow_cross_damage_helper:IsHidden()
	return true
end
function modifier_drow_cross_damage_helper:OnCreated(keys)
	if IsServer() then
		self.pct = keys.pct
	end
end

function modifier_drow_cross_damage_helper:DeclareFunctions()
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE }
end

function modifier_drow_cross_damage_helper:GetModifierDamageOutgoing_Percentage()
	return self.pct - 100
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_drow_ranger_aura", "heroes/hero_drow_ranger/hero_drow_ranger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drow_ranger_aura_buff", "heroes/hero_drow_ranger/hero_drow_ranger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_drow_ranger_aura_debuff",
	"heroes/hero_drow_ranger/hero_drow_ranger",
	LUA_MODIFIER_MOTION_NONE
)

drow_ranger_aura = class({})

function drow_ranger_aura:GetIntrinsicModifierName()
	return "modifier_drow_ranger_aura"
end

--------------------------------------------------------------------------------

modifier_drow_ranger_aura = class({})

function modifier_drow_ranger_aura:IsHidden()
	return true
end

function modifier_drow_ranger_aura:IsPurgable()
	return false
end

function modifier_drow_ranger_aura:IsAura()
	local caster = self:GetCaster()
	return not caster:PassivesDisabled() and not caster:IsIllusion()
end

function modifier_drow_ranger_aura:GetModifierAura()
	return "modifier_drow_ranger_aura_buff"
end

function modifier_drow_ranger_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_drow_ranger_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_drow_ranger_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("AbilityCastRange")
end

function modifier_drow_ranger_aura:GetAuraEntityReject(target)
	return false
end

--------------------------------------------------------------------------------

modifier_drow_ranger_aura_buff = class({})

function modifier_drow_ranger_aura_buff:IsHidden()
	return false
end
function modifier_drow_ranger_aura_buff:IsPurgable()
	return false
end
function modifier_drow_ranger_aura_buff:GetTexture()
	return "speedaura2"
end

function modifier_drow_ranger_aura_buff:OnCreated()
	self.attack_speed = self:GetAbility():GetSpecialValueFor("attack_speed")
end

function modifier_drow_ranger_aura_buff:OnRefresh()
	self:OnCreated()
end

function modifier_drow_ranger_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_drow_ranger_aura_buff:GetModifierAttackSpeedBonus_Constant()
	if self:GetCaster():IsRealHero() then
		return self:GetCaster():GetAgility() * self.attack_speed * 0.01
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_drow_ranger_marksmanship_lua",
	"heroes/hero_drow_ranger/hero_drow_ranger",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_drow_ranger_marksmanship_lua_aura_buff",
	"heroes/hero_drow_ranger/hero_drow_ranger",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_drow_ranger_marksmanship_lua_effect",
	"heroes/hero_drow_ranger/hero_drow_ranger",
	LUA_MODIFIER_MOTION_NONE
)

drow_ranger_marksmanship_lua = class({})

function drow_ranger_marksmanship_lua:GetIntrinsicModifierName()
	return "modifier_drow_ranger_marksmanship_lua"
end

function drow_ranger_marksmanship_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_drow/drow_marksmanship.vpcf", context)
end

function drow_ranger_marksmanship_lua:OnProjectileHit_ExtraData(target, location, data)
	if not target then
		return
	end
	self.split = true
	self.split_procs = (data.procs == 1)
	self:GetCaster():PerformAttack(target, true, true, true, false, false, false, false)
	self.split = false
end

--------------------------------------------------------------------------------

modifier_drow_ranger_marksmanship_lua = class({})

function modifier_drow_ranger_marksmanship_lua:IsHidden()
	return false
end

function modifier_drow_ranger_marksmanship_lua:IsPurgable()
	return false
end

function modifier_drow_ranger_marksmanship_lua:IsAura()
	return not self:GetCaster():PassivesDisabled() and not self:GetCaster():IsIllusion()
end

function modifier_drow_ranger_marksmanship_lua:GetModifierAura()
	return "modifier_drow_ranger_marksmanship_lua_aura_buff"
end

function modifier_drow_ranger_marksmanship_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_drow_ranger_marksmanship_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_drow_ranger_marksmanship_lua:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_drow_ranger_marksmanship_lua:GetAuraEntityReject(target)
	return target == self:GetCaster()
end

function modifier_drow_ranger_marksmanship_lua:OnCreated()
	local abil = self:GetAbility()
	self.agi_lock = false
	self.chance = abil:GetSpecialValueFor("chance")
	self.bonus_damage = abil:GetSpecialValueFor("bonus_damage")
	self.split_range = abil:GetSpecialValueFor("split_range")
	self.split_count = abil:GetSpecialValueFor("split_count")
	self.split_damage_reduction = abil:GetSpecialValueFor("split_damage_reduction")
	if IsServer() then
		self:PlayEffects1()
	end
end

function modifier_drow_ranger_marksmanship_lua:OnRefresh()
	self:OnCreated()
end

function modifier_drow_ranger_marksmanship_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_drow_ranger_marksmanship_lua:OnAttackStart(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() or params.target:IsOther() then
		return
	end
	if RollPercentage(self.chance) then
		self.proced_attack_record = true
	else
		self.proced_attack_record = false
	end
end

function modifier_drow_ranger_marksmanship_lua:GetModifierProjectileName()
	return "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
end

function modifier_drow_ranger_marksmanship_lua:GetModifierProcAttack_BonusDamage_Physical(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() then
		return 0
	end

	if self.proced_attack_record then
		self.proced_attack_record = false

		params.target:EmitSound("Hero_DrowRanger.Marksmanship.Target")
		return self.bonus_damage
	end
	return 0
end

function modifier_drow_ranger_marksmanship_lua:GetModifierBonusStats_Agility()
	local parent = self:GetParent()
	if not parent or parent:PassivesDisabled() or self.agi_lock then
		return 0
	end

	self.agi_lock = true
	local current_agility = parent:GetAgility()
	local bonus_agility = self:GetAbility():GetSpecialValueFor("bonus_agility")
	self.agi_lock = false

	return current_agility * (bonus_agility / 100)
end

function modifier_drow_ranger_marksmanship_lua:OnAttackLanded(params)
	if not IsServer() or params.attacker ~= self:GetParent() then
		return
	end

	if self:GetAbility().split then
		return
	end

	if params.attacker:HasModifier("modifier_drow_cross_damage_helper") then
		return
	end

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_drow_8")

	if talent and talent:GetLevel() > 0 then
		local enemies = FindUnitsInRadius(
			self:GetParent():GetTeamNumber(),
			params.target:GetOrigin(),
			params.target,
			self.split_range,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_CLOSEST,
			false
		)

		local count = 0
		for _, enemy in pairs(enemies) do
			if enemy ~= params.target and count < self.split_count then
				local info = {
					Target = enemy,
					Source = params.target,
					Ability = self:GetAbility(),
					EffectName = self:GetParent():GetRangedProjectileName(),
					iMoveSpeed = self:GetParent():GetProjectileSpeed(),
					bDodgeable = true,
					bIsAttack = true,
					ExtraData = { procs = RollPercentage(self.chance) and 1 or 0 },
				}
				if info.ExtraData.procs == 1 then
					info.EffectName = "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
				end
				ProjectileManager:CreateTrackingProjectile(info)
				count = count + 1
			end
		end
	end
end

function modifier_drow_ranger_marksmanship_lua:GetModifierDamageOutgoing_Percentage()
	if self:GetAbility().split then
		return -self.split_damage_reduction
	end
end

function modifier_drow_ranger_marksmanship_lua:PlayEffects1()
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_drow/drow_marksmanship.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(pfx, 2, Vector(2, 0, 0))
	self:AddParticle(pfx, false, false, -1, false, false)
end

--------------------------------------------------------------------------------

modifier_drow_ranger_marksmanship_lua_aura_buff = class({})

function modifier_drow_ranger_marksmanship_lua_aura_buff:IsHidden()
	return false
end

function modifier_drow_ranger_marksmanship_lua_aura_buff:IsPurgable()
	return false
end

function modifier_drow_ranger_marksmanship_lua_aura_buff:OnCreated()
	self.agi_lock = false
end

function modifier_drow_ranger_marksmanship_lua_aura_buff:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATS_AGILITY_BONUS }
end

function modifier_drow_ranger_marksmanship_lua_aura_buff:GetModifierBonusStats_Agility()
	local parent = self:GetParent()
	if not parent or parent:PassivesDisabled() or self.agi_lock then
		return 0
	end

	self.agi_lock = true
	local current_agility = parent:GetAgility()
	local bonus_agility = self:GetAbility():GetSpecialValueFor("bonus_agility")
	self.agi_lock = false

	return current_agility * (bonus_agility / 100)
end