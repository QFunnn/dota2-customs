--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_133"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySlice
local g = b.__TS__ArrayIncludes
local h = b.__TS__ObjectKeys
local i = b.__TS__ArrayFilter
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 1,
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 4,
		["19"] = 5,
		["20"] = 4,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 4,
		["27"] = 5,
		["29"] = 5,
		["30"] = 11,
		["31"] = 19,
		["32"] = 11,
		["33"] = 19,
		["34"] = 23,
		["35"] = 24,
		["36"] = 25,
		["37"] = 23,
		["38"] = 28,
		["39"] = 29,
		["40"] = 28,
		["41"] = 34,
		["42"] = 35,
		["45"] = 36,
		["46"] = 37,
		["47"] = 38,
		["50"] = 39,
		["51"] = 40,
		["52"] = 41,
		["53"] = 41,
		["54"] = 42,
		["55"] = 42,
		["57"] = 43,
		["58"] = 43,
		["59"] = 43,
		["60"] = 43,
		["61"] = 44,
		["64"] = 45,
		["65"] = 46,
		["66"] = 47,
		["67"] = 48,
		["70"] = 49,
		["71"] = 50,
		["72"] = 50,
		["73"] = 50,
		["74"] = 50,
		["75"] = 50,
		["76"] = 51,
		["77"] = 51,
		["78"] = 51,
		["79"] = 51,
		["80"] = 51,
		["81"] = 51,
		["82"] = 51,
		["83"] = 51,
		["84"] = 51,
		["85"] = 34,
		["86"] = 19,
		["87"] = 11,
		["88"] = 11,
		["89"] = 11,
		["90"] = 11,
		["91"] = 11,
		["92"] = 11,
		["93"] = 11,
		["94"] = 11,
		["95"] = 19,
		["97"] = 19,
	}
)
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseItem
local n = l.registerAbility
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
k.item_artifact_133 = c()
local r = k.item_artifact_133
r.name = "item_artifact_133"
d(r, m)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_133"
end
r = e({ n(nil) }, r)
k.item_artifact_133 = r
k.modifier_item_artifact_133 = c()
local s = k.modifier_item_artifact_133
s.name = "modifier_item_artifact_133"
d(s, p)
function s.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.exp = self:GetAbilitySpecialValueFor("exp")
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_REFRESH] = { self:GetParent() } }
end
function s.prototype.OnShopRefresh(self)
	if not IsServer() or not RollPercentage(self.chance) then
		return
	end
	local t = self:GetParent():GetPlayerOwnerID()
	local u = PlayerData:getHero(t)
	if not u then
		return
	end
	local v = u:getAbilityData()
	local w = f(AbilityShop.banList)
	local x = PlayerData:getplayerData(t)
	local y = x and x.bannedSect
	if y then
		w[#w + 1] = y
	end
	local z = i(h(v), function(A, B)
		return v[B].exp > 0 and not g(w, B)
	end)
	if #z == 0 then
		return
	end
	local B = GetRandomElement(z)
	local C = PlayerData:getplayerData(t)
	local D = self:GetAbility()
	if not B or not C or not D then
		return
	end
	u:addSectExp(B, self.exp)
	C:modifyArtifactExtraData(D:entindex(), "exp_gain", self.exp)
	Notification:combatToPlayer(
		t,
		{
			message = "notify_artifact_48",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. D:GetAbilityName(),
			string_sect = "DOTA_Tooltip_ability_" .. B,
			int_exp = self.exp,
		}
	)
end
s = e(
	{
		q(
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
	s
)
k.modifier_item_artifact_133 = s
return k