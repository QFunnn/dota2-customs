--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_21"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__StringSplit
local h = b.__TS__ArrayIncludes
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["17"] = 5,
		["18"] = 13,
		["19"] = 5,
		["20"] = 13,
		["22"] = 13,
		["23"] = 14,
		["24"] = 5,
		["25"] = 15,
		["26"] = 16,
		["27"] = 17,
		["28"] = 18,
		["29"] = 19,
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 22,
		["36"] = 17,
		["38"] = 15,
		["39"] = 28,
		["40"] = 29,
		["41"] = 30,
		["42"] = 30,
		["43"] = 30,
		["44"] = 31,
		["45"] = 32,
		["47"] = 30,
		["48"] = 30,
		["50"] = 28,
		["51"] = 13,
		["52"] = 5,
		["53"] = 5,
		["54"] = 5,
		["55"] = 5,
		["56"] = 5,
		["57"] = 5,
		["58"] = 5,
		["59"] = 5,
		["60"] = 13,
		["62"] = 13,
		["63"] = 39,
		["64"] = 47,
		["65"] = 39,
		["66"] = 47,
		["67"] = 49,
		["68"] = 50,
		["69"] = 49,
		["70"] = 52,
		["71"] = 53,
		["72"] = 52,
		["73"] = 57,
		["74"] = 58,
		["75"] = 59,
		["78"] = 60,
		["81"] = 61,
		["82"] = 62,
		["83"] = 63,
		["84"] = 63,
		["85"] = 63,
		["86"] = 63,
		["87"] = 64,
		["88"] = 64,
		["89"] = 64,
		["90"] = 65,
		["91"] = 65,
		["92"] = 65,
		["94"] = 65,
		["96"] = 64,
		["97"] = 68,
		["98"] = 69,
		["99"] = 69,
		["100"] = 69,
		["101"] = 69,
		["102"] = 69,
		["103"] = 69,
		["104"] = 69,
		["105"] = 70,
		["106"] = 71,
		["107"] = 72,
		["108"] = 73,
		["109"] = 78,
		["111"] = 69,
		["112"] = 69,
		["114"] = 57,
		["115"] = 47,
		["116"] = 39,
		["117"] = 39,
		["118"] = 39,
		["119"] = 39,
		["120"] = 39,
		["121"] = 39,
		["122"] = 39,
		["123"] = 39,
		["124"] = 47,
		["126"] = 47,
	}
)
local j = {}
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("modifiers.city_effect.city_effect_modifier")
local o = n.CityEffectModifier
j.modifier_city_21 = c()
local p = j.modifier_city_21
p.name = "modifier_city_21"
d(p, o)
function p.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.modifierList = {}
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		PlayerData:eachPlayer(function(r, s)
			local t = PlayerResource:GetSelectedHeroEntity(s.playerID)
			if IsValid(t) then
				local u = t:AddNewModifier(t, nil, "modifier_city_21_buff", nil)
				if IsValid(u) then
					local v = self.modifierList
					v[#v + 1] = u
				end
			end
		end)
	end
end
function p.prototype.OnDestroy(self)
	if IsServer() then
		e(self.modifierList, function(r, w)
			if IsValid(w) then
				w:Destroy()
			end
		end)
	end
end
p = f(
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
j.modifier_city_21 = p
j.modifier_city_21_buff = c()
local x = j.modifier_city_21_buff
x.name = "modifier_city_21_buff"
d(x, l)
function x.prototype.GetAbilitySpecialValue(self)
	self.count = CityEffect:GetSpecialValueFor("city_21", "count")
end
function x.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function x.prototype.OnHeroLevelUp(self, q)
	local y = self:GetParent():GetPlayerOwnerID()
	if q.player_id ~= y then
		return
	end
	if q.up_lvl <= 0 then
		return
	end
	local z = PlayerData:getHero(y)
	local A = q.up_lvl
	local B = g(AbilityShop:GetRecommendSectByHeroName(z.unitName), "|")
	local C = AbilityShop
	local D = AbilityShop.getRandomAbility
	local E = self.count * A
	local F
	if h(B, "sect_none") then
		F = nil
	else
		F = B
	end
	local G = D(C, y, E, { specifySect = F, isAbilityShop = false })
	if #G > 0 then
		e(G, function(r, H)
			local I
			local J
			J = H.aid
			I = H.rarity
			if J then
				self:IncrementStackCount()
				PlayerData:getHero(y):learnAbility(J, true)
				Notification:combatToPlayer(
					y,
					{
						message = "notify_artifact_ability_" .. I,
						string_itemname_artifact = "DOTA_Tooltip_ability_city_21",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. J,
					}
				)
				CityEffect:addCityEffectAbilites(y, J)
			end
		end)
	end
end
x = f(
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
	x
)
j.modifier_city_21_buff = x
return j