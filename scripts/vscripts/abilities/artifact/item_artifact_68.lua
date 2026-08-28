--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_68"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArrayFilter
local h = b.__TS__ArrayMap
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 4,
		["18"] = 5,
		["19"] = 4,
		["20"] = 5,
		["21"] = 6,
		["22"] = 7,
		["23"] = 6,
		["24"] = 5,
		["25"] = 4,
		["26"] = 5,
		["28"] = 5,
		["29"] = 11,
		["30"] = 20,
		["31"] = 11,
		["32"] = 20,
		["33"] = 23,
		["34"] = 24,
		["35"] = 23,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 28,
		["40"] = 27,
		["41"] = 26,
		["42"] = 32,
		["43"] = 33,
		["46"] = 34,
		["47"] = 36,
		["48"] = 36,
		["49"] = 36,
		["50"] = 36,
		["51"] = 37,
		["52"] = 38,
		["53"] = 38,
		["54"] = 38,
		["55"] = 38,
		["56"] = 39,
		["57"] = 39,
		["58"] = 39,
		["59"] = 39,
		["60"] = 39,
		["61"] = 41,
		["62"] = 41,
		["63"] = 41,
		["64"] = 41,
		["67"] = 44,
		["68"] = 45,
		["69"] = 46,
		["70"] = 47,
		["71"] = 47,
		["72"] = 47,
		["73"] = 47,
		["74"] = 47,
		["75"] = 47,
		["76"] = 47,
		["77"] = 47,
		["78"] = 47,
		["79"] = 32,
		["80"] = 20,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 11,
		["89"] = 11,
		["90"] = 20,
		["92"] = 20,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseItem
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.item_artifact_68 = c()
local q = j.item_artifact_68
q.name = "item_artifact_68"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_68"
end
q = e({ m(nil) }, q)
j.item_artifact_68 = q
j.modifier_item_artifact_68 = c()
local r = j.modifier_item_artifact_68
r.name = "modifier_item_artifact_68"
d(r, o)
function r.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function r.prototype.OnAbilityLearn(self, s)
	if s.bGift then
		return
	end
	if self.sect_list ~= nil then
		local t = g(self.sect_list, function(u, v)
			return f(s.currentSectList, v)
		end)
		if #t ~= 0 then
			PlayerData:modifyGold(self:GetParent():GetPlayerOwnerID(), self.gold_bonus)
			PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
				:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold_bonus)
			EmitAnnouncerSoundForPlayer("General.Coins", self:GetParent():GetPlayerOwnerID())
		end
	end
	self.sect_list = s.currentSectList
	local w = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	w:removeSectModifiers(self:GetAbility():GetName())
	h(s.currentSectList, function(u, x)
		w:addSectModifier(x, self:GetAbility():GetName())
	end)
end
r = e(
	{
		p(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	r
)
j.modifier_item_artifact_68 = r
return j