--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_shadow_shaman_shackles_dummy_duration = class({})

function modifier_shadow_shaman_shackles_dummy_duration:IsHidden()
	return true
end
function modifier_shadow_shaman_shackles_dummy_duration:IsPurgable()
	return false
end

function modifier_shadow_shaman_shackles_dummy_duration:OnCreated()
	self.ability = self:GetAbility()
	if self.ability then
		self.ability.channel_duration = self:GetDuration()
	end
end

function modifier_shadow_shaman_shackles_dummy_duration:OnDestroy()
	if self.ability then
		self.ability.channel_duration = nil
	end
end