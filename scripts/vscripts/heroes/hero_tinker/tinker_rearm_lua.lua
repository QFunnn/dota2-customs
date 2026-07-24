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

	-- -- Reset cooldown for abilities that is not rearm
	-- local ability_exempt_table = {}
	-- ability_exempt_table["phoenix_supernova"] = true
	-- ability_exempt_table["arc_warden_tempest_double"] = true
	-- ability_exempt_table["arc_warden_tempest_double_lua"] = true

	-- --全球流的大招不能刷新
	-- ability_exempt_table["zuus_thundergods_wrath"] = true
	-- ability_exempt_table["furion_wrath_of_nature"] = true
	-- ability_exempt_table["ancient_apparition_ice_blast"] = true
	-- ability_exempt_table["spectre_haunt"] = true
	-- ability_exempt_table["silencer_global_silence"] = true

	-- --强保命技能不能刷新
	-- ability_exempt_table["skeleton_king_reincarnation"] = true
	-- ability_exempt_table["abaddon_borrowed_time"] = true
	-- ability_exempt_table["oracle_false_promise"] = true
	-- ability_exempt_table["dazzle_shallow_grave"] = true
	-- ability_exempt_table["slark_shadow_dance"] = true
	-- ability_exempt_table["dark_willow_shadow_realm"] = true
	-- ability_exempt_table["slark_depth_shroud"] = true
	-- ability_exempt_table["muerta_pierce_the_veil"] = true

	-- --召唤类大招不能刷新
	-- ability_exempt_table["undying_tombstone_lua"] = true
	-- ability_exempt_table["shadow_shaman_mass_serpent_ward"] = true
	-- ability_exempt_table["warlock_rain_of_chaos"] = true

	-- --蒸汽背包无限越狱
	-- -- ability_exempt_table["rattletrap_jetpack"] = true
	-- --善咒无限点金
	-- ability_exempt_table["dazzle_good_juju_lua"] = true
	-- -- --善咒无限点金
	-- -- ability_exempt_table["dazzle_good_juju"] = true

	-- local ability_discount_table = {}
	-- --PK无法反制
	-- ability_discount_table["faceless_void_chronosphere"] = 0.4
	-- --全球流的大招
	-- ability_discount_table["zuus_cloud"] = 0.5
	-- --刷新吞噬秒怪
	-- ability_discount_table["doom_bringer_devour"] = 0.5
	-- --刷新神箭秒怪
	-- ability_discount_table["mirana_arrow"] = 0.6

	-- --全球流召唤飞弹也不能刷新
	-- --泉水阶段不能刷新风暴之眼
	-- for i = 0, hCaster:GetAbilityCount() - 1 do
	-- 	local hAbility = hCaster:GetAbilityByIndex(i)
	-- 	if hAbility and not ability_exempt_table[hAbility:GetAbilityName()] and not (hCaster:HasModifier("modifier_hero_refreshing") and "razor_eye_of_the_storm" == hAbility:GetAbilityName()) then

	-- 		local flRatio = 1
	-- 		--打折的技能
	-- 		if ability_discount_table[hAbility:GetAbilityName()] ~= nil then
	-- 			flRatio = ability_discount_table[hAbility:GetAbilityName()]
	-- 		end

	-- 		local flEffectiveCooldown = hAbility:GetEffectiveCooldown(hAbility:GetLevel() - 1)
	-- 		local flCurrentCooldown = hAbility:GetCooldownTimeRemaining()

	-- 		--如果100%刷新
	-- 		if flRatio > 0.99 then
	-- 			hAbility:EndCooldown()
	-- 		else
	-- 			if flCurrentCooldown - flEffectiveCooldown * flRatio <= 0 then
	-- 				hAbility:EndCooldown()
	-- 			else
	-- 				hAbility:EndCooldown()
	-- 				hAbility:StartCooldown(flCurrentCooldown - flEffectiveCooldown * flRatio)
	-- 			end
	-- 		end

	-- 	end
	-- end

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
		table.insert(self.tStack, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
		self:SetStackCount(iStackCount)
	end
end
function modifier_tinker_rearm_lua_buff:OnRefresh(params)
	self.bonus_status_resistance = self:GetAbilitySpecialValueFor("bonus_status_resistance")
	if IsServer() then
		local hParent = self:GetParent()
		local iCount = params.stack or 1
		local iStackCount = self:GetStackCount() + iCount
		table.insert(self.tStack, { fDieTime = GameRules:GetGameTime() + (params.duration or 0), iCount = iCount })
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
	local fGameTime = GameRules:GetGameTime()
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