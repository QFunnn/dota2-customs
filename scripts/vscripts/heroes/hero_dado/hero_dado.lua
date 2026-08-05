--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dado_storm_lua_thinker", "heroes/hero_dado/hero_dado", LUA_MODIFIER_MOTION_NONE)

dado_storm_lua = class({})

function dado_storm_lua:Precache(context)
	PrecacheResource("particle", "particles/dado_bolt.vpcf", context)
end

function dado_storm_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	local thinker = CreateModifierThinker(
		caster,
		self,
		"modifier_dado_storm_lua_thinker",
		{},
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)

	local modifier = thinker:FindModifierByName("modifier_dado_storm_lua_thinker")
	if modifier then
		modifier:Cast(target)
	end
end

-----------------------------------------------------------

modifier_dado_storm_lua_thinker = class({})

function modifier_dado_storm_lua_thinker:IsHidden()
	return true
end
function modifier_dado_storm_lua_thinker:IsPurgable()
	return false
end

function modifier_dado_storm_lua_thinker:OnCreated(kv)
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local mana = caster:GetMaxMana()

	self.delay = ability:GetSpecialValueFor("jump_delay")
	self.count = ability:GetSpecialValueFor("jump_count")
	self.radius = ability:GetSpecialValueFor("radius")
	self.damage = ability:GetSpecialValueFor("dmg") / 100

	self.targets = {}
	self.damageTable = {
		attacker = caster,
		damage = self.damage * mana,
		damage_type = ability:GetAbilityDamageType(),
		ability = ability,
	}
end

function modifier_dado_storm_lua_thinker:Cast(target)
	self.current_target = target
	self.started = false
	self:StartIntervalThink(self.delay)
end

function modifier_dado_storm_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self:GetParent())
end

function modifier_dado_storm_lua_thinker:OnIntervalThink()
	if not self.started then
		self.started = true
		self:Struck(self.current_target)
		return
	end

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self.current_target:GetOrigin(),
		self.current_target,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	local found = false
	for _, enemy in pairs(enemies) do
		if not self.targets[enemy] then
			found = true
			self.current_target = enemy
			self:Struck(enemy)
			break
		end
	end

	if not found then
		self:Destroy()
	end
end

function modifier_dado_storm_lua_thinker:Struck(target)
	if not target:IsMagicImmune() then
		self.damageTable.victim = target
		ApplyDamage(self.damageTable)
		self.targets[target] = true
	end

	self:PlayEffects(target)

	self.count = self.count - 1
	if self.count <= 0 then
		self:Destroy()
	end
end

function modifier_dado_storm_lua_thinker:PlayEffects(target)
	local effect_cast = ParticleManager:CreateParticle("particles/dado_bolt.vpcf", PATTACH_CUSTOMORIGIN, target)
	ParticleManager:SetParticleControl(effect_cast, 0, target:GetOrigin() + Vector(0, 0, 250))
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn("Hero_Enigma.MaleficeTick", target)
end

------------------------------------------------------------------
------------------------------------------------------------------

LinkLuaModifier("modifier_dado_tp_in_thinker", "heroes/hero_dado/hero_dado", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dado_tp_in_mana", "heroes/hero_dado/hero_dado", LUA_MODIFIER_MOTION_NONE)

dado_tp_in = class({})

function dado_tp_in:CastFilterResultLocation(location)
	if IsServer() then
		local caster = self:GetCaster()
		if caster:HasModifier("modifier_guild_event") then
			return UF_FAIL_CUSTOM
		end
	end
	return UF_SUCCESS
end

function dado_tp_in:GetCustomCastErrorLocation(location)
	return "#dota_hud_error_disabled_in_event"
end

function dado_tp_in:CastFilterResult()
	local caster = self:GetCaster()
	if caster:HasModifier("modifier_guild_event") then
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end

function dado_tp_in:GetCustomCastError()
	return "#dota_hud_error_disabled_in_event"
end

function dado_tp_in:Precache(context)
	PrecacheResource("particle", "particles/dado/portal_in.vpcf", context)
end

function dado_tp_in:GetIntrinsicModifierName()
	return "modifier_dado_tp_in_mana"
end

function dado_tp_in:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local position = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("dur")

	EmitSoundOn("Hero_Enigma.Black_Hole.Stop", caster)

	CreateModifierThinker(
		caster,
		self,
		"modifier_dado_tp_in_thinker",
		{ duration = duration },
		position,
		caster:GetTeamNumber(),
		false
	)
end

------------------------------------------------------------------

modifier_dado_tp_in_thinker = class({})

function modifier_dado_tp_in_thinker:OnCreated()
	if not IsServer() then
		return
	end
	local pos = self:GetParent():GetAbsOrigin()
	self.pfx = ParticleManager:CreateParticle("particles/dado/portal_in.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.pfx, 0, pos)
	self:StartIntervalThink(0.1)
end

function modifier_dado_tp_in_thinker:OnIntervalThink()
	local caster = self:GetCaster()
	local center = self:GetParent():GetAbsOrigin()
	local pos = self:GetParent():GetAbsOrigin()

	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		self:GetParent(),
		150,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, unit in pairs(units) do
		local thinkers = Entities:FindAllByClassname("npc_dota_thinker")
		for _, thinker in pairs(thinkers) do
			if thinker:HasModifier("modifier_dado_tp_out_thinker") then
				local target_pos = thinker:GetAbsOrigin()
				unit.isTeleporting = true
				FindClearSpaceForUnit(unit, target_pos, true)
				unit:EmitSound("Hero_Tinker.Teleport_Out")
				unit.isTeleporting = false
				return
			end
		end
	end
end

function modifier_dado_tp_in_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end

------------------------------------------------------------------

modifier_dado_tp_in_mana = class({})

function modifier_dado_tp_in_mana:IsHidden()
	return true
end

function modifier_dado_tp_in_mana:IsPurgable()
	return false
end

function modifier_dado_tp_in_mana:OnCreated()
	self.mana = self:GetAbility():GetSpecialValueFor("mana")
end

function modifier_dado_tp_in_mana:OnRefresh()
	self.mana = self:GetAbility():GetSpecialValueFor("mana")
end

function modifier_dado_tp_in_mana:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_BONUS,
	}
end

function modifier_dado_tp_in_mana:GetModifierManaBonus()
	return self.mana
end

------------------------------------------------------------------
------------------------------------------------------------------

LinkLuaModifier("modifier_dado_tp_out_thinker", "heroes/hero_dado/hero_dado", LUA_MODIFIER_MOTION_NONE)

dado_tp_out = class({})

function dado_tp_out:CastFilterResult()
	local caster = self:GetCaster()

	if caster:HasModifier("modifier_guild_event") then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function dado_tp_out:GetCustomCastError()
	return "#dota_hud_error_disabled_in_event"
end

function dado_tp_out:Precache(context)
	PrecacheResource("particle", "particles/dado/portal_out.vpcf", context)
end

function dado_tp_out:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local front = caster:GetForwardVector():Normalized()
	local position = caster:GetOrigin() + front * 100

	if self.last_thinker and not self.last_thinker:IsNull() then
		local old_modifier = self.last_thinker:FindModifierByName("modifier_dado_tp_out_thinker")
		if old_modifier then
			old_modifier:Destroy()
		end
		UTIL_Remove(self.last_thinker)
	end

	EmitSoundOn("Hero_Enigma.Black_Hole.Stop", caster)

	self.last_thinker =
		CreateModifierThinker(caster, self, "modifier_dado_tp_out_thinker", {}, position, caster:GetTeamNumber(), false)
end

------------------------------------------------------------------

modifier_dado_tp_out_thinker = class({})

function modifier_dado_tp_out_thinker:OnCreated()
	if not IsServer() then
		return
	end
	local pos = self:GetParent():GetAbsOrigin()
	self.pfx = ParticleManager:CreateParticle("particles/dado/portal_out.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.pfx, 0, pos)
end

function modifier_dado_tp_out_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end

------------------------------------------------------------------
------------------------------------------------------------------

LinkLuaModifier("modifier_dado_ampl", "heroes/hero_dado/hero_dado", LUA_MODIFIER_MOTION_NONE)

dado_ampl = class({})

function dado_ampl:GetIntrinsicModifierName()
	return "modifier_dado_ampl"
end

------------------------------------------------------------------

modifier_dado_ampl = class({})

function modifier_dado_ampl:IsHidden()
	return false
end
function modifier_dado_ampl:IsPurgable()
	return false
end

function modifier_dado_ampl:OnCreated(kv)
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.hit_counter = 0
	self:UpdateValues()

	if IsServer() then
		local field_fx =
			ParticleManager:CreateParticle("particles/dado_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
		self:AddParticle(field_fx, false, false, -1, true, true)
	end
end

function modifier_dado_ampl:OnRefresh(kv)
	self:UpdateValues()
end

function modifier_dado_ampl:UpdateValues()
	if not IsServer then
		return
	end
	if not self.ability or self.ability:IsNull() then
		return
	end

	local int_mult = self.ability:GetSpecialValueFor("attack_spill")
	self.spell_amp = self.parent:GetIntellect(true) * int_mult
	self.attack_life = self.ability:GetSpecialValueFor("attack_life")
end

function modifier_dado_ampl:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_dado_ampl:GetModifierSpellAmplify_Percentage()
	return self.spell_amp
end

function modifier_dado_ampl:OnTakeDamage(keys)
	if not IsServer() then
		return
	end

	if keys.unit ~= self.parent then
		return
	end
	if not self.parent:IsAlive() then
		return
	end
	if self.parent:IsIllusion() or self.parent:PassivesDisabled() then
		return
	end

	self.hit_counter = self.hit_counter + 1

	if self.hit_counter >= self.attack_life then
		self.hit_counter = 0
		local damage = keys.damage
		self.parent:SetHealth(math.min(self.parent:GetMaxHealth(), self.parent:GetHealth() + damage))
		local back_fx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_faceless_void/faceless_void_backtrack.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self.parent
		)
		ParticleManager:ReleaseParticleIndex(back_fx)
		self.parent:EmitSound("Hero_FacelessVoid.Backtrack")
	end
end

------------------------------------------------------------------
------------------------------------------------------------------

LinkLuaModifier("modifier_dado_passive", "heroes/hero_dado/hero_dado", LUA_MODIFIER_MOTION_NONE)

dado_passive = class({})

function dado_passive:GetIntrinsicModifierName()
	return "modifier_dado_passive"
end

--------------------------------------------------------------------------------

modifier_dado_passive = class({})

function modifier_dado_passive:IsHidden()
	return true
end
function modifier_dado_passive:IsPurgable()
	return false
end

function modifier_dado_passive:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_dado_passive:GetModifierHealthRegenPercentage()
	return -100
end

function modifier_dado_passive:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() then
		return
	end
	if params.target:IsBuilding() or params.target:IsOther() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end

	local caster = self:GetParent()
	local target = params.target
	local ability = self:GetAbility()

	local range = ability:GetSpecialValueFor("range")
	local damage = caster:GetAverageTrueAttackDamage(target)

	local caster_pos = caster:GetAbsOrigin()
	local target_pos = target:GetAbsOrigin()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target_pos,
		target,
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= target then
			local info = {
				Target = enemy,
				Source = target,
				Ability = ability,
				EffectName = "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf",
				iMoveSpeed = 9000,
				bDodgeable = false,
				ExtraData = { damage = damage },
			}
			ProjectileManager:CreateTrackingProjectile(info)
		end
	end
end

function dado_passive:OnProjectileHit_ExtraData(target, location, data)
	if not target then
		return
	end

	ApplyDamage({
		victim = target,
		attacker = self:GetCaster(),
		damage = data.damage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self,
	})
	target:EmitSound("Hero_Enigma.Projectiles")
end

------------------------------------------------------------------
------------------------------------------------------------------

LinkLuaModifier("modifier_dado_field", "heroes/hero_dado/hero_dado", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dado_field_debuff", "heroes/hero_dado/hero_dado", LUA_MODIFIER_MOTION_NONE)

dado_field = class({})

function dado_field:Precache(context)
	PrecacheResource("particle", "particles/dado_chronosphere.vpcf", context)
end

function dado_field:IsStealable()
	return true
end

function dado_field:IsHiddenWhenStolen()
	return false
end

function dado_field:GetAOERadius()
	return self:GetSpecialValueFor("radius") + RandomInt(1, 350)
end

function dado_field:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")
	CreateModifierThinker(
		caster,
		self,
		"modifier_dado_field",
		{ duration = duration },
		point,
		caster:GetTeamNumber(),
		false
	)
	EmitSoundOn("Hero_Enigma.Midnight_Pulse", caster)
end

---------------------------------------------------------------------------------------------------------------------

modifier_dado_field = class({})

function modifier_dado_field:IsHidden()
	return true
end
function modifier_dado_field:IsDebuff()
	return false
end
function modifier_dado_field:IsPurgable()
	return false
end
function modifier_dado_field:IsPurgeException()
	return false
end
function modifier_dado_field:RemoveOnDeath()
	return true
end
function modifier_dado_field:IsAura()
	return true
end
function modifier_dado_field:IsAuraActiveOnDeath()
	return false
end

function modifier_dado_field:GetAuraEntityReject(hEntity)
	if IsServer() then
	end
end

function modifier_dado_field:GetAuraRadius()
	return self.radius
end

function modifier_dado_field:GetAuraSearchFlags()
	return self:GetAbility():GetAbilityTargetFlags()
end

function modifier_dado_field:GetAuraSearchTeam()
	return self:GetAbility():GetAbilityTargetTeam()
end

function modifier_dado_field:GetAuraSearchType()
	return self:GetAbility():GetAbilityTargetType()
end

function modifier_dado_field:GetModifierAura()
	return "modifier_dado_field_debuff"
end

function modifier_dado_field:OnCreated()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.radius = self:GetAbility():GetAOERadius()
	if IsServer() then
		self.particle_time =
			ParticleManager:CreateParticle("particles/dado_chronosphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
		ParticleManager:SetParticleControl(self.particle_time, 0, self.parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(self.particle_time, 1, Vector(self.radius, self.radius, self.radius))

		self:AddParticle(self.particle_time, false, false, -1, false, false)
	end
end

---------------------------------------------------------------------------------------------------------------------

modifier_dado_field_debuff = class({})

function modifier_dado_field_debuff:IsHidden()
	return true
end
function modifier_dado_field_debuff:IsDebuff()
	return true
end
function modifier_dado_field_debuff:IsPurgable()
	return true
end
function modifier_dado_field_debuff:IsPurgeException()
	return true
end
function modifier_dado_field_debuff:RemoveOnDeath()
	return true
end

function modifier_dado_field_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_dado_field_debuff:OnCreated()
	if IsServer() then
		self.caster = self:GetCaster()
		self.parent = self:GetParent()
		self.ability = self:GetAbility()
		self.radius = (self:GetAuraOwner():FindModifierByName("modifier_dado_field").radius - 50) / 350

		self.dot_damage_min = self.ability:GetSpecialValueFor("dot_damage")
			+ self:GetCaster():ExtraIntelligenceDamage()
				* self.ability:GetSpecialValueFor("ExtraIntelligenceDamage")
		self.dot_damage_max = self.ability:GetSpecialValueFor("dot_damage_max")
			+ self:GetCaster():ExtraIntelligenceDamage()
				* self.ability:GetSpecialValueFor("ExtraIntelligenceDamage")
		self.dot_interval = self.ability:GetSpecialValueFor("dot_interval")

		local damageRange = self.dot_damage_max - self.dot_damage_min
		self.damage = self.dot_damage_max - (damageRange * self.radius)

		self:StartIntervalThink(self.dot_interval)
	end
end

function modifier_dado_field_debuff:OnIntervalThink()
	if IsServer() then
		local damage_table = {
			victim = self.parent,
			attacker = self.caster,
			damage = self.damage,
			damage_type = self.ability:GetAbilityDamageType(),
			ability = self.ability,
		}
		ApplyDamage(damage_table)
		EmitSoundOn("Ability.PlasmaFieldImpact", self.parent)
	end
end