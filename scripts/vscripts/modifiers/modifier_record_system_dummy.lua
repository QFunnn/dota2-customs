--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/modifier_record_system_dummy"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 3,
		["13"] = 11,
		["14"] = 3,
		["15"] = 11,
		["16"] = 12,
		["17"] = 13,
		["18"] = 14,
		["19"] = 12,
		["20"] = 16,
		["21"] = 17,
		["22"] = 18,
		["24"] = 16,
		["25"] = 21,
		["26"] = 22,
		["27"] = 22,
		["28"] = 22,
		["29"] = 22,
		["30"] = 22,
		["31"] = 22,
		["32"] = 22,
		["33"] = 22,
		["34"] = 22,
		["35"] = 22,
		["36"] = 21,
		["37"] = 33,
		["38"] = 34,
		["39"] = 33,
		["40"] = 40,
		["41"] = 41,
		["42"] = 43,
		["43"] = 40,
		["44"] = 45,
		["45"] = 46,
		["46"] = 48,
		["47"] = 49,
		["48"] = 50,
		["50"] = 45,
		["51"] = 53,
		["52"] = 54,
		["53"] = 56,
		["54"] = 57,
		["55"] = 58,
		["57"] = 53,
		["58"] = 11,
		["59"] = 3,
		["60"] = 3,
		["61"] = 3,
		["62"] = 3,
		["63"] = 3,
		["64"] = 3,
		["65"] = 3,
		["66"] = 3,
		["67"] = 11,
		["69"] = 11,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_record_system_dummy = c()
local l = h.modifier_record_system_dummy
l.name = "modifier_record_system_dummy"
d(l, j)
function l.prototype.OnCreated(self, m)
	local n = self:GetParent()
	n.iLastRecord = 0
end
function l.prototype.OnDestroy(self)
	if IsServer() then
		self:GetParent():RemoveSelf()
	end
end
function l.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
function l.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ATTACK_RECORD, MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY, MODIFIER_EVENT_ON_TAKEDAMAGE }
end
function l.prototype.OnAttackRecord(self, m)
	self:GetParent().iLastRecord = m.record
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK_RECORD, m, m.attacker, m.target)
end
function l.prototype.OnAttackRecordDestroy(self, m)
	FireModifierEvent(MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY, m, m.attacker, m.target)
	local n = self:GetParent()
	if n.ATTACK_SYSTEM ~= nil then
		e(n.ATTACK_SYSTEM, m.record)
	end
end
function l.prototype.OnTakeDamage(self, m)
	FireModifierEvent(MODIFIER_EVENT_ON_TAKEDAMAGE, m, m.attacker, m.unit)
	local n = self:GetParent()
	if n.DAMAGE_SYSTEM ~= nil then
		e(n.DAMAGE_SYSTEM, m.record)
	end
end
l = f(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	l
)
h.modifier_record_system_dummy = l
return h