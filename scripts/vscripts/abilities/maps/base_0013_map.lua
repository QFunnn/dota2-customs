--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/maps/base_0013_map"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["14"] = 3,
		["15"] = 8,
		["16"] = 9,
		["17"] = 3,
		["18"] = 11,
		["19"] = 12,
		["20"] = 13,
		["21"] = 14,
		["22"] = 15,
		["23"] = 16,
		["24"] = 11,
		["25"] = 18,
		["26"] = 19,
		["27"] = 20,
		["29"] = 22,
		["30"] = 22,
		["31"] = 22,
		["32"] = 22,
		["33"] = 22,
		["34"] = 22,
		["35"] = 22,
		["36"] = 22,
		["37"] = 22,
		["38"] = 22,
		["39"] = 22,
		["40"] = 18,
		["41"] = 31,
		["42"] = 32,
		["43"] = 33,
		["45"] = 35,
		["46"] = 35,
		["47"] = 35,
		["48"] = 35,
		["49"] = 35,
		["50"] = 35,
		["51"] = 35,
		["52"] = 35,
		["53"] = 35,
		["54"] = 35,
		["55"] = 35,
		["56"] = 35,
		["57"] = 35,
		["58"] = 45,
		["59"] = 46,
		["60"] = 31,
		["61"] = 48,
		["62"] = 49,
		["63"] = 50,
		["64"] = 51,
		["65"] = 52,
		["66"] = 53,
		["67"] = 54,
		["69"] = 56,
		["70"] = 57,
		["71"] = 58,
		["73"] = 60,
		["76"] = 63,
		["77"] = 64,
		["78"] = 65,
		["79"] = 66,
		["81"] = 68,
		["82"] = 69,
		["84"] = 71,
		["85"] = 48,
		["86"] = 73,
		["87"] = 74,
		["90"] = 77,
		["91"] = 78,
		["93"] = 73,
		["94"] = 81,
		["95"] = 82,
		["96"] = 83,
		["98"] = 81,
		["99"] = 86,
		["100"] = 87,
		["101"] = 88,
		["103"] = 86,
	}
)
local f = {}
local g = require("abilities.maps.map_base")
local h = g.MapBase
f.base_0013_map = c()
local i = f.base_0013_map
i.name = "base_0013_map"
d(i, h)
function i.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.IdleLoopTime = 120
	self.VictoryTime = 15
end
function i.prototype.spawn(self)
	self.lastQAngle = VectorToAngles(vec3_bottom)
	self.IdleStartTime = GameRules:GetGameTime()
	self:StartIdle()
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END, self.OnBattleEnd)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END, self.OnBattleEndStateEnd)
end
function i.prototype.StartIdle(self)
	if IsValid(self.ent) then
		self.ent:RemoveSelf()
	end
	self.ent = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = GetGroundPosition(self.position, nil),
			model = "models/eom/props/base_0013_map/base_0013_map_3.vmdl",
			DefaultAnim = "ACT_DOTA_IDLE",
			use_animgraph = "1",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			angles = self:GetQAngle("idle"),
		}
	)
end
function i.prototype.Victory(self)
	if IsValid(self.ent) then
		self.ent:RemoveSelf()
	end
	self.ent = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{
			origin = GetGroundPosition(self.position, nil),
			model = "models/eom/props/base_0013_map/base_0013_map_3.vmdl",
			StartingAnim = "ACT_DOTA_VICTORY",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_USE_SEQUENCE_SETTINGS",
			DefaultAnim = "ACT_DOTA_IDLE",
			use_animgraph = "1",
			AnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			angles = self:GetQAngle("victory"),
		}
	)
	local j = PlayerResource:GetSelectedHeroEntity(self.playerID)
	EmitSoundOnLocationWithCaster(self.position, "Hero_RingMaster.TheWheel.Projectile", j)
end
function i.prototype.GetQAngle(self, k)
	local l = GameRules:GetGameTime()
	local m = l
	local n = 0
	if self.IdleStartTime then
		m = m - self.IdleStartTime
		n = m / self.IdleLoopTime * 100 % 100
	else
		m = m - self.VictoryStartTime
		if m > self.VictoryTime then
			n = (m - self.VictoryTime) / self.IdleLoopTime * 100 % 100
		else
			n = m / self.VictoryTime * 100
		end
	end
	self.lastQAngle.y = (self.lastQAngle.y + n * 0.01 * 360) % 360
	if k == "idle" then
		self.IdleStartTime = l
		self.VictoryStartTime = nil
	else
		self.IdleStartTime = nil
		self.VictoryStartTime = l
	end
	return self.lastQAngle
end
function i.prototype.OnBattleEnd(self, o)
	if o.isNeutral ~= nil then
		return
	end
	if o.illusionPlayerID ~= self.playerID and o.winPlayerID == self.playerID then
		self:Victory()
	end
end
function i.prototype.OnBattleEndStateEnd(self)
	if self.VictoryStartTime ~= nil then
		self:StartIdle()
	end
end
function i.prototype.dispose(self)
	if IsValid(self.ent) then
		UTIL_Remove(self.ent)
	end
end
return f