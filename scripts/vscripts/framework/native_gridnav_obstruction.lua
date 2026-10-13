--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "framework/native_gridnav_obstruction"
local b = require("lualib_bundle")
local c = b.__TS__ArrayEvery
local d = b.__TS__Class
local e = b.__TS__ArrayFilter
local f = b.__TS__ArrayPushArray
local g = b.__TS__ArrayMap
local h = b.__TS__ArraySome
local i = b.__TS__ArrayFind
local j = {}
local k = require("data.dungeon_gridnav.reader")
local l = k.gridNavReader
local m
local n
local function o(p, q, r)
	return (tostring(q) .. ",") .. tostring(r)
end
local function s(p, t)
	return t == 1
end
local function u(p, v)
	return v == 0 or v == 2
end
local function w(self, x, y, z)
	local A = {}
	local B = {}
	for p, C in ipairs(x) do
		do
			if not s(nil, C.flags) or not u(nil, z(nil, C.x, C.y)) or B[o(nil, C.x, C.y)] then
				goto D
			end
			local E
			for p, F in ipairs(y) do
				for p, G in ipairs(F.cells) do
					local q = C.x - G.x
					local r = C.y - G.y
					if c(F.cells, function(p, H)
						return u(nil, z(nil, q + H.x, r + H.y))
					end) then
						E = { x = q, y = r, profile = F }
						break
					end
				end
				if E ~= nil then
					break
				end
			end
			if E == nil then
				goto D
			end
			A[#A + 1] = E
			for p, H in ipairs(E.profile.cells) do
				B[o(nil, E.x + H.x, E.y + H.y)] = true
			end
			if #A >= 512 then
				break
			end
		end
		::D::
	end
	return A
end
j.NativeGridNavObstruction = d()
local I = j.NativeGridNavObstruction
I.name = "NativeGridNavObstruction"
function I.prototype.____constructor(self, J, K, L)
	self.owned = {}
	self.disposed = false
	self.baseline = {}
	self.terrains = { { prefab = J, origin = K } }
	self.protectedAreas = L
	self.report = {
		status = "loading",
		prefab = J,
		obstructions = 0,
		extraBefore = 0,
		extraRemaining = 0,
		missingRoads = 0,
		unknownWalkable = 0,
		misblocked = 0,
	}
end
function I.prototype.Start(self, M)
	if self.disposed then
		return
	end
	self.completion = M
	self.report.reason = nil
	self.report.misblocked = 0
	self:StopTimers()
	self:ClearOwned()
	for p, N in ipairs(self.terrains) do
		local O, P = l:GetMap(N.prefab)
		if O == nil or N.origin.x % 64 ~= 0 or N.origin.y % 64 ~= 0 then
			self:Fail(P or "room_origin_not_grid_aligned")
			return
		end
	end
	self:WaitStable(function(p, x)
		self.baseline = x
		self.report.extraBefore = #e(x, function(p, C)
			return s(nil, C.flags) and u(nil, self:Target(C.x, C.y))
		end)
		if self.report.extraBefore == 0 then
			self:Verify()
			return
		end
		self:EnsureProfiles(x)
	end)
end
function I.prototype.AddTerrain(self, J, K, L, M)
	local Q = self.terrains
	Q[#Q + 1] = { prefab = J, origin = K }
	f(self.protectedAreas, L)
	self:Start(M)
end
function I.prototype.Dispose(self)
	self.disposed = true
	self.completion = nil
	self:StopTimers()
	self:ClearOwned()
	if n == self then
		n = nil
	end
end
function I.prototype.StopTimers(self)
	if self.timer ~= nil then
		Timer:StopTimer(self.timer)
	end
	self.timer = nil
end
function I.prototype.Remove(self, R)
	if IsValid(R) then
		R:SetEnabled(false, true)
		UTIL_Remove(R)
	end
end
function I.prototype.ClearOwned(self)
	if self.probe ~= nil then
		self:Remove(self.probe)
	end
	self.probe = nil
	for p, R in ipairs(self.owned) do
		self:Remove(R)
	end
	if #self.owned > 0 then
		print((("[GridNavPatch] cleanup prefab=" .. self.report.prefab) .. " owned=") .. tostring(#self.owned))
	end
	self.owned = {}
end
function I.prototype.Position(self, q, r)
	return Vector(GridNav:GridPosToWorldCenterX(q), GridNav:GridPosToWorldCenterY(r), self.terrains[1].origin.z)
end
function I.prototype.Target(self, q, r)
	local S = self:Position(q, r)
	local A
	for p, N in ipairs(self.terrains) do
		local v = l:GetCode(N.prefab, S, N.origin)
		if v == 1 then
			return 1
		end
		if v == 3 then
			A = 3
		elseif v ~= nil and A == nil then
			A = v
		end
	end
	return A
end
function I.prototype.Snapshot(self)
	local T = math.huge
	local U = math.huge
	local V = -math.huge
	local W = -math.huge
	for p, N in ipairs(self.terrains) do
		local O = l:GetMap(N.prefab)
		local X = O and O.capture_radius or 2048
		T = math.min(T, GridNav:WorldToGridPosX(N.origin.x - X))
		U = math.min(U, GridNav:WorldToGridPosY(N.origin.y - X))
		V = math.max(V, GridNav:WorldToGridPosX(N.origin.x + X - 1))
		W = math.max(W, GridNav:WorldToGridPosY(N.origin.y + X - 1))
	end
	local A = {}
	do
		local q = T
		while q <= V do
			do
				local r = U
				while r <= W do
					local S = self:Position(q, r)
					A[#A + 1] = { x = q, y = r, flags = (GridNav:IsTraversable(S) and 1 or 0)
						+ (GridNav:IsBlocked(S) and 2 or 0) }
					r = r + 1
				end
			end
			q = q + 1
		end
	end
	return A
end
function I.prototype.WaitStable(self, Y)
	local Z = ""
	local _ = 0
	local a0 = 0
	self.timer = Timer:Timer(0.1, function()
		if self.disposed then
			return
		end
		local x = self:Snapshot()
		local a1 = table.concat(
			g(x, function(p, C)
				return tostring(C.flags)
			end),
			""
		)
		_ = a1 == Z and _ + 1 or 0
		Z = a1
		if _ >= 2 then
			self.timer = nil
			Y(nil, x)
			return
		end
		a0 = a0 + 1
		if a0 >= 30 then
			self.timer = nil
			self:Fail("native_grid_unstable")
			return
		end
		return 0.1
	end)
end
function I.prototype.Create(self, S)
	local R = SpawnEntityFromTableSynchronous(
		"point_simple_obstruction",
		{
			origin = GetGroundPosition(S, nil),
			StartDisabled = true,
			block_fow = false,
			targetname = DoUniqueString("gridnav_native_patch"),
		}
	)
	if not IsValid(R) then
		return nil
	end
	R:SetEnabled(true, true)
	return R
end
function I.prototype.EnsureProfiles(self, x)
	if m ~= nil then
		self:Apply(m)
		return
	end
	if n == nil or n == self then
		n = self
		self:Calibrate(x)
		return
	end
	self.timer = Timer:Timer(0.1, function()
		if self.disposed then
			return
		end
		if m ~= nil or n == nil then
			self.timer = nil
			self:EnsureProfiles(self:Snapshot())
			return
		end
		return 0.1
	end)
end
function I.prototype.Calibrate(self, x)
	local a2 = {}
	for p, C in ipairs(x) do
		if s(nil, C.flags) then
			a2[o(nil, C.x, C.y)] = true
		end
	end
	local a3 = i(x, function(p, C)
		local S = self:Position(C.x, C.y)
		if
			h(self.protectedAreas, function(p, a4)
				return math.abs(S.x - a4.x) <= 192 and math.abs(S.y - a4.y) <= 192
			end)
		then
			return false
		end
		do
			local a5 = -3
			while a5 <= 3 do
				do
					local a6 = -3
					while a6 <= 3 do
						if not a2[o(nil, C.x + a5, C.y + a6)] then
							return false
						end
						a6 = a6 + 1
					end
				end
				a5 = a5 + 1
			end
		end
		return true
	end)
	if a3 == nil then
		self:Fail("no_clear_7x7_calibration_area")
		return
	end
	local a7 = { { x = 0, y = 0 }, { x = 32, y = 0 }, { x = 0, y = 32 }, { x = 32, y = 32 } }
	local y = {}
	local a8
	a8 = function(p, a9)
		if a9 >= #a7 then
			if #y == 0 then
				self:Fail("no_measurable_obstruction_footprint")
				return
			end
			m = y
			self:Apply(y)
			return
		end
		local aa = a7[a9 + 1]
		local ab = self:Position(a3.x, a3.y)
		self.probe = self:Create(Vector(ab.x + aa.x, ab.y + aa.y, ab.z))
		if self.probe == nil then
			self:Fail("obstruction_spawn_failed")
			return
		end
		self:WaitStable(function(p, ac)
			local ad = e(ac, function(p, C)
				return math.abs(C.x - a3.x) <= 3 and math.abs(C.y - a3.y) <= 3 and not s(nil, C.flags)
			end)
			local ae = h(ac, function(p, C)
				return a2[o(nil, C.x, C.y)]
					and not s(nil, C.flags)
					and (math.abs(C.x - a3.x) > 3 or math.abs(C.y - a3.y) > 3)
			end)
			local af = h(ad, function(p, C)
				return math.abs(C.x - a3.x) == 3 or math.abs(C.y - a3.y) == 3
			end)
			if self.probe ~= nil then
				self:Remove(self.probe)
			end
			self.probe = nil
			self:WaitStable(function(p, ag)
				if h(ag, function(p, C)
					return a2[o(nil, C.x, C.y)] and not s(nil, C.flags)
				end) then
					self:Fail("probe_did_not_restore_grid")
					return
				end
				if not ae and not af and #ad > 0 then
					y[#y + 1] = { phaseX = aa.x, phaseY = aa.y, cells = g(ad, function(p, C)
						return { x = C.x - a3.x, y = C.y - a3.y }
					end) }
				end
				a8(nil, a9 + 1)
			end)
		end)
	end
	a8(nil, 0)
end
function I.prototype.Apply(self, y)
	local ah = w(nil, self.baseline, y, function(p, q, r)
		return self:Target(q, r)
	end)
	local a9 = 0
	self.timer = Timer:Timer(0.1, function()
		if self.disposed then
			return
		end
		do
			local ai = 0
			while ai < 16 and a9 < #ah do
				local aj = ah[a9 + 1]
				local ab = self:Position(aj.x, aj.y)
				local R = self:Create(Vector(ab.x + aj.profile.phaseX, ab.y + aj.profile.phaseY, ab.z))
				if R == nil then
					self:Fail("obstruction_spawn_failed")
					return
				end
				local ak = self.owned
				ak[#ak + 1] = R
				do
					ai = ai + 1
					a9 = a9 + 1
				end
			end
		end
		if a9 < #ah then
			return 0.1
		end
		self.timer = nil
		self:WaitStable(function()
			return self:Verify()
		end)
	end)
end
function I.prototype.Verify(self)
	local x = self:Snapshot()
	local al = {}
	for p, C in ipairs(self.baseline) do
		al[o(nil, C.x, C.y)] = C.flags
	end
	self.report.extraRemaining = #e(x, function(p, C)
		return s(nil, C.flags) and u(nil, self:Target(C.x, C.y))
	end)
	self.report.missingRoads = #e(x, function(p, C)
		return not s(nil, C.flags) and self:Target(C.x, C.y) == 1
	end)
	self.report.unknownWalkable = #e(x, function(p, C)
		return s(nil, C.flags) and (self:Target(C.x, C.y) == 3 or self:Target(C.x, C.y) == nil)
	end)
	self.report.misblocked = #e(x, function(p, C)
		return s(nil, al[o(nil, C.x, C.y)]) and not s(nil, C.flags) and not u(nil, self:Target(C.x, C.y))
	end)
	if self.report.misblocked > 0 then
		self:Fail("misblocked_legal_or_unknown_cells_rolled_back")
		return
	end
	self.report.status = (
		self.report.extraRemaining > 0
		or self.report.missingRoads > 0
		or self.report.unknownWalkable > 0
	)
			and "partial"
		or "verified"
	self:Finish()
end
function I.prototype.Fail(self, P)
	if P == "misblocked_legal_or_unknown_cells_rolled_back" then
		m = nil
	end
	self:ClearOwned()
	self.report.status = "failed"
	self.report.reason = P
	self.report.extraRemaining = #e(self:Snapshot(), function(p, C)
		return s(nil, C.flags) and u(nil, self:Target(C.x, C.y))
	end)
	self:Finish()
end
function I.prototype.Finish(self)
	if self.disposed then
		return
	end
	self.report.obstructions = #self.owned
	print(
		(
			(
				(
					(
						(
							(
								(
									(
										(
											(
												(
													(
														(
															(
																(
																	("[GridNavPatch] status=" .. self.report.status)
																	.. " prefab="
																) .. self.report.prefab
															) .. " obstructions="
														) .. tostring(#self.owned)
													) .. " extraBefore="
												) .. tostring(self.report.extraBefore)
											) .. " extraRemaining="
										) .. tostring(self.report.extraRemaining)
									) .. " missingRoads="
								) .. tostring(self.report.missingRoads)
							) .. " unknownWalkable="
						) .. tostring(self.report.unknownWalkable)
					) .. " misblocked="
				) .. tostring(self.report.misblocked)
			) .. " reason="
		) .. (self.report.reason or "-")
	)
	if n == self then
		n = nil
	end
	local am = self.completion
	self.completion = nil
	if am ~= nil then
		am(nil)
	end
end
return j