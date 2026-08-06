--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


item_levelup_20 = class({})

function item_levelup_20:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local player_id = IsValid(caster) and caster:GetPlayerOwnerID() or -1

	if not IsValid(caster) or player_id < 0 then
		return
	end

	local spawned = elite_spawn_system:SpawnItemElites(player_id)
	if spawned then
		ConsumeLevelUpItemCharge(caster, ability)
	end
end