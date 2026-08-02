--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_lich_frost_blast_lua", "abilities/bosses/lich/lich", LUA_MODIFIER_MOTION_NONE)

boss_lich_frost_blast_lua = class({})

function boss_lich_frost_blast_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_lich_frost_blast_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		self:PlayEffects()
		return
	end

	local duration = self:GetSpecialValueFor("duration")
	local damage_aoe = self:GetSpecialValueFor("aoe_damage") + self:GetSpecialValueFor("diff_boost_damage")
	local radius = self:GetSpecialValueFor("radius")

	local damageTable = {
		attacker = caster,
		damage = damage_aoe,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		enemy:AddNewModifier(caster, self, "modifier_boss_lich_frost_blast_lua", { duration = duration })
	end
	self:PlayEffects(target, radius)
end

function boss_lich_frost_blast_lua:PlayEffects(target, radius)
	local particle_cast = "particles/units/heroes/hero_lich/lich_frost_nova.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn("Ability.FrostNova", target)
end

--------------------------------------------------------------------------------

modifier_boss_lich_frost_blast_lua = class({})

function modifier_boss_lich_frost_blast_lua:IsHidden()
	return false
end

function modifier_boss_lich_frost_blast_lua:IsDebuff()
	return true
end

function modifier_boss_lich_frost_blast_lua:IsPurgable()
	return true
end

function modifier_boss_lich_frost_blast_lua:OnCreated(kv)
	self.as_slow = self:GetAbility():GetSpecialValueFor("slow_attack_speed")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("slow_movement_speed")
end

function modifier_boss_lich_frost_blast_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_boss_lich_frost_blast_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end

function modifier_boss_lich_frost_blast_lua:GetModifierAttackSpeedBonus_Constant()
	return -self.as_slow
end

function modifier_boss_lich_frost_blast_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_lich_frost_blast_lua", "abilities/bosses/lich/lich", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_lich_chain_frost_lua", "abilities/bosses/lich/lich", LUA_MODIFIER_MOTION_NONE)

boss_lich_chain_frost_lua = class({})

function boss_lich_chain_frost_lua:Precache(context)
	PrecacheResource("particle", "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost.vpcf", context)
end

function boss_lich_chain_frost_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_lich_chain_frost_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	self:CreateChainProjectile(caster, target, 0)
	EmitSoundOn("Hero_Lich.ChainFrost", caster)
end

function boss_lich_chain_frost_lua:CreateChainProjectile(source, target, current_jumps)
	local caster = self:GetCaster()
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local info = {
		Target = target,
		Source = source,
		Ability = self,
		EffectName = "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = false,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = self:GetSpecialValueFor("vision_radius"),
		iVisionTeamNumber = caster:GetTeamNumber(),
		ExtraData = {
			jumps_done = current_jumps,
		},
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function boss_lich_chain_frost_lua:OnProjectileHit_ExtraData(target, location, extraData)
	if not target or target:IsInvulnerable() or target:IsOutOfGame() then
		return
	end

	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local jump_range = self:GetSpecialValueFor("jump_range")
	local max_jumps = self:GetSpecialValueFor("jumps")
	local duration = self:GetSpecialValueFor("slow_duration")

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})

	target:AddNewModifier(caster, self, "modifier_boss_lich_chain_frost_lua", { duration = duration })

	local sound = target:IsHero() and "Hero_Lich.ChainFrostImpact.Hero" or "Hero_Lich.ChainFrostImpact.Creep"
	EmitSoundOn(sound, target)

	local current_jumps = extraData.jumps_done
	if current_jumps < max_jumps then
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetAbsOrigin(),
			nil,
			jump_range,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_CLOSEST,
			false
		)

		local next_target = nil
		for _, enemy in pairs(enemies) do
			if enemy ~= target and enemy:IsAlive() then
				next_target = enemy
				break
			end
		end

		if next_target then
			Timers:CreateTimer(0.2, function()
				self:CreateChainProjectile(target, next_target, current_jumps + 1)
			end)
		end
	end
	return true
end

--------------------------------------------------------------------------------

modifier_boss_lich_chain_frost_lua = class({})

function modifier_boss_lich_chain_frost_lua:OnCreated()
	self.as_slow = self:GetAbility():GetSpecialValueFor("slow_attack_speed")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("slow_movement_speed")
end

function modifier_boss_lich_chain_frost_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_boss_lich_chain_frost_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end
function modifier_boss_lich_chain_frost_lua:GetModifierAttackSpeedBonus_Constant()
	return -self.as_slow
end
function modifier_boss_lich_chain_frost_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_lich_ice_aura", "abilities/bosses/lich/lich", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_lich_ice_aura_debuff", "abilities/bosses/lich/lich", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_lich_ice_aura_debuff_timeout", "abilities/bosses/lich/lich", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_lich_ice_aura_freeze", "abilities/bosses/lich/lich", LUA_MODIFIER_MOTION_NONE)

boss_lich_ice_aura = class({})

function boss_lich_ice_aura:GetIntrinsicModifierName()
	return "modifier_boss_lich_ice_aura"
end

--------------------------------------------------------------------------------

modifier_boss_lich_ice_aura = class({})

function modifier_boss_lich_ice_aura:IsHidden()
	return true
end
function modifier_boss_lich_ice_aura:IsAura()
	return true
end

function modifier_boss_lich_ice_aura:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("max_distance")
	end
	return 0
end

function modifier_boss_lich_ice_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_boss_lich_ice_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_boss_lich_ice_aura:GetModifierAura()
	return "modifier_boss_lich_ice_aura_debuff"
end

--------------------------------------------------------------------------------

modifier_boss_lich_ice_aura_debuff = class({})

function modifier_boss_lich_ice_aura_debuff:IsDebuff()
	return true
end
function modifier_boss_lich_ice_aura_debuff:IsPurgable()
	return false
end

function modifier_boss_lich_ice_aura_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self.counter = 0
	self:StartIntervalThink(0.5)
end

function modifier_boss_lich_ice_aura_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not caster or caster:IsNull() or not ability or ability:IsNull() then
		return
	end

	local distance = (parent:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()
	local min_dist = ability:GetSpecialValueFor("min_distance")
	local max_dist = ability:GetSpecialValueFor("max_distance")
	local min_red = ability:GetSpecialValueFor("hp_regen_min")
	local max_red = ability:GetSpecialValueFor("hp_regen_max")
	local duration = ability:GetSpecialValueFor("duration")

	local current_reduction = 0
	if distance >= max_dist then
		current_reduction = min_red
	elseif distance <= min_dist then
		current_reduction = max_red
	else
		local range = max_dist - min_dist
		local pct = (distance - min_dist) / range
		current_reduction = max_red - (pct * (max_red - min_red))
	end

	if distance <= min_dist then
		self.counter = self.counter + 0.5
		if self.counter >= duration then
			if not parent:HasModifier("modifier_boss_lich_ice_aura_debuff_timeout") then
				parent:AddNewModifier(caster, ability, "modifier_boss_lich_ice_aura_freeze", { duration = duration })
				parent:AddNewModifier(
					caster,
					ability,
					"modifier_boss_lich_ice_aura_debuff_timeout",
					{ duration = duration + 3 }
				)
				self.counter = 0
			end
		end
	else
		self.counter = 0
	end
	self:SetStackCount(math.floor(current_reduction))
end

function modifier_boss_lich_ice_aura_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_boss_lich_ice_aura_debuff:GetModifierHPRegenAmplify_Percentage()
	return -self:GetStackCount()
end

--------------------------------------------------------------------------------

modifier_boss_lich_ice_aura_freeze = class({})

function modifier_boss_lich_ice_aura_freeze:IsDebuff()
	return true
end
function modifier_boss_lich_ice_aura_freeze:IsPurgable()
	return true
end

function modifier_boss_lich_ice_aura_freeze:OnCreated()
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("Hero_Lich.ChainFrostImpact.Hero")
end

function modifier_boss_lich_ice_aura_freeze:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end

function modifier_boss_lich_ice_aura_freeze:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
	return funcs
end

function modifier_boss_lich_ice_aura_freeze:GetDisableHealing()
	return 1
end

function modifier_boss_lich_ice_aura_freeze:GetEffectName()
	return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end

function modifier_boss_lich_ice_aura_freeze:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
--------------------------------------------------------------------------------

modifier_boss_lich_ice_aura_debuff_timeout = class({})

function modifier_boss_lich_ice_aura_debuff_timeout:IsHidden()
	return false
end
function modifier_boss_lich_ice_aura_debuff_timeout:IsDebuff()
	return false
end
function modifier_boss_lich_ice_aura_debuff_timeout:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_lich_pull_enemy", "abilities/bosses/lich/lich", LUA_MODIFIER_MOTION_NONE)

boss_lich_pull_enemy = class({})

function boss_lich_pull_enemy:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

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
		enemy:AddNewModifier(caster, self, "modifier_boss_lich_pull_enemy", { duration = duration })
	end

	caster:EmitSound("Hero_Lich.SinisterGaze.Cast")
end

--------------------------------------------------------------------------------

modifier_boss_lich_pull_enemy = class({})

function modifier_boss_lich_pull_enemy:IsHidden()
	return false
end
function modifier_boss_lich_pull_enemy:IsDebuff()
	return true
end
function modifier_boss_lich_pull_enemy:IsStunDebuff()
	return true
end
function modifier_boss_lich_pull_enemy:IsPurgable()
	return true
end

function modifier_boss_lich_pull_enemy:OnCreated()
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.pull_speed = self:GetAbility():GetSpecialValueFor("speed")

	ExecuteOrderFromTable({
		UnitIndex = self.parent:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
		TargetIndex = self.caster:entindex(),
	})

	self:StartIntervalThink(0.1)
end

function modifier_boss_lich_pull_enemy:OnIntervalThink()
	if not IsServer() then
		return
	end

	self.parent:MoveToNPC(self.caster)
end

function modifier_boss_lich_pull_enemy:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}
end

function modifier_boss_lich_pull_enemy:GetModifierMoveSpeed_Absolute()
	return self.pull_speed
end

function modifier_boss_lich_pull_enemy:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end

function modifier_boss_lich_pull_enemy:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:Stop()
end

function modifier_boss_lich_pull_enemy:GetEffectName()
	return "particles/units/heroes/hero_lich/lich_sinister_gaze.vpcf"
end

function modifier_boss_lich_pull_enemy:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end