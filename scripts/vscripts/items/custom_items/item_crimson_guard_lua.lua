--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_crimson_guard_lua1 = item_crimson_guard_lua1 or class({})
item_crimson_guard_lua2 = item_crimson_guard_lua1 or class({})
item_crimson_guard_lua3 = item_crimson_guard_lua1 or class({})

LinkLuaModifier(
	"modifier_item_crimson_guard_lua",
	"items/custom_items/item_crimson_guard_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_crimson_guard_active_lua",
	"items/custom_items/item_crimson_guard_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)

function item_crimson_guard_lua1:GetIntrinsicModifierName()
	return "modifier_item_crimson_guard_lua"
end

function item_crimson_guard_lua1:OnSpellStart()
	self:GetParent():EmitSound("Item.CrimsonGuard.Cast")
	local allys = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetCaster():GetAbsOrigin(),
		nil,
		1200,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, units in pairs(allys) do
		units:AddNewModifier(self:GetCaster(), self, "modifier_item_crimson_guard_active_lua", { duration = 12 })
	end
end

-------------------------------------------------------------------------------------

modifier_item_crimson_guard_active_lua = class({})

function modifier_item_crimson_guard_active_lua:OnCreated()
	EmitSoundOn("sounds/items/crimson_guard.vsnd", caster)

	self.particle = ParticleManager:CreateParticle(
		"particles/items2_fx/vanguard_active.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self.particle,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_origin",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.particle, 2, Vector(self:GetParent():GetModelRadius() * 1.2, 0, 0))
	self:AddParticle(self.particle, false, false, -1, false, false)

	if self:GetParent():IsRangedAttacker() then
		self.block_damage_active = self:GetAbility():GetSpecialValueFor("block_damage_ranged_active")
	else
		self.block_damage_active = self:GetAbility():GetSpecialValueFor("block_damage_melee_active")
	end
end

function modifier_item_crimson_guard_active_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}
end

function modifier_item_crimson_guard_active_lua:GetModifierPhysical_ConstantBlock()
	return self.block_damage_active
end

--------------------------------------------------------------------------

modifier_item_crimson_guard_lua = class({})

function modifier_item_crimson_guard_lua:IsHidden()
	return true
end
function modifier_item_crimson_guard_lua:IsPurgable()
	return false
end
function modifier_item_crimson_guard_lua:RemoveOnDeath()
	return false
end
function modifier_item_crimson_guard_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_crimson_guard_lua:OnCreated()
	local ability = self:GetAbility()

	self.bonus_health = ability:GetSpecialValueFor("bonus_health")
	self.bonus_health_regen = ability:GetSpecialValueFor("bonus_health_regen")
	self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")

	if self:GetParent():IsRangedAttacker() then
		self.block_damage = ability:GetSpecialValueFor("block_damage_ranged")
	else
		self.block_damage = ability:GetSpecialValueFor("block_damage_melee")
	end
end

function modifier_item_crimson_guard_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}
end

function modifier_item_crimson_guard_lua:GetModifierConstantHealthRegen()
	return self.bonus_health_regen
end

function modifier_item_crimson_guard_lua:GetModifierHealthBonus()
	return self.bonus_health
end

function modifier_item_crimson_guard_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_item_crimson_guard_lua:GetModifierPhysical_ConstantBlock()
	if RandomInt(1, 2) == 1 then
		return self.block_damage
	else
		return 0
	end
end