--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_boots_speed_rare = class({})
LinkLuaModifier("modifier_item_boots_speed_rare", "items/neutral/item_boots_speed_rare.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_item_boots_speed_rare_aura_positive",
	"items/neutral/item_boots_speed_rare.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_boots_speed_rare_aura_positive_effect",
	"items/neutral/item_boots_speed_rare.lua",
	LUA_MODIFIER_MOTION_NONE
)

function item_boots_speed_rare:GetIntrinsicModifierName()
	return "modifier_item_boots_speed_rare"
end

modifier_item_boots_speed_rare = class({})

function modifier_item_boots_speed_rare:IsHidden()
	return true
end
function modifier_item_boots_speed_rare:IsPurgable()
	return false
end
function modifier_item_boots_speed_rare:RemoveOnDeath()
	return false
end
function modifier_item_boots_speed_rare:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_boots_speed_rare:OnCreated()
	if IsServer() then
		if not self:GetAbility() then
			self:Destroy()
		end
	end

	if not IsServer() then
		return
	end

	if not self:GetCaster():HasModifier("modifier_item_boots_speed_rare_aura_positive") then
		self:GetCaster()
			:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_boots_speed_rare_aura_positive", {})
	end
end

function modifier_item_boots_speed_rare:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}
end

function modifier_item_boots_speed_rare:GetModifierMoveSpeed_Absolute()
	if self:GetAbility() then
		return 550
	end
end

function modifier_item_boots_speed_rare:OnDestroy()
	if IsServer() then
		-- If it is the last Assault Cuirass in the inventory, remove the aura
		if not self:GetCaster():HasModifier("modifier_item_boots_speed_rare") then
			self:GetCaster():RemoveModifierByName("modifier_item_boots_speed_rare_aura_positive")
		end
	end
end

-- Assault Cuirass positive aura
modifier_item_boots_speed_rare_aura_positive = class({})

function modifier_item_boots_speed_rare_aura_positive:IsDebuff()
	return false
end
function modifier_item_boots_speed_rare_aura_positive:AllowIllusionDuplicate()
	return true
end
function modifier_item_boots_speed_rare_aura_positive:IsHidden()
	return true
end
function modifier_item_boots_speed_rare_aura_positive:IsPurgable()
	return false
end

function modifier_item_boots_speed_rare_aura_positive:GetAuraRadius()
	if self:GetAbility() then
		return 700
	end
end

function modifier_item_boots_speed_rare_aura_positive:GetAuraEntityReject(target)
	return false
end

function modifier_item_boots_speed_rare_aura_positive:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_item_boots_speed_rare_aura_positive:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_boots_speed_rare_aura_positive:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_item_boots_speed_rare_aura_positive:GetModifierAura()
	return "modifier_item_boots_speed_rare_aura_positive_effect"
end

function modifier_item_boots_speed_rare_aura_positive:IsAura()
	return true
end

modifier_item_boots_speed_rare_aura_positive_effect = class({})

function modifier_item_boots_speed_rare_aura_positive_effect:OnCreated()
	if IsServer() then
		if not self:GetAbility() then
			self:Destroy()
		end
	end
end

function modifier_item_boots_speed_rare_aura_positive_effect:IsHidden()
	return true
end
function modifier_item_boots_speed_rare_aura_positive_effect:IsPurgable()
	return false
end
function modifier_item_boots_speed_rare_aura_positive_effect:IsDebuff()
	return false
end

function modifier_item_boots_speed_rare_aura_positive_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_item_boots_speed_rare_aura_positive_effect:GetModifierMoveSpeedBonus_Percentage()
	return 25
end