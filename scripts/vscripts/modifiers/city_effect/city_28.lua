--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_28"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__New
local g = b.__TS__DecorateLegacy
local h = b.__TS__SourceMapTraceBack
h(
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
		["52"] = 46,
		["53"] = 47,
		["55"] = 49,
		["56"] = 49,
		["57"] = 49,
		["58"] = 49,
		["59"] = 53,
		["60"] = 54,
		["61"] = 55,
		["62"] = 49,
		["63"] = 49,
		["64"] = 49,
		["65"] = 49,
		["66"] = 49,
		["68"] = 41,
		["71"] = 39,
		["73"] = 36,
		["74"] = 66,
		["75"] = 67,
		["78"] = 70,
		["79"] = 71,
		["82"] = 74,
		["83"] = 75,
		["84"] = 76,
		["85"] = 76,
		["86"] = 76,
		["87"] = 76,
		["88"] = 76,
		["89"] = 76,
		["90"] = 76,
		["91"] = 76,
		["92"] = 81,
		["93"] = 66,
		["94"] = 83,
		["95"] = 84,
		["97"] = 85,
		["98"] = 85,
		["99"] = 86,
		["100"] = 87,
		["103"] = 90,
		["104"] = 91,
		["105"] = 92,
		["107"] = 85,
		["110"] = 95,
		["111"] = 83,
		["112"] = 97,
		["113"] = 98,
		["114"] = 99,
		["115"] = 100,
		["116"] = 101,
		["117"] = 102,
		["118"] = 102,
		["119"] = 102,
		["120"] = 103,
		["121"] = 102,
		["122"] = 102,
		["123"] = 105,
		["124"] = 106,
		["126"] = 108,
		["127"] = 109,
		["128"] = 109,
		["129"] = 109,
		["130"] = 110,
		["131"] = 111,
		["133"] = 109,
		["134"] = 109,
		["136"] = 116,
		["137"] = 97,
		["138"] = 14,
		["139"] = 6,
		["140"] = 6,
		["141"] = 6,
		["142"] = 6,
		["143"] = 6,
		["144"] = 6,
		["145"] = 6,
		["146"] = 6,
		["147"] = 14,
		["149"] = 14,
	}
)
local i = {}
local j = require("class.weight_pool")
local k = j.CWeightPool
local l = require("modifiers.eom_modifier")
local m = l.registerEOMModifier
local n = require("modifiers.city_effect.city_effect_modifier")
local o = n.CityEffectModifier
i.modifier_city_28 = c()
local p = i.modifier_city_28
p.name = "modifier_city_28"
d(p, o)
function p.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.enable = true
end
function p.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self:EffectFunc()
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function p.prototype.OnRoundStart(self, q)
	self:EffectFunc()
end
function p.prototype.EffectFunc(self)
	if self.enable and Rounds:getCurrentRound() >= self.round then
		self.enable = false
		PlayerData:eachAlivePlayerHero(function(r, s, t)
			local u = self:GetLegendPool(t)
			do
				local v = 0
				while v < self.count do
					local w = self:GetRandomSelectionFromPool(u, 3)
					if #w == 0 then
						break
					end
					if s:IsBotData() then
						self:GrantLegendAbility(t, w[1])
					else
						Selection:AddSpecialSelection(t, "ability_card", w, function(r, x)
							self:GrantLegendAbility(t, x)
							return true
						end, nil, 0, true)
					end
					v = v + 1
				end
			end
		end)
	end
end
function p.prototype.GrantLegendAbility(self, t, y)
	if y == nil or not KeyValues.AbilityUpgradesKvs[y] then
		return
	end
	local s = PlayerData:getHero(t)
	if not s then
		return
	end
	local z = KeyValues.AbilityUpgradesKvs[y]
	s:learnAbility(y, true)
	Notification:combatToPlayer(
		t,
		{
			message = "notify_artifact_ability_" .. tostring(z.rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetCityName(),
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. y,
		}
	)
	CityEffect:addCityEffectAbilites(t, y)
end
function p.prototype.GetRandomSelectionFromPool(self, u, A)
	local w = {}
	do
		local v = 0
		while v < A and u:count() > 0 do
			local y = u:random()
			if y == nil then
				break
			end
			u:remove(y)
			if KeyValues.AbilityUpgradesKvs[y] then
				w[#w + 1] = y
			end
			v = v + 1
		end
	end
	return w
end
function p.prototype.GetLegendPool(self, t)
	local s = PlayerData:getHero(t)
	local B = PlayerData:getplayerData(t)
	local C = {}
	local D = {}
	e(AbilityShop.banList, function(r, E)
		D[#D + 1] = E
	end)
	if B.bannedSect then
		D[#D + 1] = B.bannedSect
	end
	for E, F in pairs(AbilityShop.sectLegendCardList) do
		e(F, function(r, y)
			if s:getAbilityUpgradeLevel(y) < SECT_ABILITY_LEVEL.sr then
				C[y] = 1
			end
		end)
	end
	return f(k, C)
end
p = g(
	{
		m(
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
	p
)
i.modifier_city_28 = p
return i