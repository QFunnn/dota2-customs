--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_grimstroke/boss_grimstroke_1"
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
k.name = "boss_grimstroke_1"
d(k, i)
function k.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function k.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = CalcDirection2D(m, l:GetAbsOrigin())
	l:EmitSound("Hero_Grimstroke.preAttack")
	self:SectorWarning(l:GetAbsOrigin(), n, self:GetCastRange(vec3_zero, nil), 50, self:GetCastPoint())
	return true
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = CalcDirection2D(m, l:GetAbsOrigin())
	local o = l:GetAbsOrigin()
	local p = self:GetSpecialValueFor("damage")
	l:SimulateCast({
		castPoint = 0.19,
		duration = 2.31,
		castAnimation = ACT_SCRIPT_CUSTOM_2,
		OnSpellStart = function()
			Bullet:SplitAction(n, 5, 10, function(q, r, s)
				self:StartThink(0.1 * s, DoUniqueString("index"), function()
					Bullet:CreateGuidedBullet({
						caster = l,
						ability = self,
						spawnOrigin = l:GetAbsOrigin() + Rotation2D(n, 10 * (s - 3), true) * 250 + Vector(0, 0, 45),
						moveSpeed = self.speed,
						lifeTime = self:GetCastRange(vec3_zero, nil) / self.speed,
						effectName = "particles/units/heroes/hero_grimstroke/grimstroke_base_attack.vpcf",
						radius = 50,
						reflectable = true,
						direction = r,
						OnBulletHit = function(t)
							l:DealDamage(t, self, p)
							l:EmitSound("Hero_Grimstroke.Attack")
						end,
					})
					l:EmitSound("Hero_Grimstroke.DarkArtistry.Damage.Creep")
					return -1
				end)
			end)
		end,
	})
end
e({ h(nil) }, k.prototype, "speed", nil)
k = e({ j(nil) }, k)
return f