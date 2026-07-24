--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rune_arcane_custom", "modifiers/modifier_rune_arcane_custom", LUA_MODIFIER_MOTION_NONE)

modifier_rune_arcane_custom = class({})

function modifier_rune_arcane_custom:IsHidden()
	return false
end

function modifier_rune_arcane_custom:IsDebuff()
	return false
end

function modifier_rune_arcane_custom:IsPurgable()
	return true
end

function modifier_rune_arcane_custom:IsPurgeException()
	return true
end

function modifier_rune_arcane_custom:GetTexture()
	return "rune_arcane"
end

function modifier_rune_arcane_custom:OnCreated()
	if not IsServer() then return end
	
	-- Параметры можно настроить здесь
	self.mana_reduction = 30  -- Снижение мана-коста на 30%
	self.cooldown_reduction = 10  -- Снижение кулдауна на 10%
	
	-- Эффект руны
	local particle = ParticleManager:CreateParticle("particles/generic_gameplay/rune_arcane_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_rune_arcane_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end

function modifier_rune_arcane_custom:GetModifierPercentageManacost()
	return self.mana_reduction or 30
end

function modifier_rune_arcane_custom:GetModifierPercentageCooldown()
	return self.cooldown_reduction or 10
end
