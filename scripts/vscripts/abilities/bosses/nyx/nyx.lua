--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

boss_nyx_assassin_mana_burn = class({})

function boss_nyx_assassin_mana_burn:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf", context)
end

function boss_nyx_assassin_mana_burn:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_nyx_assassin_mana_burn:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not target then
		return
	end

	local base_damage = self:GetSpecialValueFor("damage")
	local boost_damage = self:GetSpecialValueFor("diff_boost_damage")
	local total_burn = base_damage + boost_damage

	EmitSoundOn("Hero_NyxAssassin.ManaBurn.Target", target)

	if target:GetTeam() ~= caster:GetTeam() then
		if target:TriggerSpellAbsorb(self) then
			return nil
		end
	end

	local particle_manaburn_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_nyx_assassin/nyx_assassin_mana_burn.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(particle_manaburn_fx)

	local target_mana = target:GetMana()
	local mana_to_burn = math.min(target_mana, total_burn)

	target:Script_ReduceMana(mana_to_burn, self)

	local damageTable = {
		victim = target,
		attacker = caster,
		damage = mana_to_burn,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	ApplyDamage(damageTable)
end

--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_boss_nyx_assassin_passive",
	"abilities/bosses/nyx/boss_nyx_assassin_impale.lua",
	LUA_MODIFIER_MOTION_NONE
)

boss_nyx_assassin_impale = class({})

function boss_nyx_assassin_impale:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale_hit.vpcf", context)
end

function boss_nyx_assassin_impale:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function boss_nyx_assassin_impale:OnSpellStart()
	if self:GetCursorPosition() == self:GetCaster():GetAbsOrigin() then
		self:GetCaster():SetCursorPosition(self:GetCursorPosition() + self:GetCaster():GetForwardVector())
	end

	local caster = self:GetCaster()
	local ability = self
	local target_point = self:GetCursorPosition()

	local width = ability:GetSpecialValueFor("width")
	local duration = ability:GetSpecialValueFor("duration")
	local length = ability:GetSpecialValueFor("length")
	local speed = ability:GetSpecialValueFor("speed")

	EmitSoundOn("Hero_NyxAssassin.Impale", caster)

	local direction = (target_point - caster:GetAbsOrigin()):Normalized()

	local spikes_projectile = {
		Ability = ability,
		EffectName = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin(),
		fDistance = length,
		fStartRadius = width,
		fEndRadius = width,
		Source = caster,
		bHasFrontalCone = false,
		bReplaceExisting = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		bDeleteOnHit = false,
		vVelocity = direction * speed * Vector(1, 1, 0),
		bProvidesVision = false,
		ExtraData = {},
	}

	ProjectileManager:CreateLinearProjectile(spikes_projectile)
end

function boss_nyx_assassin_impale:OnProjectileHit_ExtraData(target, location, ExtraData)
	if not target then
		return nil
	end

	if target:IsMagicImmune() then
		return nil
	end

	local caster = self:GetCaster()
	local ability = self

	duration = self:GetSpecialValueFor("duration")
	air_time = self:GetSpecialValueFor("air_time")
	air_height = self:GetSpecialValueFor("air_height")

	EmitSoundOn("Hero_NyxAssassin.Impale.Target", target)

	local particle_impact_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale_hit.vpcf",
		PATTACH_ABSORIGIN,
		target
	)
	ParticleManager:SetParticleControl(particle_impact_fx, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle_impact_fx)

	target:AddNewModifier(
		caster,
		self,
		"modifier_stunned",
		{ duration = duration * (1 - target:GetStatusResistance()) }
	)

	local knockbackProperties = {
		duration = air_time * (1 - target:GetStatusResistance()),
		knockback_duration = air_time * (1 - target:GetStatusResistance()),
		knockback_distance = 0,
		knockback_height = air_height,
	}

	target:RemoveModifierByName("modifier_knockback")
	target:AddNewModifier(target, nil, "modifier_knockback", knockbackProperties)

	Timers:CreateTimer(0.5, function()
		target:RemoveGesture(ACT_DOTA_FLAIL)
	end)

	Timers:CreateTimer(air_time, function()
		EmitSoundOn("Hero_NyxAssassin.Impale.TargetLand", target)

		damageTable = {
			victim = target,
			attacker = caster,
			damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage"),
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		}
		ApplyDamage(damageTable)
	end)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_nyx_assassin_passive", "abilities/bosses/nyx/nyx", LUA_MODIFIER_MOTION_NONE)

boss_nyx_assassin_passive = class({})

function boss_nyx_assassin_passive:GetIntrinsicModifierName()
	return "modifier_boss_nyx_assassin_passive"
end

--------------------------------------------------------------------------------

modifier_boss_nyx_assassin_passive = class({})

function modifier_boss_nyx_assassin_passive:IsHidden()
	return true
end
function modifier_boss_nyx_assassin_passive:IsPurgable()
	return false
end

function modifier_boss_nyx_assassin_passive:OnCreated(kv)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local unit_name = parent:GetUnitName()

	self.phis = 0
	self.mag = 0

	if unit_name == "npc_dota_boss_nyx_1" then
		self:PlayEffects2()
		self.phis = 0
		self.mag = 1
	elseif unit_name == "npc_dota_boss_nyx_2" then
		self:PlayEffects()
		self.phis = 1
		self.mag = 0
	end
end

function modifier_boss_nyx_assassin_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	}
end

function modifier_boss_nyx_assassin_passive:GetAbsoluteNoDamagePhysical()
	return self.phis
end

function modifier_boss_nyx_assassin_passive:GetAbsoluteNoDamageMagical()
	return self.mag
end

function modifier_boss_nyx_assassin_passive:PlayEffects()
	local particle =
		ParticleManager:CreateParticle("particles/nyx_phisical.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 1, Vector(150, 150, 150))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_boss_nyx_assassin_passive:PlayEffects2()
	local particle =
		ParticleManager:CreateParticle("particles/nyx_magical.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 1, Vector(150, 150, 150))
	self:AddParticle(particle, false, false, -1, false, false)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_boss_nyx_assassin_dispersion_cast", "abilities/bosses/nyx/nyx", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_ring_lua", "heroes/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nyx_cd", "abilities/bosses/nyx/nyx", LUA_MODIFIER_MOTION_NONE)

boss_nyx_assassin_dispersion = class({})

function boss_nyx_assassin_dispersion:Precache(context)
	PrecacheResource("particle", "particles/dispersion/dispersion.vpcf", context)
end

function boss_nyx_assassin_dispersion:OnSpellStart(target)
	local caster = self:GetCaster()
	caster:EmitSound("DOTA_Item.BladeMail.Activate")
	caster:AddNewModifier(
		caster,
		self,
		"modifier_boss_nyx_assassin_dispersion_cast",
		{ duration = self:GetSpecialValueFor("duration") }
	)
end

--------------------------------------------------------------------------------

modifier_boss_nyx_assassin_dispersion_cast = class({})

function modifier_boss_nyx_assassin_dispersion_cast:IsHidden()
	return true
end

function modifier_boss_nyx_assassin_dispersion_cast:IsPurgable()
	return false
end

function modifier_boss_nyx_assassin_dispersion_cast:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_boss_nyx_assassin_dispersion_cast:GetEffectName()
	return "particles/dispersion/dispersion_effect.vpcf"
end

function modifier_boss_nyx_assassin_dispersion_cast:OnTakeDamage(keys)
	if not IsServer() then
		return
	end
	if keys.unit == self:GetParent() and not self:GetParent():HasModifier("modifier_nyx_cd") then
		self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_nyx_cd", { duration = 0.2 })
		self.original_damage = keys.original_damage
		self:CastWave()
	end
end

function modifier_boss_nyx_assassin_dispersion_cast:CastWave()
	self.caster = self:GetCaster()
	local ability = self:GetAbility()
	local radius = self:GetAbility():GetSpecialValueFor("radius")
	local speed = self:GetAbility():GetSpecialValueFor("speed")
	local effect = self:PlayEffects(radius, speed)

	local ring = self.caster:AddNewModifier(
		self.caster, -- player source
		self, -- ability source
		"modifier_generic_ring_lua", -- modifier name
		{
			start_radius = 0,
			end_radius = radius,
			speed = speed,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			IsCircle = 0,
		}
	)
	ring:SetCallback(function(enemy)
		self:OnHit(enemy, ability)
	end)
	ring:SetEndCallback(function()
		ParticleManager:SetParticleControl(effect, 1, Vector(speed, radius, -1))
	end)

	ring:SetEndCallback(function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
	end)
end

function modifier_boss_nyx_assassin_dispersion_cast:OnHit(enemy, ability)
	local radius = ability:GetSpecialValueFor("radius")
	local damage_percentage = ability:GetSpecialValueFor("damage")
	local damage = damage_percentage * self.original_damage / 100
	local damageTable = {
		victim = enemy,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
	}
	ApplyDamage(damageTable)

	EmitSoundOn("Ability.PlasmaFieldImpact", enemy)
end

function modifier_boss_nyx_assassin_dispersion_cast:PlayEffects(radius, speed)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/dispersion/dispersion.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(speed, radius, 1))
	EmitSoundOn("Ability.PlasmaField", self:GetCaster())
	return effect_cast
end

--------------------------------------------------------------------------------

modifier_nyx_cd = class({})

function modifier_nyx_cd:IsHidden()
	return true
end

function modifier_nyx_cd:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

boss_nyx_assassin_swap = class({})

function boss_nyx_assassin_swap:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local name_1 = "npc_dota_boss_nyx_1"
	local name_2 = "npc_dota_boss_nyx_2"

	local nyx_1 = nil
	local nyx_2 = nil

	local all_entities = Entities:FindAllByClassname("npc_dota_creature")
	for _, ent in pairs(all_entities) do
		if ent:GetUnitName() == name_1 and ent:IsAlive() then
			nyx_1 = ent
		elseif ent:GetUnitName() == name_2 and ent:IsAlive() then
			nyx_2 = ent
		end
	end

	if nyx_1 and nyx_2 then
		local pos_1 = nyx_1:GetAbsOrigin()
		local pos_2 = nyx_2:GetAbsOrigin()

		self:PlayEffects(pos_1)
		self:PlayEffects(pos_2)

		EmitSoundOn("Hero_VengefulSpirit.NetherSwap", nyx_1)
		EmitSoundOn("Hero_VengefulSpirit.NetherSwap", nyx_2)

		FindClearSpaceForUnit(nyx_1, pos_2, true)
		FindClearSpaceForUnit(nyx_2, pos_1, true)

		nyx_1:Stop()
		nyx_2:Stop()
	end
end

function boss_nyx_assassin_swap:PlayEffects(position)
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_vengeful/vengeful_nether_swap.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:SetParticleControl(pfx, 1, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end