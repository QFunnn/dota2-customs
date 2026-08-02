--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_simulate_cast"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerModifier
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = c()
k.name = "modifier_simulate_cast"
d(k, j)
function k.prototype.OnCreated(self, l)
	if not IsServer() then
		return
	end
	local m = self:GetParent()
	self.castPoint = l.castPoint
	self.castAnimation = l.castAnimation
	self.orderType = l.orderType
	self.animationRate = l.animationRate
	self.position = l.position and StringToVector(l.position) or nil
	local n
	if l.targetIndex then
		n = EntIndexToHScript(l.targetIndex)
	else
		n = nil
	end
	self.target = n
	self.activityModifier = l.activityModifier or ""
	if self.orderType == DOTA_UNIT_ORDER_CAST_TARGET and self.target then
		m:SetCursorCastTarget(self.target)
	elseif self.orderType == DOTA_UNIT_ORDER_CAST_POSITION and self.position then
		m:SetCursorPosition(self.position)
	end
	if self.castAnimation ~= nil then
		if l.animationFadeIn ~= nil and l.animationFadeOut ~= nil then
			m:StartGestureWithFadeAndPlaybackRate(
				self.castAnimation,
				l.animationFadeIn,
				l.animationFadeOut,
				self.animationRate
			)
		else
			m:StartGestureWithPlaybackRate(self.castAnimation, self.animationRate)
		end
	end
	if self.castPoint > 0 then
		self:StartThink(0, "interrupted", function()
			if not m:IsAlive() then
				if self.castAnimation ~= nil then
					m:RemoveGesture(self.castAnimation)
				end
				self:Destroy()
			end
			return 0
		end)
		self:StartThink(self.castPoint, "cast_point", function()
			self:OnSpellStart()
			self:StartThink(-1, "interrupted")
			return -1
		end)
	else
		self:OnSpellStart()
	end
end
function k.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:OnFinish()
end
function k.prototype.OnSpellStart(self) end
function k.prototype.OnFinish(self) end
function k.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS] = self.activityModifier }
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
k = e({ h(a) }, k)
return f