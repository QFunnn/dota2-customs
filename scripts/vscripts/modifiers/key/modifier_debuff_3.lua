--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/key/modifier_debuff_3"
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
k.name = "modifier_debuff_3"
d(k, h)
function k.prototype.OnCreated(self, l)
	self.level = l.level
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function k.prototype.GetModifierIncomingDamage_Percentage(self, l)
	local m
	if l ~= nil then
		m = l.attacker
	end
	local n = m
	if not IsValid(n) then
		return 0
	end
	local o = self:GetParent()
	local p = KeyValues:GetKvAbilityValue(KeyValues.keys, "key_debuff_3", "angle", self.level)
	local q = KeyValues:GetKvAbilityValue(KeyValues.keys, "key_debuff_3", "reduce_damage_pct", self.level)
	if p <= 0 or q <= 0 then
		return 0
	end
	local r = (n:GetAbsOrigin() - o:GetAbsOrigin()):Normalized()
	local s = o:GetForwardVector():Normalized()
	local t = s.x * r.x + s.y * r.y + s.z * r.z
	if t >= math.cos(math.rad(p * 0.5)) then
		return -q
	end
	return 0
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