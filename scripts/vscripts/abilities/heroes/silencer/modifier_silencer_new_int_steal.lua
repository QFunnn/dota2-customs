--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_silencer_new_int_steal = class({})

function modifier_silencer_new_int_steal:IsHidden() return false end
function modifier_silencer_new_int_steal:IsPurgable() return false end
function modifier_silencer_new_int_steal:IsPurgeException() return false end
function modifier_silencer_new_int_steal:RemoveOnDeath() return false end

function modifier_silencer_new_int_steal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_EVENT_ON_HERO_KILLED,
	}

	return funcs
end

function modifier_silencer_new_int_steal:GetModifierBonusStats_Intellect()
	return self:GetStackCount()
end

function modifier_silencer_new_int_steal:GetTexture()
	return "silencer_glaives_of_wisdom"
end

function modifier_silencer_new_int_steal:OnHeroKilled(keys)
	if (not IsServer()) then return end

	local caster = self:GetCaster()

	if keys.target and keys.target:IsRealHero() and (keys.reincarnate == false or keys.reincarnate == nil) and keys.target:GetTeam() ~= caster:GetTeam() then
		if caster == keys.attacker then
			self:SetStackCount(self:GetStackCount() + 2)
		else
			local units = FindUnitsInRadius(caster:GetTeam(), keys.target:GetAbsOrigin(), nil, 925, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
			for _, unit in pairs(units) do
				if unit == caster then
					self:SetStackCount(self:GetStackCount() + 2)
					break
				end
			end
		end
	end
end