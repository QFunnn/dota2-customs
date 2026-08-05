--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_templar_assassin_refraction_lua",
	"heroes/hero_templar_assassin/hero_templar_assassin",
	LUA_MODIFIER_MOTION_NONE
)

templar_assassin_refraction_lua = class({})

function templar_assassin_refraction_lua:OnUpgrade()
	if IsServer() then
		self:SetContextThink("RefractionAutocast", function()
			return self:HandleAutocast()
		end, 0.5)
	end
end

function templar_assassin_refraction_lua:HandleAutocast()
	if not self:GetAutoCastState() then
		return 0.5
	end
	if not self:IsFullyCastable() then
		return 0.5
	end
	if self:GetCaster():IsInvisible() then
		return 0.5
	end

	if self:GetCaster():HasModifier("modifier_templar_assassin_refraction_lua") then
		return 0.5
	end

	self:CastAbility()
	return 0.5
end

function templar_assassin_refraction_lua:OnSpellStart()
	local caster = self:GetCaster()
	caster:EmitSound("Hero_TemplarAssassin.Refraction")
	caster:AddNewModifier(caster, self, "modifier_templar_assassin_refraction_lua", {
		duration = self:GetSpecialValueFor("duration"),
	})
end

-------------------------------------------------------

modifier_templar_assassin_refraction_lua = class({})

function modifier_templar_assassin_refraction_lua:IsPurgable()
	return false
end
function modifier_templar_assassin_refraction_lua:GetTexture()
	return "templar_assassin_refraction"
end

function modifier_templar_assassin_refraction_lua:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetAbility():GetSpecialValueFor("instances"))

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_templar_assassin/templar_assassin_refraction.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	self:AddParticle(pfx, false, false, -1, true, false)
end

function modifier_templar_assassin_refraction_lua:OnRefresh()
	self:OnCreated()
end

function modifier_templar_assassin_refraction_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
end

function modifier_templar_assassin_refraction_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_templar_assassin_refraction_lua:OnAttackLanded(keys)
	if not IsServer() then
		return
	end
	if keys.attacker == self:GetParent() and keys.target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
		keys.target:EmitSound("Hero_TemplarAssassin.Refraction.Damage")
		self:SpendCharge()
	end
end

function modifier_templar_assassin_refraction_lua:HandleBlock(keys)
	if not IsServer() then
		return
	end
	if keys.damage >= 5 and bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == 0 then
		self:PlayHitEffects()
		self:SpendCharge()
		return 1
	end
	return 0
end

function modifier_templar_assassin_refraction_lua:GetAbsoluteNoDamagePhysical(keys)
	return self:HandleBlock(keys)
end
function modifier_templar_assassin_refraction_lua:GetAbsoluteNoDamageMagical(keys)
	return self:HandleBlock(keys)
end
function modifier_templar_assassin_refraction_lua:GetAbsoluteNoDamagePure(keys)
	return self:HandleBlock(keys)
end

function modifier_templar_assassin_refraction_lua:SpendCharge()
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end

function modifier_templar_assassin_refraction_lua:PlayHitEffects()
	local parent = self:GetParent()
	parent:EmitSound("Hero_TemplarAssassin.Refraction.Absorb")
	local hit = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_templar_assassin/templar_assassin_refract_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControlEnt(
		hit,
		2,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(hit)
end

-------------------------------------------------------
-------------------------------------------------------

LinkLuaModifier(
	"modifier_templar_assassin_meld_lua",
	"heroes/hero_templar_assassin/hero_templar_assassin",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_templar_assassin_meld_lua_debuff",
	"heroes/hero_templar_assassin/hero_templar_assassin",
	LUA_MODIFIER_MOTION_NONE
)

templar_assassin_meld_lua = class({})

function templar_assassin_meld_lua:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_templar_assassin_8")
	if talent and talent:GetLevel() > 0 then
		return 0
	end
	return self.BaseClass.GetCooldown(self, level)
end

function templar_assassin_meld_lua:GetIntrinsicModifierName()
	return "modifier_templar_assassin_meld_lua"
end

-----------------------------------------------------------------------------------

modifier_templar_assassin_meld_lua = class({})

function modifier_templar_assassin_meld_lua:IsHidden()
	return true
end
function modifier_templar_assassin_meld_lua:IsPurgable()
	return false
end
function modifier_templar_assassin_meld_lua:RemoveOnDeath()
	return false
end

function modifier_templar_assassin_meld_lua:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
end

function modifier_templar_assassin_meld_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}
end

function modifier_templar_assassin_meld_lua:OnAttack(keys)
	if not IsServer() then
		return
	end
	if keys.attacker ~= self.parent or self.parent:IsIllusion() or self.parent:PassivesDisabled() then
		return
	end
	if self.ability:IsFullyCastable() and not keys.no_attack_cooldown and not keys.target:IsWard() then
		self.meld_attack_id = keys.record
		self.ability:UseResources(false, false, false, true)
		local talent = self.caster:FindAbilityByName("special_bonus_unique_templar_assassin_8")
		if talent and talent:GetLevel() > 0 then
			self.ability:EndCooldown()
		end
	end
end

function modifier_templar_assassin_meld_lua:OnAttackLanded(keys)
	if not IsServer() then
		return
	end
	if keys.attacker ~= self:GetParent() then
		return
	end
	if keys.record == self.meld_attack_id then
		local target = keys.target
		if target and target:IsAlive() then
			target:EmitSound("Hero_TemplarAssassin.Meld.Attack")
			target:AddNewModifier(self.parent, self.ability, "modifier_templar_assassin_meld_lua_debuff", {
				duration = self.ability:GetSpecialValueFor("duration"),
			})

			ApplyDamage({
				victim = target,
				attacker = self.parent,
				damage = self.ability:GetSpecialValueFor("bonus_damage"),
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
				ability = self.ability,
			})
		end
		self.meld_attack_id = nil
	end
end

function modifier_templar_assassin_meld_lua:OnAttackFail(keys)
	if keys.record == self.meld_attack_id then
		self.meld_attack_id = nil
	end
end

function modifier_templar_assassin_meld_lua:GetModifierProjectileName()
	if self.meld_attack_id then
		return "particles/units/heroes/hero_templar_assassin/templar_assassin_meld_attack.vpcf"
	end
end

-----------------------------------------------------------------------------------

modifier_templar_assassin_meld_lua_debuff = class({})

function modifier_templar_assassin_meld_lua_debuff:IsDebuff()
	return true
end
function modifier_templar_assassin_meld_lua_debuff:IsPurgable()
	return true
end

function modifier_templar_assassin_meld_lua_debuff:OnCreated()
	local ability = self:GetAbility()
	self.armor_red = ability:GetSpecialValueFor("bonus_armor")

	if not IsServer() then
		return
	end
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_templar_assassin/templar_meld_overhead.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	self:AddParticle(pfx, false, false, -1, false, true)
end

function modifier_templar_assassin_meld_lua_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_templar_assassin_meld_lua_debuff:GetModifierPhysicalArmorBonus()
	return -self.armor_red
end

function modifier_templar_assassin_meld_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_templar_assassin/templar_assassin_meld_armor.vpcf"
end

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_templar_assassin_psi_blades_lua_damage",
	"heroes/hero_templar_assassin/hero_templar_assassin",
	LUA_MODIFIER_MOTION_NONE
)

templar_assassin_psi_blades_lua = class({})

function templar_assassin_psi_blades_lua:GetIntrinsicModifierName()
	return "modifier_templar_assassin_psi_blades_lua_damage"
end

function templar_assassin_psi_blades_lua:OnUpgrade()
	self.OnUpgrade = function() end
	if not IsServer() then
		return
	end
	self:ToggleAutoCast()
end

-----------------------------------------------------------------------------------

modifier_templar_assassin_psi_blades_lua_damage = class({})

function modifier_templar_assassin_psi_blades_lua_damage:IsHidden()
	return true
end

function modifier_templar_assassin_psi_blades_lua_damage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_templar_assassin_psi_blades_lua_damage:GetModifierAttackRangeBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_range")
end

function modifier_templar_assassin_psi_blades_lua_damage:OnAttackLanded(keys)
	if keys.attacker ~= self:GetParent() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end

	local ability = self:GetAbility()
	if not ability or not ability:IsTrained() then
		return
	end
	if not ability:GetAutoCastState() then
		return
	end

	local target = keys.target
	local spill_range = ability:GetSpecialValueFor("attack_spill_range")
	local spill_width = ability:GetSpecialValueFor("attack_spill_width")
	local spill_pct = ability:GetSpecialValueFor("attack_spill_pct")
	local attacker_pos = self:GetParent():GetAbsOrigin()
	local target_pos = target:GetAbsOrigin()

	local direction = (target_pos - attacker_pos):Normalized()
	local end_pos = target_pos + (direction * spill_range)

	local enemies = FindUnitsInLine(
		self:GetParent():GetTeamNumber(),
		target_pos,
		end_pos,
		nil,
		spill_width,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= target then
			enemy:EmitSound("Hero_TemplarAssassin.PsiBlade")
			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_templar_assassin/templar_assassin_psi_blade.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				target
			)
			ParticleManager:SetParticleControlEnt(
				pfx,
				0,
				target,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				target_pos,
				true
			)
			ParticleManager:SetParticleControlEnt(
				pfx,
				1,
				enemy,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				enemy:GetAbsOrigin(),
				true
			)
			ParticleManager:ReleaseParticleIndex(pfx)

			ApplyDamage({
				victim = enemy,
				damage = keys.damage * spill_pct * 0.01,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
					+ DOTA_DAMAGE_FLAG_HPLOSS
					+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
				attacker = self:GetParent(),
				ability = ability,
			})
		end
	end
end

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_templar_assassin_trap_lua",
	"heroes/hero_templar_assassin/hero_templar_assassin",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_templar_assassin_trap_lua_slow",
	"heroes/hero_templar_assassin/hero_templar_assassin",
	LUA_MODIFIER_MOTION_NONE
)

templar_assassin_trap_lua = class({})

function templar_assassin_trap_lua:CastFilterResult()
	local caster = self:GetCaster()

	if caster:HasModifier("modifier_guild_event") then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function templar_assassin_trap_lua:GetCustomCastError()
	return "#dota_hud_error_disabled_in_event"
end

function templar_assassin_trap_lua:OnSpellStart()
	local caster = self:GetCaster()
	local position = caster:GetAbsOrigin()

	caster:EmitSound("Hero_TemplarAssassin.Trap.Cast")

	if RollPercentage(50) then
		local sound = RollPercentage(2) and "templar_assassin_temp_psionictrap_04"
			or "templar_assassin_temp_psionictrap_0" .. RandomInt(1, 3)
		caster:EmitSound(sound)
	end

	local trap = CreateUnitByName(
		"npc_dota_templar_assassin_psionic_trap",
		position,
		false,
		caster,
		caster,
		caster:GetTeamNumber()
	)
	trap:SetControllableByPlayer(caster:GetPlayerID(), true)
	trap:AddNewModifier(caster, self, "modifier_kill", { duration = self:GetSpecialValueFor("duration") })
	trap:AddNewModifier(caster, self, "modifier_templar_assassin_trap_lua", {})
end

-------------------------------------------------------------------------------------------

modifier_templar_assassin_trap_lua = class({})

function modifier_templar_assassin_trap_lua:IsHidden()
	return true
end

function modifier_templar_assassin_trap_lua:OnCreated()
	if not IsServer() then
		return
	end
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_templar_assassin/templar_assassin_trap.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(pfx, 60, Vector(141, 0, 0))
	ParticleManager:SetParticleControl(pfx, 61, Vector(1, 0, 0))
	self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_templar_assassin_trap_lua:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = false,
	}
end

function modifier_templar_assassin_trap_lua:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()

	parent:EmitSound("Hero_TemplarAssassin.Trap.Explode")

	local explode = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_templar_assassin/templar_assassin_trap_explode.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(explode, 60, Vector(141, 0, 0))
	ParticleManager:SetParticleControl(explode, 61, Vector(1, 0, 0))
	ParticleManager:ReleaseParticleIndex(explode)

	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		parent,
		250,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(
			caster,
			ability,
			"modifier_templar_assassin_trap_lua_slow",
			{ duration = ability:GetSpecialValueFor("slow_duration") }
		)
	end
end

-------------------------------------------------------------------------------------------

modifier_templar_assassin_trap_lua_slow = class({})

function modifier_templar_assassin_trap_lua_slow:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_templar_assassin_trap_lua_slow:OnCreated()
	local abil = self:GetAbility()
	self.slow = abil:GetSpecialValueFor("slow") * -1
	self.damage = abil:GetSpecialValueFor("damage")
	if IsServer() then
		self:OnIntervalThink()
		self:StartIntervalThink(1)
	end
end

function modifier_templar_assassin_trap_lua_slow:OnIntervalThink()
	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})
end

function modifier_templar_assassin_trap_lua_slow:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_templar_assassin_trap_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_templar_assassin_trap_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_templar_assassin/templar_assassin_trap_slow.vpcf"
end

-------------------------------------------------------------------------

templar_assassin_trap_lua_teleport = class({})

function templar_assassin_trap_lua_teleport:CastFilterResult()
	local caster = self:GetCaster()

	if caster:HasModifier("modifier_guild_event") then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function templar_assassin_trap_lua_teleport:GetCustomCastError()
	return "#dota_hud_error_disabled_in_event"
end

function templar_assassin_trap_lua_teleport:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local origin_pos = caster:GetAbsOrigin()

	local trap_ability = caster:FindAbilityByName("templar_assassin_trap_lua")
	if not trap_ability then
		return
	end

	local radius = 250
	local damage = trap_ability:GetSpecialValueFor("damage")
	local slow_dur = trap_ability:GetSpecialValueFor("slow_duration")

	local all_units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin_pos,
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_CLOSEST,
		false
	)

	for _, unit in pairs(all_units) do
		if unit:GetUnitName() == "npc_dota_templar_assassin_psionic_trap" and unit:IsAlive() then
			local target_pos = unit:GetAbsOrigin()

			local enemies_origin = FindUnitsInRadius(
				caster:GetTeamNumber(),
				origin_pos,
				caster,
				radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				0,
				0,
				false
			)
			for _, enemy in pairs(enemies_origin) do
				self:ApplyTrapEffects(enemy, caster, trap_ability, slow_dur)
			end

			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_templar_assassin/templar_assassin_trap_explode.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(pfx, 0, origin_pos)
			ParticleManager:ReleaseParticleIndex(pfx)

			caster:EmitSound("Hero_TemplarAssassin.Trap.Cast")
			caster.isTeleporting = true
			FindClearSpaceForUnit(caster, target_pos, true)
			caster.isTeleporting = false

			unit:ForceKill(false)
			break
		end
	end
end

function templar_assassin_trap_lua_teleport:ApplyTrapEffects(target, caster, ability, duration)
	target:AddNewModifier(caster, ability, "modifier_templar_assassin_trap_lua_slow", { duration = duration })
end