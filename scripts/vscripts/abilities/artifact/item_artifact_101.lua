--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_101"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
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
		["21"] = 6,
		["22"] = 5,
		["23"] = 4,
		["24"] = 5,
		["26"] = 5,
		["27"] = 11,
		["28"] = 19,
		["29"] = 11,
		["30"] = 19,
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 27,
		["35"] = 24,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 32,
		["40"] = 33,
		["41"] = 34,
		["42"] = 34,
		["43"] = 34,
		["44"] = 34,
		["45"] = 34,
		["46"] = 35,
		["47"] = 35,
		["48"] = 35,
		["49"] = 35,
		["50"] = 35,
		["51"] = 35,
		["52"] = 35,
		["53"] = 37,
		["54"] = 38,
		["55"] = 39,
		["56"] = 40,
		["57"] = 41,
		["58"] = 42,
		["63"] = 29,
		["64"] = 48,
		["65"] = 49,
		["66"] = 48,
		["67"] = 53,
		["68"] = 54,
		["69"] = 55,
		["71"] = 53,
		["72"] = 58,
		["73"] = 59,
		["76"] = 60,
		["77"] = 60,
		["78"] = 61,
		["79"] = 62,
		["80"] = 63,
		["81"] = 63,
		["82"] = 63,
		["83"] = 63,
		["84"] = 63,
		["85"] = 64,
		["86"] = 64,
		["87"] = 64,
		["88"] = 64,
		["89"] = 64,
		["90"] = 64,
		["91"] = 64,
		["92"] = 58,
		["93"] = 19,
		["94"] = 11,
		["95"] = 11,
		["96"] = 11,
		["97"] = 11,
		["98"] = 11,
		["99"] = 11,
		["100"] = 11,
		["101"] = 11,
		["102"] = 19,
		["104"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.item_artifact_101 = c()
local o = h.item_artifact_101
o.name = "item_artifact_101"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_101"
end
o = e({ k(nil) }, o)
h.item_artifact_101 = o
h.modifier_item_artifact_101 = c()
local p = h.modifier_item_artifact_101
p.name = "modifier_item_artifact_101"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.base_regen = self:GetAbilitySpecialValueFor("base_regen")
	self.sect_lv = self:GetAbilitySpecialValueFor("sect_lv")
	self.bonus_regen = self:GetAbilitySpecialValueFor("bonus_regen")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self.sectList = {}
		local r = self:GetParent():GetPlayerOwnerID()
		PlayerData:modifyHealth(r, self.base_regen)
		PlayerData:getplayerData(r)
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_health", self.base_regen)
		SendOverheadEventMessage(
			nil,
			OVERHEAD_ALERT_HEAL,
			self:GetParent(),
			self.base_regen,
			self:GetParent():GetPlayerOwner()
		)
		local s = PlayerData:getHero(r)
		if s then
			local t = s:getAbilityData()
			for u, v in pairs(t) do
				if v.level >= self.sect_lv then
					self:Effect(u)
				end
			end
		end
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SECT_LEVEL_UP] = { self:GetParent() } }
end
function p.prototype.OnSectLevelUp(self, q)
	if q.newLevel >= self.sect_lv then
		self:Effect(q.sect)
	end
end
function p.prototype.Effect(self, u)
	if f(self.sectList, u) then
		return
	end
	local w = self.sectList
	w[#w + 1] = u
	local r = self:GetParent():GetPlayerOwnerID()
	PlayerData:modifyHealth(r, self.bonus_regen)
	PlayerData:getplayerData(r):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_health", self.bonus_regen)
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_HEAL,
		self:GetParent(),
		self.bonus_regen,
		self:GetParent():GetPlayerOwner()
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
h.modifier_item_artifact_101 = p
return h