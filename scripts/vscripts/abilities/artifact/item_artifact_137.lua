--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_137"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 2,
		["10"] = 2,
		["11"] = 2,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 7,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 10,
		["28"] = 11,
		["29"] = 10,
		["30"] = 11,
		["31"] = 14,
		["32"] = 15,
		["33"] = 16,
		["34"] = 14,
		["35"] = 18,
		["36"] = 19,
		["37"] = 18,
		["38"] = 21,
		["39"] = 22,
		["42"] = 23,
		["43"] = 24,
		["46"] = 25,
		["49"] = 26,
		["50"] = 27,
		["53"] = 28,
		["56"] = 29,
		["57"] = 30,
		["60"] = 31,
		["61"] = 32,
		["62"] = 33,
		["65"] = 34,
		["67"] = 34,
		["68"] = 34,
		["69"] = 34,
		["70"] = 34,
		["71"] = 34,
		["73"] = 35,
		["74"] = 35,
		["75"] = 35,
		["76"] = 35,
		["77"] = 35,
		["78"] = 35,
		["79"] = 35,
		["80"] = 35,
		["81"] = 35,
		["82"] = 21,
		["83"] = 11,
		["84"] = 10,
		["85"] = 10,
		["86"] = 10,
		["87"] = 10,
		["88"] = 10,
		["89"] = 10,
		["90"] = 10,
		["91"] = 10,
		["92"] = 11,
		["94"] = 11,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_137 = c()
local o = h.item_artifact_137
o.name = "item_artifact_137"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_137"
end
o = e({ k(nil) }, o)
h.item_artifact_137 = o
h.modifier_item_artifact_137 = c()
local p = h.modifier_item_artifact_137
p.name = "modifier_item_artifact_137"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
	self.exp = self:GetAbilitySpecialValueFor("exp")
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { -1, -1 } }
end
function p.prototype.OnAbilityLearn(self, q)
	if not IsServer() then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	if q.heroclass ~= PlayerData:getHero(r) then
		return
	end
	if not RollPercentage(self.chance) then
		return
	end
	local s = q.displaySectListBeforeLearn or q.heroclass:getDisplaySectList()
	if #s == 0 then
		return
	end
	if not f(q.currentSectList, s[1]) then
		return
	end
	local t = s[#s]
	if not t then
		return
	end
	q.heroclass:addSectExp(t, self.exp)
	local u = self:GetAbility()
	if not u then
		return
	end
	local v = PlayerData:getplayerData(r)
	if v ~= nil then
		v:modifyArtifactExtraData(u:entindex(), "exp_gain", self.exp)
	end
	Notification:combatToPlayer(
		r,
		{
			message = "notify_artifact_48",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. u:GetAbilityName(),
			string_sect = "DOTA_Tooltip_ability_" .. t,
			int_exp = self.exp,
		}
	)
end
p = e(
	{
		n(
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
h.modifier_item_artifact_137 = p
return h