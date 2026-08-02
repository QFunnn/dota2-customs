--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "lib/dota_ts_adapter"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = {}
function e.toDotaClassInstance(self, f, g)
	local h = g
	local i = h.prototype
	while i do
		for j in pairs(i) do
			if not (rawget(f, j) ~= nil) then
				f[j] = i[j]
			end
		end
		i = getmetatable(i)
	end
end
e.BaseAbility = c()
local k = e.BaseAbility
k.name = "BaseAbility"
function k.prototype.____constructor(self) end
e.BaseItem = c()
local l = e.BaseItem
l.name = "BaseItem"
function l.prototype.____constructor(self) end
function l.prototype.GetItemIntrinsicModifierName(self)
	return
end
function l.prototype.GetSuperiorItemList(self)
	return
end
e.BaseModifier = c()
local m = e.BaseModifier
m.name = "BaseModifier"
function m.prototype.____constructor(self) end
function m.apply(self, n, o, p, q)
	return n:AddNewModifier(o, p, self.name, q)
end
e.BaseModifierMotionHorizontal = c()
local r = e.BaseModifierMotionHorizontal
r.name = "BaseModifierMotionHorizontal"
d(r, e.BaseModifier)
e.BaseModifierMotionVertical = c()
local s = e.BaseModifierMotionVertical
s.name = "BaseModifierMotionVertical"
d(s, e.BaseModifier)
e.BaseModifierMotionBoth = c()
local t = e.BaseModifierMotionBoth
t.name = "BaseModifierMotionBoth"
d(t, e.BaseModifier)
setmetatable(e.BaseAbility.prototype, { __index = CDOTA_Ability_Lua or C_DOTA_Ability_Lua })
setmetatable(e.BaseItem.prototype, { __index = CDOTA_Item_Lua or C_DOTA_Item_Lua })
setmetatable(e.BaseModifier.prototype, { __index = CDOTA_Modifier_Lua or C_DOTA_Modifier_Lua })
e.registerAbility = function(u, v)
	return function(u, p)
		if v ~= nil then
			p.name = v
		else
			v = p.name
		end
		local w = _G
		w[v] = {}
		e.toDotaClassInstance(nil, w[v], p)
		local x = w[v].Spawn
		w[v].Spawn = function(self)
			self:____constructor()
			if x then
				x(self)
			end
		end
	end
end
e.registerModifier = function(self, v)
	local y = self
	return function(u, z)
		if v ~= nil then
			z.name = v
		else
			v = z.name
		end
		local w = _G
		w[v] = {}
		e.toDotaClassInstance(nil, w[v], z)
		local A = w[v].OnCreated
		w[v].OnCreated = function(self, B)
			self:____constructor()
			if A ~= nil then
				A(self, B)
			end
		end
		local C = LUA_MODIFIER_MOTION_NONE
		local D = z.____super
		while D do
			if D == e.BaseModifierMotionBoth then
				C = LUA_MODIFIER_MOTION_BOTH
				break
			elseif D == e.BaseModifierMotionHorizontal then
				C = LUA_MODIFIER_MOTION_HORIZONTAL
				break
			elseif D == e.BaseModifierMotionVertical then
				C = LUA_MODIFIER_MOTION_VERTICAL
				break
			end
			D = D.____super
		end
		if y and #y > 0 then
			LinkLuaModifier(v, y, C)
		end
	end
end
function e.registerEntityFunction(self, v, E)
	local w = getfenv(2)
	w[v] = function(...)
		E(nil, ...)
	end
end
return e