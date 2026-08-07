--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_greevil_battle"
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
		["11"] = 3,
		["12"] = 11,
		["13"] = 3,
		["14"] = 11,
		["15"] = 12,
		["16"] = 13,
		["17"] = 14,
		["19"] = 12,
		["20"] = 17,
		["21"] = 18,
		["22"] = 19,
		["23"] = 20,
		["24"] = 17,
		["25"] = 25,
		["26"] = 26,
		["27"] = 27,
		["28"] = 28,
		["29"] = 25,
		["30"] = 30,
		["31"] = 31,
		["32"] = 32,
		["33"] = 33,
		["36"] = 36,
		["37"] = 37,
		["38"] = 37,
		["39"] = 37,
		["40"] = 38,
		["41"] = 39,
		["43"] = 37,
		["44"] = 37,
		["45"] = 30,
		["46"] = 43,
		["47"] = 44,
		["48"] = 43,
		["49"] = 11,
		["50"] = 3,
		["51"] = 3,
		["52"] = 3,
		["53"] = 3,
		["54"] = 3,
		["55"] = 3,
		["56"] = 3,
		["57"] = 3,
		["58"] = 11,
		["60"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_greevil_battle = c()
local k = g.modifier_greevil_battle
k.name = "modifier_greevil_battle"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self.parent:AddNoDraw()
	end
end
function k.prototype.EDeclareEvents(self)
	local m = self:GetParent()
	local n = m:GetCaster()
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { n, n },
		[EOMModifierEvents.MODIFIER_EVENT_ON_SHOW_GREEVIL] = { -1, -1 },
	}
end
function k.prototype.OnShowGreevil(self, l)
	local m = self:GetParent()
	m:StartGesture(ACT_DOTA_SPAWN)
	m:RemoveNoDraw()
end
function k.prototype.OnBattleEnd(self, l)
	local m = self:GetParent()
	local o = m:GetCaster()
	if IsValid(o) and o:IsAlive() then
		return
	end
	m:StartGesture(ACT_DOTA_DIE)
	TimerManager:GameTimer(1, function()
		if IsValid(m) then
			m:SafeRemoveUnit()
		end
	end)
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_ROOTED] = true }
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_greevil_battle = k
return g