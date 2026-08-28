--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


if _G.debug == nil then
	_G.debug = {}
end
if _G.debug.traceback == nil then
	_G.debug.traceback = function(...)
		return ""
	end
end
if _G.debug.getinfo == nil then
	_G.debug.getinfo = function(...)
		return { source = "", what = "" }
	end
end
local a = "addon_game_mode_client"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__DecorateLegacy
local g = b.__TS__New
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
SendToConsole("dota_combine_models 0")
Convars:SetBool("dota_combine_models", false)
require("requires")
local k = c()
k.name = "MClient"
d(k, CModule)
function k.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.keyEvent = {}
	self.abilityKeyEvent = {}
	self.commandUnique = {}
	self.WaitSceneEntityLoadData = {}
end
function k.prototype.initPriority(self)
	return 1
end
function k.prototype.init(self, l)
	if not l then
	end
	GameEvent("client_reload_game_keyvalues", function()
		require("addon_game_mode_client")
	end, nil)
	GameEvent("custom_command_unique", function(self, m)
		self.commandUnique[m.command] = m.unique
	end, self)
	GameEvent("lua_server_to_client", function(self, m)
		local n = m.event_name
		local o = json.decode(m.data)
		if o ~= nil then
			Event:Fire(n, o)
		end
	end, self)
	GameEvent("wait_scene_entity_load", function(self, m)
		local o = m.data
		if self.WaitSceneEntityLoadData == nil then
			self.WaitSceneEntityLoadData = {}
		end
		if self.WaitSceneEntityLoadData[m.name] == nil then
			self.WaitSceneEntityLoadData[m.name] = {}
		end
		if o ~= nil then
			local p = self.WaitSceneEntityLoadData[m.name]
			p[#p + 1] = { key = m.key, data = o }
		else
			for q, r in ipairs(self.WaitSceneEntityLoadData[m.name]) do
				if r.key == m.key then
					table.remove(self.WaitSceneEntityLoadData[m.name], q)
					break
				end
			end
		end
	end, self)
	RequestEvent("register_key_event", function(self, ...)
		return self:OnRegisterKeyEvent(...)
	end, self)
	RequestEvent("unregister_key_event", function(self, ...)
		return self:OnUnregisterKeyEvent(...)
	end, self)
	RequestEvent("register_ability_key_event", function(self, ...)
		return self:OnRegisterAbilityKeyEvent(...)
	end, self)
	RequestEvent("unregister_ability_key_event", function(self, ...)
		return self:OnUnregisterAbilityKeyEvent(...)
	end, self)
	RequestEvent("call_lua_client_function", function(self, ...)
		return self:OnCallLuaClientFunction(...)
	end, self)
end
function k.prototype.GetSceneEntityData(self, s)
	local t = self.WaitSceneEntityLoadData[s]
	if t ~= nil and t[1] ~= nil then
		local o = json.decode(t[1].data)
		if o ~= nil then
			table.remove(self.WaitSceneEntityLoadData[s], 1)
			return o
		end
	end
end
function k.prototype.OnRegisterKeyEvent(self, u)
	local n = DoUniqueString(u.key_name)
	SendToConsole((("bind " .. u.key_name) .. " +") .. n)
	self.keyEvent[n] = { key_name = u.key_name }
	return { unique_name = n, event_name = u.key_name }
end
function k.prototype.OnUnregisterKeyEvent(self, u)
	local v = self.keyEvent[u.event_name]
	local w = false
	if v ~= nil then
		w = true
		e(self.keyEvent, u.event_name)
		SendToConsole((("unbind " .. v.key_name) .. " +") .. u.event_name)
	end
	return { success = w }
end
function k.prototype.OnRegisterAbilityKeyEvent(self, x)
	local y = DoUniqueString(x.key_name)
	SendToConsole((("bind " .. x.key_name) .. " +") .. y)
	self.abilityKeyEvent[y] = { slot = x.slot, key_name = x.key_name, quick_cast = x.quick_cast }
	return { event_name = y }
end
function k.prototype.OnUnregisterAbilityKeyEvent(self, x)
	local z = self.abilityKeyEvent[x.event_name]
	local A = false
	if z ~= nil then
		A = true
		self.abilityKeyEvent[x.event_name] = nil
		SendToConsole((("unbind " .. z.key_name) .. " +") .. x.event_name)
	end
	return { success = A }
end
function k.prototype.OnCallLuaClientFunction(self, x)
	local B = x.func_name
	local C
	local D = _G[B]
	if type(D) == "function" then
		do
			pcall(function()
				local E = json.decode(x.args_json)
				if type(E) == "table" then
					C = D(unpack(E))
				else
					C = D()
				end
			end)
		end
	end
	return { value = C }
end
function k.prototype.SendToConsole(self, F, ...)
	local G = self.commandUnique[F]
	if G ~= nil then
		local t = { F .. G, ... }
		SendToConsole(table.concat(t, " "))
	end
end
k = f({ j }, k)
if Client == nil then
	Client = g(k)
end
if not GameModeActivated then
	CModule:initialize()
end
require("reload")
_G.CalculatePropertyValue = function(H, I, C)
	return PropertySystem:AggregatePropertyValues(H, I, C)
end
return h