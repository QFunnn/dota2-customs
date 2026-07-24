--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_butterfly_2", "item_ability/item_butterfly_2.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_butterfly_2_buff_damage", "item_ability/item_butterfly_2.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_butterfly_2_buff_evasion", "item_ability/item_butterfly_2.lua", LUA_MODIFIER_MOTION_NONE)

--Abilities
if item_butterfly_2 == nil then
	item_butterfly_2 = class({})
end
function item_butterfly_2:GetIntrinsicModifierName()
	return "modifier_item_butterfly_2"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_butterfly_2 == nil then
	modifier_item_butterfly_2 = class({})
end
function modifier_item_butterfly_2:IsHidden()
	return false
end
function modifier_item_butterfly_2:IsDebuff()
	return false
end
function modifier_item_butterfly_2:IsPurgable()
	return false
end
function modifier_item_butterfly_2:IsPurgeException()
	return false
end
function modifier_item_butterfly_2:RemoveOnDeath()
	return false
end
function modifier_item_butterfly_2:OnCreated(params)
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_attack_speed_pct = self:GetAbilitySpecialValueFor("bonus_attack_speed_pct")
	self.bonus_evasion = self:GetAbilitySpecialValueFor("bonus_evasion")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_attack_speed_limit_threshold = self:GetAbilitySpecialValueFor("bonus_attack_speed_limit_threshold")
	self.bonus_attack_speed_limit_max = self:GetAbilitySpecialValueFor("bonus_attack_speed_limit_max")
	self.bonus_attack_speed_limit = self:GetAbilitySpecialValueFor("bonus_attack_speed_limit")
	self.bonus_agi_pct = self:GetAbilitySpecialValueFor("bonus_agi_pct")
	self.buff_duration = self:GetAbilitySpecialValueFor("buff_duration")
	if IsServer() then
		self.iBonusAttackSpeed = 0
		self.fMaxDisplayAttackSpeed = 0
		self.BonusPctAgility = 0
		self:SetHasCustomTransmitterData(true)
		self:StartIntervalThink(1)
		self:OnIntervalThink()
	end
end
function modifier_item_butterfly_2:OnRefresh(params)
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_attack_speed_pct = self:GetAbilitySpecialValueFor("bonus_attack_speed_pct")
	self.bonus_evasion = self:GetAbilitySpecialValueFor("bonus_evasion")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	self.bonus_attack_speed_limit_threshold = self:GetAbilitySpecialValueFor("bonus_attack_speed_limit_threshold")
	self.bonus_attack_speed_limit_max = self:GetAbilitySpecialValueFor("bonus_attack_speed_limit_max")
	self.bonus_attack_speed_limit = self:GetAbilitySpecialValueFor("bonus_attack_speed_limit")
	self.bonus_agi_pct = self:GetAbilitySpecialValueFor("bonus_agi_pct")
	self.buff_duration = self:GetAbilitySpecialValueFor("buff_duration")
	if IsServer() then
	end
end
function modifier_item_butterfly_2:OnRemoved(bDeath)
	if IsServer() then
	end
end
function modifier_item_butterfly_2:OnDestroy()
	if IsServer() then
		self:SetHasCustomTransmitterData(false)
	end
end
function modifier_item_butterfly_2:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		-- MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
		MODIFIER_PROPERTY_ATTACKSPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function modifier_item_butterfly_2:AddCustomTransmitterData()
	return {
		iBonusAttackSpeed = self.iBonusAttackSpeed,
		fMaxDisplayAttackSpeed = self.fMaxDisplayAttackSpeed,
		BonusPctAgility = self.BonusPctAgility,
	}
end
function modifier_item_butterfly_2:HandleCustomTransmitterData(t)
	self.iBonusAttackSpeed = t.iBonusAttackSpeed
	self.fMaxDisplayAttackSpeed = t.fMaxDisplayAttackSpeed
	self.BonusPctAgility = t.BonusPctAgility
end
function modifier_item_butterfly_2:OnIntervalThink()
	local hParent = self:GetParent()
	local iAgility = hParent:GetAgility()
	local iOriginalAgility = iAgility - self.BonusPctAgility

	self.BonusPctAgility = math.floor(iOriginalAgility * self.bonus_agi_pct * 0.01)
	self:SendBuffRefreshToClients()
end
function modifier_item_butterfly_2:GetModifierAttackSpeedBaseOverride(params)
	local hParent = self:GetParent()
	local fAttackSpeedPercent = self.bonus_attack_speed_pct
	local fMaxPct = 700
	if hParent:HasModifier("modifier_marci_unleash_flurry") then
		fMaxPct = 9999
	else
		local fOriginalMaxAttackSpeed = math.ceil(1.7 * 100 / (hParent:GetBaseAttackTime() * 100 / 700))
		local iAgility = hParent:GetAgility()
		local iBonusAttackSpeed = math.min(self.bonus_attack_speed_limit_max, math.floor(iAgility / self.bonus_attack_speed_limit_threshold) * self.bonus_attack_speed_limit)
		local fTargetMaxAttackSpeed = fOriginalMaxAttackSpeed + iBonusAttackSpeed
		fMaxPct = hParent:GetBaseAttackTime() / 1.7 * fTargetMaxAttackSpeed
		if iBonusAttackSpeed ~= self.iBonusAttackSpeed or fTargetMaxAttackSpeed ~= self.fMaxDisplayAttackSpeed then
			self.iBonusAttackSpeed = iBonusAttackSpeed
			self.fMaxDisplayAttackSpeed = fTargetMaxAttackSpeed
			if self.SendBuffRefreshToClients and type(self.SendBuffRefreshToClients) == "function" then
				self:SendBuffRefreshToClients()
			end
		end
	end


	-- 计算全部攻击速度百分比
	if hParent:HasModifier("modifier_tiny_grow") then
		fAttackSpeedPercent = fAttackSpeedPercent - 30
	end
	fAttackSpeedPercent = (100 + fAttackSpeedPercent) * 0.01

	return Clamp(1 + hParent:GetIncreasedAttackSpeed(false) * fAttackSpeedPercent, 20 * 0.01, fMaxPct * 0.01)
end
function modifier_item_butterfly_2:GetModifierAttackSpeedBonus_Constant(params)
	return self.bonus_attack_speed
end
function modifier_item_butterfly_2:GetModifierAttackSpeedPercentage(params)
	return self.bonus_attack_speed_pct
end
function modifier_item_butterfly_2:GetModifierEvasion_Constant(params)
	return self.bonus_evasion
end
function modifier_item_butterfly_2:GetModifierBonusStats_Agility()
	return self.bonus_agi + self.BonusPctAgility
end
function modifier_item_butterfly_2:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_butterfly_2:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()

	if IsValid(hParent) and IsValid(hAbility) then
		hParent:AddNewModifier(hParent, hAbility, "modifier_item_butterfly_2_buff_damage", { duration = self.buff_duration })
	end
end
function modifier_item_butterfly_2:OnTooltip()
	return self.iBonusAttackSpeed
end
function modifier_item_butterfly_2:OnTooltip2()
	return self.fMaxDisplayAttackSpeed
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_butterfly_2_buff_damage == nil then
	modifier_item_butterfly_2_buff_damage = class({})
end
function modifier_item_butterfly_2_buff_damage:IsHidden()
	return false
end
function modifier_item_butterfly_2_buff_damage:IsDebuff()
	return false
end
function modifier_item_butterfly_2_buff_damage:IsPurgable()
	return false
end
function modifier_item_butterfly_2_buff_damage:IsPurgeException()
	return false
end
function modifier_item_butterfly_2_buff_damage:OnCreated(params)
	self.buff_attack_speed = self:GetAbilitySpecialValueFor("buff_attack_speed")
	self.buff_attack_speed_max_stack = self:GetAbilitySpecialValueFor("buff_attack_speed_max_stack")
	self.buff_agi_max_stack = self:GetAbilitySpecialValueFor("buff_agi_max_stack")
	self.buff_max_stack = self:GetAbilitySpecialValueFor("buff_max_stack")
	if IsServer() then
		self:SetStackCount(1)
	end
end
function modifier_item_butterfly_2_buff_damage:OnRefresh(params)
	self.buff_attack_speed = self:GetAbilitySpecialValueFor("buff_attack_speed")
	self.buff_attack_speed_max_stack = self:GetAbilitySpecialValueFor("buff_attack_speed_max_stack")
	self.buff_agi_max_stack = self:GetAbilitySpecialValueFor("buff_agi_max_stack")
	self.buff_max_stack = self:GetAbilitySpecialValueFor("buff_max_stack")
	if IsServer() then
		local iStack = self:GetStackCount()
		self:SetStackCount(math.min(iStack + 1, self.buff_max_stack))
	end
end
function modifier_item_butterfly_2_buff_damage:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_butterfly_2_buff_damage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
end
function modifier_item_butterfly_2_buff_damage:GetModifierAttackSpeedBonus_Constant(params)
	local fBonusAttackSpeed = self.buff_attack_speed * self:GetStackCount()
	if self:GetStackCount() >= self.buff_max_stack then
		fBonusAttackSpeed = fBonusAttackSpeed + self.buff_attack_speed_max_stack
	end
	return fBonusAttackSpeed
end
function modifier_item_butterfly_2_buff_damage:GetModifierBonusStats_Agility()
	if self:GetStackCount() >= self.buff_max_stack then
		return self.buff_agi_max_stack
	end
end
function modifier_item_butterfly_2_buff_damage:GetTexture()
	return "item_butterfly"
end