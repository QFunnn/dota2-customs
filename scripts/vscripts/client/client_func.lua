--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local PARTICLE_PATHS = { DAMAGE_CRIT = GENERIC_PARTICLES.popup_crit }
local EFFECT_HANDLERS = {
	[1] = function(____, ent)
		local pid = ParticleManager:CreateParticle(GENERIC_PARTICLES.heart_strike, PATTACH_POINT_FOLLOW, ent)
		ParticleManager:SetParticleControlEnt(
			pid,
			0,
			ent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			ent:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(pid)
	end,
}
local NUMBER_TYPE_CONFIG = {
	[1] = {
		color = Vector(255, 215, 0),
		particlePath = PARTICLE_PATHS.DAMAGE_CRIT,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = 4,
		preSymbol = -1,
	},
	[2] = {
		color = Vector(POPUP_COLORS.SPELL_CRITICAL.r, POPUP_COLORS.SPELL_CRITICAL.g, POPUP_COLORS.SPELL_CRITICAL.b),
		particlePath = PARTICLE_PATHS.DAMAGE_CRIT,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = 4,
		preSymbol = -1,
	},
	[3] = {
		color = Vector(POPUP_COLORS.MANA.r, POPUP_COLORS.MANA.g, POPUP_COLORS.MANA.b),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = 0,
	},
	[4] = {
		color = Vector(POPUP_COLORS.GOLD.r, POPUP_COLORS.GOLD.g, POPUP_COLORS.GOLD.b),
		particlePath = GENERIC_PARTICLES.popup_gold,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 0,
	},
	[5] = {
		color = Vector(POPUP_COLORS.PHYSICAL_DAMAGE.r, POPUP_COLORS.PHYSICAL_DAMAGE.g, POPUP_COLORS.PHYSICAL_DAMAGE.b),
		particlePath = GENERIC_PARTICLES.popup_damage,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = -1,
	},
	[7] = {
		color = Vector(POPUP_COLORS.HEALING.r, POPUP_COLORS.HEALING.g, POPUP_COLORS.HEALING.b),
		particlePath = GENERIC_PARTICLES.popup_healing,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = 0,
	},
	[8] = {
		color = Vector(POPUP_COLORS.GOLD.r, POPUP_COLORS.GOLD.g, POPUP_COLORS.GOLD.b),
		particlePath = GENERIC_PARTICLES.popup_gold,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 1,
	},
	[9] = {
		color = Vector(POPUP_COLORS.MAGICAL_DAMAGE.r, POPUP_COLORS.MAGICAL_DAMAGE.g, POPUP_COLORS.MAGICAL_DAMAGE.b),
		particlePath = GENERIC_PARTICLES.popup_damage,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = -1,
	},
	[10] = {
		color = Vector(
			POPUP_COLORS.SPECIAL_PHYSICAL.r,
			POPUP_COLORS.SPECIAL_PHYSICAL.g,
			POPUP_COLORS.SPECIAL_PHYSICAL.b
		),
		particlePath = GENERIC_PARTICLES.popup_damage,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = 3,
	},
	[19] = {
		color = Vector(120, 0, 255),
		particlePath = GENERIC_PARTICLES.popup_damage,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = 3,
	},
	[11] = {
		color = Vector(0, 128, 64),
		particlePath = GENERIC_PARTICLES.popup_dot,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = 5,
		preSymbol = -1,
	},
	[12] = {
		color = Vector(255, 0, 0),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 0,
	},
	[13] = {
		color = Vector(255, 0, 0),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 1,
	},
	[14] = {
		color = Vector(0, 255, 0),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 0,
	},
	[15] = {
		color = Vector(0, 255, 0),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 1,
	},
	[16] = {
		color = Vector(15, 202, 235),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 0,
	},
	[17] = {
		color = Vector(15, 202, 235),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 1,
	},
	[18] = {
		color = Vector(POPUP_COLORS.BLOCK.r, POPUP_COLORS.BLOCK.g, POPUP_COLORS.BLOCK.b),
		particlePath = GENERIC_PARTICLES.popup_block,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = 7,
		preSymbol = 1,
	},
	[6] = {
		color = Vector(POPUP_COLORS.DOT_DAMAGE.r, POPUP_COLORS.DOT_DAMAGE.g, POPUP_COLORS.DOT_DAMAGE.b),
		particlePath = GENERIC_PARTICLES.popup_dot,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = 6,
		preSymbol = -1,
	},
}
____exports.ClientFunc = __TS__Class()
local ClientFunc = ____exports.ClientFunc
ClientFunc.name = "ClientFunc"
function ClientFunc.prototype.____constructor(self)
	self._client_particle_callback = { [2] = self._CreateDamageParticle, [1] = self._CreateEffect }
	ListenToGameEvent("client_game_events", function(keys)
		return self:_OnClientGameEvent(keys)
	end, nil)
end
function ClientFunc.prototype._OnClientGameEvent(self, keys)
	if not keys.data then
		return
	end
	local dataArr = __TS__StringSplit(keys.data, "&")
	for ____, str in ipairs(dataArr) do
		self:_HandleSingleData(str)
	end
end
function ClientFunc.prototype._HandleSingleData(self, str)
	local parts = __TS__StringSplit(str, ":")
	local dataType = tonumber(parts[1])
	local content = parts[2]
	local callback = self._client_particle_callback[dataType]
	if callback then
		callback(nil, content)
	end
end
function ClientFunc.prototype._CreateEffect(self, content)
	local args = __TS__StringSplit(content, ",")
	local entIndex = tonumber(args[1])
	local effectType = tonumber(args[2])
	local ent = EntIndexToHScript(entIndex)
	if not ent or not IsValid(ent) then
		return
	end
	local handler = EFFECT_HANDLERS[effectType]
	if handler then
		handler(nil, ent)
	end
end
function ClientFunc.prototype._CreateDamageParticle(self, content)
	local args = __TS__StringSplit(content, ",")
	local entIndex = tonumber(args[1])
	local ent = EntIndexToHScript(entIndex)
	local numType = tonumber(args[2])
	local num = tonumber(args[3])
	local config = NUMBER_TYPE_CONFIG[numType]
	if not config then
		return
	end
	local color = config.color
	local particlePath = config.particlePath
	local postSymbol = config.postSymbol
	local preSymbol = config.preSymbol
	local attachment = config.attachment
	local pIndex = ParticleManager:CreateParticle(particlePath, attachment, ent)
	ParticleManager:SetParticleControl(pIndex, 1, Vector(preSymbol, num, postSymbol))
	local len = #tostring(num)
	if preSymbol ~= -1 then
		len = len + 1
	end
	if postSymbol ~= -1 then
		len = len + 1
	end
	local duration = 3
	ParticleManager:SetParticleControl(pIndex, 2, Vector(duration, len, 0))
	ParticleManager:SetParticleControl(pIndex, 3, color)
	ParticleManager:ReleaseParticleIndex(pIndex)
end
__TS__New(____exports.ClientFunc)
return ____exports