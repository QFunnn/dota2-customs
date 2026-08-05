--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_mars_lil", "heroes/hero_mars/hero_mars", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_lil_debuff", "heroes/hero_mars/hero_mars", LUA_MODIFIER_MOTION_NONE)

mars_lil = class({})

function mars_lil:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shells_projectile.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_snapfire/hero_snapfire_shells_buff.vpcf", context)
end

function mars_lil:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(caster, self, "modifier_mars_lil", { duration = duration })
end

-------------------------------------------------------------------------------

modifier_mars_lil = class({})

function modifier_mars_lil:IsHidden()
	return false
end

function modifier_mars_lil:IsDebuff()
	return false
end

function modifier_mars_lil:IsStunDebuff()
	return false
end

function modifier_mars_lil:IsPurgable()
	return true
end

function modifier_mars_lil:OnCreated(kv)
	self.caster = self:GetCaster()
	self.attacks = self:GetAbility():GetSpecialValueFor("attacks")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.as_bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
	self.range_bonus = self:GetAbility():GetSpecialValueFor("attack_range_bonus")
	self.bat = self:GetAbility():GetSpecialValueFor("base_attack_time")
	self.slow = self:GetAbility():GetSpecialValueFor("loss_duration")

	if not IsServer() then
		return
	end

	self:SetStackCount(self.attacks)
	self.records = {}
	self:PlayEffects()
	EmitSoundOn("Hero_Snapfire.ExplosiveShells.Cast", self:GetParent())
end

function modifier_mars_lil:OnDestroy()
	if not IsServer() then
		return
	end
	StopSoundOn("Hero_Snapfire.ExplosiveShells.Cast", self:GetParent())
end

function modifier_mars_lil:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
	}
	return funcs
end

function modifier_mars_lil:OnAttack(params)
	if params.attacker ~= self:GetParent() then
		return
	end
	if self:GetStackCount() <= 0 then
		self:Destroy()
		return
	end

	self.records[params.record] = true

	EmitSoundOn("Hero_Snapfire.ExplosiveShellsBuff.Attack", self:GetParent())

	if self:GetStackCount() > 0 then
		self:DecrementStackCount()
	end
end

function modifier_mars_lil:OnAttackLanded(params)
	if params.attacker ~= self:GetParent() then
		return
	end
	if self.records[params.record] then
		params.target:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_mars_lil_debuff",
			{ duration = self.slow }
		)
		EmitSoundOn("Hero_Snapfire.ExplosiveShellsBuff.Target", params.target)
	end
end

function modifier_mars_lil:OnAttackRecordDestroy(params)
	if self.records[params.record] then
		self.records[params.record] = nil

		if next(self.records) == nil and self:GetStackCount() <= 0 then
			self:Destroy()
		end
	end
end

function modifier_mars_lil:GetModifierProjectileName()
	if self:GetStackCount() <= 0 then
		return
	end
	return "particles/units/heroes/hero_snapfire/hero_snapfire_shells_projectile.vpcf"
end

function modifier_mars_lil:GetModifierPreAttack_BonusDamage()
	if self:GetStackCount() <= 0 then
		return
	end
	return self.damage
end

function modifier_mars_lil:GetModifierAttackRangeBonus()
	if self:GetStackCount() <= 0 then
		return
	end
	return self.range_bonus
end

function modifier_mars_lil:GetModifierAttackSpeedBonus_Constant()
	if self:GetStackCount() <= 0 then
		return
	end
	return self.as_bonus
end

function modifier_mars_lil:GetModifierBaseAttackTimeConstant()
	if self:GetStackCount() <= 0 then
		return
	end
	local bat = self.bat
	local parent = self:GetParent()
	if parent and parent.dms_bat_factor then
		bat = bat * parent.dms_bat_factor
	end
	return bat
end

function modifier_mars_lil:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_shells_buff.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		4,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		5,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)

	self:AddParticle(effect_cast, false, false, -1, false, false)
end

-------------------------------------------------------------------------------

modifier_mars_lil_debuff = class({})

function modifier_mars_lil_debuff:IsHidden()
	return false
end

function modifier_mars_lil_debuff:IsDebuff()
	return true
end

function modifier_mars_lil_debuff:IsStunDebuff()
	return false
end

function modifier_mars_lil_debuff:IsPurgable()
	return true
end

function modifier_mars_lil_debuff:OnCreated(kv)
	self.loss = self:GetAbility():GetSpecialValueFor("loss_armor") * -1
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_mars_lil_debuff:OnRefresh(kv)
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end

function modifier_mars_lil_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_mars_lil_debuff:GetModifierPhysicalArmorBonus()
	return self.loss * self:GetStackCount()
end

function modifier_mars_lil_debuff:GetEffectName()
	return "particles/units/heroes/hero_sniper/sniper_headshot_slow.vpcf"
end

function modifier_mars_lil_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_mars_gods_rebuke_lua", "heroes/hero_mars/hero_mars", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_generic_knockback_lua",
	"heroes/generic/modifier_generic_knockback_lua",
	LUA_MODIFIER_MOTION_BOTH
)

mars_gods_rebuke_lua = class({})

function mars_gods_rebuke_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_mars/mars_shield_bash.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf", context)
end

function mars_gods_rebuke_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")
	local angle = self:GetSpecialValueFor("angle") / 2
	local duration = self:GetSpecialValueFor("knockback_duration")
	local distance = self:GetSpecialValueFor("knockback_distance")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)

	local buff = caster:AddNewModifier(caster, self, "modifier_mars_gods_rebuke_lua", {})

	local origin = caster:GetOrigin()
	local cast_direction = (point - origin):Normalized()
	local cast_angle = VectorToAngles(cast_direction).y

	local caught = false
	for _, enemy in pairs(enemies) do
		local enemy_direction = (enemy:GetOrigin() - origin):Normalized()
		local enemy_angle = VectorToAngles(enemy_direction).y
		local angle_diff = math.abs(AngleDiff(cast_angle, enemy_angle))
		if angle_diff <= angle then
			caster:PerformAttack(enemy, true, true, true, true, true, false, true)

			if not (enemy:HasModifier("modifier_mars_spear_of_mars_lua_debuff") or enemy:IsAncient()) then
				enemy:AddNewModifier(caster, self, "modifier_generic_knockback_lua", {
					duration = duration,
					distance = distance,
					height = 30,
					direction_x = enemy_direction.x,
					direction_y = enemy_direction.y,
				})
			end
			caught = true
			self:PlayEffects2(enemy, origin, cast_direction)
		end
	end

	buff:Destroy()
	self:PlayEffects1(caught, (point - origin):Normalized())
end

function mars_gods_rebuke_lua:PlayEffects1(caught, direction)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_mars/mars_shield_bash.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetCaster():GetOrigin())
	ParticleManager:SetParticleControlForward(effect_cast, 0, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Hero_Mars.Shield.Cast"
	-- EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

function mars_gods_rebuke_lua:PlayEffects2(target, origin, direction)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf",
		PATTACH_WORLDORIGIN,
		target
	)
	ParticleManager:SetParticleControl(effect_cast, 0, target:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:SetParticleControlForward(effect_cast, 1, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn("Hero_Mars.Shield.Crit", target)
end

-------------------------------------------------------------------------------

modifier_mars_gods_rebuke_lua = class({})

function modifier_mars_gods_rebuke_lua:IsHidden()
	return true
end

function modifier_mars_gods_rebuke_lua:IsDebuff()
	return false
end

function modifier_mars_gods_rebuke_lua:IsPurgable()
	return false
end

function modifier_mars_gods_rebuke_lua:OnCreated(kv)
	self.caster = self:GetCaster()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("damage")
	self.bonus_crit = self:GetAbility():GetSpecialValueFor("crit_mult")
end

function modifier_mars_gods_rebuke_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
	return funcs
end

function modifier_mars_gods_rebuke_lua:GetModifierPreAttack_BonusDamagePostCrit(params)
	if not IsServer() then
		return
	end
	return self.bonus_damage
end

function modifier_mars_gods_rebuke_lua:GetModifierPreAttack_CriticalStrike(params)
	return self.bonus_crit
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_mars_bulwark_lua", "heroes/hero_mars/hero_mars", LUA_MODIFIER_MOTION_NONE)

mars_bulwark_lua = class({})

function mars_bulwark_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_mars/mars_shield_of_mars_small.vpcf", context)
end

function mars_bulwark_lua:GetIntrinsicModifierName()
	return "modifier_mars_bulwark_lua"
end

-------------------------------------------------------------------------------

modifier_mars_bulwark_lua = class({})

function modifier_mars_bulwark_lua:IsHidden()
	return false
end

function modifier_mars_bulwark_lua:IsDebuff()
	return false
end

function modifier_mars_bulwark_lua:IsStunDebuff()
	return false
end

function modifier_mars_bulwark_lua:IsPurgable()
	return false
end

function modifier_mars_bulwark_lua:OnCreated(kv)
	self.angle_front = self:GetAbility():GetSpecialValueFor("forward_angle") / 2
	self.angle_side = self:GetAbility():GetSpecialValueFor("side_angle") / 2
end

function modifier_mars_bulwark_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}
	return funcs
end

function modifier_mars_bulwark_lua:GetModifierPhysical_ConstantBlock(params)
	if params.inflictor then
		return 0
	end

	if params.target:PassivesDisabled() then
		return 0
	end

	local parent = params.target
	local attacker = params.attacker
	local reduction = 0

	local facing_direction = parent:GetAnglesAsVector().y
	local attacker_vector = (attacker:GetOrigin() - parent:GetOrigin())
	local attacker_direction = VectorToAngles(attacker_vector).y
	local angle_diff = math.abs(AngleDiff(facing_direction, attacker_direction))

	if angle_diff < self.angle_front then
		reduction = self:GetAbility():GetSpecialValueFor("physical_damage_reduction")
		self:PlayEffects(true, attacker_vector)
	elseif angle_diff < self.angle_side then
		reduction = self:GetAbility():GetSpecialValueFor("physical_damage_reduction_side")
		self:PlayEffects(false, attacker_vector)
	end
	return reduction * params.damage / 100
end

function modifier_mars_bulwark_lua:PlayEffects(front)
	local particle_cast = "particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf"
	local sound_cast = "Hero_Mars.Shield.Block"

	if not front then
		particle_cast = "particles/units/heroes/hero_mars/mars_shield_of_mars_small.vpcf"
		sound_cast = "Hero_Mars.Shield.BlockSmall"
	end

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetParent())
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_mars_atrophy_aura_lua", "heroes/hero_mars/hero_mars", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_atrophy_aura_lua_debuff", "heroes/hero_mars/hero_mars", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mars_atrophy_aura_lua_stack", "heroes/hero_mars/hero_mars", LUA_MODIFIER_MOTION_NONE)

mars_atrophy_aura_lua = class({})

function mars_atrophy_aura_lua:GetIntrinsicModifierName()
	return "modifier_mars_atrophy_aura_lua"
end

--------------------------------------------------------------------------------

modifier_mars_atrophy_aura_lua = class({})

function modifier_mars_atrophy_aura_lua:IsHidden()
	return self:GetStackCount() == 0
end
function modifier_mars_atrophy_aura_lua:IsPurgable()
	return false
end
function modifier_mars_atrophy_aura_lua:RemoveOnDeath()
	return false
end

function modifier_mars_atrophy_aura_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_mars_atrophy_aura_lua:OnCreated()
	self.bonus = self:GetAbility():GetSpecialValueFor("bonus_damage_from_creep")
	self.duration = self:GetAbility():GetSpecialValueFor("bonus_damage_duration")
end

function modifier_mars_atrophy_aura_lua:OnRefresh()
	self.bonus = self:GetAbility():GetSpecialValueFor("bonus_damage_from_creep")
	self.duration = self:GetAbility():GetSpecialValueFor("bonus_damage_duration")
end

function modifier_mars_atrophy_aura_lua:OnDeath(params)
	if not IsServer() then
		return
	end
	if params.unit:IsIllusion() or params.unit == self:GetParent() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if not params.unit:FindModifierByNameAndCaster("modifier_mars_atrophy_aura_lua_debuff", self:GetParent()) then
		return
	end
	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return
	end

	self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_mars_atrophy_aura_lua_stack",
		{ duration = self.duration }
	)

	self:UpdateStacks()
end

function modifier_mars_atrophy_aura_lua:UpdateStacks()
	if not IsServer() then
		return
	end
	local count = self:GetParent():FindAllModifiersByName("modifier_mars_atrophy_aura_lua_stack")
	self:SetStackCount(#count)
end

function modifier_mars_atrophy_aura_lua:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount() * self.bonus
end

function modifier_mars_atrophy_aura_lua:IsAura()
	return not self:GetParent():PassivesDisabled()
end
function modifier_mars_atrophy_aura_lua:GetModifierAura()
	return "modifier_mars_atrophy_aura_lua_debuff"
end
function modifier_mars_atrophy_aura_lua:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end
function modifier_mars_atrophy_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_mars_atrophy_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

modifier_mars_atrophy_aura_lua_debuff = class({})

function modifier_mars_atrophy_aura_lua_debuff:IsHidden()
	return true
end
function modifier_mars_atrophy_aura_lua_debuff:IsDebuff()
	return true
end

function modifier_mars_atrophy_aura_lua_debuff:OnCreated()
	self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction_pct")
end

function modifier_mars_atrophy_aura_lua_debuff:OnRefresh()
	self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction_pct")
end

function modifier_mars_atrophy_aura_lua_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end

function modifier_mars_atrophy_aura_lua_debuff:GetModifierBaseDamageOutgoing_Percentage()
	return -self.reduction
end

--------------------------------------------------------------------------------

modifier_mars_atrophy_aura_lua_stack = class({})

function modifier_mars_atrophy_aura_lua_stack:IsHidden()
	return true
end
function modifier_mars_atrophy_aura_lua_stack:IsPurgable()
	return false
end
function modifier_mars_atrophy_aura_lua_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_mars_atrophy_aura_lua_stack:OnDestroy()
	if not IsServer() then
		return
	end
	local main_mod = self:GetParent():FindModifierByName("modifier_mars_atrophy_aura_lua")
	if main_mod then
		main_mod:UpdateStacks()
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------