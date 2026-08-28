--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_1"
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
		["14"] = 4,
		["15"] = 12,
		["16"] = 4,
		["17"] = 12,
		["19"] = 12,
		["20"] = 14,
		["21"] = 4,
		["22"] = 15,
		["23"] = 16,
		["24"] = 15,
		["25"] = 18,
		["26"] = 19,
		["27"] = 20,
		["28"] = 21,
		["29"] = 22,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 25,
		["36"] = 20,
		["38"] = 18,
		["39"] = 31,
		["40"] = 32,
		["41"] = 33,
		["42"] = 33,
		["43"] = 33,
		["44"] = 34,
		["45"] = 35,
		["47"] = 33,
		["48"] = 33,
		["50"] = 31,
		["51"] = 40,
		["52"] = 41,
		["53"] = 40,
		["54"] = 45,
		["55"] = 46,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 48,
		["60"] = 49,
		["61"] = 50,
		["62"] = 51,
		["63"] = 56,
		["65"] = 47,
		["66"] = 47,
		["68"] = 45,
		["69"] = 12,
		["70"] = 4,
		["71"] = 4,
		["72"] = 4,
		["73"] = 4,
		["74"] = 4,
		["75"] = 4,
		["76"] = 4,
		["77"] = 4,
		["78"] = 12,
		["80"] = 12,
		["82"] = 64,
		["83"] = 72,
		["84"] = 64,
		["85"] = 72,
		["86"] = 73,
		["87"] = 74,
		["88"] = 73,
		["89"] = 72,
		["90"] = 64,
		["91"] = 64,
		["92"] = 64,
		["93"] = 64,
		["94"] = 64,
		["95"] = 64,
		["96"] = 64,
		["97"] = 64,
		["98"] = 72,
		["100"] = 72,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
h.modifier_city_1 = c()
local n = h.modifier_city_1
n.name = "modifier_city_1"
d(n, m)
function n.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.modifierList = {}
end
function n.prototype.GetAbilitySpecialValue(self)
	self.gold_gain = self:GetAbilitySpecialValueFor("gold_gain")
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		PlayerData:eachPlayer(function(p, q)
			local r = PlayerResource:GetSelectedHeroEntity(q.playerID)
			if IsValid(r) then
				local s = r:AddNewModifier(r, nil, "modifier_city_1_buff", nil)
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
function n.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_BEFORE_PREPARE] = { -1, -1 } }
end
function n.prototype.OnBeforePrepare(self, o)
	if IsServer() then
		e(self.modifierList, function(p, s)
			if IsValid(s) then
				local v = s:GetCaster():GetPlayerOwnerID()
				PlayerData:modifyGold(v, self.gold_gain)
				Notification:combatToPlayer(
					v,
					{
						message = "notify_bonus_gold",
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self._city_name,
						int_gold = self.gold_gain,
					}
				)
				CityEffect:modifyCityEffectExtraData(v, "bonus_gold", self.gold_gain)
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
h.modifier_city_1 = n
h.modifier_city_1_buff = c()
local w = h.modifier_city_1_buff
w.name = "modifier_city_1_buff"
d(w, j)
function w.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INTEREST_RATE_CONSTANT] = 9999999 }
end
w = f(
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
	w
)
h.modifier_city_1_buff = w
return h