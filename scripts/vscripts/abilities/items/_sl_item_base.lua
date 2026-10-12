--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/_sl_item_base.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
____debugRuntime.register(
	"abilities/items/_sl_item_base.lua",
	{
		["9"] = "1:1",
		["10"] = "1:10",
		["11"] = "3:1",
		["12"] = "3:23",
		["13"] = "3:1",
		["14"] = "3:34",
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
local BaseItem = ____dota_ts_adapter.BaseItem
____exports.SLItemBase = __TS__Class()
local SLItemBase = ____exports.SLItemBase
SLItemBase.name = "SLItemBase"
__TS__ClassExtends(SLItemBase, BaseItem)
function SLItemBase.prototype.CreateParticle(self, name, attach, owner)
	return SParticleManager:CreateItemParticle(self, name, attach, owner)
end
function SLItemBase.prototype.DestroyParticle(self, particle, immediate)
	SParticleManager:DestroyParticle(particle, immediate)
end
function SLItemBase.prototype.ReleaseParticleIndex(self, particle)
	SParticleManager:ReleaseParticleIndex(particle)
end
function SLItemBase.prototype.SetParticleControl(self, particle, control_point, value)
	SParticleManager:SetParticleControl(particle, control_point, value)
end
function SLItemBase.prototype.SetParticleControlEnt(
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
function SLItemBase.prototype.SetParticleControlTransform(self, fx_index, point, origin, q_angles)
	SParticleManager:SetParticleControlTransform(fx_index, point, origin, q_angles)
end
function SLItemBase.prototype.SetParticleControlTransformForward(self, fx_index, point, origin, forward)
	SParticleManager:SetParticleControlTransformForward(fx_index, point, origin, forward)
end
function SLItemBase.prototype.SetParticleAlwaysSimulate(self, pid)
	SParticleManager:SetParticleAlwaysSimulate(pid)
end
function SLItemBase.prototype.AddStatusEffect(self, unit, effect)
	return SParticleManager:AddStatusEffect(unit, effect, 2, self)
end
return ____exports