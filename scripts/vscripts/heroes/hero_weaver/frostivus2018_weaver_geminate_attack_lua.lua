--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_frostivus2018_weaver_geminate_attack_lua", "heroes/hero_weaver/frostivus2018_weaver_geminate_attack_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frostivus2018_weaver_geminate_attack_lua_delay", "heroes/hero_weaver/frostivus2018_weaver_geminate_attack_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if frostivus2018_weaver_geminate_attack_lua == nil then
	frostivus2018_weaver_geminate_attack_lua = class({})
end
function frostivus2018_weaver_geminate_attack_lua:GetIntrinsicModifierName()
	return "modifier_frostivus2018_weaver_geminate_attack_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_frostivus2018_weaver_geminate_attack_lua == nil then
	modifier_frostivus2018_weaver_geminate_attack_lua = class({})
end
function modifier_frostivus2018_weaver_geminate_attack_lua:IsHidden()
	return true
end
function modifier_frostivus2018_weaver_geminate_attack_lua:IsDebuff()
	return false
end
function modifier_frostivus2018_weaver_geminate_attack_lua:IsPurgable()
	return false
end
function modifier_frostivus2018_weaver_geminate_attack_lua:IsPurgeException()
	return false
end
function modifier_frostivus2018_weaver_geminate_attack_lua:AllowIllusionDuplicate()
	return false
end
function modifier_frostivus2018_weaver_geminate_attack_lua:OnCreated(params)
	self.tooltip_attack = self:GetAbilitySpecialValueFor("tooltip_attack")
	if IsServer() then
	end
end
function modifier_frostivus2018_weaver_geminate_attack_lua:OnRefresh(params)
	self.tooltip_attack = self:GetAbilitySpecialValueFor("tooltip_attack")
	if IsServer() then
	end
end
function modifier_frostivus2018_weaver_geminate_attack_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_frostivus2018_weaver_geminate_attack_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK
	}
end
function modifier_frostivus2018_weaver_geminate_attack_lua:OnAttack(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hTarget = params.target

	if IsValid(hParent) and IsValid(hAttacker) and IsValid(hTarget) and hAttacker == hParent and hTarget:IsAlive() and (not hAttacker:PassivesDisabled()) and self:GetAbility():IsCooldownReady() and (not hAttacker:AttackFilter(params.record, ATTACK_STATE_NOT_PROCESSPROCS, ATTACK_STATE_NO_EXTENDATTACK)) then
		for i = 1, self.tooltip_attack do
			hParent:AddNewModifier(hParent, self:GetAbility(), "modifier_frostivus2018_weaver_geminate_attack_lua_delay", { delay = i, index = hTarget:entindex() })
		end
		self:GetAbility():UseResources(true, false, true, true)
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_frostivus2018_weaver_geminate_attack_lua_delay == nil then
	modifier_frostivus2018_weaver_geminate_attack_lua_delay = class({})
end
function modifier_frostivus2018_weaver_geminate_attack_lua_delay:IsHidden()
	return true
end
function modifier_frostivus2018_weaver_geminate_attack_lua_delay:IsDebuff()
	return false
end
function modifier_frostivus2018_weaver_geminate_attack_lua_delay:IsPurgable()
	return false
end
function modifier_frostivus2018_weaver_geminate_attack_lua_delay:IsPurgeException()
	return false
end
function modifier_frostivus2018_weaver_geminate_attack_lua_delay:OnCreated(params)
	self.arrow_count = self:GetAbilitySpecialValueFor("arrow_count")
	self.bonus_range = self:GetAbilitySpecialValueFor("bonus_range")
	self.delay = self:GetAbilitySpecialValueFor("delay")
	self.tooltip_attack = self:GetAbilitySpecialValueFor("tooltip_attack")
	if IsServer() then
		self.delay_done = false
		self.main_target_count = self.tooltip_attack
		if params.index ~= nil then
			local t = EntIndexToHScript(params.index)
			if IsValid(t) and t:IsAlive() then
				self.hTarget = t
			end
		end
		self:StartIntervalThink(self.delay * (params.delay or 1))
	end
end
function modifier_frostivus2018_weaver_geminate_attack_lua_delay:OnRefresh(params)
	self.arrow_count = self:GetAbilitySpecialValueFor("arrow_count")
	self.bonus_range = self:GetAbilitySpecialValueFor("bonus_range")
	self.delay = self:GetAbilitySpecialValueFor("delay")
	self.tooltip_attack = self:GetAbilitySpecialValueFor("tooltip_attack")
	if IsServer() then
	end
end
function modifier_frostivus2018_weaver_geminate_attack_lua_delay:OnDestroy()
	if IsServer() then
	end
end
function modifier_frostivus2018_weaver_geminate_attack_lua_delay:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_frostivus2018_weaver_geminate_attack_lua_delay:OnIntervalThink()
	local hParent = self:GetParent()
	if not self.delay_done then
		local count = 0
		self.units = {}
		local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, hParent:Script_GetAttackRange() + self.bonus_range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() and unit ~= self.hTarget then
				table.insert(self.units, unit)
				count = count + 1
				if count >= self.arrow_count then
					break
				end
			end
		end
	end
	if self.main_target_count > 0 and IsValid(self.hTarget) and self.hTarget:IsAlive() and (self.hTarget.IsAttackImmune ~= nil and type(self.hTarget.IsAttackImmune) == "function" and not self.hTarget:IsAttackImmune()) and (not self.hTarget:IsInvulnerable()) then
		hParent:Attack(self.hTarget, ATTACK_STATE_SKIPCOOLDOWN + ATTACK_STATE_IGNOREINVIS + ATTACK_STATE_NO_EXTENDATTACK + ATTACK_STATE_SKIPCOUNTING)
		self.main_target_count = self.main_target_count - 1
	end
	for i = #self.units, 1, -1 do
		local unit = self.units[i]
		if IsValid(unit) and unit:IsAlive() then
			hParent:Attack(unit, ATTACK_STATE_SKIPCOOLDOWN + ATTACK_STATE_IGNOREINVIS + ATTACK_STATE_NO_EXTENDATTACK + ATTACK_STATE_SKIPCOUNTING)
			table.remove(self.units, i)
			break
		else
			table.remove(self.units, i)
		end
	end

	if self.units ~= nil and #self.units <= 0 then
		self:Destroy()
	end
	if not self.delay_done then
		self.delay_done = true
		self:StartIntervalThink(0.1)
	end
end