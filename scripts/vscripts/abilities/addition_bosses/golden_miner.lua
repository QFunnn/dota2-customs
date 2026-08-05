--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_golden_miner_crushing_rift",
	"abilities/addition_bosses/golden_miner",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_golden_miner_fracture_debuff",
	"abilities/addition_bosses/golden_miner",
	LUA_MODIFIER_MOTION_NONE
)

golden_miner_crushing_rift = class({})

function golden_miner_crushing_rift:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_tiny/tiny_avalanche_projectile.vpcf", context)
end

function golden_miner_crushing_rift:GetIntrinsicModifierName()
	return "modifier_golden_miner_crushing_rift"
end

--------------------------------------------------------------------------------

modifier_golden_miner_crushing_rift = class({})

function modifier_golden_miner_crushing_rift:IsHidden()
	return true
end

function modifier_golden_miner_crushing_rift:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_golden_miner_crushing_rift:OnAttackLanded(params)
	if params.attacker ~= self:GetParent() then
		return
	end
	if params.target:IsBuilding() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end

	local caster = self:GetParent()
	local casterPos = caster:GetAbsOrigin()
	local distance = self:GetAbility():GetSpecialValueFor("distance")
	local start_radius = 100
	local end_radius = 360
	local speed = 1500

	local forward = caster:GetForwardVector()

	local info = {
		Ability = self:GetAbility(),
		EffectName = "particles/units/heroes/hero_tiny/tiny_avalanche_projectile.vpcf",
		vSpawnOrigin = casterPos,
		fDistance = distance,
		fStartRadius = start_radius,
		fEndRadius = end_radius,
		Source = caster,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		vVelocity = forward * speed,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	}

	ProjectileManager:CreateLinearProjectile(info)
	caster:EmitSound("Hero_Tiny.Avalanche")
end

function golden_miner_crushing_rift:OnProjectileHit(target, location)
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local debuff_duration = self:GetSpecialValueFor("debuff_duration")
	if target then
		local caster = self:GetCaster()

		ApplyDamage({
			victim = target,
			attacker = caster,
			damage = caster:GetAverageTrueAttackDamage(caster),
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		})

		target:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration })
		target:AddNewModifier(caster, self, "modifier_golden_miner_fracture_debuff", { duration = debuff_duration })
	end
	return false
end

--------------------------------------------------------------------------------

modifier_golden_miner_fracture_debuff = class({
	IsDebuff = function()
		return true
	end,
	IsPurgable = function()
		return true
	end,
})

function modifier_golden_miner_fracture_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_golden_miner_fracture_debuff:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
end

function modifier_golden_miner_fracture_debuff:DeclareFunctions()
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_golden_miner_fracture_debuff:GetModifierPhysicalArmorBonus()
	return -(self:GetStackCount() * self:GetAbility():GetSpecialValueFor("disarm"))
end

function modifier_golden_miner_fracture_debuff:GetTexture()
	return "tiny_craggy_exterior"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_golden_miner_flesh_weight_aura",
	"abilities/addition_bosses/golden_miner",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_golden_miner_flesh_weight_debuff",
	"abilities/addition_bosses/golden_miner",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_golden_miner_flesh_weight_debuff_timeout",
	"abilities/addition_bosses/golden_miner",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_golden_miner_petrified", "abilities/addition_bosses/golden_miner", LUA_MODIFIER_MOTION_NONE)

golden_miner_flesh_weight = class({})

function golden_miner_flesh_weight:GetIntrinsicModifierName()
	return "modifier_golden_miner_flesh_weight_aura"
end

--------------------------------------------------------------------------------

modifier_golden_miner_flesh_weight_aura = class({})

function modifier_golden_miner_flesh_weight_aura:IsHidden()
	return true
end
function modifier_golden_miner_flesh_weight_aura:IsAura()
	return true
end

function modifier_golden_miner_flesh_weight_aura:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("max_distance")
	end
	return 0
end

function modifier_golden_miner_flesh_weight_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_golden_miner_flesh_weight_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_golden_miner_flesh_weight_aura:GetModifierAura()
	return "modifier_golden_miner_flesh_weight_debuff"
end
--------------------------------------------------------------------------------

modifier_golden_miner_flesh_weight_debuff = class({
	IsDebuff = function()
		return true
	end,
	IsPurgable = function()
		return false
	end,
})

function modifier_golden_miner_flesh_weight_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self.counter = 0
	self:StartIntervalThink(0.5)
end

function modifier_golden_miner_flesh_weight_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local parent = self:GetParent()
	if not caster or caster:IsNull() then
		return
	end

	local distance = (parent:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()
	local min_dist = self:GetAbility():GetSpecialValueFor("min_distance")
	local max_dist = self:GetAbility():GetSpecialValueFor("max_distance")
	local min_slow = self:GetAbility():GetSpecialValueFor("min_slow")
	local max_slow = self:GetAbility():GetSpecialValueFor("max_slow")
	local duration = self:GetAbility():GetSpecialValueFor("duration")

	if distance >= max_dist then
		self.current_slow = min_slow
	elseif distance <= min_dist then
		self.current_slow = max_slow
	else
		local range = max_dist - min_dist
		local pct = (distance - min_dist) / range
		self.current_slow = max_slow - (pct * (max_slow - min_slow))
	end

	if distance <= min_dist then
		self.counter = (self.counter or 0) + 0.5
		if self.counter >= duration + 1 then
			if not parent:HasModifier("modifier_golden_miner_flesh_weight_debuff_timeout") then
				parent:AddNewModifier(
					caster,
					self:GetAbility(),
					"modifier_golden_miner_petrified",
					{ duration = duration }
				)
				parent:AddNewModifier(
					caster,
					self:GetAbility(),
					"modifier_golden_miner_flesh_weight_debuff_timeout",
					{ duration = duration + 3 }
				)
				self.counter = 0
			end
		end
	else
		self.counter = 0
	end

	self:SetStackCount(math.floor(self.current_slow))
end

function modifier_golden_miner_flesh_weight_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_golden_miner_flesh_weight_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetStackCount()
end

function modifier_golden_miner_flesh_weight_debuff:GetModifierAttackSpeedBonus_Constant()
	if self:GetStackCount() > 100 then
		return -100
	end
	return 0
end

--------------------------------------------------------------------------------

modifier_golden_miner_petrified = class({
	IsDebuff = function()
		return true
	end,
	IsPurgable = function()
		return true
	end,
})

function modifier_golden_miner_petrified:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end

function modifier_golden_miner_petrified:GetStatusEffectName()
	return "particles/status_fx/status_effect_medusa_stone_gaze.vpcf"
end

function modifier_golden_miner_petrified:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_golden_miner_petrified:OnCreated()
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("Hero_Medusa.StoneGaze.Stun")
end

--------------------------------------------------------------------------------

modifier_golden_miner_flesh_weight_debuff_timeout = class({
	IsDebuff = function()
		return false
	end,
	IsPurgable = function()
		return false
	end,
})

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_golden_miner_rock_throw", "abilities/addition_bosses/golden_miner", LUA_MODIFIER_MOTION_NONE)

golden_miner_rock_throw = class({})

function golden_miner_rock_throw:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function golden_miner_rock_throw:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_primal_beast.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf",
		context
	)
end

function golden_miner_rock_throw:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local cast_range = self:GetCastRange(caster:GetAbsOrigin(), nil)
	local caster_pos = caster:GetAbsOrigin()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster_pos,
		nil,
		cast_range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)

	local target_enemy = nil
	local max_distance = -1

	for _, enemy in pairs(enemies) do
		local dist = (enemy:GetAbsOrigin() - caster_pos):Length2D()
		if dist > max_distance then
			max_distance = dist
			target_enemy = enemy
		end
	end

	if not target_enemy then
		return
	end

	local target_loc = target_enemy:GetAbsOrigin()

	local dummy = CreateModifierThinker(caster, self, nil, {}, target_loc, caster:GetTeamNumber(), false)

	local info = {
		Target = dummy,
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw.vpcf",
		iMoveSpeed = 800,
		bDodgeable = false,
	}
	ProjectileManager:CreateTrackingProjectile(info)

	caster:EmitSound("Hero_PrimalBeast.RockThrow.Cast")
end

function golden_miner_rock_throw:OnProjectileHit(target, location)
	if not target then
		return
	end

	local caster = self:GetCaster()
	local rock_radius = self:GetSpecialValueFor("impact_radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		rock_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		local damage_table = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		}

		ApplyDamage(damage_table)
		enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration })
	end

	self:PlayEffects(target)
end

function golden_miner_rock_throw:PlayEffects(target)
	target:EmitSound("Hero_PrimalBeast.RockThrow.Impact")
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 3, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
	target:ForceKill(false)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LinkLuaModifier(
	"modifier_golden_miner_death_nova_pull",
	"abilities/addition_bosses/golden_miner",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_golden_miner_death_nova_vortex",
	"abilities/addition_bosses/golden_miner",
	LUA_MODIFIER_MOTION_NONE
)

golden_miner_death_nova = class({})

function golden_miner_death_nova:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function golden_miner_death_nova:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sandking.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_remote_mines_detonate.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_tiny/tiny_avalanche_projectile.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_sandking/sandking_epicenter.vpcf", context)
end

function golden_miner_death_nova:OnSpellStart()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("pull_duration")

	CreateModifierThinker(
		caster,
		self,
		"modifier_golden_miner_death_nova_pull",
		{ duration = duration },
		caster:GetAbsOrigin(),
		caster:GetTeamNumber(),
		false
	)
end

function golden_miner_death_nova:OnProjectileHit(target, location)
	if not target or target:IsNull() then
		return false
	end

	local caster = self:GetCaster()
	local explode_dmg = self:GetSpecialValueFor("explode_damage") or 0
	local boost_dmg = self:GetSpecialValueFor("diff_boost_damage") or 0
	local total_damage = explode_dmg + boost_dmg

	if total_damage > 0 then
		ApplyDamage({
			victim = target,
			attacker = caster or self:GetParent(),
			damage = total_damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		})
		target:EmitSound("Hero_Tiny.Avalanche.Target")
	end
	return true
end

--------------------------------------------------------------------------------

modifier_golden_miner_death_nova_pull = class({})

function modifier_golden_miner_death_nova_pull:OnCreated()
	if not IsServer() then
		return
	end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.pulses = self:GetAbility():GetSpecialValueFor("pulses")
	local base_dmg = self:GetAbility():GetSpecialValueFor("damage_per_pulse") or 0
	local boost_dmg = self:GetAbility():GetSpecialValueFor("diff_boost_additional") or 0
	self.damage = base_dmg + boost_dmg
	self.pulse = 0

	EmitSoundOn("Ability.SandKing_Epicenter.spell", self:GetParent())

	self:StartIntervalThink(0.75)
	self:OnIntervalThink()
end

function modifier_golden_miner_death_nova_pull:OnIntervalThink()
	if not IsServer() then
		return
	end

	self.pulse = self.pulse + 1
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local center = parent:GetOrigin()

	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		center,
		parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		if not enemy:HasModifier("modifier_golden_miner_death_nova_vortex") then
			enemy:AddNewModifier(caster, self:GetAbility(), "modifier_golden_miner_death_nova_vortex", {
				duration = self:GetRemainingTime(),
				center_x = center.x,
				center_y = center.y,
				center_z = center.z,
			})
		end

		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = self.damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(),
		})
	end

	self:PlayEffects(self.radius)

	if self.pulse >= self.pulses then
		self:Destroy()
	end
end

function modifier_golden_miner_death_nova_pull:OnDestroy()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local ability = self:GetAbility()
	local caster = self:GetCaster()

	if not ability or ability:IsNull() then
		return
	end
	local source = caster
	if not source or source:IsNull() then
		source = parent
	end

	local center = parent:GetAbsOrigin()
	local shard_count = ability:GetSpecialValueFor("shard_count") or 8

	StopSoundOn("Ability.SandKing_Epicenter.spell", parent)
	EmitSoundOn("Hero_PrimalBeast.RockThrow.Impact", parent)

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_remote_mines_detonate.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:ReleaseParticleIndex(pfx)

	for i = 1, shard_count do
		local angle = i * (360 / shard_count)
		local direction = Vector(math.cos(math.rad(angle)), math.sin(math.rad(angle)), 0)
		local velocity = direction * 900

		ProjectileManager:CreateLinearProjectile({
			Ability = ability,
			EffectName = "particles/units/heroes/hero_tiny/tiny_avalanche_projectile.vpcf",
			vSpawnOrigin = center + Vector(0, 0, 100),
			fDistance = 1000,
			fStartRadius = 100,
			fEndRadius = 100,
			Source = source,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			vVelocity = velocity,
			bHasFrontalCone = false,
			bReplaceExisting = false,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		})
	end
end

function modifier_golden_miner_death_nova_pull:PlayEffects(radius)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_epicenter.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

--------------------------------------------------------------------------------

modifier_golden_miner_death_nova_vortex = class({
	IsHidden = function()
		return true
	end,
	IsPurgable = function()
		return false
	end,
})

function modifier_golden_miner_death_nova_vortex:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.center = Vector(kv.center_x, kv.center_y, kv.center_z)
	self.pull_speed = self:GetAbility():GetSpecialValueFor("pull_speed")
	self:StartIntervalThink(0.03)
end

function modifier_golden_miner_death_nova_vortex:OnIntervalThink()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local current_pos = parent:GetAbsOrigin()
	local dist = (self.center - current_pos):Length2D()
	local stop_radius = 100

	if dist > stop_radius then
		local direction = (self.center - current_pos):Normalized()
		local next_pos = current_pos + direction * (self.pull_speed * 0.03)

		if GridNav:IsTraversable(next_pos) then
			FindClearSpaceForUnit(parent, next_pos, true)
		end
	end
end