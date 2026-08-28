--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_axe/boss_axe_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.AbilityValue
local i = g.EOMAbility
local j = g.registerEOMAbility
local k = c()
k.name = "boss_axe_2"
d(k, i)
function k.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = CalcDirection2D(m, l:GetAbsOrigin())
	l:EmitSound("Hero_Axe.PreAttack")
	self:SectorWarning(l:GetAbsOrigin(), n, self.radius, 120, self:GetCastPoint())
	return true
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = CalcDirection2D(m, l:GetAbsOrigin())
	local o = l:GetAbsOrigin()
	local p = self:GetSpecialValueFor("damage")
	l:Dash(n, 100, 0, 0.06, function(m)
		l:PushOff(m)
	end)
	l:SimulateCast({
		castPoint = 0.1,
		duration = 0.83,
		castAnimation = ACT_SCRIPT_CUSTOM_4,
		OnSpellStart = function()
			local q = FindEnemiesInSector(l, o, self.radius, n, 120)
			l:DealDamage(q, self, p)
			l:EmitSound("Hero_Axe.Attack")
		end,
		OnFinish = function()
			l:FadeGesture(ACT_SCRIPT_CUSTOM_4)
		end,
	})
end
e({ h(nil) }, k.prototype, "radius", nil)
k = e({ j(nil) }, k)
return f