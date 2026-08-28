--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_108"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 19,
		["28"] = 11,
		["29"] = 19,
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 22,
		["34"] = 27,
		["35"] = 28,
		["36"] = 27,
		["37"] = 32,
		["38"] = 33,
		["41"] = 34,
		["42"] = 35,
		["43"] = 36,
		["44"] = 37,
		["45"] = 38,
		["48"] = 41,
		["49"] = 42,
		["50"] = 43,
		["51"] = 44,
		["54"] = 32,
		["55"] = 48,
		["56"] = 49,
		["57"] = 50,
		["58"] = 50,
		["59"] = 50,
		["60"] = 50,
		["61"] = 50,
		["62"] = 51,
		["63"] = 51,
		["64"] = 51,
		["65"] = 51,
		["66"] = 51,
		["67"] = 51,
		["68"] = 51,
		["69"] = 52,
		["70"] = 52,
		["71"] = 52,
		["72"] = 52,
		["73"] = 52,
		["74"] = 52,
		["75"] = 52,
		["76"] = 52,
		["77"] = 57,
		["78"] = 58,
		["79"] = 58,
		["80"] = 58,
		["81"] = 58,
		["82"] = 58,
		["83"] = 59,
		["84"] = 59,
		["85"] = 59,
		["86"] = 59,
		["87"] = 59,
		["88"] = 59,
		["89"] = 59,
		["90"] = 59,
		["91"] = 48,
		["92"] = 19,
		["93"] = 11,
		["94"] = 11,
		["95"] = 11,
		["96"] = 11,
		["97"] = 11,
		["98"] = 11,
		["99"] = 11,
		["100"] = 11,
		["101"] = 19,
		["103"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_108 = c()
local n = g.item_artifact_108
n.name = "item_artifact_108"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_108"
end
n = e({ j(nil) }, n)
g.item_artifact_108 = n
g.modifier_item_artifact_108 = c()
local o = g.modifier_item_artifact_108
o.name = "modifier_item_artifact_108"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.hp = self:GetAbilitySpecialValueFor("hp")
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function o.prototype.OnBattleEnd(self, p)
	if p.isNeutral then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if p.illusionPlayerID ~= q and p.winPlayerID == q then
		local r = PlayerData:getplayerData(q)
		if r and r.loseStack > 0 then
			self:ArtifactEffect(q)
		end
	end
	if p.illusionPlayerID ~= q and p.losePlayerID == q then
		local r = PlayerData:getplayerData(q)
		if r and r.winStack > 0 then
			self:ArtifactEffect(q)
		end
	end
end
function o.prototype.ArtifactEffect(self, q)
	PlayerData:modifyHealth(q, self.hp)
	PlayerData:getplayerData(q):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_health", self.hp)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), self.hp, self:GetParent():GetPlayerOwner())
	Notification:combatToPlayer(
		q,
		{
			message = "notify_bonus_hp",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			int_hp = self.hp,
		}
	)
	PlayerData:modifyGold(q, self.gold)
	PlayerData:getplayerData(self:GetCaster():GetPlayerOwnerID())
		:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold)
	Notification:combatToPlayer(
		q,
		{
			message = "notify_bonus_gold",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
			int_gold = self.gold,
		}
	)
end
o = e(
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
	o
)
g.modifier_item_artifact_108 = o
return g