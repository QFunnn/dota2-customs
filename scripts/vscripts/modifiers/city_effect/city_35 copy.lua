--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/city_effect/city_35 copy.ts"
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
		["66"] = 51,
		["67"] = 52,
		["68"] = 53,
		["69"] = 51,
		["70"] = 56,
		["71"] = 57,
		["72"] = 56,
		["73"] = 63,
		["74"] = 64,
		["75"] = 65,
		["76"] = 66,
		["77"] = 67,
		["78"] = 68,
		["79"] = 69,
		["80"] = 70,
		["81"] = 71,
		["83"] = 69,
		["84"] = 74,
		["85"] = 75,
		["86"] = 76,
		["87"] = 77,
		["88"] = 78,
		["89"] = 78,
		["90"] = 78,
		["92"] = 78,
		["93"] = 79,
		["94"] = 80,
		["96"] = 81,
		["97"] = 81,
		["98"] = 82,
		["99"] = 83,
		["100"] = 81,
		["103"] = 89,
		["107"] = 63,
		["108"] = 48,
		["109"] = 40,
		["110"] = 40,
		["111"] = 40,
		["112"] = 40,
		["113"] = 40,
		["114"] = 40,
		["115"] = 40,
		["116"] = 40,
		["117"] = 48,
		["119"] = 48,
	}
)
local i = {}
local j = require("modifiers.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
local m = require("modifiers.city_effect.city_effect_modifier")
local n = m.CityEffectModifier
i.modifier_city_35 = d()
local o = i.modifier_city_35
o.name = "modifier_city_35"
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
				local t = s:AddNewModifier(s, nil, "modifier_city_35_buff", nil)
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
i.modifier_city_35 = o
i.modifier_city_35_buff = d()
local w = i.modifier_city_35_buff
w.name = "modifier_city_35_buff"
e(w, k)
function w.prototype.GetAbilitySpecialValue(self)
	self.round = CityEffect:GetSpecialValueFor("city_35", "round")
	self.level = CityEffect:GetSpecialValueFor("city_35", "level")
end
function w.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function w.prototype.OnRoundStart(self, p)
	if Rounds:getCurrentRound() % self.round == 0 then
		local x = self:GetParent():GetPlayerOwnerID()
		local y = PlayerData:getHero(x)
		local z = AbilityShop:getAbilityPoolNew("n", nil, nil, false)
		local A = y:getAbilityUpgradeData()
		z:each(function(q, B)
			if A[B] == nil or A[B].level > self.level then
				z:set(B, 0)
			end
		end)
		if #z.tName > 0 then
			local C = z:random()
			if C then
				local D = KeyValues.AbilityUpgradesKvs[C]
				local E = A[C]
				if E ~= nil then
					E = E.level
				end
				local F = E or 0
				local G = SECT_ABILITY_LEVEL[D.rarity]
				local H = G - F
				do
					local I = 0
					while I < H do
						y:learnAbility(C, true)
						Notification:combatToPlayer(
							x,
							{
								message = "notify_artifact_ability_n",
								string_itemname_artifact = "DOTA_Tooltip_ability_city_35",
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. C,
							}
						)
						I = I + 1
					end
				end
				CityEffect:addCityEffectAbilites(x, C, true)
			end
		end
	end
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
i.modifier_city_35_buff = w
return i