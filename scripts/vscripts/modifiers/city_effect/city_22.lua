--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_22"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
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
		["22"] = 5,
		["23"] = 15,
		["24"] = 16,
		["25"] = 17,
		["26"] = 18,
		["27"] = 19,
		["28"] = 20,
		["29"] = 21,
		["30"] = 22,
		["31"] = 22,
		["34"] = 17,
		["36"] = 15,
		["37"] = 28,
		["38"] = 29,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 31,
		["43"] = 32,
		["45"] = 30,
		["46"] = 30,
		["48"] = 28,
		["49"] = 13,
		["50"] = 5,
		["51"] = 5,
		["52"] = 5,
		["53"] = 5,
		["54"] = 5,
		["55"] = 5,
		["56"] = 5,
		["57"] = 5,
		["58"] = 13,
		["60"] = 13,
		["61"] = 39,
		["62"] = 47,
		["63"] = 39,
		["64"] = 47,
		["65"] = 49,
		["66"] = 50,
		["67"] = 49,
		["68"] = 52,
		["69"] = 53,
		["70"] = 54,
		["72"] = 52,
		["73"] = 57,
		["74"] = 58,
		["75"] = 59,
		["76"] = 60,
		["77"] = 61,
		["78"] = 62,
		["79"] = 63,
		["82"] = 57,
		["83"] = 67,
		["84"] = 68,
		["85"] = 67,
		["86"] = 47,
		["87"] = 39,
		["88"] = 39,
		["89"] = 39,
		["90"] = 39,
		["91"] = 39,
		["92"] = 39,
		["93"] = 39,
		["94"] = 39,
		["95"] = 47,
		["97"] = 47,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
h.modifier_city_22 = c()
local n = h.modifier_city_22
n.name = "modifier_city_22"
d(n, m)
function n.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.modifierList = {}
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		PlayerData:eachPlayer(function(p, q)
			local r = PlayerResource:GetSelectedHeroEntity(q.playerID)
			if IsValid(r) then
				local s = r:AddNewModifier(r, nil, "modifier_city_22_buff", nil)
				if IsValid(s) then
					local t = self.modifierList
					t[#t + 1] = s
				end
			end
		end)
	end
end
function n.prototype.OnDestroy(self)
	if IsServer() then
		e(self.modifierList, function(p, u)
			if IsValid(u) then
				u:Destroy()
			end
		end)
	end
end
n = f(
	{
		k(
			a,
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
	n
)
h.modifier_city_22 = n
h.modifier_city_22_buff = c()
local v = h.modifier_city_22_buff
v.name = "modifier_city_22_buff"
d(v, j)
function v.prototype.GetAbilitySpecialValue(self)
	self.level = CityEffect:GetSpecialValueFor("city_22", "level") - 1
end
function v.prototype.OnCreated(self, o)
	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end
function v.prototype.OnIntervalThink(self)
	if IsServer() then
		self:StartIntervalThink(-1)
		local w = self:GetParent():GetPlayerOwnerID()
		local x = PlayerData:getHero(w)
		if x then
			x:fixHeroLevel(x.hero)
		end
	end
end
function v.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_DEFAULT_LEVEL_BONUS] = self.level }
end
v = f(
	{
		k(
			a,
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
	v
)
h.modifier_city_22_buff = v
return h