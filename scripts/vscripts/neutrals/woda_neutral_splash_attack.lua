--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_splash_attack", "neutrals/woda_neutral_splash_attack", LUA_MODIFIER_MOTION_NONE)

woda_neutral_splash_attack = class({})

function woda_neutral_splash_attack:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/black_dragon_attack_explosion.vpcf", context )
end

function woda_neutral_splash_attack:GetIntrinsicModifierName()
	return "modifier_woda_neutral_splash_attack"
end

modifier_woda_neutral_splash_attack = class({})

function modifier_woda_neutral_splash_attack:IsHidden() return true end
function modifier_woda_neutral_splash_attack:IsPurgable() return false end

function modifier_woda_neutral_splash_attack:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_woda_neutral_splash_attack:GetModifierProcAttack_Feedback(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	
	local blast_pfx = ParticleManager:CreateParticle("particles/neutral_fx/black_dragon_attack_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)
	ParticleManager:SetParticleControl(blast_pfx, 3, params.target:GetAbsOrigin())
	--ParticleManager:ReleaseParticleIndex(blast_pfx)

	local enemies = FindUnitsInRadius(params.attacker:GetTeamNumber(), params.target:GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), self:GetAbility():GetAbilityTargetTeam(), self:GetAbility():GetAbilityTargetType(), self:GetAbility():GetAbilityTargetFlags(), FIND_ANY_ORDER, false)

	local damage = self:GetParent():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility():GetSpecialValueFor("splash")

	for _, enemy in pairs(enemies) do
		if enemy ~= params.target then
			ApplyDamage({ victim = enemy, attacker = params.attacker, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, ability = self:GetAbility() })
		end
	end
end