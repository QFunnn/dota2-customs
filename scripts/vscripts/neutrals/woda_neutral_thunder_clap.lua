--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_thunder_clap_debuff", "neutrals/woda_neutral_thunder_clap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_thunder_clap = class({})

function woda_neutral_thunder_clap:Precache(context)
    PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/ursa_thunderclap.vpcf", context )
end

function woda_neutral_thunder_clap:OnSpellStart()
	if not IsServer() then return end
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})
	self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())

	Timers:CreateTimer(0.4, function()
		if self.sign then
			ParticleManager:DestroyParticle(self.sign, true)
		end

		if not self:GetCaster():IsAlive() then return end

		local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/ursa_thunderclap.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
		ParticleManager:SetParticleControl(trail_pfx, 1, Vector(radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(trail_pfx)

		self:GetCaster():EmitSound("n_creep_Ursa.Clap")

		local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

		for _, target in ipairs(targets) do
			target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_thunder_clap_debuff", { duration = duration * (1 - target:GetStatusResistance())})
		end
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_woda_neutral_thunder_clap_debuff = class({})

function modifier_woda_neutral_thunder_clap_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_woda_neutral_thunder_clap_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movement_speed")
end
