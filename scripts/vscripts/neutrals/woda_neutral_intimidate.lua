--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_intimidate_debuff", "neutrals/woda_neutral_intimidate", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_intimidate = class({})

function woda_neutral_intimidate:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/wolf_intimidate_howl_cast.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/wolf_intimidate_howl_cast_dmg_debuff.vpcf", context )
end

function woda_neutral_intimidate:OnSpellStart()
	if not IsServer() then return end
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})

	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/wolf_intimidate_howl_cast.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
		ParticleManager:SetParticleControl(trail_pfx, 1, Vector(radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(trail_pfx)

		local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

		for _, target in ipairs(targets) do
			target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_intimidate_debuff", { duration = duration * (1 - target:GetStatusResistance())})
		end
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_woda_neutral_intimidate_debuff = class({})

function modifier_woda_neutral_intimidate_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
	}
end

function modifier_woda_neutral_intimidate_debuff:GetModifierDamageOutgoing_Percentage()
	if self:GetParent():HasModifier("modifier_phantom_assassin_stifling_dagger_custom") then return end
	return self:GetAbility():GetSpecialValueFor("damage_reduce")
end

function modifier_woda_neutral_intimidate_debuff:GetEffectName()
	return "particles/neutral_fx/wolf_intimidate_howl_cast_dmg_debuff.vpcf"
end

function modifier_woda_neutral_intimidate_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
