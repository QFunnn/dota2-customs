--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
--- 为任意基类注入“事件处理能力”的 mixin 工厂函数。
--
-- - 最终返回的类会实现 `EventHandlerInterface`，并提供统一的事件注册/注销流程。
-- - 事件回调方法由业务子类覆写（mixin 内部只提供默认空实现）。
--
-- @param Base 作为混入目标的基类构造器
-- @returns 注入事件处理能力后的派生类
function ____exports.WithEventHandler(self, Base)
	local ____class_0 = __TS__Class()
	____class_0.name = ____class_0.name
	__TS__ClassExtends(____class_0, Base)
	function ____class_0.prototype.____constructor(self, ...)
		Base.prototype.____constructor(self, ...)
		self.__registered_events = {}
	end
	function ____class_0.prototype.GetName(self)
		return ""
	end
	function ____class_0.prototype.GetEntity(self)
		return nil
	end
	function ____class_0.prototype.DeclareEvents(self)
		return {}
	end
	function ____class_0.prototype.GetDefaultEventTarget(self)
		return {
			scope = "entity",
			entity = self:GetEntity(),
		}
	end
	function ____class_0.prototype.GetEventTargetForEvent(self, _event)
		return nil
	end
	function ____class_0.prototype.__dispatchEvent(self, eventName, data)
		if self:IsRemoved() then
			return
		end
		local fn = self[eventName]
		if type(fn) == "function" then
			SafelyCall(nil, function()
				return fn(self, data)
			end)
		end
	end
	function ____class_0.prototype.__normalizeDeclaration(self, decl)
		if type(decl) == "table" then
			local anyDecl = decl
			local event = anyDecl.event
			local t = anyDecl.target
			local ____temp_1
			if type(t) == "function" then
				____temp_1 = t(self)
			else
				____temp_1 = t
			end
			local target = ____temp_1
			local priority = anyDecl.priority
			return { event = event, target = target, priority = priority }
		end
		return { event = decl }
	end
	function ____class_0.prototype.InitializeEvents(self)
		if self:IsRemoved() then
			return
		end
		if #self.__registered_events > 0 then
			self:UnregisterAllEvents()
		end
		local events = self:DeclareEvents() or {}
		local defaultTarget = self:GetDefaultEventTarget()
		for ____, rawDecl in ipairs(events) do
			local ____temp_2 = self:__normalizeDeclaration(rawDecl)
			local ev = ____temp_2.event
			local declaredTarget = ____temp_2.target
			local priority = ____temp_2.priority
			local target = declaredTarget or self:GetEventTargetForEvent(ev) or defaultTarget
			MyGameEvent:RegisterEvent(ev, function(____, data)
				return self:__dispatchEvent(ev, data)
			end, self, target, self:GetName(), priority)
			local ____self___registered_events_3 = self.__registered_events
			____self___registered_events_3[#____self___registered_events_3 + 1] = { event = ev, target = target }
		end
	end
	function ____class_0.prototype.UnregisterAllEvents(self)
		if not MyGameEvent then
			return
		end
		for ____, it in ipairs(self.__registered_events) do
			MyGameEvent:RemoveEvent(it.event, self, it.target)
		end
		self.__registered_events = {}
	end
	return ____class_0
end
return ____exports