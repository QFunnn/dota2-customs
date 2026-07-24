--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_felling_shield_lua_1", "item_ability/item_felling_shield_lua_1.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_felling_shield_lua_buff", "item_ability/item_felling_shield_lua_1.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_felling_shield_lua_shield", "item_ability/item_felling_shield_lua_1.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_felling_shield_lua_1 == nil then
	item_felling_shield_lua_1 = class({})
end
function item_felling_shield_lua_1:GetIntrinsicModifierName()
	return "modifier_item_felling_shield_lua_1"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_felling_shield_lua_1 == nil then
	modifier_item_felling_shield_lua_1 = class({})
end
function modifier_item_felling_shield_lua_1:IsHidden()
	return true
end
function modifier_item_felling_shield_lua_1:IsDebuff()
	return false
end
function modifier_item_felling_shield_lua_1:IsPurgable()
	return false
end
function modifier_item_felling_shield_lua_1:IsPurgeException()
	return false
end
function modifier_item_felling_shield_lua_1:OnCreated(params)
	self.shield_duration = self:GetAbilitySpecialValueFor("shield_duration")
	self.shield_hp_pct = self:GetAbilitySpecialValueFor("shield_hp_pct")
	self.max_shield_hp = self:GetAbilitySpecialValueFor("max_shield_hp")
	self.buff_chance = self:GetAbilitySpecialValueFor("buff_chance")
	self.buff_duration = self:GetAbilitySpecialValueFor("buff_duration")
	self.all_stats = self:GetAbilitySpecialValueFor("all_stats")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.feedback_mana_burn = self:GetAbilitySpecialValueFor("feedback_mana_burn")
	self.damage_per_burn = self:GetAbilitySpecialValueFor("damage_per_burn")
	self.bonus_hp = self:GetAbilitySpecialValueFor("bonus_hp")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_1:OnRefresh(params)
	self.shield_duration = self:GetAbilitySpecialValueFor("shield_duration")
	self.shield_hp_pct = self:GetAbilitySpecialValueFor("shield_hp_pct")
	self.max_shield_hp = self:GetAbilitySpecialValueFor("max_shield_hp")
	self.buff_chance = self:GetAbilitySpecialValueFor("buff_chance")
	self.buff_duration = self:GetAbilitySpecialValueFor("buff_duration")
	self.all_stats = self:GetAbilitySpecialValueFor("all_stats")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.feedback_mana_burn = self:GetAbilitySpecialValueFor("feedback_mana_burn")
	self.damage_per_burn = self:GetAbilitySpecialValueFor("damage_per_burn")
	self.bonus_hp = self:GetAbilitySpecialValueFor("bonus_hp")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_damage = self:GetAbilitySpecialValueFor("bonus_damage")
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_1:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_1:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end
function modifier_item_felling_shield_lua_1:GetModifierHealthBonus()
	return self.bonus_hp
end
function modifier_item_felling_shield_lua_1:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end
function modifier_item_felling_shield_lua_1:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
function modifier_item_felling_shield_lua_1:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_felling_shield_lua_1:GetModifierBonusStats_Strength()
	return self.all_stats + self.bonus_str
end
function modifier_item_felling_shield_lua_1:GetModifierBonusStats_Agility()
	return self.all_stats + self.bonus_agi
end
function modifier_item_felling_shield_lua_1:GetModifierBonusStats_Intellect()
	return self.all_stats + self.bonus_int
end
function modifier_item_felling_shield_lua_1:GetModifierProcAttack_BonusDamage_Physical(params)
	local name = self:GetName()
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hTarget = params.target
	local buffs = hParent:FindAllModifiersByName(name)
	local hAbility = self:GetAbility()
	if self == buffs[1] then
		if IsValid(hParent) and IsValid(hAttacker) and IsValid(hTarget) and hAttacker == hParent and not hTarget:HasState(MODIFIER_STATE_DEBUFF_IMMUNE) then
			if self.feedback_mana_burn > 0 then
				local mana_burned = math.min(self.feedback_mana_burn, (hTarget:GetMana() or 0))
				if mana_burned > 0 then
					hTarget:Script_ReduceMana(mana_burned, hAbility)

					if IsValid(hTarget) then
						local iParticleID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
						ParticleManager:DestroyParticle(iParticleID, false)
						ParticleManager:ReleaseParticleIndex(iParticleID)
					end
					--[[Wearable_System:PlayItemEffect(hParent:GetPlayerOwnerID(), hParent, self:GetAbility():GetAbilityName(), MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL, {
						hTarget = hTarget,
					})]]

					return mana_burned * self.damage_per_burn
				end
			end
		end
	end
end
function modifier_item_felling_shield_lua_1:OnAttackLanded(params)
	local name = self:GetName()
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	local hTarget = params.target
	local buffs = hParent:FindAllModifiersByName(name)

	if self == buffs[1] then
		if IsValid(hParent) and IsValid(hAttacker) and IsValid(hTarget) and hAttacker == hParent and hTarget:IsNeutralUnitType() then
			local damage = params.damage or 0
			if damage > 0 then
				local stack = damage * self.shield_hp_pct * 0.01
				stack = math.min(stack, self.max_shield_hp)
				hParent:AddNewModifier(hParent, self:GetAbility(), "modifier_item_felling_shield_lua_shield", { duration = self.shield_duration, stack = stack })
			end
			if RandomFloat(0, 100) < self.buff_chance then
				hParent:AddNewModifier(hParent, self:GetAbility(), "modifier_item_felling_shield_lua_buff", { duration = self.buff_duration })
			end
		end
	end
end
function modifier_item_felling_shield_lua_1:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_felling_shield_lua_buff == nil then
	modifier_item_felling_shield_lua_buff = class({})
end
function modifier_item_felling_shield_lua_buff:IsHidden()
	return false
end
function modifier_item_felling_shield_lua_buff:IsDebuff()
	return false
end
function modifier_item_felling_shield_lua_buff:IsPurgable()
	return false
end
function modifier_item_felling_shield_lua_buff:IsPurgeException()
	return false
end
function modifier_item_felling_shield_lua_buff:OnCreated(params)
	self.creep_damage_reduce = self:GetAbilitySpecialValueFor("creep_damage_reduce")
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_buff:OnRefresh(params)
	self.creep_damage_reduce = self:GetAbilitySpecialValueFor("creep_damage_reduce")
	if IsServer() then
	end
end
function modifier_item_felling_shield_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function modifier_item_felling_shield_lua_buff:GetModifierIncomingDamage_Percentage(params)
	local hParent = self:GetParent()
	local hAttacker = params.attacker
	if IsServer() then
		if IsValid(hParent) and IsValid(hAttacker) and hAttacker:IsNeutralUnitType() then
			return -self.creep_damage_reduce
		end
	end
end
function modifier_item_felling_shield_lua_buff:OnTooltip()
	return self.creep_damage_reduce
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_felling_shield_lua_shield == nil then
	modifier_item_felling_shield_lua_shield = class({})
end
function modifier_item_felling_shield_lua_shield:IsHidden()
	return false
end
function modifier_item_felling_shield_lua_shield:IsDebuff()
	return false
end
function modifier_item_felling_shield_lua_shield:IsPurgable()
	return false
end
function modifier_item_felling_shield_lua_shield:IsPurgeException()
	return false
end
function modifier_item_felling_shield_lua_shield:OnCreated(params)
	self.max_hp_pct = self:GetAbilitySpecialValueFor("max_hp_pct")
	self.max_hp_base = self:GetAbilitySpecialValueFor("max_hp_base")
	if IsServer() then
		local hParent = self:GetParent()
		local max_stack = hParent:GetMaxHealth() * self.max_hp_pct * 0.01 + self.max_hp_base

		if self then
			local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_sven/sven_warcry_buff_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
			ParticleManager:SetParticleControl(iParticleID, 1, Vector(120, 0, 0))
			ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
			self:AddParticle(iParticleID, false, false, -1, false, false)
		end
		--[[Wearable_System:PlayItemEffect(hParent:GetPlayerOwnerID(), hParent, self:GetAbility():GetAbilityName(), MODIFIER_PROPERTY_PROCATTACK_FEEDBACK, {
			tBuff = self,
		})]]
		self:SetStackCount(math.min(max_stack, params.stack or 0))
	end
end
function modifier_item_felling_shield_lua_shield:OnRefresh(params)
	self.max_hp_pct = self:GetAbilitySpecialValueFor("max_hp_pct")
	self.max_hp_base = self:GetAbilitySpecialValueFor("max_hp_base")
	if IsServer() then
		local hParent = self:GetParent()
		local stack = params.stack or 0
		if stack > 0 then
			local max_stack = hParent:GetMaxHealth() * self.max_hp_pct * 0.01 + self.max_hp_base
			self:SetStackCount(math.min(max_stack, self:GetStackCount() + stack))
		end
	end
end
function modifier_item_felling_shield_lua_shield:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function modifier_item_felling_shield_lua_shield:OnTooltip()
	return self:GetStackCount()
end
function modifier_item_felling_shield_lua_shield:OnStackCountChanged(iStackCount)
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
end
function modifier_item_felling_shield_lua_shield:GetModifierIncomingPhysicalDamageConstant(params)
	local parent = self:GetParent()
	local attacker = params.attacker
	if IsServer() then
		if IsValid(parent) and IsValid(attacker) then
			if parent:GetTeamNumber() ~= attacker:GetTeamNumber() and attacker:IsNeutralUnitType() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS then
				local damage = params.damage or 0
				if parent:HasModifier("modifier_templar_assassin_refraction_absorb") then return 0 end
				local shield_hp = self:GetStackCount()
				if damage > 0 then
					if damage >= shield_hp then
						self:SetStackCount(0)
						return -(shield_hp + 1)
					else
						self:SetStackCount(shield_hp - damage)
						return -(damage + 1)
					end
				end
			end
		end
	else
		return self:GetStackCount()
	end
end