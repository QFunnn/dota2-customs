--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
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
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 4,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 10,
		["23"] = 11,
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["28"] = 11,
		["31"] = 16,
		["32"] = 17,
		["35"] = 20,
		["36"] = 21,
		["37"] = 4,
		["38"] = 5,
		["39"] = 28,
		["40"] = 36,
		["41"] = 28,
		["42"] = 36,
		["43"] = 41,
		["44"] = 42,
		["45"] = 41,
		["46"] = 45,
		["47"] = 46,
		["48"] = 48,
		["49"] = 49,
		["51"] = 50,
		["52"] = 50,
		["53"] = 51,
		["54"] = 52,
		["56"] = 50,
		["60"] = 45,
		["61"] = 58,
		["62"] = 59,
		["63"] = 58,
		["64"] = 64,
		["65"] = 65,
		["68"] = 66,
		["71"] = 67,
		["74"] = 69,
		["75"] = 70,
		["78"] = 73,
		["79"] = 76,
		["80"] = 77,
		["81"] = 78,
		["82"] = 83,
		["83"] = 84,
		["84"] = 84,
		["85"] = 84,
		["86"] = 84,
		["87"] = 84,
		["89"] = 64,
		["90"] = 36,
		["91"] = 28,
		["92"] = 28,
		["93"] = 28,
		["94"] = 28,
		["95"] = 28,
		["96"] = 28,
		["97"] = 28,
		["98"] = 28,
		["99"] = 36,
		["101"] = 36,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.greevil_effect.greevil_effect_base")
local m = l.GreevilEffectBase
h.greevil_effect_4 = c()
local n = h.greevil_effect_4
n.name = "greevil_effect_4"
d(n, m)
function n.prototype.spawn(self)
	local o = self.playerID
	local p = self:getSpecialValueFor("gold_cost")
	local q = 0
	do
		local r = 0
		while r < PlayerResource:GetPlayerCount() do
			if r ~= o and not PlayerData:isShardUnlock(r) then
				q = q + 1
			end
			r = r + 1
		end
	end
	local s = q * p
	if s > PlayerData:getGold(o) then
		return
	end
	PlayerData:modifyGold(o, -s)
	self:AddCourierBuff("modifier_greevil_effect_4", {})
	m.prototype.spawn(self)
end
h.modifier_greevil_effect_4 = c()
local t = h.modifier_greevil_effect_4
t.name = "modifier_greevil_effect_4"
d(t, j)
function t.prototype.GetAbilitySpecialValue(self)
	self.g_gold_get = self:GetGreevilEffectValueFor("greevil_effect_4", "gold_get")
end
function t.prototype.OnCreated(self, u)
	if IsServer() then
		local o = self:GetParent():GetPlayerOwnerID()
		self.nonShardPlayers = {}
		do
			local r = 0
			while r < PlayerResource:GetPlayerCount() do
				if r ~= o and not PlayerData:isShardUnlock(r) then
					self.nonShardPlayers[r] = true
				end
				r = r + 1
			end
		end
	end
end
function t.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BUY_SHARD] = { -1, -1 } }
end
function t.prototype.OnBuyShard(self, u)
	if not IsServer() then
		return
	end
	if not self.nonShardPlayers then
		return
	end
	if u.playerID == self:GetParent():GetPlayerOwnerID() then
		return
	end
	local v = u.playerID
	if not self.nonShardPlayers[v] then
		return
	end
	e(self.nonShardPlayers, v)
	local o = self:GetParent():GetPlayerOwnerID()
	PlayerData:modifyGold(o, self.g_gold_get)
	Notification:combatToPlayer(
		o,
		{
			message = "notify_bonus_gold",
			int_gold = self.g_gold_get,
			string_itemname_artifact = "DOTA_Tooltip_ability_greevil_effect_4",
		}
	)
	local w = PlayerData:getHero(o)
	if w ~= nil then
		w:addProperty("item_health", self:GetGreevilEffectValueFor("greevil_effect_4", "health_bonus"))
	end
end
t = f(
	{
		k(
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
	t
)
h.modifier_greevil_effect_4 = t
return h