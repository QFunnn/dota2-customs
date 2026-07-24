--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spirit_breaker_empowering_haste_lua", "heroes/hero_spirit_breaker/spirit_breaker_empowering_haste_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spirit_breaker_empowering_haste_lua_mark", "heroes/hero_spirit_breaker/spirit_breaker_empowering_haste_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if spirit_breaker_empowering_haste_lua == nil then
	spirit_breaker_empowering_haste_lua = class({})
end
function spirit_breaker_empowering_haste_lua:GetIntrinsicModifierName()
	return "modifier_spirit_breaker_empowering_haste_lua"
end
function spirit_breaker_empowering_haste_lua:OnUpgrade()
	local hCaster = self:GetCaster()
	if self:GetLevel() > 1 then
		local buff = hCaster:FindModifierByName("modifier_spirit_breaker_empowering_haste_lua")
		local basic_stack = self:GetSpecialValueFor("basic_stack")
		if buff ~= nil then
			buff:SetStackCount(buff:GetStackCount() + basic_stack)
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_spirit_breaker_empowering_haste_lua == nil then
	modifier_spirit_breaker_empowering_haste_lua = class({})
end
function modifier_spirit_breaker_empowering_haste_lua:IsDebuff()
	return false
end
function modifier_spirit_breaker_empowering_haste_lua:IsHidden()
	return false
end
function modifier_spirit_breaker_empowering_haste_lua:IsPurgable()
	return false
end
function modifier_spirit_breaker_empowering_haste_lua:IsPurgeException()
	return false
end
function modifier_spirit_breaker_empowering_haste_lua:OnCreated(params)
	self.movespeed_damage_pct = self:GetAbilitySpecialValueFor("movespeed_damage_pct")
	self.bonus_movespeed_per_kill = self:GetAbilitySpecialValueFor("bonus_movespeed_per_kill")
	self.bonus_movespeed_per_kill_creep = self:GetAbilitySpecialValueFor("bonus_movespeed_per_kill_creep")
	if IsServer() then
		self:SetStackCount(self:GetAbilitySpecialValueFor("basic_stack"))
		self.records = {}
	end
end
function modifier_spirit_breaker_empowering_haste_lua:OnRefresh(params)
	self.movespeed_damage_pct = self:GetAbilitySpecialValueFor("movespeed_damage_pct")
	self.bonus_movespeed_per_kill = self:GetAbilitySpecialValueFor("bonus_movespeed_per_kill")
	self.bonus_movespeed_per_kill_creep = self:GetAbilitySpecialValueFor("bonus_movespeed_per_kill_creep")
	if IsServer() then
	end
end
function modifier_spirit_breaker_empowering_haste_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_spirit_breaker_empowering_haste_lua:RemoveOnDeath()
	return false
end
function modifier_spirit_breaker_empowering_haste_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_DAMAGE_CALCULATED,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
	}
end
function modifier_spirit_breaker_empowering_haste_lua:OnAttackRecordDestroy(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local record = params.record
	if IsValid(hParent) then
		self.records[record] = nil
	end
end
function modifier_spirit_breaker_empowering_haste_lua:GetModifierProcAttack_BonusDamage_Physical(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local record = params.record

	if IsValid(hParent) and hTarget:IsAlive() then
		self.records[record] = false
	end
end
function modifier_spirit_breaker_empowering_haste_lua:OnTakeDamage(params)
	local hParent = self:GetParent()
	local hTarget = params.unit
	local record = params.record
	if IsValid(hParent) and IsValid(hTarget) and params.attacker == hParent then
		if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
			if not hTarget:IsAlive() then
				if self.records[record] == false then
					local stack = self.bonus_movespeed_per_kill_creep
					if hTarget:IsRealHero() then
						stack = self.bonus_movespeed_per_kill
					end
					self:SetStackCount(self:GetStackCount() + stack)
					self.records[record] = true
				end
			end
		end
	end
end
function modifier_spirit_breaker_empowering_haste_lua:OnDamageCalculated(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local record = params.record
	if IsValid(hParent) and IsValid(hTarget) and params.attacker == hParent then
		if not hTarget:IsAlive() then
			if self.records[record] == false then
				local stack = self.bonus_movespeed_per_kill_creep
				if hTarget:IsRealHero() then
					stack = self.bonus_movespeed_per_kill
				end
				self:SetStackCount(self:GetStackCount() + stack)
				self.records[record] = true
			end
		end
	end
end
function modifier_spirit_breaker_empowering_haste_lua:GetModifierPreAttack_BonusDamage()
	local hParent = self:GetParent()
	return math.max(hParent:GetIdealSpeed() - hParent:GetBaseMoveSpeed(), 1) * self.movespeed_damage_pct * 0.01
end
function modifier_spirit_breaker_empowering_haste_lua:GetModifierIgnoreMovespeedLimit()
	return 1
end
function modifier_spirit_breaker_empowering_haste_lua:GetModifierMoveSpeedBonus_Constant()
	return self:GetStackCount()
end
function modifier_spirit_breaker_empowering_haste_lua:GetPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end