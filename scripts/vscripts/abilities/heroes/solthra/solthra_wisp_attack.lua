--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/solthra/solthra_wisp_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.BaseAbility
local i = g.registerAbility
local j = c()
j.name = "solthra_wisp_attack"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.AOETick = 0
end
function j.prototype.ProcsMagicStick(self)
	return false
end
function j.prototype.GetCooldown(self, k)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function j.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function j.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function j.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorTarget()
	if not IsValid(m) then
		return
	end
	local n = l:GetPlayerOwnerID()
	local o = PlayerResource:GetSelectedHeroEntity(n)
	if not IsValid(o) then
		return
	end
	local p = o and o:FindAbilityByName("solthra_attack")
	if not p then
		return
	end
	local q = p:GetSpecialValueFor("interval")
	local r = GameRules:GetGameTime()
	local s = r - self.AOETick
	local t = s >= q
	if t then
		self.AOETick = r
	end
	local u = o:GetAttackDamage()
	if p.StartAttack then
		p:StartAttack({ caster = l, position = m:GetAbsOrigin(), isAOEAttack = t, damage = u })
	end
	Event:Fire("attack_event", { attacker = l, position = m and m:GetAbsOrigin() })
end
j = e({ i(nil) }, j)
return f