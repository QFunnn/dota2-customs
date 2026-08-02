--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_abyss_auto_pickup"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = 0.25
local k = c()
k.name = "modifier_abyss_auto_pickup"
d(k, h)
function k.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(j)
	self:OnIntervalThink()
end
function k.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local l = self:GetParent()
	if not IsValid(l) or not l:IsRealHero() then
		self:Destroy()
		return
	end
	if AbyssalHordeManager ~= nil then
		AbyssalHordeManager:TryAutoPickupDrop(l)
	end
end
k = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
return f