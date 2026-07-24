--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gem_custom_buff", "items/item_gem_custom", LUA_MODIFIER_MOTION_NONE)

item_gem_custom = class({})

function item_gem_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():EmitSound("Item.SeerStone")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_gem_custom_buff", {duration = duration})
end

modifier_item_gem_custom_buff = class({})

function modifier_item_gem_custom_buff:IsPurgable() return false end

function modifier_item_gem_custom_buff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_item_gem_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetParent():GetDayTimeVisionRange(), 0.1, false)
end

function modifier_item_gem_custom_buff:CheckState()
	return 
    {
		[MODIFIER_STATE_FORCED_FLYING_VISION] = true,
	}
end

function modifier_item_gem_custom_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_FIXED_DAY_VISION,
		MODIFIER_PROPERTY_FIXED_NIGHT_VISION
	}
end

function modifier_item_gem_custom_buff:GetFixedDayVision ()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_item_gem_custom_buff:GetFixedNightVision()
	return self:GetAbility():GetSpecialValueFor("radius")
end