--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/hunt_boss/modifier_hunt_heavy"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.TransmitterData
local j = g.registerEOMModifier
local k = c()
k.name = "modifier_hunt_heavy"
d(k, h)
function k.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.reducePct = 0
end
function k.prototype.OnCreated(self, l)
	self.reducePct = math.max(0, toFiniteNumber(l.reducePct, 0))
	self:SetStackCount(self.reducePct)
	if IsServer() then
		PropertySystem:AddStaticProperty(
			self:GetParent():entindex(),
			"movespeed_reduce_mul",
			self:GetName(),
			self.reducePct
		)
	end
	print("modifier_hunt_heavy:OnCreated", self:GetParent():GetName(), self.reducePct)
end
e({ i(nil) }, k.prototype, "reducePct", nil)
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
return f