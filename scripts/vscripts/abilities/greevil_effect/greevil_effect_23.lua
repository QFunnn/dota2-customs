--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_23"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 7,
		["18"] = 7,
		["19"] = 8,
		["20"] = 10,
		["21"] = 11,
		["22"] = 11,
		["23"] = 11,
		["24"] = 11,
		["25"] = 11,
		["26"] = 11,
		["27"] = 11,
		["28"] = 12,
		["29"] = 13,
		["30"] = 7,
		["31"] = 7,
		["32"] = 4,
	}
)
local f = {}
local g = require("abilities.greevil_effect.greevil_effect_base")
local h = g.GreevilEffectBase
f.greevil_effect_23 = c()
local i = f.greevil_effect_23
i.name = "greevil_effect_23"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getSpecialValueFor("health")
	local k = self:getSpecialValueFor("gold")
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE, function()
		local l = PlayerResource:GetSelectedHeroEntity(self.playerID)
		PlayerData:modifyHealth(self.playerID, j)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, l, j, l:GetPlayerOwner())
		PlayerData:modifyGold(self.playerID, k)
		Notification:combatToPlayer(
			self.playerID,
			{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.name, int_gold = k }
		)
	end)
end
return f