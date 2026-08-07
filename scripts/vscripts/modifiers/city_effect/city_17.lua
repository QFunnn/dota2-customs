--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_17"
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
		["62"] = 40,
		["63"] = 48,
		["64"] = 40,
		["65"] = 48,
		["66"] = 50,
		["67"] = 51,
		["68"] = 50,
		["69"] = 53,
		["70"] = 54,
		["71"] = 53,
		["72"] = 58,
		["73"] = 59,
		["74"] = 58,
		["75"] = 63,
		["76"] = 64,
		["79"] = 65,
		["80"] = 66,
		["81"] = 67,
		["83"] = 63,
		["84"] = 70,
		["85"] = 71,
		["86"] = 72,
		["87"] = 73,
		["88"] = 74,
		["89"] = 75,
		["90"] = 76,
		["92"] = 70,
		["93"] = 48,
		["94"] = 40,
		["95"] = 40,
		["96"] = 40,
		["97"] = 40,
		["98"] = 40,
		["99"] = 40,
		["100"] = 40,
		["101"] = 40,
		["102"] = 48,
		["104"] = 48,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
h.modifier_city_17 = c()
local n = h.modifier_city_17
n.name = "modifier_city_17"
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
				local s = r:AddNewModifier(r, nil, "modifier_city_17_buff", nil)
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
h.modifier_city_17 = n
h.modifier_city_17_buff = c()
local v = h.modifier_city_17_buff
v.name = "modifier_city_17_buff"
d(v, j)
function v.prototype.GetAbilitySpecialValue(self)
	self.gold = CityEffect:GetSpecialValueFor("city_17", "gold")
end
function v.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function v.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_WAGES }
end
function v.prototype.OnBattleEnd(self, o)
	if o.isNeutral ~= nil then
		return
	end
	local w = self:GetParent():GetPlayerOwnerID()
	if w == o.winPlayerID and o.illusionPlayerID ~= w then
		self:SetStackCount(PlayerData:getPlayerDamage(o.winPlayerID) * self.gold)
	end
end
function v.prototype.EOM_GetModifierExtraWages(self)
	if IsServer() then
		local x = self:GetStackCount()
		local w = self:GetParent():GetPlayerOwnerID()
		CityEffect:modifyCityEffectExtraData(w, "bonus_gold", x)
		self:SetStackCount(0)
		return x
	end
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
h.modifier_city_17_buff = v
return h