--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


arc_warden_tempest_double_lua = class({}) ---@class arc_warden_tempest_double_lua : CDOTA_Ability_Lua
LinkLuaModifier("modifier_arc_warden_tempest_double_lua", "heroes/hero_arc_warden/arc_warden_tempest_double_lua",
	LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_arc_warden_tempest_double_lua_illusion", "heroes/hero_arc_warden/arc_warden_tempest_double_lua",
	LUA_MODIFIER_MOTION_NONE)

local TRANSFER_PLAIN = 1 -- just add modifier to hClone
local TRANSFER_FULL = 2  -- add modifier and transfer stacks
local BanAbility = {
	"lone_druid_spirit_bear"
}

local function IsUnitValid(unit)
	return IsValid(unit) and not unit:IsNull()
end

local function RemoveNonTalentAbilities(unit)
	if not IsUnitValid(unit) then
		return
	end

	for i = 0, unit:GetAbilityCount() - 1 do
		local ability = unit:GetAbilityByIndex(i)
		if ability and not string.find(ability:GetAbilityName(), "special_bonus") then
			unit:RemoveAbility(ability:GetAbilityName())
		end
	end
end

local function RemoveAllItems(unit)
	if not IsUnitValid(unit) then
		return
	end

	for index = 0, 16 do
		local item = unit:GetItemInSlot(index)
		if item then
			UTIL_Remove(item)
		end
	end
end

local function SyncLevel(source, target)
	if not IsUnitValid(source) or not IsUnitValid(target) then
		return
	end

	while target:GetLevel() < source:GetLevel() do
		target:HeroLevelUp(false)
	end
end

local function IsItemClonable(item)
	if not item or item:IsNull() then
		return false
	end

	local kv = item:GetAbilityKeyValues()
	if type(kv) ~= "table" then
		return true
	end

	return not IsKvFlagDisabled(kv.IsTempestDoubleClonable)
end

local function AddLockedItemToSlot(unit, item_name, target_slot)
	if not IsUnitValid(unit) or not item_name then
		return
	end

	local new_item = unit:AddItemByName(item_name)
	if not new_item then
		return
	end

	new_item:SetCombineLocked(true)

	if type(target_slot) == "number" then
		local current_slot = new_item:GetItemSlot()
		if current_slot ~= -1 and current_slot ~= target_slot then
			unit:SwapItems(current_slot, target_slot)
		end
	end
end

local function CopyItemsFromCaster(caster, clone)
	if not IsUnitValid(caster) or not IsUnitValid(clone) then
		return
	end

	local neutral_item = caster:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
	if neutral_item then
		AddLockedItemToSlot(clone, neutral_item:GetAbilityName(), DOTA_ITEM_NEUTRAL_SLOT)
	end

	for index = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_9 do
		local caster_item = caster:GetItemInSlot(index)
		if IsItemClonable(caster_item) then
			AddLockedItemToSlot(clone, caster_item:GetAbilityName(), index)
		end
	end
end


arc_warden_tempest_double_lua.transferable_modifiers = {
	--["modifier_item_dark_moon_shard"]			= TRANSFER_PLAIN, --некорректная работа
	["modifier_item_moon_shard_consumed"]       = TRANSFER_PLAIN,
	["modifier_item_ultimate_scepter_consumed"] = TRANSFER_PLAIN,
	["modifier_item_aghanims_shard"]            = TRANSFER_PLAIN,
	["modifier_chen_base"]                      = TRANSFER_PLAIN,
	["modifier_channel_listener"]               = TRANSFER_PLAIN,
	--["modifier_book_of_strength"]				= TRANSFER_FULL, --некорректная работа
	--["modifier_book_of_intelligence"]			= TRANSFER_FULL, --некорректная работа
	--["modifier_book_of_agility"]				= TRANSFER_FULL, --некорректная работа
	["modifier_loser_curse"]                    = TRANSFER_FULL,
}

function arc_warden_tempest_double_lua:RemoveDouble()
	if IsUnitValid(self.Double) then
		self.Double:RemoveModifierByName("modifier_arc_warden_tempest_double_lua")
	end
end

function arc_warden_tempest_double_lua:SummonDouble(vLocation, isRecall)
	local hCaster = self:GetCaster()
	if not IsUnitValid(hCaster) then
		return
	end

	if isRecall and IsUnitValid(self.Double) then
		self.Double:RespawnHero(false, false)
		FindClearSpaceForUnit(self.Double, vLocation, true)
		self:InitDoubleAsync()
	else
		CreateUnitByNameAsync(hCaster:GetUnitName(), vLocation, true, hCaster, hCaster, hCaster:GetTeamNumber(),
			function(unit)
				if not IsUnitValid(unit) then
					return
				end
				self.Double = unit
				self:InitDoubleAsync()
			end)
	end
end

function arc_warden_tempest_double_lua:InitDoubleAsync()
	local unit = self.Double
	local hCaster = self:GetCaster()
	if IsUnitValid(unit) and IsUnitValid(hCaster) and IsValid(self) then
		Timers:CreateTimer(0, function()
			if not IsUnitValid(unit) or not IsUnitValid(hCaster) or not IsValid(self) then
				return nil
			end
			local duration = self:GetSpecialValueFor("duration") or 0
			unit:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), false)
			unit:SetHealth(unit:GetMaxHealth())
			unit:SetMana(unit:GetMaxMana())
			unit:SetHasInventory(false)
			unit:SetCanSellItems(false)

			RemoveNonTalentAbilities(unit)
			RemoveAllItems(unit)
			SyncLevel(hCaster, unit)

			-- Скипетр и шард нужно выдать копии ДО копирования способностей: иначе движок
			-- сразу прячет обратно абилки, которые ниже разблокируются через SetHidden(false),
			-- а TransferModifiers и синхронизация в OnIntervalThink отрабатывают уже после.
			for _, modifierName in ipairs({ "modifier_item_ultimate_scepter_consumed", "modifier_item_aghanims_shard" }) do
				if hCaster:HasModifier(modifierName) and not unit:HasModifier(modifierName) then
					unit:AddNewModifier(hCaster, nil, modifierName, {})
				end
			end

			--Между добавлением и удалением предмета сделан промежуток, чтобы исправить проблему, при которой эффект “Нигилизма” не отображался на иллюзиях.
			Timers:CreateTimer(0.1, function()
				if IsUnitValid(hCaster) and IsUnitValid(unit) then
					CopyItemsFromCaster(hCaster, unit)
				end
				return nil
			end)

			for i = 0, hCaster:GetAbilityCount() - 1 do
				local hAbility = hCaster:GetAbilityByIndex(i)
				if hAbility ~= nil then
					local AbilityName = hAbility:GetAbilityName()
					if not string.find(AbilityName, "special_bonus") and not table.contains(BanAbility, AbilityName) then
						local hNewAbility = unit:AddAbility(AbilityName)
						if IsValid(hNewAbility) then
							local ability_kv = hAbility:GetAbilityKeyValues()
							local grantedByScepter = type(ability_kv) == "table" and IsKvFlagEnabled(ability_kv.IsGrantedByScepter)
							local grantedByShard = type(ability_kv) == "table" and IsKvFlagEnabled(ability_kv.IsGrantedByShard)
								and AbilityName ~= "crystal_maiden_freezing_field_stop"

							if grantedByScepter then
								hNewAbility:SetHidden(false)
							end
							if grantedByShard then
								hNewAbility:SetHidden(false)
							end

							Timers:CreateTimer(0.3, function()
								if IsValid(hNewAbility) then
									hNewAbility:ClearInnateModifiers()
								end
								return nil
							end)
						end
					end
				end
			end

			for i = 0, unit:GetAbilityCount() - 1 do
				local hAbility = unit:GetAbilityByIndex(i)
				if IsValid(hAbility) then ---@cast hAbility CDOTABaseAbility
					local AbilityName = hAbility:GetAbilityName()
					if Util:IsAbilityInPool(AbilityName) then
						local linkedAbilities = AbilityPool:GetLinkedAbilities(AbilityName)
						if linkedAbilities then
							for _, LinkAbilityName in pairs(linkedAbilities) do
								local linkAbility = unit:FindAbilityByName(LinkAbilityName)
								if linkAbility and IsValid(linkAbility) and linkAbility:HasBehavior(DOTA_ABILITY_BEHAVIOR_HIDDEN) then
									unit:SwapAbilities(hAbility, linkAbility, true, false)
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

			unit:SetAbilityPoints(0)

			--- Добавляем на темпест курсы и прочие баффы
			self:TransferModifiers(hCaster, unit)

			unit:AddNewModifier(hCaster, self, "modifier_arc_warden_tempest_double_lua_illusion", {})
			unit:AddNewModifier(hCaster, self, "modifier_arc_warden_tempest_double_lua", { duration = duration })

			return nil
		end)
	end

	if IsUnitValid(unit) then
		local iParticleID = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_arc_warden/arc_warden_tempest_cast_custom.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc",
			unit:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
end

function arc_warden_tempest_double_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local vLocation = self:GetCursorPosition()
	if IsValid(hCaster) and vLocation then
		EmitSoundOn("Hero_ArcWarden.TempestDouble", hCaster)

		if IsValid(self.Double) and self.Double:IsAlive() then
			self:RemoveDouble()
		end
		self:SummonDouble(vLocation, IsValid(self.Double))
	end
end

---Передача модификаторов
---@param hCaster CDOTA_BaseNPC
---@param hClone CDOTA_BaseNPC
function arc_warden_tempest_double_lua:TransferModifiers(hCaster, hClone)
	if not IsUnitValid(hCaster) or not IsUnitValid(hClone) then
		return
	end

	for name, transfer_type in pairs(self.transferable_modifiers) do
		local hCaster_modifier = hCaster:FindModifierByName(name)
		if hCaster_modifier and not hCaster_modifier:IsNull() then
			local hClone_modifier = hClone:FindModifierByName(name)
			if not hClone_modifier then
				hClone_modifier = hClone:AddNewModifier(hCaster, hCaster_modifier:GetAbility(), name,
					{ duration = hCaster_modifier:GetDuration() })
			end
			if transfer_type == TRANSFER_FULL and hClone_modifier and not hClone_modifier:IsNull() then
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

			RemoveNonTalentAbilities(hClone)

			self.hClone = hClone
		end
	end

	if IsValid(self.hClone) then
		SyncLevel(hCaster, self.hClone)
		RemoveAllItems(self.hClone)

		Timers:CreateTimer(0.1, function()
			if IsValid(hCaster) then
				if IsUnitValid(self.hClone) then
					CopyItemsFromCaster(hCaster, self.hClone)
				end
			end
			return nil
		end)
	end

	return self.hClone
end

---Modifier---------------------
modifier_arc_warden_tempest_double_lua = class({}) ---@class CDOTA_Modifier_Lua

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
			---@cast hAbility CDOTABaseAbility
			---@cast hCaster CDOTA_BaseNPC
			hParent:SetAbilityPoints(0)
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

			for i = 0, hCaster:GetAbilityCount() - 1 do
				local hCasterAbility = hCaster:GetAbilityByIndex(i)
				if IsValid(hCasterAbility) then ---@cast hCasterAbility CDOTABaseAbility
					local AbilityName = hCasterAbility:GetAbilityName()
					local hNewAbility = hParent:FindAbilityByName(AbilityName)
					if IsValid(hNewAbility) and not hAbility.ZERO_LEVEL_ABILITIES[AbilityName] then ---@cast hNewAbility CDOTABaseAbility
						if hNewAbility:GetLevel() ~= hCasterAbility:GetLevel() then
							if string.find(AbilityName, "special_bonus_") ~= nil then
								hParent:SetAbilityPoints(1)
								hParent:UpgradeAbility(hNewAbility)
							else
								hNewAbility:SetLevel(hCasterAbility:GetLevel())
							end
						end
						if hNewAbility:GetAutoCastState() ~= hCasterAbility:GetAutoCastState() then
							hNewAbility:ToggleAutoCast()
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
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_arc_warden_tempest_double_lua:OnDeath(params)
	if not IsServer() then return end

	local parent = self:GetParent()
	if not IsUnitValid(parent) or params.unit ~= parent then
		return
	end

	local ability = self:GetAbility()
	local attacker = params.attacker
	if not IsValid(ability) or not IsUnitValid(attacker) then ---@cast ability CDOTABaseAbility
		return
	end

	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end

	local bounty = ability:GetSpecialValueFor("bounty") or 0
	if bounty <= 0 then
		return
	end

	local killer_player_id = attacker:GetPlayerOwnerID()
	if killer_player_id == nil or killer_player_id < 0 then
		local owner = attacker:GetOwnerEntity()
		if IsUnitValid(owner) and owner.GetPlayerOwnerID then
			killer_player_id = owner:GetPlayerOwnerID()
		end
	end

	if killer_player_id ~= nil and killer_player_id >= 0 then
		PlayerResource:ModifyGold(killer_player_id, bounty, true, DOTA_ModifyGold_HeroKill)
		SendOverheadEventMessage(PlayerResource:GetPlayer(killer_player_id), OVERHEAD_ALERT_GOLD,
			PlayerResource:GetSelectedHeroEntity(killer_player_id), bounty, nil)
	end
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
				if IsValid(unit) then ---@cast unit CDOTA_BaseNPC
					unit:ForceKill(false)
				end
			end
		end
	end
	hParent.__summon = nil
	hParent:ForceKill(false)
end

function modifier_arc_warden_tempest_double_lua:GetUnitLifetimeFraction()
	local duration = self:GetDuration()
	if not duration or duration <= 0 then
		return 0
	end
	return ((self:GetDieTime() - GameRules:GetGameTime()) / duration)
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
modifier_arc_warden_tempest_double_lua_illusion = class({}) ---@class CDOTA_Modifier_Lua

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