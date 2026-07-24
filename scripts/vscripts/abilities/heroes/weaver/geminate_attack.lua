--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


weaver_geminate_attack_lua = weaver_geminate_attack_lua or class({})

LinkLuaModifier("modifier_weaver_geminate_attack_lua", "abilities/heroes/weaver/geminate_attack.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_geminate_attack_delay_lua", "abilities/heroes/weaver/geminate_attack.lua", LUA_MODIFIER_MOTION_NONE)


function weaver_geminate_attack_lua:GetCastRange(location, target)
	return self:GetCaster():Script_GetAttackRange()
end

function weaver_geminate_attack_lua:GetIntrinsicModifierName()
	return "modifier_weaver_geminate_attack_lua"
end


-- function weaver_geminate_attack_lua:OnSpellStart()
-- 	local target = self:GetCursorTarget()
-- 	local caster = self:GetCaster()

-- 	caster:MoveToTargetToAttack(target)
-- end

function weaver_geminate_attack_lua:DoSecondaryAttacks(target)
	local caster = self:GetCaster()
	local delay_per_attack = self:GetSpecialValueFor("delay")

	for geminate_attacks = 1, self:GetSpecialValueFor("tooltip_attack") do
		caster:AddNewModifier(target, self, "modifier_weaver_geminate_attack_delay_lua", {delay = delay_per_attack * geminate_attacks})
	end
end


modifier_weaver_geminate_attack_lua = modifier_weaver_geminate_attack_lua or class({})


function modifier_weaver_geminate_attack_lua:IsHidden() return true end


function modifier_weaver_geminate_attack_lua:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if IsServer() and not self.ability:GetAutoCastState() then self.ability:ToggleAutoCast() end
end


function modifier_weaver_geminate_attack_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK
	}
end


function modifier_weaver_geminate_attack_lua:OnAttack(params)
	if params.no_attack_cooldown then return end
	if params.attacker ~= self.parent then return end
	if not IsValidEntity(params.target) then return end
	if not IsValidEntity(self.parent) or not IsValidEntity(self.ability) then return end
	if not self.ability:IsFullyCastable() or self.parent:IsIllusion() or self.parent:PassivesDisabled() then return end
	if not self.ability:GetAutoCastState() then return end

	local target = params.target
	if (target.IsOther and target:IsOther()) then return end

	self.ability:DoSecondaryAttacks(target)

	self.ability:UseResources(true, false, true, true)
end

------------------------------------
-- GEMINATE ATTACK DELAY MODIFIER --
------------------------------------

modifier_weaver_geminate_attack_delay_lua = modifier_weaver_geminate_attack_delay_lua or class({})

function modifier_weaver_geminate_attack_delay_lua:IsHidden()	return true end
function modifier_weaver_geminate_attack_delay_lua:IsPurgable()	return false end
function modifier_weaver_geminate_attack_delay_lua:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end


function modifier_weaver_geminate_attack_delay_lua:OnCreated(params)
	if not IsServer() then return end

	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")

	if params and params.delay then
		self:StartIntervalThink(params.delay)
	end
end


function modifier_weaver_geminate_attack_delay_lua:OnIntervalThink()
	local parent = self:GetParent()
	local caster = self:GetCaster() -- caster for modifier is an entity that applied modifier

	-- https://discord.com/channels/501306949434867713/997015568492281956/997016647300816906
	if not caster then
		self:StartIntervalThink(-1)
		self:Destroy()
		return
	end

	if parent:IsAlive() then
		self.attack_bonus = true
		parent:PerformAttack(caster, true, true, true, false, true, false, false)
		self.attack_bonus = false

		self:StartIntervalThink(-1)
		self:Destroy()
	end
end


function modifier_weaver_geminate_attack_delay_lua:DeclareFunctions()
	return {MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE}
end


function modifier_weaver_geminate_attack_delay_lua:GetModifierPreAttack_BonusDamage()
	if not IsServer() or not self.attack_bonus then return end

	return self.bonus_damage
end