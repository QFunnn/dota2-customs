--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if tinker_rearm_lua == nil then
	tinker_rearm_lua = class({})
end
LinkLuaModifier("modifier_tinker_rearm_lua", "heroes/hero_tinker/tinker_rearm_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tinker_rearm_lua_buff", "heroes/hero_tinker/tinker_rearm_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tinker_rearm_lua_counter", "heroes/hero_tinker/tinker_rearm_lua", LUA_MODIFIER_MOTION_NONE)

-- function tinker_rearm_lua:GetIntrinsicModifierName()
-- 	return "modifier_tinker_rearm_lua_counter"
-- end
function tinker_rearm_lua:OnSpellStart()
	local hCaster = self:GetCaster()

	hCaster:AddNewModifier(hCaster, self, "modifier_tinker_rearm_lua", { duration = self:GetChannelTime() })
	EmitSoundOn("Hero_Tinker.RearmStart", hCaster)
end
function tinker_rearm_lua:GetChannelAnimation()
	local hCaster = self:GetCaster()
	if hCaster:GetUnitName() == "npc_dota_hero_tinker" then
		return _G["ACT_DOTA_TINKER_REARM" .. self:GetLevel()]
	else
		return ACT_DOTA_GENERIC_CHANNEL_1
	end
end
function tinker_rearm_lua:OnChannelFinish(bInterrupted)
	local hCaster = self:GetCaster()
	local buff_duration = self:GetSpecialValueFor("buff_duration")

	StopSoundOn("Hero_Tinker.RearmStart", hCaster)
	hCaster:RemoveModifierByName("modifier_tinker_rearm_lua")
	if bInterrupted then
		return
	end
	EmitSoundOn("Hero_Tinker.Rearm", hCaster)

	-- Put item exemption in here
	local exempt_table = {}
	exempt_table["item_black_king_bar"] = true
	exempt_table["item_arcane_boots"] = true
	exempt_table["item_guardian_greaves"] = true
	exempt_table["item_sphere"] = true
	exempt_table["item_demonicon"] = true
	exempt_table["item_demonicon_custom"] = true
	exempt_table["item_aeon_disk_lua"] = true
	exempt_table["item_hand_of_midas_lua"] = true

	for index = 0, hCaster:GetAbilityCount() - 1 do
		local hAbility = hCaster:GetAbilityByIndex(index)
		if IsValid(hAbility) and hAbility:IsRefreshable() and (not hAbility:IsSealingAbility()) then
			if not hAbility:IsCooldownReady() then
				hAbility:EndCooldown()
			end
			if hAbility:GetMaxAbilityCharges(-1) > 0 then
				local iCurrentCharge = hAbility:GetCurrentAbilityCharges()
				local iMaxCharge = hAbility:GetMaxAbilityCharges(-1)
				if iCurrentCharge < iMaxCharge - 1 then
					hAbility:SetCurrentAbilityCharges(iCurrentCharge + 1)
				else
					hAbility:RefreshCharges()
				end
			end
		end
	end

	for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
		local hItem = hCaster:GetItemInSlot(i)
		if IsValid(hItem) and hItem:IsRefreshable() and not exempt_table[hItem:GetAbilityName()] then
			if not hItem:IsCooldownReady() then
				hItem:EndCooldown()
			end
		end
	end

	hCaster:AddNewModifier(hCaster, self, "modifier_tinker_rearm_lua_buff", { duration = buff_duration })

end
---------------------------------------------------------------------
--Modifiers
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
		local hParent = self:GetParent()
		local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_tinker/tinker_loadout.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, "attach_attack2", Vector(0, 0, 0), true)
		self:AddParticle(iParticleID, false, false, -1, false, false)
		-- 25级天赋 再装填魔抗
	end
	self.magic_resistance = self:GetAbilitySpecialValueFor("magic_resistance")
end
function modifier_tinker_rearm_lua:OnRefresh(params)
	if IsServer() then
	end
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
	return "particles/units/heroes/hero_tinker/tinker_loadout.vpcf"
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
	if IsServer() then
	end
end
function modifier_tinker_rearm_lua_counter:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
end
function modifier_tinker_rearm_lua_counter:OnIntervalThink()
	local hParent = self:GetParent()
	local hSourceAbility = self:GetAbility()
	local iBonusTime = 0

	local exempt_table = {}
	exempt_table["item_black_king_bar"] = true
	exempt_table["item_arcane_boots"] = true
	exempt_table["item_guardian_greaves"] = true
	exempt_table["item_sphere"] = true
	exempt_table["item_demonicon"] = true
	exempt_table["item_aeon_disk_lua"] = true
	exempt_table["item_hand_of_midas_lua"] = true

	for index = 0, hParent:GetAbilityCount() - 1 do
		local hAbility = hParent:GetAbilityByIndex(index)
		if IsValid(hAbility) and hAbility:IsRefreshable() and hAbility ~= self then
			if not hAbility:IsCooldownReady() then
				if hAbility:IsSealingAbility() then
					iBonusTime = iBonusTime + hAbility:GetCooldownTimeRemaining() * self.sealing_bonus_rate + self.sealing_bonus_base
				end
			else
				-- 充能型技能
				if hAbility:GetMaxAbilityCharges(-1) > 0 then
					if hAbility:IsSealingAbility() then
						iBonusTime = iBonusTime + hAbility:GetAbilityChargeRestoreTime(-1) * self.sealing_bonus_rate + self.sealing_bonus_base
					end
				end
			end
		end
	end
	for index = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
		local hItem = hParent:GetItemInSlot(index)
		if IsValid(hItem) and hItem:IsRefreshable() and hItem:GetCooldown(-1) > 0 and not hItem:IsCooldownReady() and not exempt_table[hItem:GetAbilityName()] then
			if hItem:IsSealingAbility() then
				iBonusTime = iBonusTime + hItem:GetCooldownTimeRemaining() * self.sealing_bonus_rate + self.sealing_bonus_base
			end
		end
	end
	if IsValid(hSourceAbility) and not hSourceAbility:IsChanneling() then
		self.bonus_time = iBonusTime
		self:SendBuffRefreshToClients()
	end
end
function modifier_tinker_rearm_lua_counter:AddCustomTransmitterData()
	local hAbility = self:GetAbility()
	if IsValid(hAbility) then
		hAbility.SealingBonusTime = self.bonus_time
	end
	return {
		bonus_time = self.bonus_time
	}
end
function modifier_tinker_rearm_lua_counter:HandleCustomTransmitterData(t)
	self.bonus_time = t.bonus_time
	local hAbility = self:GetAbility()
	if IsValid(hAbility) then
		hAbility.SealingBonusTime = self.bonus_time
	end
end
function modifier_tinker_rearm_lua_counter:OnTooltip()
	local hAbility = self:GetAbility()
	if IsValid(hAbility) then
		return hAbility:GetCooldown(-1)
	end
end
function modifier_tinker_rearm_lua_counter:OnTooltip2()
	local hAbility = self:GetAbility()
	if IsValid(hAbility) then
		return hAbility:GetChannelTime()
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
		local hParent = self:GetParent()
		self.tStack = {}
		self:StartIntervalThink(FrameTime())
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStack, { fDieTime = GameRulesCustom:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end
function modifier_tinker_rearm_lua_buff:OnRefresh(params)
	self.bonus_status_resistance = self:GetAbilitySpecialValueFor("bonus_status_resistance")
	if IsServer() then
		local hParent = self:GetParent()
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStack, { fDieTime = GameRulesCustom:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end
function modifier_tinker_rearm_lua_buff:OnIntervalThink()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	if (not IsValid(hParent)) or (not IsValid(hAbility)) then
		self:Destroy()
		return
	end
	local fGameTime = GameRulesCustom:GetGameTime()
	for i = #self.tStack, 1, -1 do
		if fGameTime >= self.tStack[i].fDieTime then
			self:SetStackCount(math.max(0, self:GetStackCount() - self.tStack[i].iCount))
			table.remove(self.tStack, i)
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