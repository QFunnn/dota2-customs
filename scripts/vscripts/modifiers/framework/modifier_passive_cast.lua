--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_passive_cast"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseModifier
local j = h.registerModifier
local k = c()
k.name = "modifier_passive_cast"
d(k, i)
function k.prototype.IsHidden(self)
	return true
end
function k.prototype.IsDebuff(self)
	return false
end
function k.prototype.IsPurgable(self)
	return false
end
function k.prototype.IsPurgeException(self)
	return false
end
function k.prototype.AllowIllusionDuplicate(self)
	return false
end
function k.prototype.DestroyOnExpire(self)
	return false
end
function k.prototype.IsPermanent(self)
	return true
end
function k.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end
function k.prototype.OnCreated(self, l)
	if not IsServer() then
		return
	end
	local m = self:GetParent()
	m:Stop()
	self:StartIntervalThink(0)
	self.bSucceeded = false
	self.flTime = 0
	self.castPoint = l.castPoint
	self.castAnimation = l.castAnimation
	self.fadeAnimationTime = l.fadeAnimationTime
	local n
	if l.bFadeAnimation ~= nil then
		n = l.bFadeAnimation
	else
		n = false
	end
	self.bFadeAnimation = n
	local o
	if l.bIgnoreBackswing ~= nil then
		o = l.bIgnoreBackswing
	else
		o = false
	end
	self.bIgnoreBackswing = o
	self.orderType = l.orderType
	self.animationRate = l.animationRate
	self.bUseCooldown = l.bUseCooldown == 1
	self.bUseMana = l.bUseMana == 1
	self.position = l.position and StringToVector(l.position) or nil
	local p
	if l.targetIndex then
		p = EntIndexToHScript(l.targetIndex)
	else
		p = nil
	end
	self.target = p
	self.callback = l.callback
	if l.activityModifier ~= nil then
		self.activityModifier = e(l.activityModifier, ",")
	end
	local q = self:GetAbility()
	if q and q.CustomAbilityPhaseStart then
		self.OnAbilityPhaseStart = q.CustomAbilityPhaseStart
	end
	if q and q.CustomAbilityPhaseInterrupted then
		self.OnAbilityPhaseInterrupted = q.CustomAbilityPhaseInterrupted
	end
	if self.castAnimation ~= nil then
		if self.activityModifier then
			if type(self.activityModifier) == "string" then
				m:AddActivityModifier(self.activityModifier)
			else
				for r, s in ipairs(self.activityModifier) do
					m:AddActivityModifier(s)
				end
			end
		end
		if self.animationRate ~= nil then
			m:StartGestureWithPlaybackRate(self.castAnimation, self.animationRate)
		else
			m:StartGesture(self.castAnimation)
		end
		if self.activityModifier then
			if type(self.activityModifier) == "string" then
				m:RemoveActivityModifier(self.activityModifier)
			else
				for r, s in ipairs(self.activityModifier) do
					m:RemoveActivityModifier(s)
				end
			end
		end
	end
	if not self.bIgnoreBackswing then
		local t = math.max(m:ActiveSequenceDuration(), self.castPoint or 0)
		self:SetDuration(t, true)
	end
	if self.orderType == DOTA_UNIT_ORDER_CAST_TARGET and self.target then
		m:SetCursorCastTarget(self.target)
	elseif self.orderType == DOTA_UNIT_ORDER_CAST_POSITION and self.position then
		m:SetCursorPosition(self.position)
	end
	if IsValid(q) then
		if self.OnAbilityPhaseStart then
			if not self:OnAbilityPhaseStart(q) then
				self:Destroy()
			end
		elseif q and not q:OnAbilityPhaseStart() then
			self:Destroy()
		end
	end
	if self.orderType == DOTA_UNIT_ORDER_CAST_TARGET then
		if not IsValid(self.target) then
			self:Destroy()
		end
		m:SetCursorCastTarget(nil)
	elseif self.orderType == DOTA_UNIT_ORDER_CAST_POSITION then
		m:SetCursorPosition(vec3_invalid)
	end
	if self.orderType == DOTA_UNIT_ORDER_CAST_POSITION or self.orderType == DOTA_UNIT_ORDER_CAST_TARGET then
		local u = self.position
		if u == nil then
			local v = self.target
			u = v and v:GetAbsOrigin()
		end
		local w = u
		if w then
			local x = (w - m:GetAbsOrigin()):Normalized()
			m:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, nil, m:GetAbsOrigin() + x)
		end
	end
end
function k.prototype.OnRefresh(self, l)
	local m = self:GetParent()
	if self.castAnimation ~= nil then
		m:FadeGesture(self.castAnimation)
	end
	self:OnCreated(l)
end
function k.prototype.OnIntervalThink(self)
	local m = self:GetParent()
	if self.flTime ~= nil then
		self.flTime = self.flTime + FrameTime()
	end
	if self.castPoint ~= nil and self.flTime ~= nil and not self.bSucceeded and self.flTime >= self.castPoint then
		self.bSucceeded = true
		self:OnSuccess()
	end
	if self.bSucceeded and self:GetRemainingTime() <= 0 then
		self:Destroy()
	end
	if not self.bSucceeded then
		if
			not m:IsAlive()
			or self.orderType == DOTA_UNIT_ORDER_CAST_TARGET
				and (not IsValid(self.target) or not self.target:IsAlive())
		then
			self:Destroy()
		end
	end
end
function k.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local m = self:GetParent()
	local q = self:GetAbility()
	local y = self.castAnimation
	if not self.bSucceeded then
		if y ~= nil then
			m:FadeGesture(y)
		end
		if IsValid(q) then
			if self.OnAbilityPhaseInterrupted then
				self:OnAbilityPhaseInterrupted(q)
			else
				q:OnAbilityPhaseInterrupted()
			end
		end
		if self.callback then
			self:callback(false)
		end
	else
		if y ~= nil then
			if self.fadeAnimationTime ~= nil and self.fadeAnimationTime > 0 then
				m:GameTimer(self.fadeAnimationTime, function()
					if IsValid(m) then
						m:RemoveGesture(y)
					end
				end)
			else
				m:RemoveGesture(y)
			end
		end
	end
end
function k.prototype.OnSuccess(self)
	if not IsServer() then
		return
	end
	local m = self:GetParent()
	local q = self:GetAbility()
	if self.bSucceeded then
		if IsValid(q) then
			q:UseResources(self.bUseMana == true, false, false, self.bUseCooldown == true)
		end
		if self.orderType == DOTA_UNIT_ORDER_CAST_TARGET and self.target then
			m:SetCursorCastTarget(self.target)
		elseif self.orderType == DOTA_UNIT_ORDER_CAST_POSITION and self.position then
			m:SetCursorPosition(self.position)
		end
		if self.callback then
			self:callback(true)
		elseif IsValid(q) then
			q:OnSpellStart()
		end
		if self.orderType == DOTA_UNIT_ORDER_CAST_TARGET then
			m:SetCursorCastTarget(nil)
		elseif self.orderType == DOTA_UNIT_ORDER_CAST_POSITION then
			m:SetCursorPosition(vec3_invalid)
		end
	end
	if self.castAnimation ~= nil and self.bFadeAnimation == true then
		m:FadeGesture(self.castAnimation)
	end
	if self.bIgnoreBackswing then
		self:Destroy()
	end
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ORDER }
end
function k.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true }
end
function k.prototype.OnOrder(self, l)
	if l.unit == self:GetParent() and self:GetElapsedTime() > FrameTime() then
		local q = l.ability
		if IsValid(q) then
			if q == self:GetAbility() then
				return
			end
			local z = q:GetBehaviorInt()
			return
		end
		if
			l.order_type == DOTA_UNIT_ORDER_TRAIN_ABILITY
			or l.order_type == DOTA_UNIT_ORDER_PURCHASE_ITEM
			or l.order_type == DOTA_UNIT_ORDER_SELL_ITEM
			or l.order_type == DOTA_UNIT_ORDER_MOVE_ITEM
			or l.order_type == DOTA_UNIT_ORDER_DISASSEMBLE_ITEM
			or l.order_type == DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO
			or l.order_type == DOTA_UNIT_ORDER_GLYPH
			or l.order_type == DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH
			or l.order_type == DOTA_UNIT_ORDER_RADAR
		then
			return
		end
		self:Destroy()
	end
end
k = f({ j(a) }, k)
return g