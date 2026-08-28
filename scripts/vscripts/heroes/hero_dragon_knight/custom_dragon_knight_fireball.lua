--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_custom_dragon_knight_fireball_thinker",
	"heroes/hero_dragon_knight/custom_dragon_knight_fireball",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_custom_dragon_knight_fireball_burn",
	"heroes/hero_dragon_knight/custom_dragon_knight_fireball",
	LUA_MODIFIER_MOTION_NONE
)

custom_dragon_knight_fireball = class({})

function custom_dragon_knight_fireball:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function custom_dragon_knight_fireball:OnSpellStart()
	local hCaster = self:GetCaster()
	local vPosition = self:GetCursorPosition()
	local fDuration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		hCaster,
		self,
		"modifier_custom_dragon_knight_fireball_thinker",
		{ duration = fDuration },
		vPosition,
		hCaster:GetTeamNumber(),
		false
	)

	EmitSoundOn("Hero_DragonKnight.Fireball.Cast", hCaster)
end

modifier_custom_dragon_knight_fireball_thinker = class({})

function modifier_custom_dragon_knight_fireball_thinker:IsHidden()
	return true
end

function modifier_custom_dragon_knight_fireball_thinker:IsPurgable()
	return false
end

function modifier_custom_dragon_knight_fireball_thinker:IsAura()
	return true
end

function modifier_custom_dragon_knight_fireball_thinker:GetModifierAura()
	return "modifier_custom_dragon_knight_fireball_burn"
end

function modifier_custom_dragon_knight_fireball_thinker:GetAuraRadius()
	return self.fRadius or 0
end

function modifier_custom_dragon_knight_fireball_thinker:GetAuraDuration()
	return self.fLingerDuration or 0
end

function modifier_custom_dragon_knight_fireball_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_custom_dragon_knight_fireball_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_custom_dragon_knight_fireball_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_custom_dragon_knight_fireball_thinker:OnCreated()
	local hAbility = self:GetAbility()
	if not hAbility then
		return
	end

	self.fRadius = hAbility:GetSpecialValueFor("radius")
	self.fLingerDuration = hAbility:GetSpecialValueFor("linger_duration")

	if IsServer() then
		local hParent = self:GetParent()
		local iParticleID = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_dragon_knight/dragon_knight_shard_fireball.vpcf",
			PATTACH_ABSORIGIN,
			hParent
		)
		ParticleManager:SetParticleControl(iParticleID, 0, hParent:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 1, hParent:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 2, Vector(self:GetDuration() + 1, 0, 0))
		self:AddParticle(iParticleID, false, false, -1, false, false)
		EmitSoundOn("Hero_DragonKnight.Fireball.Target", hParent)
	end
end

function modifier_custom_dragon_knight_fireball_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove(self:GetParent())
	end
end

modifier_custom_dragon_knight_fireball_burn = class({})

function modifier_custom_dragon_knight_fireball_burn:IsHidden()
	return false
end

function modifier_custom_dragon_knight_fireball_burn:IsDebuff()
	return true
end

function modifier_custom_dragon_knight_fireball_burn:IsPurgable()
	return false
end

function modifier_custom_dragon_knight_fireball_burn:OnCreated()
	local hAbility = self:GetAbility()
	if not hAbility then
		return
	end

	self.fDamagePerSecond = hAbility:GetSpecialValueFor("damage")
	self.fBurnInterval = hAbility:GetSpecialValueFor("burn_interval")

	if IsServer() then
		self:OnIntervalThink()
		self:StartIntervalThink(self.fBurnInterval)
	end
end

function modifier_custom_dragon_knight_fireball_burn:OnRefresh()
	local hAbility = self:GetAbility()
	if not hAbility then
		return
	end

	self.fDamagePerSecond = hAbility:GetSpecialValueFor("damage")
	self.fBurnInterval = hAbility:GetSpecialValueFor("burn_interval")
end

function modifier_custom_dragon_knight_fireball_burn:OnIntervalThink()
	local hAbility = self:GetAbility()
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()
	if not hAbility or not hCaster then
		return
	end

	local iDamageType = hAbility:GetAbilityDamageType()
	if hAbility:GetSpecialValueFor("physical_damage_type") == 1 then
		iDamageType = DAMAGE_TYPE_PHYSICAL
	end

	ApplyDamage({
		victim = hParent,
		attacker = hCaster,
		damage = self.fDamagePerSecond * self.fBurnInterval,
		damage_type = iDamageType,
		damage_flags = DOTA_DAMAGE_FLAG_PROPERTY_FIRE,
		ability = hAbility,
	})
end

function modifier_custom_dragon_knight_fireball_burn:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_custom_dragon_knight_fireball_burn:OnTooltip()
	return self.fDamagePerSecond or 0
end