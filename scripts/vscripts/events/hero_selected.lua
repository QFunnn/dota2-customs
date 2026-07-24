--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local laggy_heroes_count = 0

function Events:OnHeroSelected(event)
	local layout = GameLoop.current_layout

	if layout.laggy_heroes and layout.laggy_heroes_max_count and layout.laggy_heroes_max_count > 0 then
		if layout.laggy_heroes[event.hero_unit] then
			laggy_heroes_count = laggy_heroes_count + 1
		end

		if laggy_heroes_count >= layout.laggy_heroes_max_count then
			for hero_name, _ in pairs(layout.laggy_heroes) do
				GameRules:AddHeroToBlacklist(hero_name)
			end
		end
	end
end