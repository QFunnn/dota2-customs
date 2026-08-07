--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_bloodseeker/boss_bloodseeker_3"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMAbility
local l = j.registerEOMAbility
local m = c()
m.name = "boss_bloodseeker_3"
d(m, k)
function m.prototype.OnAbilityPhaseStart(self)
	local n = self:GetCaster()
	local o = ParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_attack_warning.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(o, 0, n, PATTACH_POINT_FOLLOW, "attach_head", n:GetAbsOrigin(), true)
	n:EmitSound("Hero_Bloodseeker.Thirst.Cast")
	return true
end
function m.prototype.OnSpellStart(self)
	local p = self:GetCursorTarget()
	if not IsValid(p) then
		return
	end
	local n = self:GetCaster()
	n:SimulateCast({ duration = 2 })
	n:ExecuteOrder(DOTA_UNIT_ORDER_MOVE_TO_TARGET, p)
	n:AddNewModifier(n, self, "modifier_boss_bloodseeker_3_buff", { entindex = p:entindex(), duration = 2 })
end
function m.prototype.AttackCombo1(self)
	local n = self:GetCaster()
	n:EmitSound("hero_bloodseeker.PreAttack")
	local q = n:GetForwardVector()
	local r = n:GetAbsOrigin()
	local s = self:GetSpecialValueFor("damage")
	self:SectorWarning(r, q, n:Script_GetAttackRange(), 120, 0.32)
	n:SimulateCast({
		castPoint = 0.32,
		duration = 0.6,
		castAnimation = ACT_SCRIPT_CUSTOM_3,
		OnSpellStart = function()
			n:Dash(q, 100, 0, 0.06, function(t)
				n:PushOff(t)
			end)
			local u = FindEnemiesInSector(n, r, n:Script_GetAttackRange(), q, 120)
			n:DealDamage(u, self, s)
			n:EmitSound("hero_bloodseeker.attack")
		end,
		OnFinish = function()
			n:FadeGesture(ACT_SCRIPT_CUSTOM_3)
			self:AttackCombo2()
		end,
	})
end
function m.prototype.AttackCombo2(self)
	local n = self:GetCaster()
	n:EmitSound("hero_bloodseeker.PreAttack")
	local q = n:GetForwardVector()
	local r = n:GetAbsOrigin()
	local s = self:GetSpecialValueFor("damage")
	self:SectorWarning(r, q, n:Script_GetAttackRange(), 120, 0.32)
	n:SimulateCast({
		castPoint = 0.32,
		duration = 0.5,
		castAnimation = ACT_SCRIPT_CUSTOM_4,
		OnSpellStart = function()
			n:Dash(q, 100, 0, 0.06, function(t)
				n:PushOff(t)
			end)
			local u = FindEnemiesInSector(n, r, n:Script_GetAttackRange(), q, 120)
			n:DealDamage(u, self, s)
			n:EmitSound("hero_bloodseeker.attack")
		end,
		OnFinish = function()
			n:FadeGesture(ACT_SCRIPT_CUSTOM_4)
			self:AttackCombo3()
		end,
	})
end
function m.prototype.AttackCombo3(self)
	local n = self:GetCaster()
	n:EmitSound("hero_bloodseeker.PreAttack")
	local q = n:GetForwardVector()
	local r = n:GetAbsOrigin()
	local v = self:GetSpecialValueFor("distance")
	local w = r + q * v
	local s = self:GetSpecialValueFor("damage")
	local x = self:GetSpecialValueFor("width")
	self:LineWarning(r, w, x, 0.32)
	n:SimulateCast({
		castPoint = 0.32,
		duration = 0.6,
		castAnimation = ACT_SCRIPT_CUSTOM_5,
		OnSpellStart = function()
			n:Dash(q, v, 0, 0.06, function(t)
				n:PushOff(t)
			end)
			local u = FindEnemiesInLine(n, r, w, x)
			n:DealDamage(u, self, s)
			n:EmitSound("hero_bloodseeker.attack")
		end,
		OnFinish = function()
			n:FadeGesture(ACT_SCRIPT_CUSTOM_5)
		end,
	})
end
m = e({ l(nil) }, m)
f.modifier_boss_bloodseeker_3_buff = c()
local y = f.modifier_boss_bloodseeker_3_buff
y.name = "modifier_boss_bloodseeker_3_buff"
d(y, h)
function y.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_ULTRA
end
function y.prototype.OnCreated(self, z)
	local A = self:GetParent()
	if IsServer() then
		self.target = EntIndexToHScript(z.entindex)
		if not IsValid(self.target) then
			self:Destroy()
			return
		end
		self:StartIntervalThink(0)
	end
end
function y.prototype.OnIntervalThink(self)
	if not IsValid(self.target) then
		self:Destroy()
		return
	end
	local A = self:GetParent()
	if CalcDistance(A, self.target) <= A:Script_GetAttackRange() then
		self:Destroy()
		local B = self:GetAbility()
		if IsValid(B) then
			B:AttackCombo1()
		end
	end
end
function y.prototype.OnDestroy(self)
	if IsServer() then
		local A = self:GetParent()
		A:Stop()
	end
end
function y.prototype.StaticDeclare(self)
	return { [MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE] = 1200, [MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS] = "haste" }
end
function y.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = false, [MODIFIER_STATE_DISARMED] = false }
end
y = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	y
)
f.modifier_boss_bloodseeker_3_buff = y
return f