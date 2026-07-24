--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_dark_moon_shard", "item_ability/item_dark_moon_shard", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dark_moon_shard_passive", "item_ability/item_dark_moon_shard", LUA_MODIFIER_MOTION_NONE)


item_dark_moon_shard = class({})

function item_dark_moon_shard:GetIntrinsicModifierName()
	return "modifier_item_dark_moon_shard_passive"
end

function item_dark_moon_shard:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hPlayer = hCaster:GetPlayerOwner()

		if (hCaster:IsRealHero() or string.find(hCaster:GetUnitName(), "npc_dota_lone_druid_bear") ~= nil) and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua") then
			if hCaster:HasModifier("modifier_item_dark_moon_shard") then
				return
			else
				hCaster:AddNewModifier(hCaster, self, "modifier_item_dark_moon_shard", {})
				self:SpendCharge()
			end
		end

		-- if hCaster and ((hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua")) or (string.find(hCaster:GetUnitName(), "npc_dota_lone_druid_bear") == 1)) then
		-- 	if hCaster:HasModifier("modifier_item_dark_moon_shard") then
		-- 		return
		-- 	end
		-- 	if hCaster:HasModifier("modifier_alchemist_chemical_rage") then
		-- 		-- CustomGameEventManager:Send_ServerToPlayer(hPlayer, "CanNotCastDuringRage", {})
		-- 		CustomGameEventManager:Send_ServerToPlayer(hPlayer, "SendCustomErrorMessage", { msg = "CanNotCastDuringRage" })
		-- 		return
		-- 	end
		-- 	if hCaster:HasModifier("modifier_snapfire_lil_shredder_buff") then
		-- 		-- CustomGameEventManager:Send_ServerToPlayer(hPlayer, "CanNotCastDuringLil", {})
		-- 		CustomGameEventManager:Send_ServerToPlayer(hPlayer, "SendCustomErrorMessage", { msg = "CanNotCastDuringLil" })
		-- 		return
		-- 	end
		-- 	if hCaster:HasModifier("modifier_oracle_false_promise") then
		-- 		-- CustomGameEventManager:Send_ServerToPlayer(hPlayer, "CanNotCastDuringRage", {})
		-- 		CustomGameEventManager:Send_ServerToPlayer(hPlayer, "SendCustomErrorMessage", { msg = "CanNotCastFalsePromise" })
		-- 		return
		-- 	end
		-- 	hCaster:AddNewModifier(hCaster, self, "modifier_item_dark_moon_shard", {})
		-- 	self:SpendCharge()
		-- 	EmitSoundOn("Item.MoonShard.Consume", hCaster)
		-- 	Util:RecordConsumableItem(hCaster:GetPlayerOwnerID(), "item_dark_moon_shard")
		-- end
		-- -- 如果小熊使用 记录在英雄上
		-- if hCaster and string.find(hCaster:GetUnitName(), "npc_dota_lone_druid_bear") == 1 then
		-- 	local nPlayerID = hCaster:GetPlayerOwnerID()
		-- 	if nPlayerID then
		-- 		local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
		-- 		if hHero then
		-- 			hHero.bUsedBearDarkMoon = true
		-- 		end
		-- 	end
		-- end
	end
end
---------------------------------------------------------------------------------------------------------------------
modifier_item_dark_moon_shard_passive = class({})

function modifier_item_dark_moon_shard_passive:IsHidden()
	return true
end
function modifier_item_dark_moon_shard_passive:GetTexture()
	return "item_dark_moon_shard"
end
function modifier_item_dark_moon_shard_passive:IsDebuff()
	return false
end
function modifier_item_dark_moon_shard_passive:IsPurgeException()
	return false
end
function modifier_item_dark_moon_shard_passive:IsPurgable()
	return false
end
function modifier_item_dark_moon_shard_passive:OnCreated()
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end
function modifier_item_dark_moon_shard_passive:OnRefresh()
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end
function modifier_item_dark_moon_shard_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end
function modifier_item_dark_moon_shard_passive:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end
function modifier_item_dark_moon_shard_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
---------------------------------------------------------------------------------------------------------------
modifier_item_dark_moon_shard = class({})
function modifier_item_dark_moon_shard:IsHidden()
	return false
end
function modifier_item_dark_moon_shard:GetTexture()
	return "item_dark_moon_shard"
end
function modifier_item_dark_moon_shard:IsPermanent()
	return true
end
function modifier_item_dark_moon_shard:IsPurgable()
	return false
end
function modifier_item_dark_moon_shard:OnCreated()
	self.base_attack_time_reduction = self:GetAbilitySpecialValueFor("base_attack_time_reduction")
	self.base_attack_time_min = self:GetAbilitySpecialValueFor("base_attack_time_min")
	if IsServer() then
		local hParent = self:GetParent()
		local tKv = GetUnitKeyValuesByName(hParent:GetUnitName())
		if tKv.AttackRate then
			local AttackRate = tonumber(tKv.AttackRate)
			self.AttackRate = math.max(self.base_attack_time_min, AttackRate * (100 - self.base_attack_time_reduction) * 0.01)
		else

			self:Destroy()
		end
		self:SetHasCustomTransmitterData(true)
	end
end
function modifier_item_dark_moon_shard:AddCustomTransmitterData()
	return {
		AttackRate = self.AttackRate
	}
end
function modifier_item_dark_moon_shard:HandleCustomTransmitterData(t)
	self.AttackRate = t.AttackRate
end
function modifier_item_dark_moon_shard:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
	}
end
function modifier_item_dark_moon_shard:GetModifierBaseAttackTimeConstant()
	return self.AttackRate
end
function modifier_item_dark_moon_shard:GetPriority()
	return MODIFIER_PRIORITY_LOW
end