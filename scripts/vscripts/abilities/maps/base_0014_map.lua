--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/maps/base_0014_map"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
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
		["21"] = 8,
		["22"] = 8,
		["23"] = 8,
		["24"] = 8,
		["25"] = 8,
		["26"] = 8,
		["27"] = 8,
		["28"] = 8,
		["29"] = 20,
		["30"] = 21,
		["31"] = 23,
		["33"] = 24,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 27,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 28,
		["43"] = 28,
		["44"] = 28,
		["45"] = 28,
		["46"] = 28,
		["47"] = 29,
		["48"] = 29,
		["49"] = 29,
		["50"] = 29,
		["51"] = 29,
		["52"] = 30,
		["53"] = 31,
		["54"] = 24,
		["57"] = 34,
		["58"] = 36,
		["59"] = 36,
		["60"] = 36,
		["61"] = 37,
		["62"] = 38,
		["63"] = 39,
		["65"] = 40,
		["66"] = 40,
		["67"] = 41,
		["68"] = 40,
		["71"] = 43,
		["74"] = 46,
		["76"] = 47,
		["77"] = 47,
		["78"] = 48,
		["79"] = 47,
		["84"] = 36,
		["85"] = 36,
		["86"] = 7,
		["87"] = 54,
		["88"] = 55,
		["89"] = 56,
		["91"] = 54,
		["92"] = 59,
		["93"] = 59,
	}
)
local f = {}
local g = require("abilities.maps.map_base")
local h = g.MapBase
f.base_0014_map = c()
local i = f.base_0014_map
i.name = "base_0014_map"
d(i, h)
function i.prototype.spawn(self)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END, self.OnBattleEnd)
end
function i.prototype.Victory(self)
	local j = {
		Vector(-11870, -10451, 0),
		Vector(-10626, -10552, 0),
		Vector(-10412, -10770, 0),
		Vector(-10146, -11256, 0),
		Vector(-10251, -11264, 0),
		Vector(-10264, -11264, 0),
		Vector(-11803, -12112, 0),
		Vector(-12050, -11822, 0),
		Vector(-12330, -11463, 0),
		Vector(-12330, -11463, 0),
	}
	local k = Vector(-11264, -11264, 0)
	local l = PlayerResource:GetSelectedHeroEntity(self.playerID)
	local m = {}
	do
		local n = 0
		while n < #j do
			local o = self.position + j[n + 1] - k
			local p = ParticleManager:CreateParticle(
				"models/eom/props/firecracker_01/particle/firecracker_01_fx.vpcf",
				PATTACH_CUSTOMORIGIN,
				l
			)
			ParticleManager:SetParticleControl(p, 0, GetGroundPosition(o, nil))
			ParticleManager:SetParticleControl(p, 2, GetGroundPosition(o, nil))
			ParticleManager:SetParticleControl(p, 3, GetGroundPosition(o, nil))
			ParticleManager:ReleaseParticleIndex(p)
			m[#m + 1] = o
			n = n + 1
		end
	end
	local q = false
	GameTimer(0.85, function()
		if not q then
			q = true
			if IsValid(l) then
				do
					local n = 0
					while n < #m do
						EmitSoundOnLocationWithCaster(m[n + 1], "ParticleDriven.Rocket.Launch", l)
						n = n + 1
					end
				end
				return 0.4
			end
		else
			if IsValid(l) then
				do
					local n = 0
					while n < #m do
						EmitSoundOnLocationWithCaster(m[n + 1], "ParticleDriven.Rocket.Explode", l)
						n = n + 1
					end
				end
			end
		end
	end)
end
function i.prototype.OnBattleEnd(self, r)
	if r.illusionPlayerID ~= self.playerID and r.winPlayerID == self.playerID then
		self:Victory()
	end
end
function i.prototype.dispose(self) end
return f