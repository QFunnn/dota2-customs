--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_115"
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
		["37"] = 24,
		["38"] = 25,
		["39"] = 27,
		["40"] = 28,
		["41"] = 28,
		["42"] = 28,
		["43"] = 28,
		["44"] = 29,
		["45"] = 29,
		["46"] = 29,
		["47"] = 29,
		["48"] = 29,
		["49"] = 30,
		["50"] = 31,
		["53"] = 21,
		["54"] = 21,
		["55"] = 11,
		["56"] = 36,
		["57"] = 37,
		["58"] = 38,
		["59"] = 39,
		["61"] = 41,
		["62"] = 36,
		["63"] = 43,
		["64"] = 44,
		["65"] = 43,
		["66"] = 46,
		["67"] = 47,
		["68"] = 46,
		["69"] = 5,
		["70"] = 4,
		["71"] = 5,
		["73"] = 5,
		["74"] = 51,
		["75"] = 60,
		["76"] = 51,
		["77"] = 60,
		["78"] = 63,
		["79"] = 64,
		["80"] = 63,
		["81"] = 66,
		["82"] = 67,
		["83"] = 68,
		["85"] = 66,
		["86"] = 71,
		["87"] = 72,
		["88"] = 71,
		["89"] = 76,
		["90"] = 78,
		["91"] = 79,
		["92"] = 80,
		["93"] = 81,
		["94"] = 82,
		["95"] = 83,
		["96"] = 84,
		["97"] = 85,
		["98"] = 85,
		["99"] = 85,
		["100"] = 85,
		["101"] = 85,
		["102"] = 85,
		["103"] = 85,
		["104"] = 85,
		["105"] = 90,
		["106"] = 90,
		["107"] = 90,
		["108"] = 90,
		["109"] = 90,
		["112"] = 76,
		["113"] = 60,
		["114"] = 51,
		["115"] = 51,
		["116"] = 51,
		["117"] = 51,
		["118"] = 51,
		["119"] = 51,
		["120"] = 51,
		["121"] = 51,
		["122"] = 51,
		["123"] = 60,
		["125"] = 60,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_115 = c()
local o = h.item_artifact_115
o.name = "item_artifact_115"
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
	PlayerData:requestPlayerSelection(q, { players = r, ability_name = "item_artifact_115" }, function(s, q, v)
		if IsValid(self) and IsValid(self:GetCaster()) then
			local w = self:GetCaster():FindAllModifiersByName("modifier_item_artifact_115")
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
	return "modifier_item_artifact_115"
end
o = f({ k(nil) }, o)
h.item_artifact_115 = o
h.modifier_item_artifact_115 = c()
local z = h.modifier_item_artifact_115
z.name = "modifier_item_artifact_115"
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
h.modifier_item_artifact_115 = z
return h