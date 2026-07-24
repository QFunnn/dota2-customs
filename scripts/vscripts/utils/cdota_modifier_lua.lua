--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_Modifier_Lua:AddIndependentStack(duration, limit, bDontDestroy, tTimerTable)
	local timerTable = tTimerTable or {}
	self.stackTimers = self.stackTimers or {}
	self.currentStack = self.currentStack or 0

	if timerTable.stacks then
		self.currentStack = self.currentStack + timerTable.stacks
	else
		self.currentStack = self.currentStack + 1
	end
	local dontDestroy = bDontDestroy
	if bDontDestroy == nil then dontDestroy = true end
	timerTable.ID = Timers:CreateTimer(duration or self:GetRemainingTime(), function(timer)
		if self:IsNull() then return end
		if timerTable.stacks then
			self.currentStack = self.currentStack - timerTable.stacks
		else
			self.currentStack = self.currentStack - 1
		end
		if limit then
			self:SetStackCount(math.min(self.currentStack, limit))
		else
			self:SetStackCount(self.currentStack)
		end
		
		for i = #self.stackTimers, 1, -1 do
			if timer.name == self.stackTimers[i].ID then
				table.remove(self.stackTimers, pos)
				break
			end
		end
		if self:GetStackCount() == 0 and self:GetDuration() == -1 and not dontDestroy then self:Destroy() end
	end)
	
	if limit then
		self:SetStackCount(math.min(self.currentStack, limit))
	else
		self:SetStackCount(self.currentStack)
	end
	table.insert(self.stackTimers, timerTable or {})
end