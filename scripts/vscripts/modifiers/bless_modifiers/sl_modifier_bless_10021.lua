--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10021.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10021.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:26",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:38",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "12:5",
		["22"] = "13:9",
		["23"] = "12:5",
		["24"] = "16:5",
		["25"] = "17:9",
		["26"] = "16:5",
		["27"] = "20:5",
		["28"] = "21:9",
		["29"] = "20:5",
		["30"] = "27:5",
		["31"] = "28:14",
		["34"] = "30:9",
		["35"] = "31:9",
		["36"] = "32:9",
		["37"] = "37:15",
		["38"] = "38:13",
		["39"] = "39:19",
		["40"] = "40:19",
		["41"] = "41:13",
		["42"] = "41:30",
		["43"] = "41:35",
		["44"] = "41:41",
		["45"] = "41:48",
		["46"] = "41:51",
		["47"] = "41:58",
		["48"] = "41:13",
		["50"] = "43:9",
		["51"] = "44:14",
		["52"] = "45:13",
		["53"] = "46:22",
		["54"] = "46:37",
		["56"] = "47:17",
		["57"] = "48:17",
		["58"] = "45:46",
		["60"] = "27:5",
		["61"] = "53:5",
		["62"] = "54:9",
		["63"] = "53:5",
		["64"] = "57:5",
		["65"] = "58:14",
		["68"] = "59:9",
		["69"] = "57:5",
		["70"] = "65:5",
		["71"] = "66:14",
		["74"] = "67:15",
		["75"] = "68:15",
		["76"] = "69:14",
		["77"] = "70:13",
		["78"] = "71:13",
		["80"] = "74:13",
		["81"] = "75:13",
		["83"] = "77:15",
		["84"] = "78:15",
		["85"] = "79:15",
		["86"] = "80:15",
		["87"] = "81:13",
		["88"] = "83:19",
		["89"] = "84:17",
		["90"] = "85:23",
		["91"] = "86:23",
		["92"] = "87:17",
		["95"] = "91:13",
		["97"] = "65:5",
		["98"] = "5:14",
		["99"] = "4:2",
		["100"] = "4:2",
		["101"] = "4:19",
		["102"] = "4:2",
		["104"] = "4:2",
		["105"] = "5:14",
		["107"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_MotionHorizontal = ____sl_modifier_base.SLModifierBase_MotionHorizontal
____exports.sl_modifier_bless_10021 = __TS__Class()
local sl_modifier_bless_10021 = ____exports.sl_modifier_bless_10021
sl_modifier_bless_10021.name = "sl_modifier_bless_10021"
__TS__ClassExtends(sl_modifier_bless_10021, SLModifierBase_MotionHorizontal)
function sl_modifier_bless_10021.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function sl_modifier_bless_10021.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10021.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10021.prototype.IsDebuff(self)
	return true
end
function sl_modifier_bless_10021.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._interval = StaticFrameTime
	self._radius = params.radius
	self._speed = params.speed
	local parent = self:GetParent()
	if parent:IsRealHero() then
		local caster = self:GetCaster()
		local pid =
			SParticleManager:CreateGenericParticle(GENERIC_PARTICLES.damage_dmgreduce, PATTACH_ABSORIGIN_FOLLOW, caster)
		self:AddParticle(pid, true, false, 1, false, false)
	end
	self:_Drag()
	if not Timers:IsValid(self._timer) then
		self._timer = Timers:CreateTimer(function()
			if not IsValid(self) then
				return nil
			end
			self:_Drag()
			return self._interval
		end)
	end
end
function sl_modifier_bless_10021.prototype.OnIntervalThink(self)
	self:_Drag()
end
function sl_modifier_bless_10021.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	Timers:RemoveTimer(self._timer)
end
function sl_modifier_bless_10021.prototype._Drag(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(caster) then
		self:Destroy()
		return nil
	end
	if parent:IsDebuffImmune() then
		return nil
	end
	local caster_pos = caster:GetAbsOrigin()
	local parent_pos = parent:GetAbsOrigin()
	local dir_vec = caster_pos:__sub(parent_pos)
	local distance = dir_vec:Length2D()
	if distance < self._radius then
		local min_radius = caster:GetModelRadius()
		if distance > min_radius then
			local direction = SLVector:Normalized2D(dir_vec)
			local drag_distance = self._speed * self._interval
			parent:SetAbsOrigin(parent_pos:__add(direction:__mul(drag_distance)))
		end
	else
		self:Destroy()
	end
end
sl_modifier_bless_10021 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10021", nil, getfenv()) },
	sl_modifier_bless_10021
)
____exports.sl_modifier_bless_10021 = sl_modifier_bless_10021
return ____exports