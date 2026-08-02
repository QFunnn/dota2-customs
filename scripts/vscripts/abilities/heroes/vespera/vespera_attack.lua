--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/heroes/vespera/vespera_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.ability_ai")
local k = j.EOMAbilityAI
local l = require("abilities.eom_ability")
local m = l.AbilityValue
local n = l.registerEOMAbility
local o = 150
local p = c()
p.name = "vespera_attack"
d(p, k)
function p.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.vespera_upgrade_2_enable_time = GameRules:GetGameTime()
end
function p.prototype.GetThinkInterval(self)
	return math.max(FrameTime(), self:GetCaster():GetSecondsPerAttack(false) * 0.5)
end
function p.prototype.GetAICastRange(self)
	return self:GetCaster():Script_GetAttackRange()
end
function p.prototype.ProcsMagicStick(self)
	return false
end
function p.prototype.GetCooldown(self, q)
	return self:GetCaster():GetSecondsPerAttack(false) - self:GetCastPoint()
end
function p.prototype.GetCastPoint(self)
	if IsServer() then
		return self:GetCaster():GetAttackAnimationPoint()
			* self:GetCaster():GetSecondsPerAttack(false)
			/ self:GetCaster():GetBaseAttackTime(false)
	end
	return 0
end
function p.prototype.GetCastAnimation(self)
	local r = self:GetCaster()
	local s = self.combo_count
	local t = r:GetModifierStackCount("modifier_vespera_combo", r)
	if t >= s or r:HasModifier("modifier_vespera_combo_final") then
		return ACT_DOTA_ATTACK_EVENT
	elseif t == s - 1 then
		return ACT_DOTA_CAST_ABILITY_7
	elseif t == s - 2 then
		return ACT_DOTA_CAST_ABILITY_6
	end
	return ACT_DOTA_CAST_ABILITY_5
end
function p.prototype.GetPlaybackRateOverride(self)
	return self:GetCaster():GetAttackSpeed(false)
end
function p.prototype.OnAbilityPhaseStart(self)
	local r = self:GetCaster()
	r:EmitSound(tostring(KeyValues.heroes[r:GetUnitName()].SoundSet) .. ".PreAttack")
	return true
end
function p.prototype.OnSpellStart(self)
	self:Attack()
end
function p.prototype.Attack(self, u, v)
	local r = self:GetCaster()
	local w = u ~= nil and v ~= nil
	local x
	local y
	local z
	local A
	local B
	if w then
		x = u
		y = v
		z = v
		A = o
	else
		local C = 150 + self.attack_radius
		local D = 100 + self.attack_radius
		local E = r:Script_GetAttackRange()
		x = r:GetAbsOrigin()
		z = self:GetCursorPosition()
		local F = CalcDirection2D(z, x)
		y = x + F * E
		local G = Rotation2D(F, math.rad(90))
		B = { x + G * C, y + G * D, y - G * D, x - G * C }
		local H = B[1]:Lerp(B[3], 0.5)
		do
			local I = 0
			while I < #B do
				local J = B[I + 1]
				B[I + 1] = J + CalcDirection2D(J, H) * 50
				I = I + 1
			end
		end
		A = math.max(C, D)
	end
	if r:HasAbilityUpgrade("vespera_upgrade_28") and r:HasModifier("modifier_vespera_upgrade_27_stealth") then
		r:AddNewModifier(r, self, "modifier_vespera_combo_final", { duration = r:GetSecondsPerAttack(false) + 60 })
	end
	local K = FindUnitsInLine(
		r:GetTeam(),
		x,
		y,
		nil,
		A,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		UNIT_AND_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE
	)
	local L = self:GetSpecialValueFor("lightning_chance")
	local M = r:HasModifier("modifier_vespera_upgrade_12_backstab") and EOM_DAMAGE_FLAGS.Backstab or nil
	for N, O in ipairs(K) do
		if w or IsPointInPolygon(O:GetAbsOrigin(), B) then
			r:Attack(O, { damageType = self:GetDamageType(), flags = M })
			if L > 0 and self:PRD(L) then
				r:LightningStrike(O, self:GetSpecialValueFor("lightning_damage"))
			end
		end
	end
	local P = w and Bullet:GetBulletInLine(x, y, o) or Bullet:GetBulletInPolygon(B)
	r:ShootDown(P)
	local Q = r:GetModifierStackCount("modifier_vespera_combo", r)
	local R = r:HasModifier("modifier_vespera_combo_final")
	local S = Q >= self.combo_count
	r:EmitSound(tostring(KeyValues.heroes[r:GetUnitName()].SoundSet) .. ".Attack")
	if R then
		r:RemoveModifierByName("modifier_vespera_combo_final")
		r:EmitSound("DOTA_Item.Daedelus.Crit")
		if
			AbilityUpgrade:HasAbilityUpgrade(r, "vespera_upgrade_2")
			and self.vespera_upgrade_2_enable_time < GameRules:GetGameTime()
		then
			self.vespera_upgrade_2_enable_time = GameRules:GetGameTime() + self:GetSpecialValueFor("passive_cd")
			local T = r:GetAbilityByTag(AbilityTag.Skill)
			if IsValid(T) then
				r:SetCursorPosition(r:GetAbsOrigin() + r:GetForwardVector() * 100)
				T:OnSpellStart()
				Event:Fire(
					"ability_cast_complete",
					{ ability = T, caster = r, position = T:GetCursorPosition(), abilityTag = T:GetAbilityTag() }
				)
			end
		end
	elseif S then
		r:EmitSound("DOTA_Item.Daedelus.Crit")
		r:RemoveModifierByName("modifier_vespera_combo")
		if
			AbilityUpgrade:HasAbilityUpgrade(r, "vespera_upgrade_2")
			and self.vespera_upgrade_2_enable_time < GameRules:GetGameTime()
		then
			self.vespera_upgrade_2_enable_time = GameRules:GetGameTime() + self:GetSpecialValueFor("passive_cd")
			local T = r:GetAbilityByTag(AbilityTag.Skill)
			if IsValid(T) then
				r:SetCursorPosition(r:GetAbsOrigin() + r:GetForwardVector() * 100)
				T:OnSpellStart()
				Event:Fire(
					"ability_cast_complete",
					{ ability = T, caster = r, position = T:GetCursorPosition(), abilityTag = T:GetAbilityTag() }
				)
			end
		end
	else
		r:AddNewModifier(r, self, "modifier_vespera_combo", { duration = r:GetSecondsPerAttack(false) + 60 })
	end
	if AbilityUpgrade:HasAbilityUpgrade(r, "vespera_upgrade_11") then
		if self:PRD(self:GetSpecialValueFor("aoe_chance"), "vespera_upgrade_11") then
			self:CuttingStorm(r, 1)
		end
	end
	Event:Fire("attack_event", { attacker = r, position = z })
end
function p.prototype.CuttingStorm(self, U, V)
	local r = self:GetCaster()
	local W = U.GetAbsOrigin ~= nil
	local z = W and U:GetAbsOrigin() or U
	local X = self:GetSpecialValueFor("aoe_damage")
	local Y = self:GetSpecialValueFor("aoe_radius") * V
	local Z = self:GetSpecialValueFor("aoe_bleed_factor")
	local _ = FindUnitsInRadius(
		r:GetTeamNumber(),
		z,
		nil,
		Y,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		UNIT_AND_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_ANY_ORDER,
		false
	)
	for I, U in ipairs(_) do
		r:DealDamage(U, self, X)
		if Z > 0 then
			U:TriggerBleed(r, self:GetSpecialValueFor("aoe_bleed_factor"))
		end
	end
	local a0 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_suriken_toss_aoe.vpcf",
		PATTACH_CUSTOMORIGIN,
		r
	)
	if W then
		ParticleManager:SetParticleControlEnt(a0, 0, r, PATTACH_ABSORIGIN_FOLLOW, nil, r:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl(a0, 3, Vector(0, 0, 100))
	else
		ParticleManager:SetParticleControl(a0, 0, z)
	end
	ParticleManager:SetParticleControl(a0, 1, Vector(Y, 0, 0))
	ParticleManager:ReleaseParticleIndex(a0)
end
function p.prototype.StaticProperty(self)
	return {
		[PropertyFunction.ATTACKSPEED] = self:GetSpecialValueFor("attack_speed"),
		[PropertyFunction.BACKSTAB_DAMAGE_AMPLIFY] = self:GetSpecialValueFor("backstab_damage"),
	}
end
function p.prototype.EventListener(self)
	return {
		ability_upgrade_added = function(N, a1)
			if a1.unit == self:GetCaster() and a1.upgradeName == "vespera_upgrade_27" then
				a1.unit:AddNewModifier(a1.unit, self, "modifier_vespera_upgrade_27", {})
			end
		end,
		ability_upgrade_removed = function(N, a1)
			if a1.unit == self:GetCaster() and a1.upgradeName == "vespera_upgrade_27" then
				a1.unit:RemoveModifierByName("modifier_vespera_upgrade_27")
			end
		end,
		ability_upgrades_cleared = function(N, a1)
			if a1.unit == self:GetCaster() then
				a1.unit:RemoveModifierByName("modifier_vespera_upgrade_27")
			end
		end,
	}
end
e({ m(nil) }, p.prototype, "combo_count", nil)
e({ m(nil) }, p.prototype, "attack_radius", nil)
p = e({ n(nil, {
	funcCondition = function(N, T)
		return T:GetAutoCastState()
	end,
}) }, p)
local a2 = c()
a2.name = "modifier_vespera_combo"
d(a2, h)
function a2.prototype.OnCreated(self, a3)
	if IsServer() then
		self:IncrementStackCount(a3.count)
	end
end
function a2.prototype.OnRefresh(self, a3)
	if IsServer() then
		self:IncrementStackCount(a3.count)
	end
end
function a2.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_AMPLIFY] = function(N, a4)
			if
				a4 ~= nil
				and self:GetStackCount() >= self.combo_count
				and a4.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
			then
				return self:GetAbilitySpecialValueFor("last_hit_damage")
			end
		end,
	}
end
e({ m(nil) }, a2.prototype, "combo_count", nil)
a2 = e(
	{
		i(
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
	a2
)
local a5 = c()
a5.name = "modifier_vespera_combo_final"
d(a5, h)
function a5.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_AMPLIFY] = function(N, a4)
			if a4 ~= nil and a4.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
				return self:GetAbilitySpecialValueFor("last_hit_damage")
			end
		end,
	}
end
a5 = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	a5
)
local a6 = c()
a6.name = "modifier_vespera_upgrade_12_backstab"
d(a6, h)
a6 = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	a6
)
local a7 = c()
a7.name = "modifier_vespera_upgrade_27"
d(a7, h)
function a7.prototype.GetAbilitySpecialValue(self)
	self.sleep = self:GetAbilitySpecialValueFor("sleep")
	self.sleep_movespeed = self:GetAbilitySpecialValueFor("sleep_movespeed")
	self.sleep_attack = self:GetAbilitySpecialValueFor("sleep_attack")
end
function a7.prototype.TriggerSleep(self)
	self:StartThink(self.sleep, "sleep", function()
		self:SetStackCount(1)
		local a0 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_assassin/vespera_upgrade_27.vpcf",
			PATTACH_ABSORIGIN,
			self:GetParent()
		)
		ParticleManager:ReleaseParticleIndex(a0)
		local a8 = self:GetParent()
		self:GetParent():EmitSound("Hero_PhantomAssassin.Blur.Break")
		if a8:HasAbilityUpgrade("vespera_upgrade_28") then
			local T = a8:GetAbilityByTag(AbilityTag.Attack)
			a8:AddNewModifier(a8, T, "modifier_vespera_combo_final", { duration = a8:GetSecondsPerAttack(false) + 60 })
		end
		return -1
	end)
end
function a7.prototype.OnCreated(self, a3)
	if IsServer() then
		self:TriggerSleep()
	end
end
function a7.prototype.EventListener(self)
	return {
		attack_event = function(N, a4)
			if a4.attacker == self:GetParent() then
				self:TriggerSleep()
			end
		end,
	}
end
function a7.prototype.StaticProperty(self)
	return { [PropertyFunction.MOVESPEED_AMPLIFY] = self:GetStackCount() * self.sleep_movespeed }
end
function a7.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.DAMAGE_AMPLIFY] = function(N, a4)
			if (a4 and a4.damage_category) == DOTA_DAMAGE_CATEGORY_ATTACK and self:GetStackCount() > 0 then
				self:SetStackCount(0)
				return self.sleep_attack
			end
		end,
	}
end
a7 = e(
	{
		i(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	a7
)
return f