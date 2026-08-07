--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_lion/boss_lion_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMAbility
local i = g.registerEOMAbility
local j = c()
j.name = "boss_lion_3"
d(j, h)
function j.prototype.OnAbilityPhaseStart(self)
	local k = self:GetCaster()
	local l = self:GetCursorPosition()
	local m = CalcDirection2D(l, k)
	local n = k:GetAbsOrigin()
	self:SectorWarning(n, m, k:Script_GetAttackRange(), 120, self:GetCastPoint())
	return true
end
function j.prototype.OnSpellStart(self)
	self:AttackCombo1()
end
function j.prototype.AttackCombo1(self)
	local k = self:GetCaster()
	local l = self:GetCursorPosition()
	local m = CalcDirection2D(l, k)
	local n = k:GetAbsOrigin()
	local o = self:GetSpecialValueFor("damage")
	k:EmitSound("Hero_Lion.Punch.PreAttack")
	k:SimulateCast({
		castPoint = 0.1,
		duration = 0.4,
		castAnimation = ACT_SCRIPT_CUSTOM_14,
		OnSpellStart = function()
			k:Dash(m, 50, 0, 0.06, function(l)
				k:PushOff(l)
			end)
			local p = FindEnemiesInSector(k, n, k:Script_GetAttackRange(), m, 120)
			k:DealDamage(p, self, o)
			k:EmitSound("Hero_Lion.Punch.Attack")
		end,
		OnFinish = function()
			k:FadeGesture(ACT_SCRIPT_CUSTOM_14)
			self:AttackCombo2()
		end,
	})
end
function j.prototype.AttackCombo2(self)
	local k = self:GetCaster()
	k:EmitSound("Hero_Lion.Punch.PreAttack")
	local m = k:GetForwardVector()
	local n = k:GetAbsOrigin()
	local o = self:GetSpecialValueFor("damage")
	self:SectorWarning(n, m, k:Script_GetAttackRange(), 120, 0.3)
	k:SimulateCast({
		castPoint = 0.3,
		duration = 0.5,
		castAnimation = ACT_SCRIPT_CUSTOM_15,
		OnSpellStart = function()
			k:Dash(m, 50, 0, 0.06, function(l)
				k:PushOff(l)
			end)
			local p = FindEnemiesInSector(k, n, k:Script_GetAttackRange(), m, 120)
			k:DealDamage(p, self, o)
			k:EmitSound("Hero_Lion.Punch.Attack")
		end,
		OnFinish = function()
			k:FadeGesture(ACT_SCRIPT_CUSTOM_15)
			if self:GetLevel() == 2 then
				self:AttackCombo4()
			else
				self:AttackCombo3()
			end
		end,
	})
end
function j.prototype.AttackCombo3(self)
	local k = self:GetCaster()
	k:EmitSound("Hero_Lion.Punch.PreAttack")
	local m = k:GetForwardVector()
	local n = k:GetAbsOrigin()
	local q = self:GetSpecialValueFor("distance") * 2
	local r = n + m * q
	local o = self:GetSpecialValueFor("damage")
	local s = self:GetSpecialValueFor("width")
	self:LineWarning(n, r, s, 0.4)
	k:SimulateCast({
		castPoint = 0.3,
		duration = 0.6,
		castAnimation = ACT_SCRIPT_CUSTOM_16,
		OnSpellStart = function()
			k:Dash(m, 250, 0, 0.06, function(l)
				k:PushOff(l)
			end)
			local p = FindEnemiesInLine(k, n, r, s)
			k:DealDamage(p, self, o)
			k:EmitSound("Hero_Lion.Punch.Attack")
		end,
		OnFinish = function()
			k:FadeGesture(ACT_SCRIPT_CUSTOM_16)
		end,
	})
end
function j.prototype.AttackCombo4(self)
	local k = self:GetCaster()
	k:EmitSound("Hero_Lion.Punch.PreAttack")
	local m = k:GetForwardVector()
	local s = self:GetSpecialValueFor("width")
	local n = k:GetAbsOrigin() + m * s
	local q = self:GetSpecialValueFor("distance") * 3
	local r = n + m * q
	local o = self:GetSpecialValueFor("damage")
	local p = FindEnemiesInRadius(k, k:GetAbsOrigin(), q, FIND_CLOSEST)
	local t = p[1]
	if IsValid(t) then
		local u = 30
		self:LockFacingTarget(t, u, 0.9)
		local v = self:FacingSupport(r, t, u, q, 0.9)
		self:LineWarning(k, v, s, 0.9)
	end
	k:SimulateCast({
		castPoint = 0.9,
		duration = 0.95,
		castAnimation = ACT_SCRIPT_CUSTOM_22,
		OnSpellStart = function()
			local w = AnglesToVector(k:GetLocalAngles())
			local r = n + w * q
			k:Dash(w, -250, 0, 0.06, function(l)
				k:PushOff(l)
			end)
			local p = FindEnemiesInLine(k, n, r, s, true)
			k:DealDamage(p, self, o)
			local x = k:GetAttachmentPosition("attach_attack2")
			r.z = x.z
			local y = ParticleManager:CreateParticle(
				"particles/econ/items/lion/dungeon_poacher/dungeon_poacher_finger.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControlEnt(y, 0, k, PATTACH_POINT_FOLLOW, "attach_attack2", n, true)
			ParticleManager:SetParticleControlForward(y, 0, w)
			ParticleManager:SetParticleControl(y, 1, r)
			ParticleManager:ReleaseParticleIndex(y)
			k:EmitSound("Hero_Lion.FingerOfDeathImpact")
			k:StartGesture(ACT_SCRIPT_CUSTOM_23)
		end,
	})
end
j = e({ i(nil) }, j)
return f