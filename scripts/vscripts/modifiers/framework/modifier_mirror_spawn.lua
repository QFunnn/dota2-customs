--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_mirror_spawn"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifierMotionBoth
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_mirror_spawn"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		self.position = StringToVector(k.position)
		self.direction = CalcDirection2D(self.position, l)
		self.startTime = GameRules:GetGameTime()
		self.baseZ = l:GetAbsOrigin().z
		self.jumpDuration = self:GetDuration()
		self.jumpHeight = 160
		l:SetForwardVector(self.direction)
		local m = l:GetAbsOrigin()
		l:SetAbsOrigin(Vector(m.x, m.y, self.baseZ + self.jumpHeight))
		if not self:ApplyHorizontalMotionController() or not self:ApplyVerticalMotionController() then
			self:Destroy()
			return
		end
	end
end
function j.prototype.OnHorizontalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function j.prototype.OnVerticalMotionInterrupted(self)
	if IsServer() then
		self:Destroy()
	end
end
function j.prototype.UpdateVerticalMotion(self, n, o)
	if IsServer() then
		local p = GameRules:GetGameTime() - self.startTime
		if p >= self.jumpDuration then
			local m = n:GetAbsOrigin()
			n:SetAbsOrigin(Vector(m.x, m.y, self.baseZ))
			self:Destroy()
			return
		end
		local q = p / self.jumpDuration
		local r = self.jumpHeight * (1 - q)
		local m = n:GetAbsOrigin()
		n:SetAbsOrigin(Vector(m.x, m.y, self.baseZ + r))
	end
end
function j.prototype.UpdateHorizontalMotion(self, n, o)
	if IsServer() then
		n:SetAbsOrigin(n:GetAbsOrigin() + self.direction * 400 * o)
	end
end
function j.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_SPAWN }
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
j = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	j
)
return f