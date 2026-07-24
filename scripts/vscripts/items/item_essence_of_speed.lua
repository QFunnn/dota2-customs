--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_essence_of_speed", "items/item_essence_of_speed", LUA_MODIFIER_MOTION_NONE)

item_essence_of_speed = class({})
function item_essence_of_speed:OnChargeCountChanged(iCharges) end

function item_essence_of_speed:CastFilterResult()
	if not IsServer() then return end

	if self:GetCaster():HasModifier("modifier_item_essence_of_speed") then 
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function item_essence_of_speed:GetCustomCastError()
	return "#essence_speed"
end

function item_essence_of_speed:OnSpellStart()
	if not IsServer() then return end
    self:GetParent():EmitSound("Item.MoonShard.Consume")
    self:GetParent():AddNewModifier(self:GetParent(), self, "modifier_item_essence_of_speed", {})
    self:SpendCharge(0)
end

modifier_item_essence_of_speed = class({})

function modifier_item_essence_of_speed:IsHidden() return true end
function modifier_item_essence_of_speed:IsPurgable() return false end
function modifier_item_essence_of_speed:IsPermanent() return true end
function modifier_item_essence_of_speed:AllowIllusionDuplicate() return true end
function modifier_item_essence_of_speed:RemoveOnDeath() return false end
function modifier_item_essence_of_speed:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_item_essence_of_speed:OnCreated(table)
	if not self:GetAbility()  then 
		self.speed = 100
	else 
		self.speed = self:GetAbility():GetSpecialValueFor("speed_bonus")
	end
end

function modifier_item_essence_of_speed:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_item_essence_of_speed:GetModifierMoveSpeedBonus_Constant()
	return self.speed
end