--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "framework/module"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayIndexOf
local e = b.__TS__ArraySplice
local f = b.__TS__ArraySort
local g = b.__TS__ArrayForEach
if Modules == nil then
	Modules = {}
end
CModule = c()
CModule.name = "CModule"
function CModule.prototype.____constructor(self)
	self.isModule = true
	Modules[#Modules + 1] = self
end
function CModule.prototype.init(self, h) end
function CModule.prototype.initPriority(self)
	return 0
end
function CModule.prototype.dispose(self)
	e(Modules, d(Modules, self), 1)
end
function CModule.initialize(self)
	g(
		f(Modules, function(i, j, k)
			return k:initPriority() - j:initPriority()
		end),
		function(i, l)
			return l:init(false)
		end
	)
end
function CModule.reload(self)
	g(
		f(Modules, function(i, j, k)
			return k:initPriority() - j:initPriority()
		end),
		function(i, l)
			return l:init(true)
		end
	)
end
function CModule.prototype.print(self, ...)
	print((("[" .. self.constructor.name) .. (IsClient() and " Client" or "")) .. "]: ", ...)
end
function CModule.prototype.error(self, ...)
	print(((("[" .. self.constructor.name) .. " ERROR") .. (IsClient() and " Client" or "")) .. "]: ", ...)
end
function CModule.prototype.reset(self) end
function CModule.reset(self)
	g(Modules, function(i, l)
		return l:reset()
	end)
end