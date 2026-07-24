--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_purge", "neutrals/woda_neutral_purge", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_purge = class({})

function woda_neutral_purge:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")

	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})

	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		if target:IsMagicImmune() then self:GetCaster():RemoveModifierByName("modifier_neutral_cast") return end
		if target:IsDebuffImmune() then self:GetCaster():RemoveModifierByName("modifier_neutral_cast") return end
		local effect = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
		target:EmitSound("n_creep_SatyrTrickster.Cast")
		target:Purge(true, false, false, false, false)
		target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_purge", {duration = duration * (1 - target:GetStatusResistance())})
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_woda_neutral_purge = class({})

function modifier_woda_neutral_purge:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_woda_neutral_purge:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movement_speed")
end