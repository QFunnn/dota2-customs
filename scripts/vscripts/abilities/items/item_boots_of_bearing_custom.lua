--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_boots_of_bearing_custom",
	"abilities/items/item_boots_of_bearing_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_boots_of_bearing_custom_active",
	"abilities/items/item_boots_of_bearing_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_boots_of_bearing_custom_haste",
	"abilities/items/item_boots_of_bearing_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_boots_of_bearing_custom_aura",
	"abilities/items/item_boots_of_bearing_custom",
	LUA_MODIFIER_MOTION_NONE
)

item_boots_of_bearing_custom = class({})

function item_boots_of_bearing_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items_fx/drum_of_endurance_buff.vpcf", context)
end

function item_boots_of_bearing_custom:GetIntrinsicModifierName()
	return "modifier_item_boots_of_bearing_custom"
end

function item_boots_of_bearing_custom:Spawn()
	self.aura_movement_speed = self:GetSpecialValueFor("aura_movement_speed")
	self.bonus_str = self:GetSpecialValueFor("bonus_str")
	self.bonus_attack_speed_pct = self:GetSpecialValueFor("bonus_attack_speed_pct")
	self.bonus_movement_speed_pct = self:GetSpecialValueFor("bonus_movement_speed_pct")
	self.duration = self:GetSpecialValueFor("duration")
	self.radius = self:GetSpecialValueFor("radius")
	self.bonus_movement_speed = self:GetSpecialValueFor("bonus_movement_speed")
	self.bonus_health_regen = self:GetSpecialValueFor("bonus_health_regen")
	self.bonus_ms_duration = self:GetSpecialValueFor("bonus_ms_duration")
end

function item_boots_of_bearing_custom:OnSpellStart()
	local caster = self:GetCaster()

	local units = caster:FindFriends(self.radius, nil, nil, DOTA_UNIT_TARGET_FLAG_INVULNERABLE)

	for _, unit in pairs(units) do
		unit:AddNewModifier(caster, self, "modifier_item_boots_of_bearing_custom_active", { duration = self.duration })
		unit:AddNewModifier(
			caster,
			self,
			"modifier_item_boots_of_bearing_custom_haste",
			{ duration = self.bonus_ms_duration }
		)
	end

	caster:EmitSound("DOTA_Item.DoE.Activate")
end

modifier_item_boots_of_bearing_custom = class(mod_hidden)
function modifier_item_boots_of_bearing_custom:IsAura()
	return true
end
function modifier_item_boots_of_bearing_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_boots_of_bearing_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_item_boots_of_bearing_custom:GetModifierAura()
	return "modifier_item_boots_of_bearing_custom_aura"
end
function modifier_item_boots_of_bearing_custom:GetAuraRadius()
	return self.ability.radius
end
function modifier_item_boots_of_bearing_custom:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.radius = self.ability.radius
end

function modifier_item_boots_of_bearing_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
	}
end

function modifier_item_boots_of_bearing_custom:GetModifierBonusStats_Strength()
	return self.ability.bonus_str
end

function modifier_item_boots_of_bearing_custom:GetModifierMoveSpeedBonus_Special_Boots()
	return self.ability.bonus_movement_speed
end

modifier_item_boots_of_bearing_custom_aura = class(mod_visible)
function modifier_item_boots_of_bearing_custom_aura:IsPurgable()
	return true
end
function modifier_item_boots_of_bearing_custom_aura:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.speed = self.ability.bonus_health_regen
	self.regen = self.ability.bonus_health_regen
end

function modifier_item_boots_of_bearing_custom_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_boots_of_bearing_custom_aura:GetModifierMoveSpeedBonus_Constant()
	return self.speed
end

function modifier_item_boots_of_bearing_custom_aura:GetModifierConstantHealthRegen()
	return self.regen
end

modifier_item_boots_of_bearing_custom_active = class(mod_visible)
function modifier_item_boots_of_bearing_custom_active:IsPurgable()
	return true
end
function modifier_item_boots_of_bearing_custom_active:OnCreated(table)
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.attack_speed = self.ability.bonus_attack_speed_pct
	self.move_speed = self.ability.bonus_movement_speed_pct

	if not IsServer() then
		return
	end
	local particle_buff_fx = ParticleManager:CreateParticle(
		"particles/items_fx/drum_of_endurance_buff.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControl(particle_buff_fx, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_buff_fx, 1, Vector(0, 0, 0))
	self:AddParticle(particle_buff_fx, false, false, -1, false, false)
end

function modifier_item_boots_of_bearing_custom_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_boots_of_bearing_custom_active:GetModifierMoveSpeedBonus_Percentage()
	return self.move_speed
end

function modifier_item_boots_of_bearing_custom_active:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed
end

function modifier_item_boots_of_bearing_custom_active:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

modifier_item_boots_of_bearing_custom_haste = class(mod_hidden)
function modifier_item_boots_of_bearing_custom_haste:CheckState()
	return {
		[MODIFIER_STATE_UNSLOWABLE] = true,
	}
end