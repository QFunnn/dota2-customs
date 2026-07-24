--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


dazzle_bad_juju_lua = class({}) ---@class dazzle_bad_juju_lua : CDOTA_Ability_Lua

LinkLuaModifier("modifier_dazzle_bad_juju_lua", "heroes/hero_dazzle/dazzle_bad_juju_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_bad_juju_lua_debuff", "heroes/hero_dazzle/dazzle_bad_juju_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_bad_juju_lua_counter", "heroes/hero_dazzle/dazzle_bad_juju_lua",
	LUA_MODIFIER_MOTION_NONE)

function dazzle_bad_juju_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	local cooldown_reduction = self:GetSpecialValueFor("cooldown_reduction")
	local cooldown_reduction_items = self:GetSpecialValueFor("cooldown_reduction_items")
	local mana_cost_increase_duration = self:GetSpecialValueFor("mana_cost_increase_duration")

	if IsValid(hCaster) then
		for index = 0, hCaster:GetAbilityCount() - 1 do
			local hAbility = hCaster:GetAbilityByIndex(index)
			if IsValid(hAbility) ---@cast hAbility CDOTA_Ability_Lua
				and hAbility ~= self and hAbility:IsRefreshable() then
				local sAbilityName = hAbility:GetAbilityName()
				if not hAbility:IsCooldownReady() and sAbilityName ~= "dark_willow_shadow_realm" then
					local cd_remain = hAbility:GetCooldownTimeRemaining()
					hAbility:EndCooldown()
					if cd_remain > cooldown_reduction then
						hAbility:StartCooldown(cd_remain - cooldown_reduction)
					end
				end
			end
		end

		EmitSoundOn("Hero_Dazzle.BadJuJu.Target", hCaster)

		hCaster:AddNewModifier(hCaster, self, "modifier_dazzle_bad_juju_lua", { duration = mana_cost_increase_duration })

		local units = FindUnitsInRadius(hCaster:GetTeamNumber(), hCaster:GetAbsOrigin(), nil, radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				unit:AddNewModifier(hCaster, self, "modifier_dazzle_bad_juju_lua_debuff",
					{
						duration = duration * unit:GetStatusResistanceFactor(hCaster)
					})
			end
		end
	end
end

---=======================================================
modifier_dazzle_bad_juju_lua = class({}) ---@class CDOTA_Modifier_Lua

function modifier_dazzle_bad_juju_lua:IsHidden()
	return false
end

function modifier_dazzle_bad_juju_lua:IsDebuff()
	return false
end

function modifier_dazzle_bad_juju_lua:IsPurgable()
	return false
end

function modifier_dazzle_bad_juju_lua:IsPurgeException()
	return false
end

function modifier_dazzle_bad_juju_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_dazzle_bad_juju_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTHCOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_dazzle_bad_juju_lua:AllowIllusionDuplicate()
	return false
end

function modifier_dazzle_bad_juju_lua:OnCreated(params)
	self.armor_reduction = self:GetAbilitySpecialValueFor("armor_reduction")
	self.mana_cost_increase_pct = self:GetAbilitySpecialValueFor("mana_cost_increase_pct")
	self.max_stacks = self:GetAbilitySpecialValueFor("max_stacks")
	if IsServer() then
		self.tStacks = {}
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStacks, { fDieTime = GameRulesCustom:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
		if iStackCount > self.max_stacks then
			self:RemoveStackCount(iStackCount - self.max_stacks)
		end

		local hParent = self:GetParent()
		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_dazzle/dazzle_armor_friend.vpcf",
			PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_OVERHEAD_FOLLOW, "", Vector(0, 0, 0), true)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, hParent, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0),
			true)
		self:AddParticle(iParticleID, false, false, -1, false, false)
		self.bonus_mana_cost_increase_pct = 0
		self:StartIntervalThink(FrameTime())
		self:SetHasCustomTransmitterData(true)
	end
end

function modifier_dazzle_bad_juju_lua:OnRefresh(params)
	self.armor_reduction = self:GetAbilitySpecialValueFor("armor_reduction")
	self.mana_cost_increase_pct = self:GetAbilitySpecialValueFor("mana_cost_increase_pct")
	self.max_stacks = self:GetAbilitySpecialValueFor("max_stacks")
	if IsServer() then
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStacks, { fDieTime = GameRulesCustom:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
		if iStackCount > self.max_stacks then
			self:RemoveStackCount(iStackCount - self.max_stacks)
		end
	end
end

function modifier_dazzle_bad_juju_lua:OnIntervalThink()
	local hParent = self:GetParent()
	local counter_buff = hParent:FindModifierByName("modifier_dazzle_bad_juju_lua_counter")
	local fGameTime = GameRulesCustom:GetGameTime()
	for i = #self.tStacks, 1, -1 do
		if fGameTime >= self.tStacks[i].fDieTime then
			self:SetStackCount(math.max(0, self:GetStackCount() - self.tStacks[i].iCount))
			table.remove(self.tStacks, i)
		end
	end
	if counter_buff then
		self.bonus_mana_cost_increase_pct = counter_buff:GetStackCount()
		self:SendBuffRefreshToClients()
	end
end

function modifier_dazzle_bad_juju_lua:AddCustomTransmitterData()
	return {
		bonus_mana_cost_increase_pct = self.bonus_mana_cost_increase_pct
	}
end

function modifier_dazzle_bad_juju_lua:HandleCustomTransmitterData(t)
	self.bonus_mana_cost_increase_pct = t.bonus_mana_cost_increase_pct
end

function modifier_dazzle_bad_juju_lua:GetModifierPercentageHealthcostStacking(params)
	local hAbility = self:GetAbility()
	if params.ability == hAbility then
		return -(math.pow((100 + self.mana_cost_increase_pct + self.bonus_mana_cost_increase_pct) * 0.01, self:GetStackCount()) * 100 - 100)
	end
end

function modifier_dazzle_bad_juju_lua:GetModifierMagicalResistanceBonus()
	return self:GetStackCount() * self.armor_reduction
end

function modifier_dazzle_bad_juju_lua:RemoveStackCount(iRemovedCount)
	if IsServer() then
		local iStackCount = self:GetStackCount()
		local iLast = 0
		for i = 1, #self.tStacks, 1 do
			if self.tStacks[i].iCount <= iRemovedCount then
				iLast = i
				iRemovedCount = iRemovedCount - self.tStacks[i].iCount
				if iRemovedCount == 0 then
					break
				end
			else
				iStackCount = iStackCount - iRemovedCount
				self.tStacks[i].iCount = self.tStacks[i].iCount - iRemovedCount
				break
			end
		end
		for i = iLast, 1, -1 do
			iStackCount = iStackCount - self.tStacks[i].iCount
			table.remove(self.tStacks, i)
		end
		self:SetStackCount(iStackCount)
		if iStackCount <= 0 then
			self:Destroy()
		end
	end
end

---=======================================================
modifier_dazzle_bad_juju_lua_counter = class({}) ---@class CDOTA_Modifier_Lua
function modifier_dazzle_bad_juju_lua_counter:IsHidden()
	return true
end

function modifier_dazzle_bad_juju_lua_counter:IsDebuff()
	return true
end

function modifier_dazzle_bad_juju_lua_counter:IsPurgable()
	return false
end

function modifier_dazzle_bad_juju_lua_counter:IsPurgeException()
	return false
end

function modifier_dazzle_bad_juju_lua_counter:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_dazzle_bad_juju_lua_counter:OnCreated(params)
	if IsServer() then
		self:StartIntervalThink(FrameTime())
		self.bonus_cooldown_pct = 0
		self:SetHasCustomTransmitterData(true)
	end
end

function modifier_dazzle_bad_juju_lua_counter:OnRefresh(params)
	if IsServer() then
	end
end

function modifier_dazzle_bad_juju_lua_counter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
end

function modifier_dazzle_bad_juju_lua_counter:RemoveOnDeath()
	return false
end

function modifier_dazzle_bad_juju_lua_counter:OnIntervalThink()
	local hParent = self:GetParent()
	local hSourceAbility = self:GetAbility()
	local iStack = 0
	local iStack_Cooldown = 0
	self.bonus_cooldown_pct = 0
	for index = 0, hParent:GetAbilityCount() - 1 do
		local hAbility = hParent:GetAbilityByIndex(index)
		if IsValid(hAbility) and hAbility:IsRefreshable() and hAbility ~= self and hAbility:GetCooldown(-1) > 0 and not hAbility:IsCooldownReady() then
			if hAbility:IsSealingAbility() then
				iStack = iStack +
				math.max(10, (-10) * math.sqrt(hAbility:GetCooldown(-1) * hParent:GetCooldownReduction()) + 120)
				iStack_Cooldown = iStack_Cooldown +
				math.max(10, (-2) * hAbility:GetCooldown(-1) * hParent:GetCooldownReduction() + 150)
			end
		end
	end
	-- for index = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
	-- 	local hItem = hParent:GetItemInSlot(index)
	-- 	if IsValid(hItem) and hItem:IsRefreshable() and hItem:GetCooldown(-1) > 0 and not hItem:IsCooldownReady() then
	-- 		if hItem:IsSealingAbility() then
	-- 			iStack = iStack + math.max(10, (-10) * math.sqrt(hItem:GetCooldown(-1) * hParent:GetCooldownReduction()) + 120)
	-- 			iStack_Cooldown = iStack_Cooldown + math.max(10, (-2) * hItem:GetCooldown(-1) * hParent:GetCooldownReduction() + 150)
	-- 		end
	-- 	end
	-- end
	self.bonus_cooldown_pct = iStack_Cooldown
	self:SendBuffRefreshToClients()
	self:SetStackCount(iStack)
	if hParent:GetHealth() <= hSourceAbility:GetEffectiveHealthCost(-1) + 1 then
		hSourceAbility:SetActivated(false)
	else
		hSourceAbility:SetActivated(true)
	end
end

function modifier_dazzle_bad_juju_lua_counter:AddCustomTransmitterData()
	return {
		bonus_cooldown_pct = self.bonus_cooldown_pct
	}
end

function modifier_dazzle_bad_juju_lua_counter:HandleCustomTransmitterData(t)
	self.bonus_cooldown_pct = t.bonus_cooldown_pct
end

function modifier_dazzle_bad_juju_lua_counter:GetModifierPercentageCooldown(params)
	local hAbility = self:GetAbility()
	if params.ability == hAbility then
		return -self.bonus_cooldown_pct
	end
end

---=======================================================
modifier_dazzle_bad_juju_lua_debuff = class({})
function modifier_dazzle_bad_juju_lua_debuff:IsHidden()
	return false
end

function modifier_dazzle_bad_juju_lua_debuff:IsDebuff()
	return true
end

function modifier_dazzle_bad_juju_lua_debuff:IsPurgable()
	return true
end

function modifier_dazzle_bad_juju_lua_debuff:IsPurgeException()
	return true
end

function modifier_dazzle_bad_juju_lua_debuff:OnCreated(params)
	local ability = self:GetAbility()
	if ability then
		self.armor_reduction = ability:GetSpecialValueFor("armor_reduction")
	else
		self.armor_reduction = 0
	end

	if IsServer() then
		self:SetStackCount(1)
		local hParent = self:GetParent()
		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_dazzle/dazzle_armor_enemy.vpcf",
			PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_OVERHEAD_FOLLOW, "", Vector(0, 0, 0), true)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, hParent, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0),
			true)
		self:AddParticle(iParticleID, false, false, -1, false, false)
	end
end

function modifier_dazzle_bad_juju_lua_debuff:OnRefresh(params)
	self.armor_reduction = self:GetAbilitySpecialValueFor("armor_reduction")
	if IsServer() then
		self:IncrementStackCount()
	end
end

function modifier_dazzle_bad_juju_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_dazzle_bad_juju_lua_debuff:GetModifierMagicalResistanceBonus()
	return -self:GetStackCount() * self.armor_reduction
end