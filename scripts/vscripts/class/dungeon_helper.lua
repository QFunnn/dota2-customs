--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "class/dungeon_helper"
local b = require("lualib_bundle")
local c = b.__TS__StringEndsWith
local d = b.__TS__StringSplit
local e = b.__TS__StringStartsWith
local f = {}
function f.AnalyzeCenterPositions(self, g)
	local h = g.gridSize or GRID_SIZE
	local i = {}
	do
		local j = 0
		while j <= g.rings do
			do
				local k = -j
				while k <= j do
					do
						local l = -j
						while l <= j do
							do
								if math.abs(k) ~= j and math.abs(l) ~= j then
									goto m
								end
								local n = Vector(g.center.x + k * h, g.center.y + l * h, g.center.z)
								if not GridNav:IsValidPosition(n) then
									print(
										(("[DungeonHelper] Invalid grid position: " .. tostring(n.x)) .. ", ")
											.. tostring(n.y)
									)
									goto m
								end
								if not GridNav:CanFindPath(g.center, n) then
									print(
										(("[DungeonHelper] CanFindPath: " .. VectorToString(g.center)) .. ", ")
											.. VectorToString(n)
									)
									goto m
								end
								i[#i + 1] = n
							end
							::m::
							l = l + 1
						end
					end
					k = k + 1
				end
			end
			j = j + 1
		end
	end
	return i
end
function f.FindSpawnGroupEntitiesBySuffix(self, o, p, q)
	local r = {}
	if o == nil then
		return r
	end
	local s = Entities:FindAllByClassname(p)
	do
		local t = 0
		while t < #s do
			do
				local u = s[t + 1]
				if u:GetSpawnGroupHandle() ~= o then
					goto v
				end
				if c(u:GetName(), q) then
					r[#r + 1] = u
				end
			end
			::v::
			t = t + 1
		end
	end
	return r
end
function f.ResolveSpawnGroupInfoTarget(self, o, w)
	local x = f.FindSpawnGroupEntitiesBySuffix(nil, o, "info_target", w)
	if #x <= 0 then
		return nil
	end
	local y = {}
	local z = {}
	do
		local t = 0
		while t < #x do
			do
				local A = d(x[t + 1]:GetName(), "_")[1]
				if A == nil or A == "" or y[A] == true then
					goto B
				end
				y[A] = true
				z[#z + 1] = A
			end
			::B::
			t = t + 1
		end
	end
	local C = GetRandomElement(z) or ""
	if C ~= "" then
		do
			local t = 0
			while t < #x do
				local u = x[t + 1]
				if e(u:GetName(), C .. "_") then
					return { position = u:GetAbsOrigin(), prefix = C }
				end
				t = t + 1
			end
		end
	end
	local D = x[1]
	if not IsValid(D) then
		return nil
	end
	local E = d(D:GetName(), "_")[1]
	return { position = D:GetAbsOrigin(), prefix = E ~= "" and E or nil }
end
function f.ResolveGateDirectionFromCenter(self, F, G)
	if F == nil then
		return vec3_top
	end
	local H = G.x - F.x
	local I = G.y - F.y
	if math.abs(I) > math.abs(H) then
		return I >= 0 and vec3_top or vec3_bottom
	end
	return H >= 0 and vec3_right or vec3_left
end
return f