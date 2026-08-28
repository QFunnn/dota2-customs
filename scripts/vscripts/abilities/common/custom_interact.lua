--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/common/custom_interact"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = c()
j.name = "custom_interact"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.pendingAction = "primary"
end
function j.prototype.SetInteractionAction(self, k)
	self.pendingAction = k
end
function j.prototype.OnController(self, l, m)
	if self:IsFullyCastable() then
		self:GetCaster():ExecuteOrder(DOTA_UNIT_ORDER_CAST_NO_TARGET, self)
	end
end
function j.prototype.OnSpellStart(self)
	local n = self:GetCaster()
	local k = self.pendingAction
	self.pendingAction = "primary"
	local o = Interaction:ExecuteInteraction(n, k)
	if o then
		return
	end
	print("[custom_interact] 无可交互目标")
	self:EndCooldown()
end
j = e({ i(nil) }, j)
return f