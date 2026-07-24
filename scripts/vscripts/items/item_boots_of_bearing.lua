--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_boots_of_bearing_custom", "items/item_boots_of_bearing", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_boots_of_bearing_custom_buff", "items/item_boots_of_bearing", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_boots_of_bearing_custom_active", "items/item_boots_of_bearing", LUA_MODIFIER_MOTION_NONE)

item_boots_of_bearing_custom = class({})

function item_boots_of_bearing_custom:GetIntrinsicModifierName()
	return "modifier_item_boots_of_bearing_custom"
end

function item_boots_of_bearing_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
	for _, unit in pairs(units) do
        unit:AddNewModifier(self:GetCaster(), self, "modifier_item_boots_of_bearing_custom_active", {duration = duration})
    end
end

modifier_item_boots_of_bearing_custom_active = class({})

function modifier_item_boots_of_bearing_custom_active:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/items_fx/drum_of_endurance_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(0,0,0))
	self:AddParticle(particle, false, false, -1, false, false)
	self:GetParent():EmitSound("DOTA_Item.DoE.Activate")
end

function modifier_item_boots_of_bearing_custom_active:CheckState()
	return {
		[MODIFIER_STATE_UNSLOWABLE] = true
	}
end

modifier_item_boots_of_bearing_custom = class({})

function modifier_item_boots_of_bearing_custom:IsHidden() return true end
function modifier_item_boots_of_bearing_custom:IsPurgable() return false end
function modifier_item_boots_of_bearing_custom:IsPurgeException() return false end

function modifier_item_boots_of_bearing_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_boots_of_bearing_custom:IsAura()
	return true
end

function modifier_item_boots_of_bearing_custom:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("radius")
	end
end

function modifier_item_boots_of_bearing_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_item_boots_of_bearing_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_boots_of_bearing_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_boots_of_bearing_custom:GetModifierAura()
	return "modifier_item_boots_of_bearing_custom_buff"
end

function modifier_item_boots_of_bearing_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_boots_of_bearing_custom:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_str")
end

function modifier_item_boots_of_bearing_custom:GetModifierMoveSpeedBonus_Special_Boots()
	return self:GetAbility():GetSpecialValueFor("bonus_movespeed")
end

function modifier_item_boots_of_bearing_custom:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("health_regen")
end

function modifier_item_boots_of_bearing_custom:GetAuraDuration()
	return 0
end

modifier_item_boots_of_bearing_custom_buff = class({})

function modifier_item_boots_of_bearing_custom_buff:OnCreated()
	if not IsServer() then return end
end

function modifier_item_boots_of_bearing_custom_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_boots_of_bearing_custom_buff:GetModifierConstantHealthRegen()
    return self:GetAbility():GetSpecialValueFor("hp_regen_aura")
end

function modifier_item_boots_of_bearing_custom_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_boots_of_bearing_custom_buff:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end