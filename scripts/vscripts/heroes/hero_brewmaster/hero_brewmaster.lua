--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_brewmaster_thunder_clap_lua_debuff",
	"heroes/hero_brewmaster/hero_brewmaster",
	LUA_MODIFIER_MOTION_NONE
)

brewmaster_thunder_clap_lua = class({})

function brewmaster_thunder_clap_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/brewmaster/brewmaster_offhand_elixir/brewmaster_thunder_clap_elixir.vpcf",
		context
	)
end

function brewmaster_thunder_clap_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	local damage = self:GetSpecialValueFor("damage")
	local movement_slow = self:GetSpecialValueFor("movement_slow")

	if caster:HasModifier("modifier_brewmaster_ult") then
		damage = damage * 2
	end

	local clap_particle = ParticleManager:CreateParticle(
		"particles/econ/items/brewmaster/brewmaster_offhand_elixir/brewmaster_thunder_clap_elixir.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(clap_particle, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(clap_particle)

	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)

	self:GetCaster():EmitSound("Hero_Brewmaster.ThunderClap")
	self:GetCaster():EmitSound("brewmaster_brew_ability_thunderclap_0" .. RandomInt(1, 3))

	for k, v in pairs(units) do
		ApplyDamage({
			victim = v,
			attacker = caster,
			damage = damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		})
		v:EmitSound("Hero_Brewmaster.ThunderClap.Target")
		v:AddNewModifier(caster, self, "modifier_brewmaster_thunder_clap_lua_debuff", {
			duration = v:IsCreep() and duration_creeps or duration,
			reduction_movespeed = -movement_slow,
		})
	end
end

---------------------------------------------------------------------------

modifier_brewmaster_thunder_clap_lua_debuff = class({})

function modifier_brewmaster_thunder_clap_lua_debuff:IsHidden()
	return false
end
function modifier_brewmaster_thunder_clap_lua_debuff:IsPurgable()
	return true
end
function modifier_brewmaster_thunder_clap_lua_debuff:IsDebuff()
	return true
end
function modifier_brewmaster_thunder_clap_lua_debuff:IsBuff()
	return false
end
function modifier_brewmaster_thunder_clap_lua_debuff:RemoveOnDeath()
	return true
end
function modifier_brewmaster_thunder_clap_lua_debuff:AllowIllusionDuplicate()
	return true
end

function modifier_brewmaster_thunder_clap_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_brewmaster_thunder_clap_lua_debuff:OnCreated(data)
	self.reduction_movespeed = data.reduction_movespeed
end

function modifier_brewmaster_thunder_clap_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.reduction_movespeed
end

---------------------------------------------------------------------------
---------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_brewmaster_cinder_brew_lua_debuff",
	"heroes/hero_brewmaster/hero_brewmaster",
	LUA_MODIFIER_MOTION_NONE
)

brewmaster_cinder_brew_lua = class({})

function brewmaster_cinder_brew_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function brewmaster_cinder_brew_lua:OnSpellStart()
	self:GetCaster():EmitSound("Hero_Brewmaster.CinderBrew.Target")
	local vPoint = self:GetCursorPosition()
	local hCaster = self:GetCaster()

	local brew_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_brewmaster/brewmaster_cinder_brew_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(brew_particle, 1, vPoint)
	ParticleManager:ReleaseParticleIndex(brew_particle)

	ProjectileManager:CreateLinearProjectile({
		EffectName = "",
		Ability = self,
		Source = self:GetCaster(),
		vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
		vVelocity = ((self:GetCursorPosition() - self:GetCaster():GetAbsOrigin()) * Vector(1, 1, 0)):Normalized()
			* 1600,
		vAcceleration = nil, --hmm...
		fMaxSpeed = nil, -- What's the default on this thing?
		fDistance = (self:GetCursorPosition() - self:GetCaster():GetAbsOrigin()):Length2D(),
		fStartRadius = 0,
		fEndRadius = 0,
		fExpireTime = nil,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		bIgnoreSource = true,
		bHasFrontalCone = false,
		bDrawsOnMinimap = false,
		bVisibleToEnemies = true,
		bProvidesVision = false,
		iVisionRadius = nil,
		iVisionTeamNumber = nil,
		ExtraData = {},
	})
end

function brewmaster_cinder_brew_lua:OnProjectileHit(hTarget, vLocation)
	if hTarget then
		return
	end
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local units = FindUnitsInRadius(
		caster:GetTeam(),
		vLocation,
		nil,
		self:GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		self:GetAbilityTargetFlags(),
		FIND_ANY_ORDER,
		false
	)
	local duration = self:GetSpecialValueFor("duration")
	local total_damage = self:GetSpecialValueFor("total_damage")

	if caster:HasModifier("modifier_brewmaster_ult") then
		total_damage = total_damage * 2
	end

	for _, unit in pairs(units) do
		unit:AddNewModifier(caster, self, "modifier_brewmaster_cinder_brew_lua_debuff", {
			duration = duration,
			total_damage = total_damage,
		})
	end
end

---------------------------------------------------------------------------

modifier_brewmaster_cinder_brew_lua_debuff = class({})

function modifier_brewmaster_cinder_brew_lua_debuff:IsHidden()
	return false
end
function modifier_brewmaster_cinder_brew_lua_debuff:IsPurgable()
	return true
end
function modifier_brewmaster_cinder_brew_lua_debuff:IsDebuff()
	return true
end
function modifier_brewmaster_cinder_brew_lua_debuff:IsBuff()
	return false
end
function modifier_brewmaster_cinder_brew_lua_debuff:RemoveOnDeath()
	return true
end
function modifier_brewmaster_cinder_brew_lua_debuff:AllowIllusionDuplicate()
	return true
end

function modifier_brewmaster_cinder_brew_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_brewmaster/brewmaster_cinder_brew_debuff.vpcf"
end

function modifier_brewmaster_cinder_brew_lua_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_brewmaster_cinder_brew.vpcf"
end

function modifier_brewmaster_cinder_brew_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_brewmaster_cinder_brew_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return -self.attack_speed_slow
end

function modifier_brewmaster_cinder_brew_lua_debuff:OnCreated(data)
	self.attack_speed_slow = self:GetAbility():GetSpecialValueFor("attack_speed_slow")

	if not IsServer() then
		return
	end

	self.dps = data.total_damage or 0
	self.multiplier = 1
	self.bIgnited = false

	self.tick_interval = 0.5
	self.damage_per_tick = self.dps * self.tick_interval

	self:StartIntervalThink(self.tick_interval)
end

function modifier_brewmaster_cinder_brew_lua_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end

	local dmg = self.damage_per_tick * self.multiplier
	ApplyDamage({
		victim = self:GetParent(),
		damage = dmg,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility(),
	})
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), dmg, nil)
end

function modifier_brewmaster_cinder_brew_lua_debuff:OnTakeDamage(keys)
	if not IsServer() then
		return
	end
	if keys.unit ~= self:GetParent() then
		return
	end
	if self.bIgnited then
		return
	end

	if not keys.inflictor or keys.inflictor:IsNull() then
		return
	end
	if keys.inflictor:GetAbilityName() ~= "brewmaster_thunder_clap_lua" then
		return
	end

	self.bIgnited = true
	self.multiplier = 2

	self:GetParent():EmitSound("Hero_BrewMaster.CinderBrew.Ignite")
	local burn_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_brewmaster/brewmaster_drunkenbrawler_crit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self:AddParticle(burn_particle, false, false, -1, false, false)
end

---------------------------------------------------------------------------
---------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_brewmaster_drunken_brawler_lua_buff",
	"heroes/hero_brewmaster/hero_brewmaster",
	LUA_MODIFIER_MOTION_NONE
)

brewmaster_drunken_brawler_lua = class({})

function brewmaster_drunken_brawler_lua:OnSpellStart()
	self:GetCaster():EmitSound("Hero_Brewmaster.Brawler.Cast")
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_brewmaster_drunken_brawler_lua_buff",
		{ duration = self:GetSpecialValueFor("duration") }
	)
end

---------------------------------------------------------------------------

modifier_brewmaster_drunken_brawler_lua_buff = class({})

function modifier_brewmaster_drunken_brawler_lua_buff:IsHidden()
	return false
end
function modifier_brewmaster_drunken_brawler_lua_buff:IsPurgable()
	return true
end
function modifier_brewmaster_drunken_brawler_lua_buff:IsDebuff()
	return false
end
function modifier_brewmaster_drunken_brawler_lua_buff:IsBuff()
	return true
end
function modifier_brewmaster_drunken_brawler_lua_buff:RemoveOnDeath()
	return true
end
function modifier_brewmaster_drunken_brawler_lua_buff:AllowIllusionDuplicate()
	return true
end

function modifier_brewmaster_drunken_brawler_lua_buff:OnCreated()
	local ability = self:GetAbility()
	self.dodge_chance = ability:GetSpecialValueFor("dodge_chance")
	self.crit_chance = ability:GetSpecialValueFor("crit_chance")
	self.crit_multiplier = ability:GetSpecialValueFor("crit_multiplier")

	local evade_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_brewmaster/brewmaster_drunkenbrawler_evade.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self:AddParticle(evade_particle, false, false, MODIFIER_PRIORITY_SUPER_ULTRA, true, true)
end

function modifier_brewmaster_drunken_brawler_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
end

function modifier_brewmaster_drunken_brawler_lua_buff:GetModifierEvasion_Constant()
	local dodge = self.dodge_chance
	if self:GetCaster():HasModifier("modifier_brewmaster_ult") then
		dodge = dodge * 2
	end
	return dodge
end

function modifier_brewmaster_drunken_brawler_lua_buff:GetModifierPreAttack_CriticalStrike()
	local chance = self.crit_chance
	if self:GetCaster():HasModifier("modifier_brewmaster_ult") then
		chance = chance * 2
	end
	if RollPercentage(chance) then
		return self.crit_multiplier
	end
end

function modifier_brewmaster_drunken_brawler_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_brewmaster/brewmaster_drunkenbrawler_crit.vpcf"
end

function modifier_brewmaster_drunken_brawler_lua_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_drunken_brawler.vpcf"
end

function modifier_brewmaster_drunken_brawler_lua_buff:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end

---------------------------------------------------------------------------
---------------------------------------------------------------------------

LinkLuaModifier("modifier_brewmaster_ult", "heroes/hero_brewmaster/hero_brewmaster", LUA_MODIFIER_MOTION_NONE)

brewmaster_ult = class({})

function brewmaster_ult:OnSpellStart()
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_brewmaster_ult", { duration = duration })
	self:PlayEffects()
end

function brewmaster_ult:PlayEffects()
	self:GetCaster():EmitSound("Hero_Brewmaster.PrimalSplit.Spawn")
end

------------------------------------------------------------------------

modifier_brewmaster_ult = class({})

function modifier_brewmaster_ult:IsHidden()
	return false
end

function modifier_brewmaster_ult:IsPurgable()
	return false
end

function modifier_brewmaster_ult:OnCreated()
	local ability = self:GetAbility()
	self.model_scele = ability:GetSpecialValueFor("model_scele")
	self.movespeed = ability:GetSpecialValueFor("movespeed")
end

function modifier_brewmaster_ult:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
	return funcs
end

function modifier_brewmaster_ult:GetModifierModelScale()
	return self.model_scele
end

function modifier_brewmaster_ult:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

function modifier_brewmaster_ult:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end

function modifier_brewmaster_ult:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end