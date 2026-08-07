--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_116"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFind
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
		["14"] = 2,
		["15"] = 4,
		["16"] = 5,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["23"] = 6,
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["27"] = 14,
		["28"] = 15,
		["29"] = 16,
		["30"] = 17,
		["31"] = 18,
		["33"] = 16,
		["34"] = 21,
		["35"] = 21,
		["36"] = 21,
		["37"] = 23,
		["38"] = 24,
		["39"] = 26,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 28,
		["45"] = 28,
		["46"] = 28,
		["47"] = 28,
		["48"] = 28,
		["49"] = 29,
		["50"] = 30,
		["53"] = 21,
		["54"] = 21,
		["55"] = 11,
		["56"] = 35,
		["57"] = 36,
		["58"] = 37,
		["59"] = 38,
		["61"] = 40,
		["62"] = 35,
		["63"] = 42,
		["64"] = 43,
		["65"] = 42,
		["66"] = 45,
		["67"] = 46,
		["68"] = 45,
		["69"] = 5,
		["70"] = 4,
		["71"] = 5,
		["73"] = 5,
		["74"] = 50,
		["75"] = 59,
		["76"] = 50,
		["77"] = 59,
		["78"] = 62,
		["79"] = 63,
		["80"] = 62,
		["81"] = 65,
		["82"] = 66,
		["83"] = 67,
		["85"] = 65,
		["86"] = 70,
		["87"] = 71,
		["88"] = 70,
		["89"] = 75,
		["90"] = 76,
		["93"] = 77,
		["94"] = 78,
		["95"] = 79,
		["96"] = 80,
		["97"] = 81,
		["98"] = 82,
		["99"] = 83,
		["100"] = 84,
		["101"] = 84,
		["102"] = 84,
		["103"] = 84,
		["104"] = 84,
		["105"] = 84,
		["106"] = 84,
		["107"] = 84,
		["108"] = 89,
		["109"] = 89,
		["110"] = 89,
		["111"] = 89,
		["112"] = 89,
		["115"] = 75,
		["116"] = 59,
		["117"] = 50,
		["118"] = 50,
		["119"] = 50,
		["120"] = 50,
		["121"] = 50,
		["122"] = 50,
		["123"] = 50,
		["124"] = 50,
		["125"] = 50,
		["126"] = 59,
		["128"] = 59,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_116 = c()
local o = h.item_artifact_116
o.name = "item_artifact_116"
d(o, j)
function o.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function o.prototype.OnSpellStart(self)
	local p = self:GetCaster()
	self:SpendCharge()
	local q = p:GetPlayerOwnerID()
	local r = {}
	PlayerData:eachPlayer(function(s, t, u)
		if u ~= q then
			r[#r + 1] = u
		end
	end)
	PlayerData:requestPlayerSelection(q, { players = r }, function(s, q, v)
		if IsValid(self) and IsValid(self:GetCaster()) then
			local w = self:GetCaster():FindAllModifiersByName("modifier_item_artifact_116")
			local x = e(w, function(s, y)
				return IsValid(y) and y:GetAbility() == self
			end)
			PlayerData:getplayerData(q):modifyArtifactExtraStringData(self:entindex(), "DesignatedPlayer", tostring(v))
			if x then
				x:SetSpecifyPlayerID(v)
			end
		end
	end)
end
function o.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function o.prototype.GetCustomCastError(self)
	return self.error
end
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_116"
end
o = f({ k(nil) }, o)
h.item_artifact_116 = o
h.modifier_item_artifact_116 = c()
local z = h.modifier_item_artifact_116
z.name = "modifier_item_artifact_116"
d(z, m)
function z.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function z.prototype.SetSpecifyPlayerID(self, q)
	if self.specify_id == nil then
		self.specify_id = q
	end
end
function z.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function z.prototype.OnBattleEnd(self, A)
	if A.isNeutral then
		return
	end
	if A.illusionPlayerID ~= self.specify_id and A.winPlayerID == self.specify_id then
		local q = self:GetParent():GetPlayerOwnerID()
		local B = PlayerData:getplayerData(q)
		if B then
			local q = self:GetParent():GetPlayerOwnerID()
			local C = self:GetAbility()
			PlayerData:modifyGold(q, self.gold)
			Notification:combatToPlayer(
				q,
				{
					message = "notify_bonus_gold",
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. C:GetAbilityName(),
					int_gold = self.gold,
				}
			)
			B:modifyArtifactExtraData(C:entindex(), "bonus_gold", self.gold)
		end
	end
end
z = f(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	z
)
h.modifier_item_artifact_116 = z
return h