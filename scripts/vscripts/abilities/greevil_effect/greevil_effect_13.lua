--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_13"
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
		["13"] = 4,
		["14"] = 4,
		["15"] = 4,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 11,
		["21"] = 20,
		["22"] = 11,
		["23"] = 20,
		["24"] = 25,
		["25"] = 26,
		["26"] = 27,
		["27"] = 25,
		["28"] = 29,
		["29"] = 30,
		["30"] = 31,
		["31"] = 33,
		["32"] = 33,
		["33"] = 34,
		["34"] = 35,
		["37"] = 29,
		["38"] = 39,
		["39"] = 40,
		["40"] = 39,
		["41"] = 44,
		["42"] = 45,
		["45"] = 46,
		["48"] = 47,
		["49"] = 47,
		["50"] = 48,
		["51"] = 49,
		["53"] = 44,
		["54"] = 52,
		["55"] = 53,
		["58"] = 54,
		["59"] = 55,
		["60"] = 56,
		["61"] = 57,
		["62"] = 52,
		["63"] = 20,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 20,
		["75"] = 20,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.greevil_effect.greevil_effect_base")
local l = k.GreevilEffectBase
g.greevil_effect_13 = c()
local m = g.greevil_effect_13
m.name = "greevil_effect_13"
d(m, l)
function m.prototype.spawn(self)
	self:AddCourierBuff("modifier_greevil_effect_13", {})
end
g.modifier_greevil_effect_13 = c()
local n = g.modifier_greevil_effect_13
n.name = "modifier_greevil_effect_13"
d(n, i)
function n.prototype.GetAbilitySpecialValue(self)
	self.level_target = self:GetGreevilEffectValueFor("greevil_effect_13", "level_target")
	self.free_refresh_count = self:GetGreevilEffectValueFor("greevil_effect_13", "free_refresh_count")
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		self.triggered = false
		local p = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
		local q = p and p:getLevel() or 1
		if q >= self.level_target then
			self:OnTrigger()
		end
	end
end
function n.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function n.prototype.OnHeroLevelUp(self, o)
	if self.triggered then
		return
	end
	if o.player_id ~= self:GetParent():GetPlayerOwnerID() then
		return
	end
	local r = PlayerData:getHero(self:GetParent():GetPlayerOwnerID())
	local q = r and r:getLevel() or 1
	if q >= self.level_target then
		self:OnTrigger()
	end
end
function n.prototype.OnTrigger(self)
	if self.triggered then
		return
	end
	self.triggered = true
	local s = self:GetParent():GetPlayerOwnerID()
	PlayerData:ModifyFreeRefresh(s, self.free_refresh_count)
	PlayerData:ModifyFreeRefreshByKey(s, "greevil_effect_13", self.free_refresh_count)
end
n = e(
	{
		j(
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
	n
)
g.modifier_greevil_effect_13 = n
return g