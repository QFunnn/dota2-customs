--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/city_effect/city_28 copy.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__ArrayForEach
local g = c.__TS__New
local h = c.__TS__Decorate
local i = c.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 3,
		["15"] = 3,
		["17"] = 6,
		["18"] = 14,
		["19"] = 6,
		["20"] = 14,
		["22"] = 14,
		["23"] = 18,
		["24"] = 6,
		["25"] = 19,
		["26"] = 20,
		["27"] = 21,
		["28"] = 19,
		["29"] = 23,
		["30"] = 24,
		["31"] = 25,
		["33"] = 23,
		["34"] = 28,
		["35"] = 29,
		["36"] = 28,
		["37"] = 33,
		["38"] = 34,
		["39"] = 33,
		["40"] = 36,
		["41"] = 37,
		["42"] = 38,
		["43"] = 39,
		["44"] = 40,
		["46"] = 41,
		["47"] = 41,
		["48"] = 42,
		["49"] = 43,
		["50"] = 44,
		["51"] = 45,
		["52"] = 46,
		["53"] = 47,
		["54"] = 47,
		["55"] = 47,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 47,
		["60"] = 47,
		["61"] = 52,
		["63"] = 41,
		["66"] = 39,
		["68"] = 36,
		["69"] = 58,
		["70"] = 59,
		["71"] = 60,
		["72"] = 61,
		["73"] = 62,
		["74"] = 63,
		["75"] = 63,
		["76"] = 63,
		["77"] = 64,
		["78"] = 63,
		["79"] = 63,
		["80"] = 66,
		["81"] = 67,
		["83"] = 69,
		["84"] = 70,
		["85"] = 70,
		["86"] = 70,
		["87"] = 71,
		["88"] = 72,
		["90"] = 70,
		["91"] = 70,
		["93"] = 77,
		["94"] = 58,
		["95"] = 14,
		["96"] = 6,
		["97"] = 6,
		["98"] = 6,
		["99"] = 6,
		["100"] = 6,
		["101"] = 6,
		["102"] = 6,
		["103"] = 6,
		["104"] = 14,
		["106"] = 14,
	}
)
local j = {}
local k = require("class.weight_pool")
local l = k.CWeightPool
local m = require("modifiers.eom_modifier")
local n = m.registerEOMModifier
local o = require("modifiers.city_effect.city_effect_modifier")
local p = o.CityEffectModifier
j.modifier_city_28 = d()
local q = j.modifier_city_28
q.name = "modifier_city_28"
e(q, p)
function q.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.enable = true
end
function q.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		self:EffectFunc()
	end
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function q.prototype.OnRoundStart(self, r)
	self:EffectFunc()
end
function q.prototype.EffectFunc(self)
	if self.enable and Rounds:getCurrentRound() >= self.round then
		self.enable = false
		PlayerData:eachAlivePlayerHero(function(s, t, u)
			local v = self:getLegendPool(u)
			do
				local w = 0
				while w < self.count do
					local x = v:random()
					v:remove(x)
					if x ~= nil and KeyValues.AbilityUpgradesKvs[x] then
						local y = KeyValues.AbilityUpgradesKvs[x]
						t:learnAbility(x, true)
						Notification:combatToPlayer(
							u,
							{
								message = "notify_artifact_ability_" .. tostring(y.rarity),
								string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetCityName(),
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
							}
						)
						CityEffect:addCityEffectAbilites(u, x)
					end
					w = w + 1
				end
			end
		end)
	end
end
function q.prototype.getLegendPool(self, u)
	local t = PlayerData:getHero(u)
	local z = PlayerData:getplayerData(u)
	local A = {}
	local B = {}
	f(AbilityShop.banList, function(s, C)
		B[#B + 1] = C
	end)
	if z.bannedSect then
		B[#B + 1] = z.bannedSect
	end
	for C, D in pairs(AbilityShop.sectLegendCardList) do
		f(D, function(s, x)
			if t:getAbilityUpgradeLevel(x) < SECT_ABILITY_LEVEL.sr then
				A[x] = 1
			end
		end)
	end
	return g(l, A)
end
q = h(
	{
		n(
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
	q
)
j.modifier_city_28 = q
return j