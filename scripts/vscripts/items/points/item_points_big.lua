--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_points_big = class({})

function item_points_big:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function item_points_big:OnSpellStart()
	if IsServer() then
		self:GetCaster():EmitSoundParams("DOTA_Item.InfusedRaindrop", 0, 0.5, 0)

		local Heroes = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCaster():GetOrigin(),
			self:GetCaster(),
			FIND_UNITS_EVERYWHERE,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS,
			0,
			false
		)
		for _, Hero in pairs(Heroes) do
			Hero:ChangeWood(500)

			Hero:EmitSoundParams("DOTA_Item.InfusedRaindrop", 0, 0.5, 0)
			UTIL_Remove(self)
		end
	end
end