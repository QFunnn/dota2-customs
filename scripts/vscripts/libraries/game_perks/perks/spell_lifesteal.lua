--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

spell_lifesteal = class(base_game_perk)

function spell_lifesteal:DeclareFunctions()
	return { MODIFIER_PROPERTY_ON_DEALDAMAGE_CUSTOM }
end

function spell_lifesteal:OnDealDamage(keys)
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

	-- spell_lifesteal specific guard clauses
	if
		keys.damage_category ~= DOTA_DAMAGE_CATEGORY_SPELL
		and IsBitOff(keys.damage_flags, DOTA_DAMAGE_FLAG_MAGIC_AUTO_ATTACK)
	then
		return
	end
	if not keys.inflictor or keys.inflictor:IsNull() then
		return
	end
	if keys.damage_flags then
		if IsBitSet(keys.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL) then
			return
		end
		if IsBitSet(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) then
			return
		end

		local reflection_exceptions = {
			viper_corrosive_skin = true,
			warlock_fatal_bonds = true,
			zuus_static_field = true,
		}
		if
			IsBitSet(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION)
			and not reflection_exceptions[keys.inflictor:GetAbilityName()]
		then
			return
		end
	end

	local lifesteal_pct = self.lifesteal
	if keys.target:IsCreep() then
		lifesteal_pct = self.lifesteal_creep
	end

	local actual_damage = math.min(keys.target:GetHealth(), keys.damage) -- prevent overhealing, only for spell lifesteal
	local heal = math.max(1, actual_damage * lifesteal_pct * 0.01)
	keys.attacker:HealWithParams(heal, keys.inflictor, false, true, keys.attacker, true)

	local lifesteal_pfx = ParticleManager:CreateParticle(
		"particles/items3_fx/octarine_core_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		keys.attacker
	)
	ParticleManager:ReleaseParticleIndex(lifesteal_pfx)
end