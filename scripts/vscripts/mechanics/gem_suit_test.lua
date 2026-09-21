--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "mechanics/gem_suit_test"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectEntries
local f = b.__TS__StringSplit
local g = b.__TS__ArrayIncludes
local h = b.__TS__DecorateLegacy
local i = b.__TS__New
local j = {}
local k = require("lib.tstl-utils")
local l = k.reloadable
local m = "gem_suit_console_test"
local n = 1
local o = 20
local p = {
	[1] = { "value" },
	[2] = { "value", "duration" },
	[3] = { "value", "duration" },
	[4] = { "value" },
	[5] = { "value", "incoming_damage" },
	[6] = { "attack_speed", "skill_damage", "hit_count", "duration" },
	[7] = { "value", "delay" },
	[8] = { "value", "delay" },
	[9] = { "value" },
	[10] = { "value" },
	[11] = { "value", "duration" },
	[12] = { "value", "movespeed_reduction" },
	[13] = { "value", "duration", "stack_limit" },
	[14] = { "value", "duration" },
	[15] = { "value", "radius", "interval" },
	[16] = { "value" },
	[17] = { "value", "duration" },
	[18] = { "value" },
	[19] = { "value" },
	[20] = { "value" },
}
local q = {
	"attack",
	"attackspeed",
	"damage_reduction",
	"incoming_damage_amplify",
	"magical_damage_boost",
	"magical_damage_multiplier",
	"melee_damage_boost",
	"movespeed",
	"physical_damage_boost",
	"physical_damage_multiplier",
	"ranged_damage_boost",
	"skill_damage_boost",
	"skill_damage_multiplier",
	"spell_damage_boost",
	"spell_damage_multiplier",
	"splash_damage_boost",
	"ultimate_damage_boost",
}
local r = c()
r.name = "CGemSuitTest"
d(r, CModule)
function r.prototype.init(self, s)
	if not s and IsInToolsMode() then
		self:RegisterCommands()
	end
end
function r.prototype.RegisterCommands(self)
	Convars:RegisterCommand("gem_suit_test_set", function(t, ...)
		local u = { ... }
		local v = self:ParseId(u[1])
		local w = self:ParsePlayerID(u[3])
		if v == nil or w == nil then
			return
		end
		local x = self:ParseLevel(u[2])
		local y = self:GetPrivilegeName(v)
		local z = self:ParseOverrides(v, u, 3)
		Privilege:ActivatePrivilege(w, y, x, m)
		for A, B in ipairs(e(z)) do
			local C = B[1]
			local D = B[2]
			Privilege:SetPlayerDynamicValue(y, w, C, D)
		end
		print((((("[GemSuitTest] enabled " .. y) .. ", level=") .. tostring(x)) .. ", player=") .. tostring(w))
		self:PrintResolvedValues(v, x, w)
	end, "Enable one gem suit privilege: gem_suit_test_set <1-20> [level=1] [player_id=0] [key=value ...]", 0)
	Convars:RegisterCommand("gem_suit_test_all", function(t, ...)
		local u = { ... }
		local w = self:ParsePlayerID(u[2])
		if w == nil then
			return
		end
		local x = self:ParseLevel(u[1])
		do
			local v = n
			while v <= o do
				Privilege:ActivatePrivilege(w, self:GetPrivilegeName(v), x, m)
				v = v + 1
			end
		end
		print((("[GemSuitTest] enabled all gem suit privileges, level=" .. tostring(x)) .. ", player=") .. tostring(w))
	end, "Enable all gem suit privileges: gem_suit_test_all [level=1] [player_id=0]", 0)
	Convars:RegisterCommand("gem_suit_test_remove", function(t, ...)
		local u = { ... }
		local E = string.lower(tostring(u[1] or "all"))
		local w = self:ParsePlayerID(u[2])
		if w == nil then
			return
		end
		if E == "all" then
			Privilege:RemovePrivilegesBySource(m, w)
			do
				local v = n
				while v <= o do
					Privilege:ClearPlayerDynamicValues(self:GetPrivilegeName(v), w)
					v = v + 1
				end
			end
			print("[GemSuitTest] removed all console test privileges, player=" .. tostring(w))
			return
		end
		local v = self:ParseId(E)
		if v == nil then
			return
		end
		local y = self:GetPrivilegeName(v)
		Privilege:RemovePrivilege(w, y, m)
		Privilege:ClearPlayerDynamicValues(y, w)
		print((("[GemSuitTest] removed " .. y) .. ", player=") .. tostring(w))
	end, "Remove gem suit test privileges: gem_suit_test_remove <1-20|all> [player_id=0]", 0)
	Convars:RegisterCommand("gem_suit_test_values", function(t, ...)
		local u = { ... }
		local v = self:ParseId(u[1])
		local w = self:ParsePlayerID(u[3])
		if v == nil or w == nil then
			return
		end
		self:PrintResolvedValues(v, self:ParseLevel(u[2]), w)
	end, "Print resolved privilege values: gem_suit_test_values <1-20> [level=1] [player_id=0]", 0)
	Convars:RegisterCommand("gem_suit_test_props", function(t, ...)
		local u = { ... }
		local w = self:ParsePlayerID(u[1])
		if w == nil then
			return
		end
		local F = PlayerResource:GetSelectedHeroEntity(w)
		if not IsValid(F) then
			return
		end
		print(("[GemSuitTest] current properties, player=" .. tostring(w)) .. ":")
		for A, G in ipairs(q) do
			local D = PropertySystem:GetPropertyValue(F:entindex(), G)
			print((("  " .. G) .. " = ") .. tostring(D))
		end
	end, "Print gem suit related properties: gem_suit_test_props [player_id=0]", 0)
end
function r.prototype.PrintResolvedValues(self, v, x, w)
	local y = self:GetPrivilegeName(v)
	local F = PlayerResource:GetSelectedHeroEntity(w)
	print(((("[GemSuitTest] " .. y) .. " configured values at level ") .. tostring(x)) .. ":")
	for A, C in ipairs(p[v]) do
		local D = Privilege:GetPrivilegeSpecialValue(y, x, C, F)
		print((("  " .. C) .. " = ") .. tostring(D))
	end
end
function r.prototype.ParseId(self, D)
	local v = math.floor(toFiniteNumber(D, 0))
	if v < n or v > o then
		print("[GemSuitTest] invalid id; expected 1-20")
		return nil
	end
	return v
end
function r.prototype.ParseLevel(self, D)
	return math.max(1, math.floor(toFiniteNumber(D, 1)))
end
function r.prototype.ParsePlayerID(self, D)
	local w = math.floor(toFiniteNumber(D, 0))
	if not PlayerResource:IsValidPlayerID(w) then
		print("[GemSuitTest] invalid player id: " .. tostring(w))
		return nil
	end
	local F = PlayerResource:GetSelectedHeroEntity(w)
	if not IsValid(F) then
		print(("[GemSuitTest] player " .. tostring(w)) .. " has no selected hero")
		return nil
	end
	return w
end
function r.prototype.ParseOverrides(self, v, u, H)
	local z = {}
	local I = p[v]
	do
		local J = H
		while J < #u do
			do
				local K = f(u[J + 1], "=")
				local C = K[1]
				local D = tonumber(K[2])
				if #K ~= 2 or not g(I, C) or D == nil then
					print(
						(("[GemSuitTest] ignored invalid override '" .. u[J + 1]) .. "'; allowed keys: ")
							.. table.concat(I, ", ")
					)
					goto L
				end
				z[C] = D
			end
			::L::
			J = J + 1
		end
	end
	return z
end
function r.prototype.GetPrivilegeName(self, v)
	if v < 10 then
		return "privilege_gem_suit_00" .. tostring(v)
	end
	return "privilege_gem_suit_0" .. tostring(v)
end
r = h({ l }, r)
j.GemSuitTest = i(r)
return j