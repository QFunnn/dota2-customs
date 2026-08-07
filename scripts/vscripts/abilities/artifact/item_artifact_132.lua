--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_132"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 23,
		["34"] = 28,
		["35"] = 29,
		["36"] = 28,
		["37"] = 32,
		["38"] = 33,
		["39"] = 32,
		["40"] = 36,
		["41"] = 37,
		["42"] = 36,
		["43"] = 42,
		["44"] = 43,
		["47"] = 44,
		["48"] = 45,
		["49"] = 46,
		["50"] = 47,
		["53"] = 48,
		["54"] = 49,
		["55"] = 50,
		["56"] = 51,
		["59"] = 52,
		["60"] = 52,
		["61"] = 52,
		["62"] = 52,
		["63"] = 52,
		["64"] = 53,
		["65"] = 53,
		["66"] = 53,
		["67"] = 53,
		["68"] = 53,
		["69"] = 53,
		["70"] = 53,
		["71"] = 54,
		["72"] = 54,
		["73"] = 54,
		["74"] = 54,
		["75"] = 54,
		["76"] = 54,
		["77"] = 54,
		["78"] = 54,
		["79"] = 42,
		["80"] = 19,
		["81"] = 11,
		["82"] = 11,
		["83"] = 11,
		["84"] = 11,
		["85"] = 11,
		["86"] = 11,
		["87"] = 11,
		["88"] = 11,
		["89"] = 19,
		["91"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_132 = c()
local n = g.item_artifact_132
n.name = "item_artifact_132"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_132"
end
n = e({ j(nil) }, n)
g.item_artifact_132 = n
g.modifier_item_artifact_132 = c()
local o = g.modifier_item_artifact_132
o.name = "modifier_item_artifact_132"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
	self.player_damage_bonus = self:GetAbilitySpecialValueFor("player_damage_bonus")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PLAYER_DAMAGE_REDUCE }
end
function o.prototype.EOM_GetModifierPlayerDamageReduce(self)
	return -self.player_damage_bonus
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function o.prototype.OnRoundStart(self)
	if not IsServer() then
		return
	end
	local p = self:GetParent():GetPlayerOwnerID()
	local q = PlayerData:getplayerData(p)
	local r = self:GetAbility()
	if not q or not r then
		return
	end
	local s = q.health
	PlayerData:modifyHealth(p, self.hp_regen, true)
	local t = q.health - s
	if t <= 0 then
		return
	end
	q:modifyArtifactExtraData(r:entindex(), "bonus_health", t)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), t, self:GetParent():GetPlayerOwner())
	Notification:combatToPlayer(
		p,
		{ message = "notify_bonus_hp", string_itemname_artifact = "DOTA_Tooltip_ability_" .. r:GetAbilityName(), int_hp = t }
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
g.modifier_item_artifact_132 = o
return g