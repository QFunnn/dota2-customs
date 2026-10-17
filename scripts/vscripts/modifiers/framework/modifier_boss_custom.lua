--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_boss_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_boss_custom"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.controlImmune = false
end
function j.prototype.OnCreated(self, k)
	self.controlImmune = k.control_immune == 1
end
function j.prototype.OnRefresh(self, k)
	if k.control_immune == 1 then
		self.controlImmune = true
	end
end
function j.prototype.StaticState(self)
	local l = { [StateEnum.STUN_IMMUNE] = true, [StateEnum.KNOCKBACK_IMMUNE] = true }
	if self.controlImmune then
		l[StateEnum.CONTROL_IMMUNE] = true
	end
	return l
end
function j.prototype.CheckState(self)
	local l = { [MODIFIER_STATE_NO_HEALTH_BAR] = true }
	if self:GetParent():HasState(StateEnum.CONTROL_IMMUNE) then
		l[MODIFIER_STATE_UNSLOWABLE] = true
	end
	return l
end
j = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	j
)
return f