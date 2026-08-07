--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10021") },
	sl_modifier_bless_10021
)
____exports.sl_modifier_bless_10021 = sl_modifier_bless_10021
return ____exports