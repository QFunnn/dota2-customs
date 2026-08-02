--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_skeleton_king/boss_attack_combo1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_attack_combo1"
d(j, h)
function j.prototype.GetCastRange(self, k, l)
	return self:GetCaster():Script_GetAttackRange()
end
function j.prototype.OnAbilityPhaseStart(self)
	local m = self:GetCaster()
	local n = self:GetCursorPosition()
	local o = CalcDirection2D(n, m)
	self:SectorWarning(m:GetAbsOrigin(), o, m:Script_GetAttackRange(), 120, self:GetCastPoint())
	return true
end
function j.prototype.OnSpellStart(self)
	local m = self:GetCaster()
	local p = m:GetAbsOrigin()
	local n = self:GetCursorPosition()
	local o = CalcDirection2D(n, m)
	local q = self:GetSpecialValueFor("damage")
	m:Dash(o, 50, 0, 0.06, function(n)
		m:PushOff(n)
	end)
	local r = FindEnemiesInSector(m, p, m:Script_GetAttackRange(), o, 120)
	m:DealDamage(r, nil, q)
	m:StartGesture(ACT_SCRIPT_CUSTOM_8)
	m:SimulateCast({ orderType = DOTA_UNIT_ORDER_CAST_POSITION, position = n, duration = 0.4 })
	self:StartThink(0.4, function()
		m:FadeGesture(ACT_SCRIPT_CUSTOM_8)
		m:ExecuteOrder(DOTA_UNIT_ORDER_CAST_POSITION, m:FindAbilityByName("boss_attack_combo2"), n)
		return -1
	end)
	m:EmitSound("Hero_SkeletonKing.Attack")
end
j = e({ i(nil) }, j)
return f