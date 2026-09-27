--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_ice", "abilities/creeps_lane/npc_lich_ice", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_ice_resist", "abilities/creeps_lane/npc_lich_ice", LUA_MODIFIER_MOTION_NONE)

npc_lich_ice = class({})

function npc_lich_ice:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_lich/lich_frost_armor.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/glyph.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_lich/lich_ice_spire.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_has_quest.vpcf", context)
end

function npc_lich_ice:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.hits = self:GetLevelSpecialValueFor("hits", 1)
	self.hits_inc = self:GetLevelSpecialValueFor("hits_inc", 1)
	self.cd_inc = self:GetLevelSpecialValueFor("cd_inc", 1)
end

function npc_lich_ice:GetCooldown(iLevel)
	return self.BaseClass.GetCooldown(self, iLevel)
		- (self.caster:GetUpgradeStack("modifier_waveupgrade_boss") - 1) * (self.cd_inc or 0)
end

function npc_lich_ice:OnSpellStart()
	self:EndCd(0)

	self.caster:EmitSound("Lich.Ice_voice")
	self.caster:EmitSound("Hero_Lich.IceSpire")

	local pillar = CreateUnitByName(
		"npc_lich_ice_unit",
		self.caster:GetAbsOrigin() + RandomVector(RandomInt(-1, 1) + self.radius),
		true,
		nil,
		nil,
		DOTA_TEAM_CUSTOM_5
	)

	self.caster:AddNewModifier(pillar, self, "modifier_lich_ice_resist", {})
	pillar:AddNewModifier(self.caster, self, "modifier_lich_ice", {})
	pillar:SetBaseMaxHealth(12)
	pillar:SetHealth(12)
	pillar.lich_caster = self.caster
end

modifier_lich_ice_resist = class(mod_hidden)
function modifier_lich_ice_resist:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_lich_ice_resist:GetEffectName()
	return "particles/units/heroes/hero_lich/lich_frost_armor.vpcf"
end
function modifier_lich_ice_resist:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_lich_ice_resist:RemoveOnDeath()
	return false
end
function modifier_lich_ice_resist:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	self.parent:AddDeathEvent(self, true)
	self.parent:AddAttackEvent_inc(self, true)

	local particle =
		ParticleManager:CreateParticle("particles/items_fx/glyph.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(170, 1, 1))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_lich_ice_resist:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
end

function modifier_lich_ice_resist:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_lich_ice_resist:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_lich_ice_resist:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_lich_ice_resist:AttackEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.target then
		return
	end
	if not params.attacker:IsRealHero() then
		return
	end

	params.attacker:SendError("#lich_invun")
end

function modifier_lich_ice_resist:DeathEvent(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self.caster and params.unit ~= self.caster.lich_caster then
		return
	end

	self.caster:EmitSound("Hero_Lich.IceSpire.Destroy")
	self:Destroy()

	if params.unit ~= self.caster.lich_caster then
		return
	end
	self.caster:Kill(nil, params.attacker)
end

modifier_lich_ice = class(mod_hidden)
function modifier_lich_ice:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.pips = self.caster:GetUpgradeStack("modifier_waveupgrade_boss") == 2 and self.ability.hits_inc
		or self.ability.hits

	if not IsServer() then
		return
	end
	self.parent = self:GetParent()

	self.health = 12
	self.hit = 12 / self.pips

	self.parent:AddAttackEvent_inc(self, true)

	local point = self.parent:GetAbsOrigin()

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_lich/lich_ice_spire.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, point)
	ParticleManager:SetParticleControl(particle, 2, point)
	ParticleManager:SetParticleControl(particle, 3, point)
	ParticleManager:SetParticleControl(particle, 4, point)
	ParticleManager:SetParticleControl(particle, 5, Vector(550, 550, 550))
	self:AddParticle(particle, false, false, -1, true, false)

	local sign =
		ParticleManager:CreateParticle("particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(sign, 0, point + Vector(0, 0, 400))
	self:AddParticle(sign, false, false, -1, true, false)

	self:StartIntervalThink(0.2)
end

function modifier_lich_ice:OnIntervalThink()
	if not IsServer() then
		return
	end
	local point = self.parent:GetAbsOrigin()

	for _, target in
		pairs(
			FindUnitsInRadius(
				self.parent:GetTeamNumber(),
				point,
				nil,
				1200,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_INVULNERABLE
					+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
					+ DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS,
				FIND_ANY_ORDER,
				false
			)
		)
	do
		AddFOWViewer(target:GetTeamNumber(), point, 300, 0.2, false)
	end
end

function modifier_lich_ice:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_HEALTHBAR_PIPS,
	}
end

function modifier_lich_ice:GetModifierHealthBarPips()
	return self.pips
end

function modifier_lich_ice:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_lich_ice:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_lich_ice:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_lich_ice:AttackEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.target then
		return
	end

	self.health = self.health - self.hit

	if self.health <= 0 then
		self.parent:Kill(nil, params.attacker)
	else
		self.parent:SetHealth(self.health)
	end
end

function modifier_lich_ice:OnDestroy()
	if not IsServer() then
		return
	end
	if self.parent:IsAlive() then
		return
	end
	if not IsValid(self.ability) then
		return
	end

	self.ability:UseResources(false, false, false, true)
end