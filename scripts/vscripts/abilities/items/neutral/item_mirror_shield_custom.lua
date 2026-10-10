--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_mirror_shield_custom",
	"abilities/items/neutral/item_mirror_shield_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_mirror_shield_custom_block",
	"abilities/items/neutral/item_mirror_shield_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_mirror_shield_custom = class({})

function item_mirror_shield_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items3_fx/lotus_orb_reflect.vpcf", context)
	PrecacheResource("particle", "particles/items/linken_active.vpcf", context)
end

function item_mirror_shield_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_item_mirror_shield_custom"
end

function item_mirror_shield_custom:Spawn()
	self.duration = self:GetSpecialValueFor("duration")
	self.cd = self:GetSpecialValueFor("cd")
end

function item_mirror_shield_custom:Block(unit, params)
	if unit:HasModifier("modifier_antimage_counterspell_custom_active") then
		return
	end
	if unit:IsInvulnerable() then
		return
	end

	local attacker = params.ability:GetCaster()

	if not attacker then
		return
	end
	if attacker:IsCreep() then
		return
	end
	if attacker:GetTeamNumber() == unit:GetTeamNumber() then
		return
	end

	local particle =
		ParticleManager:CreateParticle("particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		unit,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		unit:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	particle =
		ParticleManager:CreateParticle("particles/items3_fx/lotus_orb_reflect.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		unit,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		unit:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	unit:EmitSound("DOTA_Item.LinkensSphere.Activate")
	unit:EmitSound("Item.LotusOrb.Activate")
	return true
end

modifier_item_mirror_shield_custom = class(mod_hidden)
function modifier_item_mirror_shield_custom:RemoveOnDeath()
	return false
end
function modifier_item_mirror_shield_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.duration = self.ability.duration
	self.cd = self.ability.cd
end

function modifier_item_mirror_shield_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSORB_SPELL,
	}
end

function modifier_item_mirror_shield_custom:GetAbsorbSpell(params)
	if not IsServer() then
		return
	end
	if self.parent:IsIllusion() then
		return
	end
	if self.parent:HasModifier("modifier_item_mirror_shield_custom_block") then
		return
	end
	if not self.ability:IsFullyCastable() then
		return
	end
	if not self.ability:Block(self.parent, params) then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_item_mirror_shield_custom_block",
		{ duration = self.duration }
	)
	self.ability:StartCooldown(self.cd)
	return 1
end

modifier_item_mirror_shield_custom_block = class(mod_hidden)
function modifier_item_mirror_shield_custom_block:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	local particle =
		ParticleManager:CreateParticle("particles/items/linken_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_item_mirror_shield_custom_block:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSORB_SPELL,
	}
end

function modifier_item_mirror_shield_custom_block:GetAbsorbSpell(params)
	if not IsServer() then
		return
	end
	if not self.ability:Block(self.parent, params) then
		return
	end
	return 1
end