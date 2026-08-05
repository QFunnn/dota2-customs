--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


modifier_custom_activity = class({})
function modifier_custom_activity:IsHidden()
	return true
end
function modifier_custom_activity:IsPurgable()
	return false
end
function modifier_custom_activity:IsPurgeException()
	return false
end
function modifier_custom_activity:RemoveOnDeath()
	return false
end
function modifier_custom_activity:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_custom_activity:OnCreated(params)
	if not IsServer() then
		return
	end
	self.activity = params.activity
	self:SetHasCustomTransmitterData(true)
end

function modifier_custom_activity:AddCustomTransmitterData()
	return {
		activity = self.activity,
	}
end

function modifier_custom_activity:HandleCustomTransmitterData(data)
	self.activity = data.activity
end

function modifier_custom_activity:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}
end

function modifier_custom_activity:GetActivityTranslationModifiers()
	return self.activity
end