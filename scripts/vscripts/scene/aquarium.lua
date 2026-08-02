--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "scene/aquarium"
local b = require("lualib_bundle")
local c = b.__TS__ArrayForEach
particleIDList = {}
entList = {}
function Spawn(self, d)
	for e, f in pairs(KeyValues.collection) do
		local g = f.type
		if g == nil then
			g = ""
		end
		if g == "fish" then
			local h = SpawnEntityFromTableSynchronous(
				"prop_dynamic",
				{ targetname = "portraitUnit", origin = "10000 0 0", model = f.model }
			)
			entList[e] = h:entindex()
		end
	end
	RequestEvent("get_fish_ent", function()
		return { entindex = thisEntity:entindex(), fishEntList = entList }
	end)
end
function UpdateOnRemove(self, d)
	c(particleIDList, function(i, j)
		ParticleManager:DestroyParticle(j, false)
	end)
	for k, l in pairs(entList) do
		local h = EntIndexToHScript(l)
		if IsValid(h) then
			h:RemoveSelf()
		end
	end
end