--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
		self:StartIntervalThink(2)
	end
end
function k.prototype.OnRefresh(self, l)
	self.level = l.level
end
function k.prototype.OnIntervalThink(self)
	local m = self:GetParent()
	if not IsValid(m) or not m:IsAlive() then
		return
	end
	local n = KeyValues:GetKvAbilityValue(KeyValues.keys, "key_debuff_4", "heal_pct", self.level)
	if n > 0 then
		m:Heal(m:GetMaxHealth() * n * 0.01, nil)
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