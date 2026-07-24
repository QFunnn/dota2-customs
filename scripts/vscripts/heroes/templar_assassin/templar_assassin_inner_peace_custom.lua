--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_templar_assassin_inner_peace_custom", "heroes/templar_assassin/templar_assassin_inner_peace_custom.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_templar_assassin_inner_peace_custom_activity", "heroes/templar_assassin/templar_assassin_inner_peace_custom.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if templar_assassin_inner_peace_custom == nil then
	templar_assassin_inner_peace_custom = class({})
end
function templar_assassin_inner_peace_custom:GetIntrinsicModifierName()
	return "modifier_templar_assassin_inner_peace_custom"
end
---------------------------------------------------------------------
--Modifiers
if modifier_templar_assassin_inner_peace_custom == nil then
	modifier_templar_assassin_inner_peace_custom = class({})
end

local THINK_INTERVAL = 0.03

function modifier_templar_assassin_inner_peace_custom:OnCreated(params)
	if IsServer() then
		self.last_position = self:GetParent():GetAbsOrigin()
		self.idle_time = 0
		self.is_meditating = false
		self.meditation_time = 0
		self:StartIntervalThink(THINK_INTERVAL)
	end
end

function modifier_templar_assassin_inner_peace_custom:OnRefresh(params)
	if IsServer() then
		self:OnCreated(params)
	end
end

function modifier_templar_assassin_inner_peace_custom:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveModifierByName("modifier_templar_assassin_inner_peace_custom_activity")
	end
end

function modifier_templar_assassin_inner_peace_custom:OnIntervalThink()
	local parent = self:GetParent()
	local current_position = parent:GetAbsOrigin()

	-- 检查英雄是否移动了（判断两次think位置是否相等）
	local moved = current_position ~= self.last_position
	self.last_position = current_position

	if moved then
		-- 英雄移动了，重置所有状态
		self.idle_time = 0
		if self.is_meditating then
			parent:RemoveModifierByName("modifier_templar_assassin_inner_peace_custom_activity")
		end
		self.is_meditating = false
		self.meditation_time = 0
		self:SetStackCount(0)
		self:GetParent():RemoveGesture(ACT_DOTA_IDLE)
		return
	end

	-- 累加静止时间
	self.idle_time = self.idle_time + THINK_INTERVAL

	local time_until_meditation = self:GetAbility():GetSpecialValueFor("time_until_meditation")

	if self.idle_time >= time_until_meditation then
		-- 开始冥想或继续冥想
		if not self.is_meditating then
			self.is_meditating = true
			self.meditation_time = 0
			self:GetParent():StartGesture(ACT_DOTA_IDLE)
			-- 添加冥想Activity modifier
			parent:AddNewModifier(parent, self:GetAbility(), "modifier_templar_assassin_inner_peace_custom_activity", {})
		end

		local time_until_max_bonus = self:GetAbility():GetSpecialValueFor("time_until_max_bonus")
		-- 限制 time_until_max_bonus 不小于 0
		time_until_max_bonus = math.max(time_until_max_bonus, 0)

		self.meditation_time = self.meditation_time + THINK_INTERVAL

		-- 限制冥想时间不超过最大加成时间
		if time_until_max_bonus > 0 then
			self.meditation_time = math.min(self.meditation_time, time_until_max_bonus)
		end

		-- 用 stackcount 同步加成比例到客户端（0~100 表示 0%~100%）
		local ratio = 1
		if time_until_max_bonus > 0 then
			ratio = math.min(self.meditation_time / time_until_max_bonus, 1)
		end
		self:SetStackCount(math.floor(ratio * 100))
	end
end

function modifier_templar_assassin_inner_peace_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_templar_assassin_inner_peace_custom:GetModifierConstantHealthRegen()
	local stacks = self:GetStackCount()
	if stacks <= 0 then
		return 0
	end
	local max_hp_regen = self:GetAbility():GetSpecialValueFor("max_hp_regen")
	return max_hp_regen * stacks / 100
end

function modifier_templar_assassin_inner_peace_custom:GetModifierConstantManaRegen()
	local stacks = self:GetStackCount()
	if stacks <= 0 then
		return 0
	end
	local max_mana_regen = self:GetAbility():GetSpecialValueFor("max_mana_regen")
	return max_mana_regen * stacks / 100
end

function modifier_templar_assassin_inner_peace_custom:IsHidden()
	return self:GetStackCount() <= 0
end

function modifier_templar_assassin_inner_peace_custom:IsPurgable()
	return false
end

function modifier_templar_assassin_inner_peace_custom:RemoveOnDeath()
	return false
end

---------------------------------------------------------------------
-- 冥想Activity Modifier
if modifier_templar_assassin_inner_peace_custom_activity == nil then
	modifier_templar_assassin_inner_peace_custom_activity = class({})
end

function modifier_templar_assassin_inner_peace_custom_activity:IsHidden()
	return true
end

function modifier_templar_assassin_inner_peace_custom_activity:IsPurgable()
	return false
end

function modifier_templar_assassin_inner_peace_custom_activity:IsDebuff()
	return false
end

function modifier_templar_assassin_inner_peace_custom_activity:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_templar_assassin_inner_peace_custom_activity:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
	}
end

function modifier_templar_assassin_inner_peace_custom_activity:GetActivityTranslationModifiers()
	return "meditation"
end