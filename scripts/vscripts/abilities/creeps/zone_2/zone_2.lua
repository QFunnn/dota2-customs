--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_armor_reduction_aura_passive", "abilities/creeps/zone_2/zone_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_armor_reduction_aura_debuff", "abilities/creeps/zone_2/zone_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

armor_reduction_aura = class({})

function armor_reduction_aura:GetIntrinsicModifierName()
	return "modifier_armor_reduction_aura_passive"
end

--------------------------------------------------------------------------------

modifier_armor_reduction_aura_passive = class({})

function modifier_armor_reduction_aura_passive:IsHidden()
	return true
end

function modifier_armor_reduction_aura_passive:IsAura()
	return true
end

function modifier_armor_reduction_aura_passive:GetModifierAura()
	return "modifier_armor_reduction_aura_debuff"
end

function modifier_armor_reduction_aura_passive:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("presence_radius")
end

function modifier_armor_reduction_aura_passive:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_armor_reduction_aura_passive:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_armor_reduction_aura_passive:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_armor_reduction_aura_passive:OnCreated()
	if not IsServer() then
		return
	end
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_boss_damage_boost", {})
end

--------------------------------------------------------------------------------

modifier_armor_reduction_aura_debuff = class({})

function modifier_armor_reduction_aura_debuff:IsHidden()
	return false
end

function modifier_armor_reduction_aura_debuff:IsDebuff()
	return true
end

function modifier_armor_reduction_aura_debuff:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	local base_reduction = ability:GetSpecialValueFor("presence_armor_reduction")
	local diff_boost = ability:GetSpecialValueFor("diff_boost_damage")

	self.total_armor_reduction = (base_reduction + diff_boost)
end

function modifier_armor_reduction_aura_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_armor_reduction_aura_debuff:GetModifierPhysicalArmorBonus()
	return -self.total_armor_reduction
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

require("data")

zombie_spawn = class({})

LinkLuaModifier("modifier_zombie_spawn", "abilities/creeps/zone_2/zone_2", LUA_MODIFIER_MOTION_VERTICAL)

function zombie_spawn:GetIntrinsicModifierName()
	return "modifier_zombie_spawn"
end

--------------------------------------------------------------------------------

modifier_zombie_spawn = class({})

function modifier_zombie_spawn:IsHidden()
	return true
end

function modifier_zombie_spawn:IsPurgable()
	return false
end

function modifier_zombie_spawn:OnCreated(kv)
	self:StartIntervalThink(1)
end

function modifier_zombie_spawn:OnIntervalThink()
	if IsServer() then
		if self:GetAbility():IsCooldownReady() and self:GetParent():IsAlive() then
			local hEnemies = FindUnitsInRadius(
				self:GetParent():GetTeamNumber(),
				self:GetParent():GetOrigin(),
				self:GetParent(),
				1100,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_CLOSEST,
				false
			)
			if #hEnemies > 0 then
				local unit = CreateUnitByName(
					"npc_dota_zone_2_unit_4",
					self:GetParent():GetAbsOrigin(),
					true,
					nil,
					nil,
					DOTA_TEAM_NEUTRALS
				)
				unit:AddNewModifier(unit, nil, "modifier_kill", { duration = 10 })
				local random_ability = passive[RandomInt(1, #passive)]
				rules:aura_dif(unit, random_ability)
				self:GetAbility():UseResources(false, false, false, true)
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_zombie_heal", "abilities/creeps/zone_2/zone_2", LUA_MODIFIER_MOTION_NONE)

zombie_heal = class({})

function zombie_heal:GetIntrinsicModifierName()
	return "modifier_zombie_heal"
end

--------------------------------------------------------------------------------

modifier_zombie_heal = class({})

function modifier_zombie_heal:IsHidden()
	return true
end

function modifier_zombie_heal:IsPurgable()
	return false
end

function modifier_zombie_heal:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.heal_amount = self:GetAbility():GetSpecialValueFor("heal_amount")
	self.heal_boost = self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end

function modifier_zombie_heal:OnIntervalThink()
	local caster = self:GetParent()

	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, unit in pairs(units) do
		unit:Heal(self.heal_amount + self.heal_boost, self:GetAbility())
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

zombie_lifesteal = class({})

LinkLuaModifier("modifier_zombie_lifesteal", "abilities/creeps/zone_2/zone_2", LUA_MODIFIER_MOTION_NONE)

function zombie_lifesteal:GetIntrinsicModifierName()
	return "modifier_zombie_lifesteal"
end

--------------------------------------------------------------------------------

modifier_zombie_lifesteal = class({})

function modifier_zombie_lifesteal:IsHidden()
	return false
end

function modifier_zombie_lifesteal:IsPurgable()
	return false
end

function modifier_zombie_lifesteal:DeclareFunctions()
	return { MODIFIER_EVENT_ON_TAKEDAMAGE }
end

function modifier_zombie_lifesteal:OnTakeDamage(keys)
	if not IsServer() then
		return
	end

	if keys.attacker == self:GetParent() and not keys.unit:IsBuilding() and keys.damage > 0 then
		if keys.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
			local lifesteal_pct = self:GetAbility():GetSpecialValueFor("lifesteal")
			local heal_amount = keys.damage * (lifesteal_pct / 100)

			self:GetParent():Heal(heal_amount, self:GetAbility())

			local pfx = ParticleManager:CreateParticle(
				"particles/generic_gameplay/generic_lifesteal.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self:GetParent()
			)
			ParticleManager:ReleaseParticleIndex(pfx)
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

zombie_ice_hit = class({})

LinkLuaModifier("modifier_zombie_ice_hit", "abilities/creeps/zone_2/zone_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_movespeed_slow", "abilities/creeps/zone_2/zone_2", LUA_MODIFIER_MOTION_NONE)

function zombie_ice_hit:GetIntrinsicModifierName()
	return "modifier_zombie_ice_hit"
end

--------------------------------------------------------------------------------

modifier_zombie_ice_hit = class({})

function modifier_zombie_ice_hit:IsHidden()
	return true
end
function modifier_zombie_ice_hit:IsPurgable()
	return false
end

function modifier_zombie_ice_hit:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_zombie_ice_hit:OnAttackLanded(keys)
	if not IsServer() then
		return
	end
	if keys.attacker ~= self:GetParent() then
		return
	end
	if keys.attacker:IsIllusion() or not keys.target:IsAlive() then
		return
	end

	local duration = self:GetAbility():GetSpecialValueFor("duration")
	keys.target:AddNewModifier(keys.attacker, self:GetAbility(), "modifier_movespeed_slow", { duration = duration })
	keys.target:EmitSound("Base.Hero_AncientApparition.ColdFootCast")
end

--------------------------------------------------------------------------------

modifier_movespeed_slow = class({})

function modifier_movespeed_slow:IsHidden()
	return false
end
function modifier_movespeed_slow:IsDebuff()
	return true
end
function modifier_movespeed_slow:IsPurgable()
	return true
end

function modifier_movespeed_slow:OnCreated()
	self.slow_pct = self:GetAbility():GetSpecialValueFor("movespeed_slow")
end

function modifier_movespeed_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_movespeed_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow_pct
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

fat_zombie_ultimate = class({})

LinkLuaModifier("modifier_fat_zombie_passive", "abilities/creeps/zone_2/zone_2", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_fat_zombie_quill_stack", "abilities/creeps/zone_2/zone_2", LUA_MODIFIER_MOTION_NONE)

function fat_zombie_ultimate:GetIntrinsicModifierName()
	return "modifier_fat_zombie_passive"
end

function fat_zombie_ultimate:Precache(context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood01_lv.vpcf",
		context
	)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context)
end

--------------------------------------------------------------------------------

modifier_fat_zombie_passive = class({})

function modifier_fat_zombie_passive:IsHidden()
	return true
end

function modifier_fat_zombie_passive:OnCreated()
	if not IsServer() then
		return
	end
	-- self:StartIntervalThink(0.1) -- отключено 05.02.2026

	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_boss_damage_boost", {})
end

-- function modifier_fat_zombie_passive:OnIntervalThink()
--     if not IsServer() then return end
--     local parent = self:GetParent()
--     if not parent:IsAlive() then return end

--     local enemies = FindUnitsInRadius(
--         parent:GetTeamNumber(),
--         parent:GetOrigin(),
--         nil,
--         150,
--         DOTA_UNIT_TARGET_TEAM_ENEMY,
--         DOTA_UNIT_TARGET_HERO,
--         DOTA_UNIT_TARGET_FLAG_NONE,
--         FIND_ANY_ORDER,
--         false
--     )

--     if #enemies > 0 then
--         parent:Kill(self:GetAbility(), enemies[1])
--     end
-- end

function modifier_fat_zombie_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_fat_zombie_passive:GetModifierMoveSpeedAbsolute()
	return 580
end

function modifier_fat_zombie_passive:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_fat_zombie_passive:OnDeath(keys)
	if not IsServer() then
		return
	end
	if keys.unit ~= self:GetParent() then
		return
	end

	local caster = self:GetParent()
	local ability = self:GetAbility()
	local pos = caster:GetAbsOrigin()

	local blood_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood01_lv.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:ReleaseParticleIndex(blood_pfx)
	caster:EmitSound("Hero_LifeStealer.Assimilate.Destroy")

	local radius = ability:GetSpecialValueFor("radius")
	local duration = ability:GetSpecialValueFor("duration")
	local base_damage = ability:GetSpecialValueFor("quill_base_damage")
		+ ability:GetSpecialValueFor("diff_boost_damage")
	local stack_damage = ability:GetSpecialValueFor("quill_stack_damage")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		local stack_modifier = enemy:FindModifierByName("modifier_fat_zombie_quill_stack")
		local current_stacks = stack_modifier and stack_modifier:GetStackCount() or 0

		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = base_damage + (current_stacks * stack_damage),
			damage_type = DAMAGE_TYPE_PURE,
			ability = ability,
		})

		local mod = enemy:AddNewModifier(caster, ability, "modifier_fat_zombie_quill_stack", { duration = duration })
		if mod then
			mod:IncrementStackCount()
		end
	end
end

--------------------------------------------------------------------------------

modifier_fat_zombie_quill_stack = class({})

function modifier_fat_zombie_quill_stack:IsDebuff()
	return true
end

function modifier_fat_zombie_quill_stack:GetTexture()
	return "fat_zombie_ultimate"
end

function modifier_fat_zombie_quill_stack:OnCreated()
	self:OnRefresh()
end

function modifier_fat_zombie_quill_stack:OnRefresh()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	self.base_armor_red = ability:GetSpecialValueFor("armor_reduction")
		+ ability:GetSpecialValueFor("diff_boost_additional")
end

function modifier_fat_zombie_quill_stack:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_fat_zombie_quill_stack:GetModifierPhysicalArmorBonus()
	return -(self.base_armor_red * self:GetStackCount())
end