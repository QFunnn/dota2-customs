--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_65"
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
		["13"] = 5,
		["14"] = 6,
		["15"] = 5,
		["16"] = 8,
		["17"] = 12,
		["18"] = 13,
		["19"] = 14,
		["20"] = 15,
		["21"] = 16,
		["22"] = 17,
		["23"] = 18,
		["24"] = 25,
		["25"] = 26,
		["26"] = 27,
		["27"] = 28,
		["28"] = 29,
		["29"] = 30,
		["30"] = 32,
		["32"] = 32,
		["34"] = 33,
		["38"] = 41,
		["39"] = 8,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_65 = c()
local i = f.card_effect_65
i.name = "card_effect_65"
d(i, h)
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE, self.OnConfirmBattle)
end
function i.prototype.OnConfirmBattle(self, j)
	local k = self:getPlayerID()
	local l = PlayerData:getHero(k).hero
	if IsValid(l) then
		local m = shallowcopy(IsTurboMode(nil) and NEUTRAL_ROUND_TURBO or NEUTRAL_ROUND)
		local n = IsTurboMode(nil) and NEUTRAL_LEVEL_TURBO or NEUTRAL_LEVEL
		local o = NEUTRAL_DROP_ITEM_LEVEL[n[table.remove(shallowcopy(m))]]
		local p = PlayerData:getEquipmentPoolWithLevel(k, o)
		local q = p:random()
		if q then
			local r = CreateItem(q, nil, nil)
			if r then
				r:SetPurchaseTime(0)
				l:AddItem(r)
				local s = l:FindModifierByName("modifier_hero")
				if s ~= nil then
					s:RefreshInventory()
				end
				Notification:combatToPlayer(
					k,
					{
						message = "notify_card_effect",
						string_card1 = "DOTA_Tooltip_ability_" .. self.cardName,
						string_card2 = "DOTA_Tooltip_ability_" .. q,
					}
				)
			end
		end
	end
	self:RemoveModifierEvent(self.id)
end
return f