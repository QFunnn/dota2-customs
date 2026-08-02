--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/maps/base_0015_map.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 4,
		["14"] = 5,
		["15"] = 4,
		["16"] = 7,
		["17"] = 8,
		["18"] = 8,
		["19"] = 8,
		["20"] = 8,
		["21"] = 12,
		["22"] = 13,
		["24"] = 14,
		["25"] = 14,
		["26"] = 15,
		["27"] = 16,
		["28"] = 17,
		["29"] = 18,
		["30"] = 18,
		["31"] = 18,
		["32"] = 18,
		["33"] = 18,
		["34"] = 18,
		["35"] = 19,
		["36"] = 20,
		["37"] = 14,
		["40"] = 22,
		["41"] = 22,
		["42"] = 22,
		["44"] = 23,
		["45"] = 23,
		["46"] = 24,
		["47"] = 23,
		["50"] = 22,
		["51"] = 22,
		["52"] = 7,
		["53"] = 28,
		["54"] = 29,
		["55"] = 30,
		["57"] = 28,
		["58"] = 33,
		["59"] = 33,
	}
)
local g = {}
local h = require("abilities.maps.map_base")
local i = h.MapBase
g.base_0015_map = d()
local j = g.base_0015_map
j.name = "base_0015_map"
e(j, i)
function j.prototype.spawn(self)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END, self.OnBattleEnd)
end
function j.prototype.Victory(self)
	local k = { Vector(1024, 0), Vector(-1024, 0) }
	local l = PlayerResource:GetSelectedHeroEntity(self.playerID)
	local m = {}
	do
		local n = 0
		while n < #k do
			local o = self.position + k[n + 1]
			local p = (k[n + 1] * -1):Normalized()
			local q = ParticleManager:CreateParticle(
				"models/events/crownfall/survivors/particles/victory_fireworks.vpcf",
				PATTACH_CUSTOMORIGIN,
				l
			)
			ParticleManager:SetParticleControlTransform(
				q,
				0,
				Vector(0, 0, 350) + GetGroundPosition(o, nil),
				VectorToAngles(p)
			)
			ParticleManager:ReleaseParticleIndex(q)
			m[#m + 1] = o
			n = n + 1
		end
	end
	GameTimer(0.2, function()
		do
			local n = 0
			while n < #k do
				EmitSoundOnLocationWithCaster(m[n + 1], "Hero_LegionCommander.Duel.Victory", l)
				n = n + 1
			end
		end
	end)
end
function j.prototype.OnBattleEnd(self, r)
	if r.illusionPlayerID ~= self.playerID and r.winPlayerID == self.playerID then
		self:Victory()
	end
end
function j.prototype.dispose(self) end
return g