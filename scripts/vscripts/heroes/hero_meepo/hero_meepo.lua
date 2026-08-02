--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_meepo_earthbind_lua", "heroes/hero_meepo/hero_meepo", LUA_MODIFIER_MOTION_NONE)

meepo_earthbind_lua = class({})

function meepo_earthbind_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_meepo/meepo_earthbind_projectile_fx.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_meepo/meepo_earthbind.vpcf", context)
end

function meepo_earthbind_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius") or self:GetCastRange(caster:GetAbsOrigin(), nil)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	if #enemies > 0 then
		local target = enemies[1]
		local info = {
			Target = target,
			Source = caster,
			Ability = self,
			EffectName = "particles/units/heroes/hero_meepo/meepo_earthbind_projectile_fx.vpcf",
			iMoveSpeed = self:GetSpecialValueFor("net_speed"),
			bDodgeable = true,
		}
		ProjectileManager:CreateTrackingProjectile(info)
		caster:EmitSound("Hero_Meepo.Earthbind.Cast")
	end
end

function meepo_earthbind_lua:OnProjectileHit(target, location)
	if not target or target:IsMagicImmune() then
		return
	end

	target:AddNewModifier(self:GetCaster(), self, "modifier_meepo_earthbind_lua", {
		duration = self:GetSpecialValueFor("duration"),
	})
	target:EmitSound("Hero_Meepo.Earthbind.Target")
	return true
end

--------------------------------------------------------------------------------

modifier_meepo_earthbind_lua = class({})

function modifier_meepo_earthbind_lua:IsDebuff()
	return true
end
function modifier_meepo_earthbind_lua:CheckState()
	return { [MODIFIER_STATE_ROOTED] = true }
end

function modifier_meepo_earthbind_lua:OnCreated()
	if not IsServer() then
		return
	end

	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	local interval = 0.5
	local attr_pct = self.ability:GetSpecialValueFor("bonus_atr_damage") / 100
	local base_damage = self.ability:GetSpecialValueFor("damage")
	local main_stat = 0

	if self.caster:IsHero() then
		main_stat = self.caster:GetPrimaryStatValue()
	end

	self.tick_damage = (base_damage + (main_stat * attr_pct)) * interval

	self:StartIntervalThink(interval)
	self:OnIntervalThink()
end

function modifier_meepo_earthbind_lua:OnIntervalThink()
	ApplyDamage({
		victim = self.parent,
		attacker = self.caster,
		damage = self.tick_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})
end

function modifier_meepo_earthbind_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end

function modifier_meepo_earthbind_lua:GetModifierIncomingDamage_Percentage(params)
	if not IsServer() then
		return
	end

	if params.attacker == self.caster then
		local inflictor = params.inflictor
		if inflictor then
			local name = inflictor:GetAbilityName()
			if name == "meepo_poof_lua" or name == "meepo_ransack_lua" then
				return self.ability:GetSpecialValueFor("bonus_other_spell_damage")
			end
		end
	end
	return 0
end

function modifier_meepo_earthbind_lua:GetEffectName()
	return "particles/units/heroes/hero_meepo/meepo_earthbind.vpcf"
end

function modifier_meepo_earthbind_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

meepo_poof_lua = class({})

function meepo_poof_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_meepo/meepo_poof_end.vpcf", context)
end

function meepo_poof_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local origin_caster = caster:GetOrigin()
	local origin_target = target:GetOrigin()
	local radius = self:GetSpecialValueFor("damage_radius")
	local attr_pct = self:GetSpecialValueFor("bonus_atr_damage") / 100
	local base_damage = self:GetSpecialValueFor("damage")
	local main_stat = 0

	if caster:IsHero() then
		main_stat = caster:GetPrimaryStatValue()
	end

	self.damage = base_damage + (main_stat * attr_pct)

	local units = _G.OldFindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)
	for i, unit in ipairs(units) do
		ApplyDamage({
			victim = unit,
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self,
		})
	end

	self:PlayEffects(caster)

	caster:SetAbsOrigin(origin_target)
	FindClearSpaceForUnit(caster, origin_target, true)

	caster:Stop()
	local units = _G.OldFindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		target:GetOrigin(),
		target,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)
	for i, unit in ipairs(units) do
		ApplyDamage({
			victim = unit,
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self,
		})
	end
	Timers:CreateTimer(0.1, function()
		self:PlayEffects(caster)
	end)
end

function meepo_poof_lua:PlayEffects(caster)
	caster:EmitSound("Hero_Meepo.Poof.End00")
	local particle_index = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_meepo/meepo_poof_end.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle_index, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_index, 1, Vector(375, 375, 375))
	ParticleManager:ReleaseParticleIndex(particle_index)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_meepo_ransack_lua", "heroes/hero_meepo/hero_meepo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_meepo_ransack_stack", "heroes/hero_meepo/hero_meepo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_meepo_ransack_stack_instance", "heroes/hero_meepo/hero_meepo", LUA_MODIFIER_MOTION_NONE)

meepo_ransack_lua = class({})

function meepo_ransack_lua:GetIntrinsicModifierName()
	return "modifier_meepo_ransack_lua"
end

--------------------------------------------------------------------------------

modifier_meepo_ransack_lua = class({})

function modifier_meepo_ransack_lua:IsHidden()
	return true
end
function modifier_meepo_ransack_lua:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_meepo_ransack_lua:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() or params.target:IsBuilding() or params.target:IsOther() then
		return
	end

	local caster = self:GetCaster()
	local target = params.target
	local ability = self:GetAbility()

	local steal_base = ability:GetSpecialValueFor("steal")
	local attr_pct = ability:GetSpecialValueFor("bonus_atr_damage") / 100
	local main_stat = caster:IsHero() and caster:GetPrimaryStatValue() or 0
	local total_damage = steal_base + (main_stat * attr_pct)

	local king_mod = caster:FindModifierByName("modifier_meepo_king_active")
	if king_mod then
		local current_hp = caster:GetHealth()
		local max_hp = caster:GetMaxHealth()
		local heal_amount = total_damage

		if current_hp >= max_hp then
			caster:AddNewModifier(caster, ability, "modifier_meepo_king_shield", {
				duration = 5,
				shield_value = heal_amount,
			})
		else
			local overflow = (current_hp + heal_amount) - max_hp
			caster:Heal(heal_amount, ability)
			if overflow > 0 then
				caster:AddNewModifier(caster, ability, "modifier_meepo_king_shield", {
					duration = 5,
					shield_value = overflow,
				})
			end
		end
	else
		caster:Heal(total_damage, ability)
	end

	ApplyDamage({
		victim = target,
		attacker = params.attacker,
		damage = total_damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = ability,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
	})

	local p_heal = ParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(p_heal)
	EmitSoundOn("Hero_Meepo.Ransack", caster)

	local duration = ability:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, ability, "modifier_meepo_ransack_stack_instance", { duration = duration })
	caster:AddNewModifier(caster, ability, "modifier_meepo_ransack_stack", { duration = duration })
end

--------------------------------------------------------------------------------

modifier_meepo_ransack_stack_instance = class({})

function modifier_meepo_ransack_stack_instance:IsHidden()
	return true
end
function modifier_meepo_ransack_stack_instance:IsPurgable()
	return false
end
function modifier_meepo_ransack_stack_instance:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_meepo_ransack_stack_instance:OnDestroy()
	if not IsServer() then
		return
	end
	local main_mod = self:GetParent():FindModifierByName("modifier_meepo_ransack_stack")
	if main_mod then
		main_mod:UpdateStacks()
	end
end

--------------------------------------------------------------------------------

modifier_meepo_ransack_stack = class({})

function modifier_meepo_ransack_stack:OnCreated()
	self.as_per_stack = self:GetAbility():GetSpecialValueFor("as")
	self.max_stacks = self:GetAbility():GetSpecialValueFor("count")
	if IsServer() then
		self:UpdateStacks()
	end
end

function modifier_meepo_ransack_stack:OnRefresh()
	if IsServer() then
		self:UpdateStacks()
	end
end

function modifier_meepo_ransack_stack:UpdateStacks()
	if not IsServer() then
		return
	end
	local instances = self:GetParent():FindAllModifiersByName("modifier_meepo_ransack_stack_instance")
	local count = #instances
	if count > self.max_stacks then
		count = self.max_stacks
	end

	self:SetStackCount(count)
	if count <= 0 then
		self:Destroy()
	end
end

function modifier_meepo_ransack_stack:DeclareFunctions()
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end

function modifier_meepo_ransack_stack:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount() * self.as_per_stack
end

function modifier_meepo_ransack_stack:GetTexture()
	return "meepo_ransack"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_meepo_king_passive", "heroes/hero_meepo/hero_meepo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_meepo_king_active", "heroes/hero_meepo/hero_meepo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_meepo_king_debuff", "heroes/hero_meepo/hero_meepo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_meepo_king_shield", "heroes/hero_meepo/hero_meepo", LUA_MODIFIER_MOTION_NONE)

meepo_king_lua = class({})

function meepo_king_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_meepo/meepo_poof_end.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap.vpcf", context)
end

function meepo_king_lua:GetIntrinsicModifierName()
	return "modifier_meepo_king_passive"
end

function meepo_king_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	caster:AddNewModifier(caster, self, "modifier_meepo_king_active", { duration = duration })
	caster:EmitSound("Hero_Meepo.Earthbind.Cast")

	local p_burst = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_meepo/meepo_poof_end.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(p_burst, 1, Vector(500, 500, 500))
	ParticleManager:ReleaseParticleIndex(p_burst)
end

--------------------------------------------------------------------------------

modifier_meepo_king_passive = class({})

function modifier_meepo_king_passive:IsHidden()
	return true
end
function modifier_meepo_king_passive:IsPurgable()
	return false
end

function modifier_meepo_king_passive:OnCreated(kv)
	self.ability = self:GetAbility()
	self.bonus_dmg_value = 0
	self:SetHasCustomTransmitterData(true)
	self:OnRefresh(kv)
end

function modifier_meepo_king_passive:OnRefresh(kv)
	if not self.ability or self.ability:IsNull() then
		return
	end
	self.expa = self.ability:GetSpecialValueFor("bonus_exp")
	self.dmg = self.ability:GetSpecialValueFor("bonus_dmg")
	self.all = self.ability:GetSpecialValueFor("bonus_all")

	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end

function modifier_meepo_king_passive:OnIntervalThink()
	if IsServer() then
		local parent = self:GetParent()
		if parent and not parent:IsNull() and self.ability and not self.ability:IsNull() then
			local pct = self.ability:GetSpecialValueFor("bonus_dmg")
			local base_avg = (parent:GetBaseDamageMin() + parent:GetBaseDamageMax()) / 2
			self.bonus_dmg_value = base_avg * (pct / 100)
			self:SendBuffRefreshToClients()
		end
	end
end

function modifier_meepo_king_passive:AddCustomTransmitterData()
	return {
		bonus_dmg = self.bonus_dmg_value or 0,
	}
end

function modifier_meepo_king_passive:HandleCustomTransmitterData(data)
	self.bonus_dmg_value = data.bonus_dmg
end

function modifier_meepo_king_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_meepo_king_passive:GetModifierBaseAttack_BonusDamage()
	return self.bonus_dmg_value
end

function modifier_meepo_king_passive:GetModifierPercentageExpRateBoost()
	return self.expa
end

function modifier_meepo_king_passive:GetModifierBonusStats_Strength()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()

	if self.lock_str then
		return 0
	end
	self.lock_str = true
	local current_stat = parent:GetStrength()
	self.lock_str = false

	return current_stat * (self.all / 100)
end

function modifier_meepo_king_passive:GetModifierBonusStats_Agility()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()

	if self.lock_agi then
		return 0
	end
	self.lock_agi = true
	local current_stat = parent:GetAgility()
	self.lock_agi = false

	return current_stat * (self.all / 100)
end

function modifier_meepo_king_passive:GetModifierBonusStats_Intellect()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()

	if self.lock_int then
		return 0
	end
	self.lock_int = true
	local current_stat = parent:GetIntellect(true)
	self.lock_int = false

	return current_stat * (self.all / 100)
end

function modifier_meepo_king_passive:GetModifierModelScale()
	return self.ability:GetSpecialValueFor("model_multiplier")
end

--------------------------------------------------------------------------------

modifier_meepo_king_active = class({})

function modifier_meepo_king_active:OnCreated()
	if not IsServer() then
		return
	end
	self.nFXIndex = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.nFXIndex, 1, Vector(500, 500, 500))
end

function modifier_meepo_king_active:OnDestroy()
	if not IsServer() then
		return
	end
	ParticleManager:DestroyParticle(self.nFXIndex, false)
end

function modifier_meepo_king_active:IsAura()
	return true
end
function modifier_meepo_king_active:GetModifierAura()
	return "modifier_meepo_king_debuff"
end
function modifier_meepo_king_active:GetAuraRadius()
	return 500
end
function modifier_meepo_king_active:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_meepo_king_active:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

modifier_meepo_king_debuff = class({})

function modifier_meepo_king_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self:StartIntervalThink(1)
end

function modifier_meepo_king_debuff:OnIntervalThink()
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", { duration = 0.1 })
	local p = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_meepo/meepo_earthbind_target.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(p)
end

function modifier_meepo_king_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_meepo_king_debuff:GetModifierPhysicalArmorBonus()
	return -self:GetAbility():GetSpecialValueFor("disarm")
end

--------------------------------------------------------------------------------

modifier_meepo_king_shield = class({})

function modifier_meepo_king_shield:IsHidden()
	return true
end
function modifier_meepo_king_shield:IsPurgable()
	return false
end

function modifier_meepo_king_shield:OnCreated(params)
	self:SetHasCustomTransmitterData(true)
	self.shield = 0

	if IsServer() then
		self.shield = params.shield_value or 0
		self:SetStackCount(self.shield)
		self:SendBuffRefreshToClients()
	end
end

function modifier_meepo_king_shield:OnRefresh(params)
	if IsServer() then
		self.shield = self.shield + (params.shield_value or 0)
		self:SetStackCount(self.shield)
		self:SendBuffRefreshToClients()
	end
end

function modifier_meepo_king_shield:AddCustomTransmitterData()
	return {
		shield = self.shield,
	}
end

function modifier_meepo_king_shield:HandleCustomTransmitterData(data)
	self.shield = data.shield
end

function modifier_meepo_king_shield:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
end

function modifier_meepo_king_shield:GetModifierIncomingDamageConstant(event)
	if not IsServer() then
		if self.shield > 0 then
			return self.shield
		end
		return 0
	end

	if self.shield > 0 then
		local damage = event.damage

		if damage < self.shield then
			self.shield = self.shield - damage
			self:SetStackCount(self.shield)
			self:SendBuffRefreshToClients()
			return -damage
		else
			local blocked = self.shield
			self.shield = 0
			self:SetStackCount(0)
			self:Destroy()
			return -blocked
		end
	end
	return 0
end