--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/spawn/modifier_boss_jakiro"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_boss_jakiro"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self:GetParent()
		l:StartGesture(ACT_SCRIPT_CUSTOM_1)
		self:StartThink(0, function()
			l:SetForwardVector(vec3_bottom)
			return -1
		end)
		self:StartThink(0.8, function()
			l:FadeGesture(ACT_SCRIPT_CUSTOM_1)
			l:StartGesture(ACT_SCRIPT_CUSTOM_2)
			l:EmitSound("Hero_Jakiro.Macropyre.Cast")
			return -1
		end)
		self:SetDuration(4, true)
	end
end
function j.prototype.OnDestroy(self)
	if IsServer() then
	end
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.AVOID_DAMAGE] = 1 }
end
function j.prototype.StaticState(self)
	return { [StateEnum.NO_HEALTH_BAR] = true }
end
function j.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_INVULNERABLE] = true }
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
				RemoveOnDeath = true,
			}
		),
	},
	j
)
return f