--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/_sl_ability_base.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
____debugRuntime.register(
	"abilities/_sl_ability_base.lua",
	{
		["9"] = "1:1",
		["10"] = "1:10",
		["11"] = "3:1",
		["12"] = "3:23",
		["13"] = "3:1",
		["14"] = "3:37",
		["15"] = "6:5",
		["16"] = "7:9",
		["17"] = "6:5",
		["18"] = "10:5",
		["19"] = "11:9",
		["20"] = "10:5",
		["21"] = "14:5",
		["22"] = "15:9",
		["23"] = "14:5",
		["24"] = "18:5",
		["25"] = "19:9",
		["26"] = "18:5",
		["27"] = "22:5",
		["28"] = "31:9",
		["29"] = "31:48",
		["30"] = "31:58",
		["31"] = "31:73",
		["32"] = "31:79",
		["33"] = "31:96",
		["34"] = "31:108",
		["35"] = "31:116",
		["36"] = "31:9",
		["37"] = "22:5",
		["38"] = "34:5",
		["39"] = "35:9",
		["40"] = "34:5",
		["41"] = "38:5",
		["42"] = "39:9",
		["43"] = "38:5",
		["44"] = "42:5",
		["45"] = "43:9",
		["46"] = "42:5",
		["47"] = "46:5",
		["48"] = "47:9",
		["49"] = "46:5",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
____exports.SLAbilityBase = __TS__Class()
local SLAbilityBase = ____exports.SLAbilityBase
SLAbilityBase.name = "SLAbilityBase"
__TS__ClassExtends(SLAbilityBase, BaseAbility)
function SLAbilityBase.prototype.CreateParticle(self, name, attach, owner)
	return SParticleManager:CreateAbilityParticle(self, name, attach, owner)
end
function SLAbilityBase.prototype.DestroyParticle(self, particle, immediate)
	SParticleManager:DestroyParticle(particle, immediate)
end
function SLAbilityBase.prototype.ReleaseParticleIndex(self, particle)
	SParticleManager:ReleaseParticleIndex(particle)
end
function SLAbilityBase.prototype.SetParticleControl(self, particle, control_point, value)
	SParticleManager:SetParticleControl(particle, control_point, value)
end
function SLAbilityBase.prototype.SetParticleControlEnt(
	self,
	particle,
	control_point,
	unit,
	particle_attach,
	attachment,
	offset,
	lock_orientation
)
	SParticleManager:SetParticleControlEnt(
		particle,
		control_point,
		unit,
		particle_attach,
		attachment,
		offset,
		lock_orientation
	)
end
function SLAbilityBase.prototype.SetParticleControlTransform(self, fx_index, point, origin, q_angles)
	SParticleManager:SetParticleControlTransform(fx_index, point, origin, q_angles)
end
function SLAbilityBase.prototype.SetParticleControlTransformForward(self, fx_index, point, origin, forward)
	SParticleManager:SetParticleControlTransformForward(fx_index, point, origin, forward)
end
function SLAbilityBase.prototype.SetParticleAlwaysSimulate(self, pid)
	SParticleManager:SetParticleAlwaysSimulate(pid)
end
function SLAbilityBase.prototype.AddStatusEffect(self, unit, effect)
	return SParticleManager:AddStatusEffect(unit, effect, 3, self)
end
return ____exports