--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/modifier_player_data"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 10,
		["13"] = 3,
		["14"] = 10,
		["16"] = 10,
		["17"] = 11,
		["18"] = 12,
		["19"] = 3,
		["20"] = 13,
		["21"] = 14,
		["22"] = 15,
		["23"] = 16,
		["24"] = 18,
		["25"] = 19,
		["26"] = 21,
		["27"] = 22,
		["28"] = 23,
		["30"] = 25,
		["33"] = 28,
		["34"] = 13,
		["35"] = 30,
		["36"] = 31,
		["37"] = 32,
		["39"] = 30,
		["40"] = 35,
		["41"] = 36,
		["42"] = 37,
		["45"] = 42,
		["47"] = 44,
		["48"] = 35,
		["49"] = 46,
		["50"] = 47,
		["52"] = 48,
		["53"] = 48,
		["54"] = 49,
		["55"] = 50,
		["56"] = 51,
		["57"] = 52,
		["58"] = 53,
		["60"] = 55,
		["61"] = 56,
		["62"] = 57,
		["65"] = 48,
		["68"] = 61,
		["69"] = 62,
		["70"] = 63,
		["72"] = 46,
		["73"] = 66,
		["74"] = 67,
		["75"] = 68,
		["77"] = 66,
		["78"] = 71,
		["79"] = 72,
		["80"] = 72,
		["81"] = 72,
		["82"] = 72,
		["83"] = 72,
		["84"] = 72,
		["85"] = 72,
		["86"] = 72,
		["87"] = 72,
		["88"] = 72,
		["89"] = 72,
		["90"] = 71,
		["91"] = 84,
		["92"] = 85,
		["93"] = 84,
		["94"] = 89,
		["95"] = 90,
		["96"] = 89,
		["97"] = 10,
		["98"] = 3,
		["99"] = 3,
		["100"] = 3,
		["101"] = 3,
		["102"] = 3,
		["103"] = 3,
		["104"] = 3,
		["105"] = 10,
		["107"] = 10,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_player_data = c()
local k = g.modifier_player_data
k.name = "modifier_player_data"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.precache_index = 0
	self.precache_step = 255
end
function k.prototype.GetTexture(self)
	if _G.GetPlayerData_PlayerID ~= nil then
		local l = _G.GetPlayerData_PlayerID
		local m = _G.GetPlayerData_FunctionName
		_G.GetPlayerData_PlayerID = nil
		_G.GetPlayerData_FunctionName = ""
		local n = _G[m]
		if type(n) == "function" then
			return tostring(n(l))
		else
			return ""
		end
	end
	return ""
end
function k.prototype.OnCreated(self, o)
	if IsInToolsMode() then
		self:StartDynamicPrecacheVPCF()
	end
end
function k.prototype.StartDynamicPrecacheVPCF(self)
	self.precache_index = 0
	if IsServer() then
		return
	else
		self.precache_step = 100
	end
	self:StartIntervalThink(0.1)
end
function k.prototype.OnIntervalThink(self)
	local p = tPrecacheList.particle
	do
		local q = self.precache_index
		while q < self.precache_index + self.precache_step do
			if p[q + 1] then
				if IsServer() then
					local r =
						ParticleManager:CreateParticleForTeam(p[q + 1], PATTACH_CUSTOMORIGIN, nil, DOTA_TEAM_NEUTRALS)
					ParticleManager:DestroyParticle(r, true)
					ParticleManager:ReleaseParticleIndex(r)
				else
					local r = ParticleManager:CreateParticle(p[q + 1], PATTACH_CUSTOMORIGIN, nil)
					ParticleManager:DestroyParticle(r, true)
					ParticleManager:ReleaseParticleIndex(r)
				end
			end
			q = q + 1
		end
	end
	self.precache_index = self.precache_index + self.precache_step
	if self.precache_index >= #p then
		self:StartIntervalThink(-1)
	end
end
function k.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():Remove()
	end
end
function k.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROVIDES_FOW_POSITION }
end
function k.prototype.GetModifierProvidesFOWVision(self)
	return 1
end
k = e(
	{ j(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	k
)
g.modifier_player_data = k
return g