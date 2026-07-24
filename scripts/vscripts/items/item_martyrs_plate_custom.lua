--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_martyrs_plate_custom", "items/item_martyrs_plate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_martyrs_plate_custom_buff", "items/item_martyrs_plate_custom", LUA_MODIFIER_MOTION_NONE)

item_martyrs_plate_custom = class({})
function item_martyrs_plate_custom:GetIntrinsicModifierName()
    return "modifier_item_martyrs_plate_custom"
end

modifier_item_martyrs_plate_custom = class({})

function modifier_item_martyrs_plate_custom:IsHidden() return true end

function modifier_item_martyrs_plate_custom:IsPurgable() return false end
function modifier_item_martyrs_plate_custom:IsPurgeException() return false end

function modifier_item_martyrs_plate_custom:OnCreated()
	self.magic_resist = self:GetAbility():GetSpecialValueFor("magic_resist")
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
end

function modifier_item_martyrs_plate_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_item_martyrs_plate_custom:GetModifierConstantHealthRegen()
	return self.hp_regen
end

function modifier_item_martyrs_plate_custom:GetModifierMagicalResistanceBonus()
	return self.magic_resist
end

function modifier_item_martyrs_plate_custom:IsAura()
    return true
end

function modifier_item_martyrs_plate_custom:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("aura_radius")
	end
end

function modifier_item_martyrs_plate_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_item_martyrs_plate_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_martyrs_plate_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC
end

function modifier_item_martyrs_plate_custom:GetModifierAura()
	return "modifier_item_martyrs_plate_custom_buff"
end

function modifier_item_martyrs_plate_custom:GetAuraEntityReject(hTarget)
    if not IsServer() then return end
    if hTarget:GetOwner() == self:GetCaster() and hTarget ~= self:GetCaster() then
        return false
    end
    return true
end

modifier_item_martyrs_plate_custom_buff = class({})
function modifier_item_martyrs_plate_custom_buff:IsPurgable() return false end
function modifier_item_martyrs_plate_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
    }
end
function modifier_item_martyrs_plate_custom_buff:GetModifierTotal_ConstantBlock(params)
    if not IsServer() then return end
    local damage = params.damage
    local change_damage = damage * (self:GetAbility():GetSpecialValueFor("damage_redirection") / 100)
    return change_damage
end