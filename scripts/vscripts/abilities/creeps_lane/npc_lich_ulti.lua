--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


npc_lich_ulti = class({})

function npc_lich_ulti:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_has_quest.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost.vpcf", context)
end

function npc_lich_ulti:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1) / 100
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.projectile = self:GetLevelSpecialValueFor("projectile", 1)
end

function npc_lich_ulti:OnAbilityPhaseStart()
	self.sign = ParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_has_quest.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self.caster
	)
	return true
end

function npc_lich_ulti:OnAbilityPhaseInterrupted()
	ParticleManager:Delete(self.sign, 2)
end

function npc_lich_ulti:OnSpellStart()
	ParticleManager:Delete(self.sign, 2)

	self.caster:EmitSound("Lich.Ulti_voice")
	self.caster:EmitSound("Hero_Lich.ChainFrost")

	self:New_Hit(self:GetCursorTarget(), self.caster)
end

function npc_lich_ulti:OnProjectileHit(target, location)
	if not target then
		return
	end

	local bounce = {}

	for _, unit in
		pairs(
			FindUnitsInRadius(
				self.caster:GetTeamNumber(),
				target:GetAbsOrigin(),
				nil,
				self.radius,
				DOTA_UNIT_TARGET_TEAM_BOTH,
				DOTA_UNIT_TARGET_ALL,
				DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
				FIND_CLOSEST,
				false
			)
		)
	do
		local ally = unit:GetTeamNumber() == self.caster:GetTeamNumber()
		if
			unit ~= target
			and (
				(ally and unit:GetUnitName() == "npc_lich_ice_unit") or (not ally and (unit:IsCreep() or unit:IsHero()))
			)
		then
			table.insert(bounce, unit)
		end
	end

	self.caster:EmitSound("Hero_Lich.ChainFrostImpact.Hero")

	if target:TriggerSpellAbsorb(self) then
		return
	end

	if #bounce > 0 then
		self:New_Hit(bounce[RandomInt(1, #bounce)], target)
	end

	local damage = target:GetMaxHealth() * self.damage
	if target:IsCreep() then
		damage = math.min(500, damage)
	end

	DoDamage({
		victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self,
	})
	return true
end

function npc_lich_ulti:New_Hit(target, source)
	local info = {
		Target = target,
		Source = source,
		Ability = self,
		EffectName = "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost.vpcf",
		iMoveSpeed = self.projectile,
		bReplaceExisting = false,
		bProvidesVision = true,
		iVisionRadius = 450,
		iVisionTeamNumber = self.caster:GetTeamNumber(),
	}

	ProjectileManager:CreateTrackingProjectile(info)
end