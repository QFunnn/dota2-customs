--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


arc_warden_tempest_double_lua = class({})
-- LinkLuaModifier("modifier_tempest_double_min_health", "heroes/hero_arc_warden/modifier_tempest_double_min_health", LUA_MODIFIER_MOTION_NONE)
-- LinkLuaModifier("modifier_tempest_double_illusion", "heroes/hero_arc_warden/modifier_tempest_double_illusion", LUA_MODIFIER_MOTION_NONE)
-- LinkLuaModifier("modifier_tempest_double_hidden", "heroes/hero_arc_warden/modifier_tempest_double_hidden", LUA_MODIFIER_MOTION_NONE)
-- LinkLuaModifier("modifier_tempest_double_dying", "heroes/hero_arc_warden/modifier_tempest_double_dying", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_warden_tempest_double_lua", "heroes/hero_arc_warden/arc_warden_tempest_double_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_warden_tempest_double_lua_illusion", "heroes/hero_arc_warden/arc_warden_tempest_double_lua", LUA_MODIFIER_MOTION_NONE)

local TRANSFER_PLAIN = 1 -- just add modifier to hClone
local TRANSFER_FULL = 2 -- add modifier and transfer stacks
local BanAbility = {
	"lone_druid_spirit_bear"
}


arc_warden_tempest_double_lua.transferable_modifiers = {
	["modifier_item_dark_moon_shard"]			= TRANSFER_PLAIN,
	["modifier_item_moon_shard_consumed"]		= TRANSFER_PLAIN,
	["modifier_item_ultimate_scepter_consumed"] = TRANSFER_PLAIN,
	["modifier_item_aghanims_shard"] = TRANSFER_PLAIN,
	['modifier_channel_listener']				= TRANSFER_PLAIN,
	["modifier_book_of_strength"]				= TRANSFER_FULL,
	["modifier_book_of_intelligence"]			= TRANSFER_FULL,
	["modifier_book_of_agility"]				= TRANSFER_FULL,
	["modifier_loser_curse"]					= TRANSFER_FULL,
}

function arc_warden_tempest_double_lua:RemoveDouble()
	self.Double:RemoveModifierByName("modifier_arc_warden_tempest_double_lua")
end
function arc_warden_tempest_double_lua:SummonDouble(vLocation, bReCall)
	local hCaster = self:GetCaster()

	if bReCall then
		self.Double:RespawnHero(false, false)
		FindClearSpaceForUnit(self.Double, vLocation, true)
		self:InitDouble()
	else
		CreateUnitByNameAsync(hCaster:GetUnitName(), vLocation, true, hCaster, hCaster, hCaster:GetTeamNumber(), function(unit)
			self.Double = unit
			self:InitDouble()
		end)
	end

end
function arc_warden_tempest_double_lua:InitDouble()
	local unit = self.Double
	local hCaster = self:GetCaster()
	if IsValid(unit) and IsValid(hCaster) then
		local duration = self:GetSpecialValueFor("duration")
		unit:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), false)
		unit:SetHealth(unit:GetMaxHealth())
		unit:SetMana(unit:GetMaxMana())
		unit:SetHasInventory(false)
		unit:SetCanSellItems(false)

		--移除技能
		for i = 0, unit:GetAbilityCount() - 1 do
			local hAbility = unit:GetAbilityByIndex(i)
			if hAbility and not string.find(hAbility:GetAbilityName(), "special_bonus") then
				unit:RemoveAbility(hAbility:GetAbilityName())
			end
		end

		--移除物品
		for index = 0, 16 do
			local hClone_item = unit:GetItemInSlot(index)
			if hClone_item then
				UTIL_Remove(hClone_item)
			end
		end

		--复制体升级
		while unit:GetLevel() < hCaster:GetLevel() do
			unit:HeroLevelUp(false)
		end

		--添加道具与删除道具留一个间隔，修复虚无主义在分身不显示的问题
		Timers:CreateTimer(0.1, function()
			if IsValid(hCaster) then
				--先添加中立物品
				local hNeutralItem = hCaster:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
				if hNeutralItem ~= nil then
					local hItem = unit:AddItemByName(hNeutralItem:GetAbilityName())
					--风暴双雄锁定合成
					if hItem then
						hItem:SetCombineLocked(true)
					end
				end

				for index = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_9 do
					local hCaster_item = hCaster:GetItemInSlot(index)
					if hCaster_item and not hCaster_item:IsNull() then
						local clonable = hCaster_item:GetAbilityKeyValues().IsTempestDoubleClonable ~= "0"
						if clonable then
							local hItem = unit:AddItemByName(hCaster_item:GetAbilityName())
							--风暴双雄锁定合成
							if hItem then
								hItem:SetCombineLocked(true)
							end
						end
					end
				end
			end
		end)

		--重写添加技能
		for i = 0, hCaster:GetAbilityCount() - 1 do
			local hAbility = hCaster:GetAbilityByIndex(i)
			if hAbility ~= nil then
				local AbilityName = hAbility:GetAbilityName()
				if not string.find(AbilityName, "special_bonus") and not table.contains(BanAbility, AbilityName) then
					local hNewAbility = unit:AddAbility(AbilityName)
					if hAbility:GetAbilityKeyValues().IsGrantedByScepter == "1" then
						hNewAbility:SetHidden(false)
					end
					if hAbility:GetAbilityKeyValues().IsGrantedByShard == "1" and AbilityName ~= "crystal_maiden_freezing_field_stop" then
						hNewAbility:SetHidden(false)
					end
					if IsValid(hNewAbility) then
						Timers:CreateTimer(0.3, function()
							hNewAbility:ClearInnateModifiers()
						end)
					end
				end
			end
		end

		--有隐藏技能的显示主技能
		for i = 0, unit:GetAbilityCount() - 1 do
			local hAbility = unit:GetAbilityByIndex(i)
			if IsValid(hAbility) then
				local AbilityName = hAbility:GetAbilityName()
				if Util:IsAbilityInPool(AbilityName) then
					if HeroBuilder.linkedAbilities[AbilityName] then
						for _, LinkAbilityName in pairs(HeroBuilder.linkedAbilities[AbilityName]) do
							local LinkAbility = unit:FindAbilityByName(LinkAbilityName)
							if IsValid(LinkAbility) and HasBehavior(LinkAbility, DOTA_ABILITY_BEHAVIOR_HIDDEN) then
								unit:SwapAbilities(AbilityName, LinkAbilityName, true, false)
							end
						end
					end
				end
			end
		end

		if not hCaster:HasModifier("modifier_hero_refreshing") then
			unit:RemoveModifierByName("modifier_hero_refreshing")
		end

		if hCaster:HasModifier("modifier_chen_base") then
			unit:AddNewModifier(hCaster, self, "modifier_chen_base", {})
		end

		--添加modifier,开始同步
		unit:SetAbilityPoints(0)
		unit:AddNewModifier(hCaster, self, "modifier_arc_warden_tempest_double_lua_illusion", {})
		unit:AddNewModifier(hCaster, self, "modifier_arc_warden_tempest_double_lua", { duration = duration })
	end

	local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_tempest_cast_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
	ParticleManager:SetParticleControlEnt(iParticleID, 0, unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(iParticleID)
end
function arc_warden_tempest_double_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local vLocation = self:GetCursorPosition()
	if IsValid(hCaster) and vLocation then
		EmitSoundOnLocationWithCaster(vLocation, "Hero_ArcWarden.TempestDouble", hCaster)

		if IsValid(self.Double) and self.Double:IsAlive() then
			--复制体存在，清除复制体
			self:RemoveDouble()
		end
		--重新召唤
		self:SummonDouble(vLocation, IsValid(self.Double))
	end
end


function arc_warden_tempest_double_lua:TransferModifiers(hCaster, hClone)
	for name, transfer_type in pairs(self.transferable_modifiers) do
		local hCaster_modifier = hCaster:FindModifierByName(name)
		if hCaster_modifier and not hCaster_modifier:IsNull() then
			local hClone_modifier = hClone:FindModifierByName(name)
			if hClone_modifier then
			else
				hClone_modifier = hClone:AddNewModifier(hClone, nil, name, { duration = hCaster_modifier:GetDuration() })
			end
			if transfer_type == TRANSFER_FULL then
				hClone_modifier:SetStackCount(hCaster_modifier:GetStackCount())
			end
		end
	end
end


function arc_warden_tempest_double_lua:GetHerohClone()
	local hCaster = self:GetCaster()
	if not hCaster or hCaster:IsNull() then return end
	local hCaster_name = hCaster:GetUnitName()

	if not self.hClone then
		if IsValid(hCaster.tempest_double_hClone) then
			self.hClone = hCaster.tempest_double_hClone
		else
			local hClone = CreateUnitByName(
			hCaster_name,
			hCaster:GetAbsOrigin(),
			true,
			hCaster,
			hCaster:GetPlayerOwner(),
			hCaster:GetTeamNumber()
			)

			hClone:AddNewModifier(hClone, nil, "modifier_spell_amplify_controller", {})

			hClone.IsRealHero = function() return true end
			hClone.IsMainHero = function() return false end
			hClone.IsTempestDouble = function() return true end

			hClone:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), true)
			hClone:SetRenderColor(0, 0, 190)

			--移除技能
			for i = 0, hClone:GetAbilityCount() - 1 do
				local hAbility = hClone:GetAbilityByIndex(i)
				if hAbility and not string.find(hAbility:GetAbilityName(), "special_bonus") then
					hClone:RemoveAbility(hAbility:GetAbilityName())
				end
			end

			self.hClone = hClone
		end
	end

	if IsValid(self.hClone) then
		while self.hClone:GetLevel() < hCaster:GetLevel() do
			self.hClone:HeroLevelUp(false)
		end

		for index = 0, 16 do
			local hClone_item = self.hClone:GetItemInSlot(index)
			if hClone_item then
				UTIL_Remove(hClone_item)
			end
		end

		--添加道具与删除道具留一个间隔，修复虚无主义在分身不显示的问题
		Timers:CreateTimer(0.1, function()
			if IsValid(hCaster) then
				--先添加中立物品
				local neutralItem = hCaster:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
				if neutralItem ~= nil then
					local hItem = self.hClone:AddItemByName(neutralItem:GetAbilityName())
					--风暴双雄锁定合成
					if hItem then
						hItem:SetCombineLocked(true)
					end
				end

				for index = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_9 do
					local hCaster_item = hCaster:GetItemInSlot(index)
					if hCaster_item and not hCaster_item:IsNull() then
						local clonable = hCaster_item:GetAbilityKeyValues().IsTempestDoubleClonable ~= "0"
						if clonable then
							local hItem = self.hClone:AddItemByName(hCaster_item:GetAbilityName())
							--风暴双雄锁定合成
							if hItem then
								hItem:SetCombineLocked(true)
							end
						end
					end
				end
			end
		end)
	end

	return self.hClone
end
---Modifier---------------------
modifier_arc_warden_tempest_double_lua = class({})

function modifier_arc_warden_tempest_double_lua:IsDebuff()
	return false
end
function modifier_arc_warden_tempest_double_lua:IsHidden()
	return false
end
function modifier_arc_warden_tempest_double_lua:IsPurgable()
	return false
end
function modifier_arc_warden_tempest_double_lua:RemoveOnDeath()
	return false
end
function modifier_arc_warden_tempest_double_lua:OnCreated()
	if IsServer() then
		self:SetStackCount(1)
		self:StartIntervalThink(0.5)
	end
end
function modifier_arc_warden_tempest_double_lua:OnRefresh()
end
function modifier_arc_warden_tempest_double_lua:OnIntervalThink()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	local hAbility = self:GetAbility()
	self:SetStackCount(0)
	if IsValid(hParent) then
		if IsValid(hAbility) and IsValid(hCaster) then
			hParent:SetAbilityPoints(0)
			--同步A杖和魔晶
			if hCaster:HasModifier("modifier_item_ultimate_scepter_consumed") then
				if not hParent:HasModifier("modifier_item_ultimate_scepter_consumed") then
					hParent:AddNewModifier(hCaster, nil, "modifier_item_ultimate_scepter_consumed", {})
				end
			else
				hParent:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
			end
			if hCaster:HasModifier("modifier_item_aghanims_shard") then
				if not hParent:HasModifier("modifier_item_aghanims_shard") then
					hParent:AddNewModifier(hCaster, nil, "modifier_item_aghanims_shard", {})
				end
			else
				hParent:RemoveModifierByName("modifier_item_aghanims_shard")
			end

			if hAbility.ZERO_LEVEL_ABILITIES == nil then
				hAbility.ZERO_LEVEL_ABILITIES = {
					["visage_summon_familiars"] = true,
					["brewmaster_primal_companion"] = true,
					["arc_warden_tempest_double_lua"] = true,
					["rubick_magic_duel"] = true,
				}
			end

			--同步技能状态
			for i = 0, hCaster:GetAbilityCount() - 1 do
				local hCasterAbility = hCaster:GetAbilityByIndex(i)
				if IsValid(hCasterAbility) then
					local AbilityName = hCasterAbility:GetAbilityName()
					local hNewAbility = hParent:FindAbilityByName(AbilityName)
					if IsValid(hNewAbility) and not hAbility.ZERO_LEVEL_ABILITIES[AbilityName] then
						if hNewAbility:GetLevel() ~= hCasterAbility:GetLevel() then
							if string.find(AbilityName, "special_bonus_") ~= nil then
								hParent:SetAbilityPoints(1)
								hParent:UpgradeAbility(hNewAbility)
							else
								hNewAbility:SetLevel(hCasterAbility:GetLevel())
								if hNewAbility:GetAutoCastState() ~= hCasterAbility:GetAutoCastState() then
									hNewAbility:ToggleAutoCast()
								end
							end

						end
						if Illusion.abilityException[AbilityName] then
							hNewAbility:SetActivated(false)
						end
					end
				end
			end
			hParent:SetAbilityPoints(0)
		else
			self:Destroy()
		end
	end
end
function modifier_arc_warden_tempest_double_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_LIFETIME_FRACTION,
	}
end
function modifier_arc_warden_tempest_double_lua:OnDestroy()
	if not IsServer() then
		return
	end
	local hParent = self:GetParent()
	if hParent.__summon then
		for entindex, v in pairs(hParent.__summon) do
			if v then
				local unit = EntIndexToHScript(entindex)
				if IsValid(unit) then
					unit:ForceKill(false)
					-- Timer(0.2, function()
					-- 	UTIL_Remove(unit)
					-- end)
				end
			end
		end
	end
	hParent.__summon = nil
	hParent:ForceKill(false)
end
function modifier_arc_warden_tempest_double_lua:GetUnitLifetimeFraction()
	return ((self:GetDieTime() - GameRules:GetGameTime()) / self:GetDuration())
end
function modifier_arc_warden_tempest_double_lua:CheckState()
	if self:GetStackCount() > 0 then
		return {
			[MODIFIER_STATE_INVULNERABLE] = true,
			[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
			[MODIFIER_STATE_STUNNED] = true,
			[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		}
	end
end
---Modifier---------------------
modifier_arc_warden_tempest_double_lua_illusion = class({})

function modifier_arc_warden_tempest_double_lua_illusion:IsDebuff()
	return false
end
function modifier_arc_warden_tempest_double_lua_illusion:IsHidden()
	return true
end
function modifier_arc_warden_tempest_double_lua_illusion:IsPurgable()
	return false
end
function modifier_arc_warden_tempest_double_lua_illusion:RemoveOnDeath()
	return false
end
function modifier_arc_warden_tempest_double_lua_illusion:OnCreated()
	if IsServer() then
		self:StartIntervalThink(10)
	end
end
function modifier_arc_warden_tempest_double_lua_illusion:OnRefresh()
end
function modifier_arc_warden_tempest_double_lua_illusion:OnDestroy()
	if IsServer() then
		local hParent = self:GetParent()
		if IsValid(hParent) then
			hParent:RemoveSelf()
		end
	end
end
function modifier_arc_warden_tempest_double_lua_illusion:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TEMPEST_DOUBLE,
		MODIFIER_PROPERTY_SUPER_ILLUSION,
	}
end
function modifier_arc_warden_tempest_double_lua_illusion:OnIntervalThink()
	local hAbility = self:GetAbility()
	if (IsValid(hAbility) and hAbility:IsHidden()) or not IsValid(hAbility) then
		self:Destroy()
	end
end
function modifier_arc_warden_tempest_double_lua_illusion:GetModifierTempestDouble()
	return 1
end
function modifier_arc_warden_tempest_double_lua_illusion:GetModifierSuperIllusion()
	return 1
end
function modifier_arc_warden_tempest_double_lua_illusion:GetEffectName()
	return "particles/units/heroes/hero_arc_warden/arc_warden_tempest_buff.vpcf"
end
function modifier_arc_warden_tempest_double_lua_illusion:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_arc_warden_tempest_double_lua_illusion:GetStatusEffectName()
	return "particles/status_fx/status_effect_arc_warden_tempest.vpcf"
end
function modifier_arc_warden_tempest_double_lua_illusion:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end