--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_megacreep_passive", "abilities/creeps_lane/npc_megacreep_upgrade", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_megacreep_passive_death",
	"abilities/creeps_lane/npc_megacreep_upgrade",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_megacreep_buf", "abilities/creeps_lane/npc_megacreep_upgrade", LUA_MODIFIER_MOTION_NONE)

npc_megacreep_upgrade = class({})

function npc_megacreep_upgrade:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_ti6_immortal.vpcf",
		context
	)
end

function npc_megacreep_upgrade:GetIntrinsicModifierName()
	return "modifier_megacreep_passive"
end

modifier_megacreep_passive = class(mod_hidden)
function modifier_megacreep_passive:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.health = self.ability:GetSpecialValueFor("health")

	if not IsServer() then
		return
	end
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_megacreep_passive_death", {})
end

modifier_megacreep_passive_death = class(mod_hidden)
function modifier_megacreep_passive_death:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
end

function modifier_megacreep_passive_death:OnDestroy()
	if not IsServer() then
		return
	end
	if self.parent:IsAlive() then
		return
	end
	if self.parent:HasModifier("modifier_death") then
		return
	end

	self.parent:EmitSound("Hero_Omniknight.Purification")

	for _, unit in
		pairs(
			FindUnitsInRadius(
				self.parent:GetTeamNumber(),
				self.parent:GetAbsOrigin(),
				nil,
				1000,
				DOTA_UNIT_TARGET_TEAM_FRIENDLY,
				DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
		)
	do
		if unit:GetHealth() > 1 then
			unit:AddNewModifier(self.parent, self.ability, "modifier_megacreep_buf", {})
		end
	end
end

modifier_megacreep_buf = class(mod_visible)
function modifier_megacreep_buf:GetTexture()
	return "omniknight_purification"
end
function modifier_megacreep_buf:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.damage = self.ability.damage
	self.health = self.ability.health

	if not IsServer() then
		return
	end
	self:OnRefresh()
end

function modifier_megacreep_buf:OnRefresh()
	if not IsServer() then
		return
	end
	self:IncrementStackCount()

	local particle = ParticleManager:CreateParticle(
		"particles/econ/items/omniknight/hammer_ti6_immortal/omniknight_purification_ti6_immortal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(100, 100, 100))
	ParticleManager:ReleaseParticleIndex(particle)

	local health = math.floor(self.parent:GetBaseMaxHealth() * (1 + self.health / 100))
	local damage = math.floor(self.parent:GetBaseDamageMax() * (1 + self.damage / 100))
	local health_k = self.parent:GetHealth() / self.parent:GetMaxHealth()

	self.parent:SetBaseMaxHealth(health)
	self.parent:SetMaxHealth(health)
	self.parent:SetHealth(math.max(1, health * health_k))
	self.parent:SetBaseDamageMin(damage)
	self.parent:SetBaseDamageMax(damage)
end

function modifier_megacreep_buf:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end

function modifier_megacreep_buf:GetModifierModelScale()
	return 20 * self:GetStackCount()
end

function modifier_megacreep_buf:OnTooltip()
	return self.damage * self:GetStackCount()
end

function modifier_megacreep_buf:OnTooltip2()
	return self.health * self:GetStackCount()
end