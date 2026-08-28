--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

lifesteal = class(base_game_perk)

function lifesteal:DeclareFunctions()
	return { MODIFIER_PROPERTY_ON_DEALDAMAGE_CUSTOM }
end

function lifesteal:OnDealDamage(keys)
	if not keys.attacker or keys.attacker:IsNull() then
		return
	end
	if not keys.target or keys.target:IsNull() then
		return
	end
	if keys.damage <= 0 then
		return
	end
	if keys.target:IsBuilding() then
		return
	end

	-- lifesteal specific guard clauses
	if keys.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return
	end
	if
		IsBitSet(keys.damage_flags, DOTA_DAMAGE_FLAG_MAGIC_AUTO_ATTACK)
		and not keys.attacker:HasModifier("modifier_muerta_pierce_the_veil_buff")
	then
		return
	end
	if keys.attacker:GetTeamNumber() == keys.target:GetTeamNumber() then
		return
	end -- lifesteal does not work on allies, but spell lifesteal does
	if keys.target:IsOther() then
		return
	end

	local heal = math.max(1, keys.damage * self.lifesteal_pct * 0.01)
	keys.attacker:HealWithParams(heal, keys.inflictor, true, true, keys.attacker, false)

	local lifesteal_pfx = ParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		keys.attacker
	)
	ParticleManager:SetParticleControl(lifesteal_pfx, 0, keys.attacker:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(lifesteal_pfx)
end