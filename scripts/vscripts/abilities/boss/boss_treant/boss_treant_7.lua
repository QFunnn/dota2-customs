--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_treant/boss_treant_7"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayFilter
local g = b.__TS__ArrayIncludes
local h = {}
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("abilities.eom_ability")
local m = l.EOMAbility
local n = l.registerEOMAbility
local o = c()
o.name = "boss_treant_7"
d(o, m)
function o.prototype.OnAbilityPhaseStart(self)
	local p = self:GetCaster()
	p:AddNewModifier(p, self, "modifier_boss_treant_7", { duration = self:GetChannelTime() })
	p:EmitSound("Hero_Tiny.TreeChannel")
	return true
end
function o.prototype.OnChannelFinish(self, q)
	local p = self:GetCaster()
	p:RemoveModifierByName("modifier_boss_treant_7")
end
o = e({ n(nil, {}) }, o)
local r = c()
r.name = "modifier_boss_treant_7"
d(r, j)
function r.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.reservedTrees = {}
end
function r.prototype.GetAbilitySpecialValue(self)
	self.width = self:GetAbilitySpecialValueFor("width")
	self.speed = self:GetAbilitySpecialValueFor("speed")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
end
function r.prototype.OnCreated(self, s)
	local t = self:GetParent()
	if IsServer() then
		self:StartIntervalThink(self.interval)
	else
		local u = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tiny/tiny_tree_channel.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			t
		)
		ParticleManager:SetParticleControl(u, 2, Vector(525, 400, 1))
		self:AddParticle(u, false, false, -1, false, false)
	end
end
function r.prototype.OnIntervalThink(self)
	local t = self:GetParent()
	local v = self:GetAbility()
	local w = t:FindAbilityByName("boss_shredder_1")
	if v == nil then
		return
	end
	if w == nil then
		return
	end
	self.reservedTrees = f(self.reservedTrees, function(x, y)
		return IsValid(y) and y:IsAlive()
	end)
	local z = f(w.treeList, function(x, y)
		return IsValid(y) and y:IsAlive() and not g(self.reservedTrees, y)
	end)
	if #z == 0 then
		return
	end
	local A = GetRandomElement(z)
	if A == nil then
		return
	end
	local B = A:GetAbsOrigin()
	local C = FindEnemiesInRadius(t, B, 3000)
	if #C == 0 then
		return
	end
	local D = C[1]
	local E = CalcDirection2D(D:GetAbsOrigin(), B)
	local F = self.reservedTrees
	F[#F + 1] = A
	v:CircleWarning(B, self.width, 1)
	v:LineWarning(B, B + E * 3000, 100, 1)
	v:StartThink(1, function()
		self.reservedTrees = f(self.reservedTrees, function(x, y)
			return y ~= A and IsValid(y) and y:IsAlive()
		end)
		w:CutDownTree(A, false)
		t:EmitSound("n_mud_golem.Boulder.Cast", B)
		Bullet:CreateLinearBullet({
			caster = t,
			spawnOrigin = B,
			direction = E,
			moveSpeed = self.speed,
			distance = 3000,
			radius = self.width,
			reflectable = true,
			effectName = "particles/units/heroes/hero_tiny/tiny_tree_linear_proj.vpcf",
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			OnBulletHit = function(G)
				t:DealDamage(G, v, self.damage)
				t:EmitSound("Hero_Tiny_Tree.Impact", G:GetAbsOrigin())
			end,
		})
		return -1
	end)
end
r = e(
	{
		k(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	r
)
return h