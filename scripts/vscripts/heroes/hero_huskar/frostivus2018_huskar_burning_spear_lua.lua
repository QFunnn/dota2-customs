--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_frostivus2018_huskar_burning_spear_lua", "heroes/hero_huskar/frostivus2018_huskar_burning_spear_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frostivus2018_huskar_burning_spear_lua_debuff", "heroes/hero_huskar/frostivus2018_huskar_burning_spear_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if frostivus2018_huskar_burning_spear_lua == nil then
	frostivus2018_huskar_burning_spear_lua = class({})
end
function frostivus2018_huskar_burning_spear_lua:CastFilterResultTarget(hTarget)
	local hCaster = self:GetCaster()
	if not IsValid(hTarget) then
		self.error_msg = "dota_hud_error_cant_cast_on_other"
		return UF_FAIL_CUSTOM
	end
	if hTarget.IsInvulnerable and type(hTarget.IsInvulnerable) == "function" and hTarget:IsInvulnerable() then
		self.error_msg = "dota_hud_error_target_invulnerable"
		return UF_FAIL_CUSTOM
	end
	if UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, hCaster:GetTeamNumber()) ~= UF_SUCCESS then
		self.error_msg = "dota_hud_error_cant_cast_on_other"
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end
function frostivus2018_huskar_burning_spear_lua:GetCustomCastErrorTarget(hTarget)
	return self.error_msg
end
function frostivus2018_huskar_burning_spear_lua:GetAOERadius()
	return self:GetSpecialValueFor("spear_aoe")
end
function frostivus2018_huskar_burning_spear_lua:GetIntrinsicModifierName()
	return "modifier_frostivus2018_huskar_burning_spear_lua"
end
function frostivus2018_huskar_burning_spear_lua:GetHealthCost(iLevel)
	local hCaster = self:GetCaster()
	local health_cost = self:GetSpecialValueFor("health_cost")
	return health_cost * 0.01 * hCaster:GetHealth()
end
---------------------------------------------------------------------
--Modifiers
if modifier_frostivus2018_huskar_burning_spear_lua == nil then
	modifier_frostivus2018_huskar_burning_spear_lua = class({})
end
function modifier_frostivus2018_huskar_burning_spear_lua:IsHidden()
	return true
end
function modifier_frostivus2018_huskar_burning_spear_lua:IsDebuff()
	return false
end
function modifier_frostivus2018_huskar_burning_spear_lua:IsPurgable()
	return false
end
function modifier_frostivus2018_huskar_burning_spear_lua:OnCreated(params)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.spear_aoe = self:GetAbilitySpecialValueFor("spear_aoe")
	self.health_cost = self:GetAbilitySpecialValueFor("health_cost")
	if IsServer() then
		self.tRecords = {}
		self.bActive = false
		AddModifierEvents(MODIFIER_EVENT_ON_ATTACK_START, self, self:GetParent())
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua:OnRefresh(params)
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.spear_aoe = self:GetAbilitySpecialValueFor("spear_aoe")
	self.health_cost = self:GetAbilitySpecialValueFor("health_cost")
	if IsServer() then
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua:OnDestroy()
	if IsServer() then
		RemoveModifierEvents(MODIFIER_EVENT_ON_ATTACK_START, self, self:GetParent())
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_START,
	}
end
function modifier_frostivus2018_huskar_burning_spear_lua:GetModifierProjectileName()
	if self.bActive then
		return "particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf"
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua:OnAttackStart_AttackSystem(params)
	self:OnAttackStart(params)
end
function modifier_frostivus2018_huskar_burning_spear_lua:GetModifierProcAttack_Feedback(params)
	local hTarget = params.target
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	if IsValid(hTarget) and IsValid(hParent) and IsValid(hAbility) and hTarget:IsAlive() and self.tRecords[params.record] ~= nil then
		local units = FindUnitsInRadius(hParent:GetTeamNumber(), hTarget:GetAbsOrigin(), nil, self.spear_aoe, hAbility:GetAbilityTargetTeam(), hAbility:GetAbilityTargetType(), DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		local iCount = 0
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				iCount = iCount + 1
				unit:EmitSound("Hero_Huskar.Burning_Spear")
				unit:AddNewModifier(hParent, hAbility, "modifier_frostivus2018_huskar_burning_spear_lua_debuff", { duration = self.duration, delay = iCount * FrameTime() })
			end
		end
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua:OnAttackStart(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	local hAttacker = params.attacker
	local iRecord = params.record or -1
	if IsValid(hParent) and IsValid(hTarget) and IsValid(hAbility) and hParent:IsAlive() and hTarget:IsAlive() and hAttacker == hParent then
		if (hParent:GetCurrentActiveAbility() == hAbility or hAbility:GetAutoCastState()) and not hParent:IsSilenced() and hAbility:CastFilterResultTarget(hTarget) == UF_SUCCESS then
			self.bActive = true
			-- self.tRecords[iRecord] = (self.tRecords[iRecord] or 0) + 1
		end
	else
		self.bActive = false
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua:OnAttackRecord(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	local hAttacker = params.attacker
	local iRecord = params.record or -1

	if IsValid(hParent) and IsValid(hTarget) and IsValid(hAbility) and hParent:IsAlive() and hAttacker == hParent then
		if self.bActive then
			self.bActive = false
		end
		if (hParent:GetCurrentActiveAbility() == hAbility or hAbility:GetAutoCastState()) and not hParent:IsSilenced() and hAbility:CastFilterResultTarget(hTarget) == UF_SUCCESS then
			self.tRecords[iRecord] = (self.tRecords[iRecord] or 0) + 1
		end
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua:OnAttackRecordDestroy(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker

	if IsValid(hParent) and hParent:IsAlive() and hAttacker == hParent then
		if self.tRecords[params.record] ~= nil then
			self.tRecords[params.record] = self.tRecords[params.record] - 1
			if self.tRecords[params.record] == 0 then
				self.tRecords[params.record] = nil
			end
		end
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua:OnAttack(params)
	if self.tRecords[params.record] ~= nil then
		local hParent = self:GetParent()
		local hAbility = self:GetAbility()
		local hAttacker = params.attacker

		if IsValid(hParent) and hParent:IsAlive() and hAttacker == hParent then
			hParent:EmitSound("Hero_Huskar.Burning_Spear.Cast")
			local hp_lose = self.health_cost * 0.01 * hParent:GetHealth()
			hParent:ModifyHealth(hParent:GetHealth() - hp_lose, hAbility, false, DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_BYPASSES_ALL_BLOCK)
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_frostivus2018_huskar_burning_spear_lua_debuff == nil then
	modifier_frostivus2018_huskar_burning_spear_lua_debuff = class({})
end
function modifier_frostivus2018_huskar_burning_spear_lua_debuff:IsHidden()
	return false
end
function modifier_frostivus2018_huskar_burning_spear_lua_debuff:IsDebuff()
	return true
end
function modifier_frostivus2018_huskar_burning_spear_lua_debuff:IsPurgable()
	return false
end
function modifier_frostivus2018_huskar_burning_spear_lua_debuff:OnCreated(params)
	self.tick_rate = self:GetAbilitySpecialValueFor("tick_rate")
	self.burn_damage = self:GetAbilitySpecialValueFor("burn_damage")
	if IsServer() then
		self.LastBurnTime = GameRules:GetGameTime() + (params.delay or 0)
		self.tStack = {}
		self:StartIntervalThink(FrameTime())
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStack, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua_debuff:OnRefresh(params)
	self.tick_rate = self:GetAbilitySpecialValueFor("tick_rate")
	self.burn_damage = self:GetAbilitySpecialValueFor("burn_damage")
	if IsServer() then
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStack, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua_debuff:OnIntervalThink()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	local hAbility = self:GetAbility()

	if not IsValid(hParent) then
		self:Destroy()
		return
	end

	local damage_type = DAMAGE_TYPE_MAGICAL
	if self:GetAbilitySpecialValueFor("SpellImmunityEnemy") >= 1 then
		damage_type = DAMAGE_TYPE_PURE
	end

	--先打伤害
	if GameRules:GetGameTime() > self.LastBurnTime + self.tick_rate and IsValid(hCaster) and IsValid(hAbility) and hParent:IsAlive() then
		local damage = self.burn_damage * self:GetStackCount()
		ApplyDamage({
			victim = hParent,
			attacker = hCaster,
			ability = hAbility,
			damage_type = damage_type,
			damage = damage,
		})
		self.LastBurnTime = GameRules:GetGameTime()
	end

	--后减少层数
	local fGameTime = GameRules:GetGameTime()
	for i = #self.tStack, 1, -1 do
		if fGameTime >= self.tStack[i].fDieTime then
			self:SetStackCount(math.max(0, self:GetStackCount() - self.tStack[i].iCount))
			table.remove(self.tStack, i)
		end
	end
end
function modifier_frostivus2018_huskar_burning_spear_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf"
end
function modifier_frostivus2018_huskar_burning_spear_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end