--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/performance_profiler"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__NumberToFixed
local f = b.__TS__DecorateLegacy
local g = b.__TS__New
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = c()
k.name = "MBlessPerformanceProfiler"
d(k, CModule)
function k.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.Enabled = false
	self.reportInterval = 5
	self.windowStart = 0
	self.propertyReadsStart = 0
	self.metrics = {}
	self.damageDepth = 0
	self.damageRootTimeMs = 0
	self.bulletUpdateTimeMs = 0
	self.bulletUpdateFrames = 0
	self.damageFrameTime = -1
	self.damageCallsThisFrame = 0
	self.maxDamageCallsPerFrame = 0
end
function k.prototype.init(self, l)
	if not l and IsInToolsMode() then
		self:RegisterCommands()
	end
end
function k.prototype.IsEnabled(self)
	return self.Enabled
end
function k.prototype.Increment(self, m, n)
	if n == nil then
		n = 1
	end
	if not self.Enabled then
		return
	end
	self.metrics[m] = (self.metrics[m] or 0) + n
end
function k.prototype.BeginDamage(self)
	if not self.Enabled then
		return -1
	end
	self:Increment("damage_calls")
	local o = GameRules:GetGameTime()
	if o ~= self.damageFrameTime then
		self.damageFrameTime = o
		self.damageCallsThisFrame = 0
	end
	self.damageCallsThisFrame = self.damageCallsThisFrame + 1
	self.maxDamageCallsPerFrame = math.max(self.maxDamageCallsPerFrame, self.damageCallsThisFrame)
	local p = self.damageDepth == 0
	self.damageDepth = self.damageDepth + 1
	return p and Plat_FloatTime() or -1
end
function k.prototype.EndDamage(self, q)
	if not self.Enabled then
		return
	end
	self.damageDepth = math.max(0, self.damageDepth - 1)
	if q >= 0 then
		self.damageRootTimeMs = self.damageRootTimeMs + (Plat_FloatTime() - q) * 1000
	end
end
function k.prototype.BeginBulletUpdate(self)
	return self.Enabled and Plat_FloatTime() or -1
end
function k.prototype.EndBulletUpdate(self, r)
	if not self.Enabled or r < 0 then
		return
	end
	self.bulletUpdateTimeMs = self.bulletUpdateTimeMs + (Plat_FloatTime() - r) * 1000
	self.bulletUpdateFrames = self.bulletUpdateFrames + 1
end
function k.prototype.Start(self, s)
	self:StopTimer()
	self.Enabled = true
	self.reportInterval = math.max(1, math.min(s, 30))
	self:ResetWindow()
	self.reportTimer = Timer:GameTimer(self.reportInterval, function()
		if not self.Enabled then
			return
		end
		self:Report()
		self:ResetWindow()
		return self.reportInterval
	end)
	print(("[BlessPerf] started; interval=" .. e(self.reportInterval, 1)) .. "s")
end
function k.prototype.Stop(self)
	if not self.Enabled then
		print("[BlessPerf] is not running")
		return
	end
	self:Report()
	self.Enabled = false
	self:StopTimer()
	self.damageDepth = 0
	print("[BlessPerf] stopped")
end
function k.prototype.Report(self)
	if not self.Enabled then
		return
	end
	local t = math.max(Plat_FloatTime() - self.windowStart, 0.001)
	local u = math.max(0, (PropertyData and PropertyData.stats.totalReads or 0) - self.propertyReadsStart)
	local v = Bullet:GetPerformanceSnapshot()
	local function w(x, y)
		return self.metrics[y] or 0
	end
	local function z(x, A)
		return e(A / t, 1)
	end
	local B = self.bulletUpdateFrames > 0 and self.bulletUpdateTimeMs / self.bulletUpdateFrames or 0
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
																	(
																		("[BlessPerf] sec=" .. e(t, 2))
																		.. (((((" damage=" .. tostring(
																			w(nil, "damage_calls")
																		)) .. "(") .. z(
																			nil,
																			w(nil, "damage_calls")
																		)) .. "/s,maxFrame=") .. tostring(
																			self.maxDamageCallsPerFrame
																		))
																		.. ")"
																	)
																	.. " resolved="
																	.. tostring(w(nil, "damage_resolved"))
																)
																.. " damageRootMs="
																.. e(self.damageRootTimeMs, 2)
															)
															.. " crit="
															.. tostring(w(nil, "crit_events"))
														)
														.. ((" critAggregate=" .. tostring(w(nil, "zeus_crit_queued"))) .. "/")
														.. tostring(w(nil, "zeus_crit_aggregated_strikes"))
													)
													.. ((" arc=" .. tostring(w(nil, "arc_calls"))) .. "/")
													.. tostring(w(nil, "arc_hits"))
												)
												.. " arcParticles="
												.. tostring(w(nil, "arc_particles"))
											)
											.. " strike="
											.. tostring(w(nil, "lightning_requests"))
										)
										.. " droppedHits="
										.. tostring(w(nil, "lightning_dropped"))
									)
									.. " aoeHits="
									.. tostring(w(nil, "lightning_aoe_hits"))
								)
								.. " lightningParticles="
								.. tostring(w(nil, "lightning_particles"))
							)
							.. (((" propertyReads=" .. tostring(u)) .. "(") .. z(nil, u))
							.. "/s)"
						)
						.. ((" events=" .. tostring(w(nil, "event_fires"))) .. "/")
						.. tostring(w(nil, "event_listener_calls"))
					)
					.. (((((((((((((((((" bullets=" .. tostring(v.total)) .. "[cache") .. tostring(v.cachedTotal)) .. ",L") .. tostring(
						v.linear
					)) .. ",T") .. tostring(v.tracking)) .. ",G") .. tostring(v.guided)) .. ",R") .. tostring(
						v.ring
					)) .. ",S") .. tostring(v.surround)) .. ",C") .. tostring(v.custom)) .. ",groups") .. tostring(
						v.groups
					))
					.. "]"
				)
				.. ((" bulletCreateDestroy=" .. tostring(w(nil, "bullet_created"))) .. "/")
				.. tostring(w(nil, "bullet_destroyed"))
			)
			.. (((" bulletMs=" .. e(self.bulletUpdateTimeMs, 2)) .. "(avg=") .. e(B, 3))
			.. ")"
		)
			.. ((" expose=" .. tostring(w(nil, "expose_effects"))) .. "/")
			.. tostring(w(nil, "expose_ticks"))
	)
end
function k.prototype.RegisterCommands(self)
	Convars:RegisterCommand("bless_perf_start", function(C, ...)
		local D = { ... }
		self:Start(toFiniteNumber(D[1], 5))
	end, "Start Zeus/Crit performance profiling: bless_perf_start [report_interval=5]", 0)
	Convars:RegisterCommand("bless_perf_stop", function()
		self:Stop()
	end, "Stop Zeus/Crit performance profiling and print the final window", 0)
	Convars:RegisterCommand("bless_perf_report", function()
		self:Report()
	end, "Print the current Zeus/Crit performance profiling window", 0)
end
function k.prototype.ResetWindow(self)
	self.metrics = {}
	self.windowStart = Plat_FloatTime()
	self.propertyReadsStart = PropertyData and PropertyData.stats.totalReads or 0
	self.damageRootTimeMs = 0
	self.bulletUpdateTimeMs = 0
	self.bulletUpdateFrames = 0
	self.damageFrameTime = -1
	self.damageCallsThisFrame = 0
	self.maxDamageCallsPerFrame = 0
end
function k.prototype.StopTimer(self)
	if self.reportTimer ~= nil then
		Timer:StopTimer(self.reportTimer)
		self.reportTimer = nil
	end
end
k = f({ j }, k)
if BlessPerformance == nil then
	BlessPerformance = g(k)
end
return h