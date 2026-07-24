--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_frostivus2018_huskar_burning_spear_lua",
	"heroes/hero_huskar/frostivus2018_huskar_burning_spear_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frostivus2018_huskar_burning_spear_lua_debuff",
	"heroes/hero_huskar/frostivus2018_huskar_burning_spear_lua.lua", LUA_MODIFIER_MOTION_NONE)


if frostivus2018_huskar_burning_spear_lua == nil then
	frostivus2018_huskar_burning_spear_lua = class({}) ---@class frostivus2018_huskar_burning_spear_lua : CDOTA_Ability_Lua
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

function frostivus2018_huskar_burning_spear_lua:GetCustomCastErrorTarget()
	return self.error_msg
end

function frostivus2018_huskar_burning_spear_lua:GetAOERadius()
	return self:GetSpecialValueFor("spear_aoe")
end

function frostivus2018_huskar_burning_spear_lua:GetIntrinsicModifierName()
	return "modifier_frostivus2018_huskar_burning_spear_lua"
end

function frostivus2018_huskar_burning_spear_lua:GetHealthCost()
	local caster = self:GetCaster()
	local max_health_cost = self:GetSpecialValueFor("max_health_cost")
	local magic_resist = caster:Script_GetMagicalArmorValue(caster) ---вальвы пидорасы теперь с одним параметром вызывается
	-- logger:Log("Magic resist = " .. magic_resist)

	return max_health_cost * (0.01 * caster:GetMaxHealth()) * (1 - magic_resist)
end

---------------------------------------------------------------------
if modifier_frostivus2018_huskar_burning_spear_lua == nil then
	modifier_frostivus2018_huskar_burning_spear_lua = class({}) ---@class modifier_frostivus2018_huskar_burning_spear_lua : CDOTA_Modifier_Lua
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

function modifier_frostivus2018_huskar_burning_spear_lua:OnCreated()
	local ability = self:GetAbility()
	if not ability then return end
	self.duration = ability:GetSpecialValueFor("duration")
	self.spear_aoe = ability:GetSpecialValueFor("spear_aoe")
	self.health_cost = ability:GetSpecialValueFor("health_cost")
	if not IsServer() then return end

	self.tRecords = {}
	self.bActive = false
	AddModifierEvents(MODIFIER_EVENT_ON_ATTACK_START, self, self:GetParent())
end

function modifier_frostivus2018_huskar_burning_spear_lua:OnRefresh()
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.spear_aoe = self:GetAbilitySpecialValueFor("spear_aoe")
	self.health_cost = self:GetAbilitySpecialValueFor("health_cost")
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
	local target = params.target
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if IsValid(target) and IsValid(parent) and IsValid(ability) and target:IsAlive() and self.tRecords[params.record] ~= nil then ---@cast ability CDOTABaseAbility
		local units = FindUnitsInRadius(
			parent:GetTeamNumber(),
			target:GetAbsOrigin(),
			nil,
			self.spear_aoe,
			ability:GetAbilityTargetTeam(),
			ability:GetAbilityTargetType(),
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		local iCount = 0
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				iCount = iCount + 1
				unit:EmitSound("Hero_Huskar.Burning_Spear")
				unit:AddNewModifier(parent, ability, "modifier_frostivus2018_huskar_burning_spear_lua_debuff", {
					duration = self.duration,
				})
			end
		end
	end
end

function modifier_frostivus2018_huskar_burning_spear_lua:OnAttackStart(params)
	local parent = self:GetParent()
	local target = params.target
	local ability = self:GetAbility()
	local attacker = params.attacker
	if IsValid(parent) and IsValid(target) and IsValid(ability) and parent:IsAlive() and target:IsAlive() and attacker == parent then ---@cast ability frostivus2018_huskar_burning_spear_lua
		if (parent:GetCurrentActiveAbility() == ability or ability:GetAutoCastState()) and not parent:IsSilenced() and ability:CastFilterResultTarget(target) == UF_SUCCESS then
			self.bActive = true
			-- self.tRecords[iRecord] = (self.tRecords[iRecord] or 0) + 1
		end
	else
		self.bActive = false
	end
end

function modifier_frostivus2018_huskar_burning_spear_lua:OnAttackRecord(params)
	local parent = self:GetParent()
	local target = params.target
	local ability = self:GetAbility()
	local attacker = params.attacker
	local iRecord = params.record or -1

	if IsValid(parent) and IsValid(target) and IsValid(ability) and parent:IsAlive() and attacker == parent then ---@cast ability frostivus2018_huskar_burning_spear_lua
		if self.bActive then
			self.bActive = false
		end
		if (parent:GetCurrentActiveAbility() == ability or ability:GetAutoCastState()) and not parent:IsSilenced() and ability:CastFilterResultTarget(target) == UF_SUCCESS then
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
		local parent = self:GetParent()
		local ability = self:GetAbility()
		local attacker = params.attacker

		if IsValid(parent) and IsValid(ability) and parent:IsAlive() and attacker == parent then ---@cast ability frostivus2018_huskar_burning_spear_lua
			parent:EmitSound("Hero_Huskar.Burning_Spear.Cast")
			parent:ModifyHealth(
				parent:GetHealth() - ability:GetHealthCost(),
				ability,
				false,
				DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NON_LETHAL +
				DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION +
				DOTA_DAMAGE_FLAG_BYPASSES_ALL_BLOCK
			)
		end
	end
end

---------------------------------------------------------------------
if modifier_frostivus2018_huskar_burning_spear_lua_debuff == nil then
	modifier_frostivus2018_huskar_burning_spear_lua_debuff = class({}) ---@class modifier_frostivus2018_huskar_burning_spear_lua_debuff : CDOTA_Modifier_Lua
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
	local ability = self:GetAbility()
	if not ability then return end

	self.tick_rate = ability:GetSpecialValueFor("tick_rate")
	self.burn_damage = ability:GetSpecialValueFor("burn_damage")
	self.burn_damage_pct = ability:GetSpecialValueFor("burn_damage_pct")
	self.burn_damage_max_pct = ability:GetSpecialValueFor("burn_damage_max_pct")
	if not IsServer() then return end

	self.tStack = {}
	self:StartIntervalThink(self.tick_rate)
	local iCount = params.stack or 1
	local iStackCount = self:GetStackCount() + iCount
	table.insert(self.tStack, { fDieTime = GameRulesCustom:GetGameTime() + (params.duration or 0), iCount = iCount })
	self:SetStackCount(iStackCount)
end

function modifier_frostivus2018_huskar_burning_spear_lua_debuff:OnRefresh(params)
	local ability = self:GetAbility()
	if not ability then return end

	self.tick_rate = ability:GetSpecialValueFor("tick_rate")
	self.burn_damage = ability:GetSpecialValueFor("burn_damage")
	self.burn_damage_pct = ability:GetSpecialValueFor("burn_damage_pct")
	self.burn_damage_max_pct = ability:GetSpecialValueFor("burn_damage_max_pct")
	if not IsServer() then return end

	local iCount = params.stack or 1
	local iStackCount = self:GetStackCount() + iCount
	table.insert(self.tStack, { fDieTime = GameRulesCustom:GetGameTime() + (params.duration or 0), iCount = iCount })
	self:SetStackCount(iStackCount)
end

function modifier_frostivus2018_huskar_burning_spear_lua_debuff:OnIntervalThink()
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()

	if not IsValid(parent) then
		self:Destroy()
		return
	end

	if IsValid(caster) and IsValid(ability) and parent:IsAlive() then ---@cast caster CDOTA_BaseNPC
		local stackCount = self:GetStackCount()
		local normalDamage = self.burn_damage * stackCount
		local percentageDamage = (parent:GetMaxHealth() * self.burn_damage_pct / 100) * stackCount
		local maxPossiblePercentageDamage = parent:GetMaxHealth() * self.burn_damage_max_pct / 100
		ApplyDamage({
			victim = parent,
			attacker = caster,
			ability = ability,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage = normalDamage + math.min(percentageDamage, maxPossiblePercentageDamage),
		})
	end

	local fGameTime = GameRulesCustom:GetGameTime()
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