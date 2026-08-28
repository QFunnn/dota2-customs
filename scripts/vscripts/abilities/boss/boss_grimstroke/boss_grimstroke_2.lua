--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_grimstroke/boss_grimstroke_2"
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
k.name = "boss_grimstroke_2"
d(k, i)
function k.prototype.OnAbilityPhaseInterrupted(self)
	self:DestroyWarningParticles()
end
function k.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = CalcDirection2D(m, l:GetAbsOrigin())
	l:EmitSound("Hero_Grimstroke.preAttack")
	self:SectorWarning(l:GetAbsOrigin(), n, self:GetCastRange(vec3_zero, nil), 30, self:GetCastPoint())
	return true
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = CalcDirection2D(m, l:GetAbsOrigin())
	local o = self:GetSpecialValueFor("damage")
	l:EmitSound("Hero_Grimstroke.InkOver.Target")
	l:SimulateCast({
		castPoint = 0.25,
		duration = 1.45,
		castAnimation = ACT_SCRIPT_CUSTOM_4,
		OnSpellStart = function()
			do
				local p = 0
				while p < 10 do
					self:StartThink(0.5 / 10 * p, DoUniqueString("index"), function()
						Bullet:CreateGuidedBullet({
							caster = l,
							ability = self,
							spawnOrigin = l:GetAbsOrigin() + n * 350 + Vector(0, 0, 250),
							moveSpeed = self.speed,
							lifeTime = self:GetCastRange(vec3_zero, nil) / self.speed,
							effectName = "particles/units/heroes/hero_grimstroke/grimstroke_base_attack.vpcf",
							radius = 50,
							reflectable = true,
							direction = Rotation2D(n, RandomInt(-15, 15), true),
							OnBulletCreated = function(q)
								Bullet:SaveData(q.__projIndex, "count", 1)
							end,
							OnBulletThink = function(m, q)
								if Bullet:GetData(q.__projIndex, "count", 0) < 40 then
									Bullet:SaveData(
										q.__projIndex,
										"count",
										Bullet:GetData(q.__projIndex, "count", 0) + 1
									)
									local r, s = q.__position, "z"
									r[s] = r[s] - 5
								end
							end,
							OnBulletHit = function(t)
								l:DealDamage(t, self, o)
								l:EmitSound("Hero_Grimstroke.DarkArtistry.Damage.Creep")
							end,
						})
						return -1
					end)
					p = p + 1
				end
			end
		end,
	})
end
e({ h(nil) }, k.prototype, "speed", nil)
k = e({ j(nil) }, k)
return f