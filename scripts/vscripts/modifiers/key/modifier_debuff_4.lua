--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/key/modifier_debuff_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.TransmitterData
local j = g.registerEOMModifier
local k = c()
k.name = "modifier_debuff_4"
d(k, h)
function k.prototype.OnCreated(self, l)
	self.level = l.level
	if IsServer() then
		self:StartHealInterval()
	end
end
function k.prototype.OnRefresh(self, l)
	self.level = l.level
	if IsServer() then
		self:StartHealInterval()
	end
end
function k.prototype.StartHealInterval(self)
	local m = KeyValues:GetKvAbilityValue(KeyValues.keys, "key_debuff_4", "cd", self.level)
	self:StartIntervalThink(m > 0 and m or -1)
end
function k.prototype.OnIntervalThink(self)
	local n = self:GetParent()
	if not IsValid(n) or not n:IsAlive() then
		return
	end
	local o = KeyValues:GetKvAbilityValue(KeyValues.keys, "key_debuff_4", "heal_pct", self.level)
	if o > 0 then
		n:Heal(n:GetMaxHealth() * o * 0.01, nil)
	end
end
e({ i(nil) }, k.prototype, "level", nil)
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	k
)
return f