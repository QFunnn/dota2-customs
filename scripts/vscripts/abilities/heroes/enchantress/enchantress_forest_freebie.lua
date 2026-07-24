--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


enchantress_forest_freebie = enchantress_forest_freebie or class({})


if not IsServer() then return end


function enchantress_forest_freebie:Spawn()
	if self._listener then return end

	self._listener = EventDriver:Listen("GameLoop:orb_captured", self.OnOrbCaptured, self)
end


function enchantress_forest_freebie:OnOrbCaptured(event)
	local caster = self:GetCaster()
	if event.team ~= caster:GetTeam() then return end

	local heal = self:GetSpecialValueFor("heal_per_orb") * event.rarity

	for _, hero in pairs(GameLoop.heroes_by_team[caster:GetTeam()]) do
		hero:Heal(heal, self)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, hero, heal, nil)
	end
end