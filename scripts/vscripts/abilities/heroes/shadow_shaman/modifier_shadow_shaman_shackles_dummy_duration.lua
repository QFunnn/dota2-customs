--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_shadow_shaman_shackles_dummy_duration = class({})

function modifier_shadow_shaman_shackles_dummy_duration:IsHidden() return true end
function modifier_shadow_shaman_shackles_dummy_duration:IsPurgable() return false end

function modifier_shadow_shaman_shackles_dummy_duration:OnCreated()
	self.parent = self:GetParent()
	if not IsValidEntity(self.parent) then return end
	self.ability = self:GetAbility()
	if self.ability then self.ability.channel_duration = self:GetDuration() end
end

function modifier_shadow_shaman_shackles_dummy_duration:OnDestroy()
	if self.ability then self.ability.channel_duration = nil end
end

function modifier_shadow_shaman_shackles_dummy_duration:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_shadow_shaman_shackles_dummy_duration:OnTakeDamage(keys)
	if self.parent ~= keys.attacker then return end
	if self.parent == keys.unit then return end -- self-damage is not healed
	if keys.original_damage <= 0 then return end
	if keys.inflictor ~= self.ability then return end

	local heal_pct = self.ability:GetSpecialValueFor("heal_percentage") or 100
	local heal_amount = keys.original_damage * (heal_pct / 100)
	self.parent:HealWithParams(heal_amount, self.ability, false, true, self.parent, false)
end