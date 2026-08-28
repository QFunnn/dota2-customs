--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/city_effect/city_34 copy.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__ArrayForEach
local g = c.__TS__Decorate
local h = c.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["15"] = 5,
		["16"] = 13,
		["17"] = 5,
		["18"] = 13,
		["20"] = 13,
		["21"] = 14,
		["22"] = 15,
		["23"] = 5,
		["24"] = 16,
		["25"] = 17,
		["26"] = 18,
		["27"] = 19,
		["28"] = 20,
		["29"] = 21,
		["30"] = 22,
		["31"] = 23,
		["32"] = 23,
		["35"] = 18,
		["37"] = 16,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 32,
		["44"] = 33,
		["46"] = 31,
		["47"] = 31,
		["49"] = 29,
		["50"] = 13,
		["51"] = 5,
		["52"] = 5,
		["53"] = 5,
		["54"] = 5,
		["55"] = 5,
		["56"] = 5,
		["57"] = 5,
		["58"] = 5,
		["59"] = 13,
		["61"] = 13,
		["62"] = 40,
		["63"] = 48,
		["64"] = 40,
		["65"] = 48,
		["66"] = 49,
		["67"] = 50,
		["68"] = 49,
		["69"] = 48,
		["70"] = 40,
		["71"] = 40,
		["72"] = 40,
		["73"] = 40,
		["74"] = 40,
		["75"] = 40,
		["76"] = 40,
		["77"] = 40,
		["78"] = 48,
		["80"] = 48,
	}
)
local i = {}
local j = require("modifiers.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
local m = require("modifiers.city_effect.city_effect_modifier")
local n = m.CityEffectModifier
i.modifier_city_34 = d()
local o = i.modifier_city_34
o.name = "modifier_city_34"
e(o, n)
function o.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.modifierList = {}
	self.particleIDList = {}
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		PlayerData:eachPlayer(function(q, r)
			local s = PlayerResource:GetSelectedHeroEntity(r.playerID)
			if IsValid(s) then
				local t = s:AddNewModifier(s, nil, "modifier_city_34_buff", nil)
				if IsValid(t) then
					local u = self.modifierList
					u[#u + 1] = t
				end
			end
		end)
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		f(self.modifierList, function(q, v)
			if IsValid(v) then
				v:Destroy()
			end
		end)
	end
end
o = g(
	{
		l(
			nil,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	o
)
i.modifier_city_34 = o
i.modifier_city_34_buff = d()
local w = i.modifier_city_34_buff
w.name = "modifier_city_34_buff"
e(w, k)
function w.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_EFFECT_CARD_COST_PERCENTAGE] = -CityEffect:GetSpecialValueFor(
			"city_34",
			"reduce_pct"
		),
	}
end
w = g(
	{
		l(
			nil,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	w
)
i.modifier_city_34_buff = w
return i