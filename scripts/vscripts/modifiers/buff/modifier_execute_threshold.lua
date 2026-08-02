--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/buff/modifier_execute_threshold"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_execute_threshold"
d(j, h)
function j.prototype.OnCreated(self, k)
	if IsServer() then
		local l = self.parent:GetMaxHealth() * EXECUTE_THRESHOLD_MAX_HEALTH * 0.01
		self.execute_threshold = math.min(l, k.stack)
	end
end
function j.prototype.OnRefresh(self, k)
	if IsServer() then
		local l = self.parent:GetMaxHealth() * EXECUTE_THRESHOLD_MAX_HEALTH * 0.01
		self.execute_threshold = math.min(l, k.stack)
	end
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(m, n)
			local o = self:GetParent()
			local p = self.parent:GetHealth()
			if n.target == o and p <= self.execute_threshold then
				n.target:Kill(nil, n.attacker)
			end
		end,
	}
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