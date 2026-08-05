--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_bad_vision = class({})

function modifier_bad_vision:IsHidden()
	return false
end
function modifier_bad_vision:IsDebuff()
	return true
end
function modifier_bad_vision:IsPurgable()
	return false
end
function modifier_bad_vision:GetTexture()
	return "darkness"
end

function modifier_bad_vision:OnCreated(kv)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
end

function modifier_bad_vision:OnIntervalThink()
	local parent = self:GetParent()
	local trigger = Entities:FindByName(nil, "vision")
	if trigger and not trigger:IsTouching(parent) then
		self:Destroy()
	end
end

function modifier_bad_vision:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_FIXED_DAY_VISION,
		MODIFIER_PROPERTY_FIXED_NIGHT_VISION,
	}
end

function modifier_bad_vision:GetFixedDayVision()
	return 350
end
function modifier_bad_vision:GetFixedNightVision()
	return 350
end