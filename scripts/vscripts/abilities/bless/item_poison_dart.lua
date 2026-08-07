--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_dart"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_poison_dart"
d(k, j)
function k.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.entList = {}
end
function k.prototype.EventListener(self)
	return {
		poison_pool_event = function(l, m)
			if m.caster == self:GetCaster() then
				self:Summon(m.position)
			end
		end,
	}
end
function k.prototype.Summon(self, n)
	local o = self:GetCaster()
	local p = self:GetSpecialValueFor("duration")
	local q = self:GetSpecialValueFor("interval")
	local r = GetWispAttackspeed(o)
	local s = q / (1 + r / 100)
	local t = self:GetSpecialValueFor("speed")
	local u = self:GetSpecialValueFor("poison") * (1 + GetWispDamage(o) / 100)
	local v = SpawnEntityFromTableSynchronous(
		"dota_prop_customtexture",
		{
			angles = ("0 " .. tostring(RandomInt(0, 360))) .. " 0",
			model = "models/heroes/venomancer/venomancer_ward.vmdl",
			scales = "0.8 0.8 0.8",
			origin = n,
			StartingAnim = "ACT_DOTA_SPAWN",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		}
	)
	local w = { ent = v, attackTimer = DoUniqueString("item_poison_dart_attack") }
	local x = self.entList
	x[#x + 1] = w
	self:StartThink(s, w.attackTimer, function()
		if not IsValid(o) or not IsValid(v) then
			return -1
		end
		local y = FindEnemiesInRadius(o, v:GetAbsOrigin(), 900, FIND_CLOSEST)[1]
		if not IsValid(y) or not y:IsAlive() then
			if v:GetSequence() ~= "ward_idle_multi" then
				v:ResetSequence("ACT_DOTA_IDLE")
				v:SetSequence("ACT_DOTA_IDLE")
			end
			return s
		end
		local z = CalcDirection2D(y, v:GetAbsOrigin())
		v:SetLocalAngles(0, VectorToAngles(z).y, 0)
		v:ResetSequence("ACT_DOTA_ATTACK")
		v:SetSequence("ACT_DOTA_ATTACK")
		self:StartThink(0.4, DoUniqueString("item_poison_dart_projectile"), function()
			if not IsValid(o) or not IsValid(v) or not IsValid(y) or not y:IsAlive() then
				return -1
			end
			Bullet:CreateTrackingBullet({
				caster = o,
				ability = self,
				target = y,
				moveSpeed = t,
				effectName = "particles/units/heroes/hero_viper/viper_base_attack.vpcf",
				spawnOrigin = v:GetAbsOrigin() + Vector(0, 0, 96),
				OnBulletHit = function(y)
					o:Poison(y, u)
					return true
				end,
			})
			o:EmitSound("hero_viper.attack", v:GetAbsOrigin())
			return -1
		end)
		return s
	end)
	self:StartThink(p, DoUniqueString("item_poison_dart_duration"), function()
		self:RemoveSummon(w)
		return -1
	end)
end
function k.prototype.RemoveSummon(self, w)
	self:StartThink(-1, w.attackTimer)
	ArrayRemove(self.entList, w)
	if IsValid(w.ent) then
		w.ent:RemoveSelf()
	end
end
function k.prototype.OnDestroy(self)
	for l, w in ipairs(self.entList) do
		self:StartThink(-1, w.attackTimer)
		if IsValid(w.ent) then
			w.ent:RemoveSelf()
		end
	end
	self.entList = {}
end
k = e({ h(nil) }, k)
return f