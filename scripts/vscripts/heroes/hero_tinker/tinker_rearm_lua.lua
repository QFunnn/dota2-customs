--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tinker_rearm_lua", "heroes/hero_tinker/tinker_rearm_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tinker_rearm_lua_buff", "heroes/hero_tinker/tinker_rearm_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tinker_rearm_lua_counter", "heroes/hero_tinker/tinker_rearm_lua", LUA_MODIFIER_MOTION_NONE)

local MODIFIER_CHANNEL = "modifier_tinker_rearm_lua"
local MODIFIER_BUFF = "modifier_tinker_rearm_lua_buff"

local REARM_START_SOUND = "Hero_Tinker.RearmStart"
local REARM_FINISH_SOUND = "Hero_Tinker.Rearm"
local REARM_PARTICLE = "particles/units/heroes/hero_tinker/tinker_loadout.vpcf"

local REARM_EXEMPT_ITEMS = {
	item_black_king_bar = true,
	item_arcane_boots = true,
	item_guardian_greaves = true,
	item_sphere = true,
	item_demonicon = true,
	item_demonicon_custom = true,
	item_aeon_disk_lua = true,
	item_hand_of_midas_lua = true,
}

if tinker_rearm_lua == nil then
	tinker_rearm_lua = class({}) ---@class tinker_rearm_lua : CDOTA_Ability_Lua
end

local function IsRearmExemptItem(item)
	return IsValid(item) and REARM_EXEMPT_ITEMS[item:GetAbilityName()] == true
end

local function IsRefreshableRearmTarget(ability)
	return IsValid(ability) and ability:IsRefreshable() and not ability:IsNotRearmableAbility()
end

local function RefreshAbilityCooldown(ability)
	if not ability:IsCooldownReady() then
		ability:EndCooldown()
	end
end

local function RefreshAbilityCharges(ability)
	local maxCharges = ability:GetMaxAbilityCharges(-1)
	if maxCharges <= 0 then
		return
	end

	local currentCharges = ability:GetCurrentAbilityCharges()
	if currentCharges < maxCharges - 1 then
		ability:SetCurrentAbilityCharges(currentCharges + 1)
	else
		ability:RefreshCharges()
	end
end

local function RefreshRearmTarget(ability)
	if not IsRefreshableRearmTarget(ability) then
		return
	end

	RefreshAbilityCooldown(ability)
	RefreshAbilityCharges(ability)
end

local function GetNotRearmableCooldownBonus(ability, bonusRate, bonusBase)
	if not IsValid(ability) or not ability:IsRefreshable() or not ability:IsNotRearmableAbility() then
		return 0
	end

	if not ability:IsCooldownReady() then
		return ability:GetCooldownTimeRemaining() * bonusRate + bonusBase
	end

	if ability:GetMaxAbilityCharges(-1) > 0 then
		return ability:GetAbilityChargeRestoreTime(-1) * bonusRate + bonusBase
	end

	return 0
end

local function SyncSealingBonusTime(modifier, bonusTime)
	local ability = modifier:GetAbility()
	if IsValid(ability) then
		ability.SealingBonusTime = bonusTime
	end
end

function tinker_rearm_lua:OnSpellStart()
	local caster = self:GetCaster()
	caster:AddNewModifier(caster, self, MODIFIER_CHANNEL, { duration = self:GetChannelTime() })
	EmitSoundOn(REARM_START_SOUND, caster)
end

function tinker_rearm_lua:GetChannelAnimation()
	local caster = self:GetCaster()
	if caster:GetUnitName() == "npc_dota_hero_tinker" then
		return _G["ACT_DOTA_TINKER_REARM" .. self:GetLevel()]
	end
	return ACT_DOTA_GENERIC_CHANNEL_1
end

function tinker_rearm_lua:OnChannelFinish(bInterrupted)
	local caster = self:GetCaster()

	StopSoundOn(REARM_START_SOUND, caster)
	caster:RemoveModifierByName(MODIFIER_CHANNEL)
	if bInterrupted then
		return
	end
	EmitSoundOn(REARM_FINISH_SOUND, caster)

	for index = 0, caster:GetAbilityCount() - 1 do
		RefreshRearmTarget(caster:GetAbilityByIndex(index))
	end

	for index = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
		local item = caster:GetItemInSlot(index)
		if IsValid(item) and item:IsRefreshable() and not IsRearmExemptItem(item) then
			RefreshAbilityCooldown(item)
		end
	end

	caster:AddNewModifier(caster, self, MODIFIER_BUFF, { duration = self:GetSpecialValueFor("buff_duration") })
end

---------------------------------------------------------------------
-- Modifiers
if modifier_tinker_rearm_lua == nil then
	modifier_tinker_rearm_lua = class({})
end

function modifier_tinker_rearm_lua:IsHidden()
	return false
end

function modifier_tinker_rearm_lua:IsDebuff()
	return false
end

function modifier_tinker_rearm_lua:IsPurgable()
	return false
end

function modifier_tinker_rearm_lua:IsPurgeException()
	return false
end

function modifier_tinker_rearm_lua:OnCreated(params)
	if IsServer() then
		local parent = self:GetParent()
		local particleId = ParticleManager:CreateParticle(REARM_PARTICLE, PATTACH_CUSTOMORIGIN_FOLLOW, parent)
		ParticleManager:SetParticleControlEnt(
			particleId,
			0,
			parent,
			PATTACH_POINT_FOLLOW,
			"attach_attack2",
			Vector(0, 0, 0),
			true
		)
		self:AddParticle(particleId, false, false, -1, false, false)
	end

	self.magic_resistance = self:GetAbilitySpecialValueFor("magic_resistance")
end

function modifier_tinker_rearm_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_tinker_rearm_lua:GetModifierMagicalResistanceBonus()
	return self.magic_resistance
end

function modifier_tinker_rearm_lua:GetEffectName()
	return REARM_PARTICLE
end

function modifier_tinker_rearm_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

---=======================================================
modifier_tinker_rearm_lua_counter = class({})

function modifier_tinker_rearm_lua_counter:IsHidden()
	return (self.bonus_time or 0) <= 0
end

function modifier_tinker_rearm_lua_counter:IsDebuff()
	return true
end

function modifier_tinker_rearm_lua_counter:IsPurgable()
	return false
end

function modifier_tinker_rearm_lua_counter:IsPurgeException()
	return false
end

function modifier_tinker_rearm_lua_counter:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_tinker_rearm_lua_counter:OnCreated(params)
	self.sealing_bonus_base = self:GetAbilitySpecialValueFor("sealing_bonus_base")
	self.sealing_bonus_rate = self:GetAbilitySpecialValueFor("sealing_bonus_rate")

	if IsServer() then
		self:StartIntervalThink(FrameTime())
		self:SetHasCustomTransmitterData(true)
	end
end

function modifier_tinker_rearm_lua_counter:OnRefresh(params)
	self.sealing_bonus_base = self:GetAbilitySpecialValueFor("sealing_bonus_base")
	self.sealing_bonus_rate = self:GetAbilitySpecialValueFor("sealing_bonus_rate")
end

function modifier_tinker_rearm_lua_counter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end

function modifier_tinker_rearm_lua_counter:OnIntervalThink()
	local parent = self:GetParent()
	local sourceAbility = self:GetAbility()
	local bonusTime = 0

	for index = 0, parent:GetAbilityCount() - 1 do
		local ability = parent:GetAbilityByIndex(index)
		if ability ~= sourceAbility then
			bonusTime = bonusTime
				+ GetNotRearmableCooldownBonus(ability, self.sealing_bonus_rate, self.sealing_bonus_base)
		end
	end

	for index = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
		local item = parent:GetItemInSlot(index)
		if IsValid(item) and item:GetCooldown(-1) > 0 and not IsRearmExemptItem(item) then
			bonusTime = bonusTime + GetNotRearmableCooldownBonus(item, self.sealing_bonus_rate, self.sealing_bonus_base)
		end
	end

	if IsValid(sourceAbility) and not sourceAbility:IsChanneling() then
		self.bonus_time = bonusTime
		self:SendBuffRefreshToClients()
	end
end

function modifier_tinker_rearm_lua_counter:AddCustomTransmitterData()
	SyncSealingBonusTime(self, self.bonus_time)
	return {
		bonus_time = self.bonus_time,
	}
end

function modifier_tinker_rearm_lua_counter:HandleCustomTransmitterData(data)
	self.bonus_time = data.bonus_time
	SyncSealingBonusTime(self, self.bonus_time)
end

function modifier_tinker_rearm_lua_counter:OnTooltip()
	local ability = self:GetAbility()
	if IsValid(ability) then
		return ability:GetCooldown(-1)
	end
end

function modifier_tinker_rearm_lua_counter:OnTooltip2()
	local ability = self:GetAbility()
	if IsValid(ability) then
		return ability:GetChannelTime()
	end
end

---=======================================================
modifier_tinker_rearm_lua_buff = class({})

function modifier_tinker_rearm_lua_buff:IsHidden()
	return false
end

function modifier_tinker_rearm_lua_buff:IsDebuff()
	return false
end

function modifier_tinker_rearm_lua_buff:IsPurgable()
	return false
end

function modifier_tinker_rearm_lua_buff:IsPurgeException()
	return false
end

function modifier_tinker_rearm_lua_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_tinker_rearm_lua_buff:OnCreated(params)
	self.bonus_status_resistance = self:GetAbilitySpecialValueFor("bonus_status_resistance")

	if IsServer() then
		self.tStack = {}
		self:StartIntervalThink(FrameTime())
		self:AddStack(params)
	end
end

function modifier_tinker_rearm_lua_buff:OnRefresh(params)
	self.bonus_status_resistance = self:GetAbilitySpecialValueFor("bonus_status_resistance")

	if IsServer() then
		self:AddStack(params)
	end
end

function modifier_tinker_rearm_lua_buff:AddStack(params)
	local count = params.stack or 1
	local duration = params.duration or 0

	table.insert(self.tStack, {
		fDieTime = GameRulesCustom:GetGameTime() + duration,
		iCount = count,
	})
	self:SetStackCount(self:GetStackCount() + count)
end

function modifier_tinker_rearm_lua_buff:OnIntervalThink()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(parent) or not IsValid(ability) then
		self:Destroy()
		return
	end

	local gameTime = GameRulesCustom:GetGameTime()
	for index = #self.tStack, 1, -1 do
		local stack = self.tStack[index]
		if gameTime >= stack.fDieTime then
			self:SetStackCount(math.max(0, self:GetStackCount() - stack.iCount))
			table.remove(self.tStack, index)
		end
	end
end

function modifier_tinker_rearm_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_CASTER,
	}
end

function modifier_tinker_rearm_lua_buff:GetModifierStatusResistanceCaster(params)
	return -self.bonus_status_resistance * self:GetStackCount()
end