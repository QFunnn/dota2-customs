--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_war_stomp = class({})

function woda_neutral_war_stomp:Precache(context)
    PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf", context )
end

function woda_neutral_war_stomp:OnSpellStart()
	if not IsServer() then return end
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())

	Timers:CreateTimer(0.4, function()
		self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})
		Timers:CreateTimer(0.4, function()
			if self.sign then
				ParticleManager:DestroyParticle(self.sign, true)
			end
			if not self:GetCaster():IsAlive() then return end
			self:GetCaster():EmitSound("n_creep_Centaur.Stomp")
			local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
			ParticleManager:SetParticleControl(trail_pfx, 1, Vector(radius, 0, 0))
			ParticleManager:ReleaseParticleIndex(trail_pfx)

			local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

			for _, target in ipairs(targets) do
				target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = duration * (1 - target:GetStatusResistance()) })
			end
			self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
		end)
	end)
end