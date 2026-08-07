--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/key/modifier_debuff_2"
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
k.name = "modifier_debuff_2"
d(k, h)
function k.prototype.OnCreated(self, l)
	self.level = l.level
	if IsServer() then
		self:ApplyShield()
		self:Destroy()
	end
end
function k.prototype.ApplyShield(self)
	local m = self:GetParent()
	if not m:HasModifier("modifier_boss_custom") then
		return
	end
	local n = KeyValues:GetKvAbilityValue(KeyValues.keys, "key_debuff_2", "shield_pct", self.level)
	if n > 0 then
		m:AddShield(m:GetMaxHealth() * n * 0.01, "key_debuff_2", "add", "permanent")
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