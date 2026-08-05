--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_magic_resist_lua", "abilities/ability_capture", LUA_MODIFIER_MOTION_NONE)

ability_capture_lua = class({})

function ability_capture_lua:GetIntrinsicModifierName()
	return "modifier_magic_resist_lua"
end

function ability_capture_lua:GetChannelTime()
	return 3
end

function ability_capture_lua:OnHeroLevelUp() end

function ability_capture_lua:GetChannelAnimation()
	return ACT_DOTA_TELEPORT
end

function ability_capture_lua:OnSpellStart(keys)
	if not IsServer() then
		return
	end

	self.respawnPos = self:GetCursorPosition()

	StartSoundEvent("Outpost.Channel", self:GetCaster())
end

function ability_capture_lua:OnChannelFinish(bInterrupted)
	if not IsServer() then
		return
	end

	local pos = self.respawnPos
	self.respawnPos = nil

	if not bInterrupted and pos then
		local items_on_the_ground = {}
		local ent = Entities:FindByClassname(nil, "dota_item_drop")
		while ent do
			if (ent:GetOrigin() - pos):Length() <= 200 then
				table.insert(items_on_the_ground, ent)
			end
			ent = Entities:FindByClassname(ent, "dota_item_drop")
		end

		for _, item_ground in pairs(items_on_the_ground) do
			if not item_ground or item_ground:IsNull() then
				goto continue
			end

			local item = item_ground:GetContainedItem()
			if not item or item:IsNull() then
				goto continue
			end

			local item_name = item:GetAbilityName()
			if item_name ~= "item_tombstone" then
				goto continue
			end

			local hero = item:GetPurchaser()
			local point = pos
			local hRelay = Entities:FindByName(nil, "logic_teleport")
			if hRelay then
				hRelay:Trigger(nil, nil)
			end
			hero:RespawnHero(false, false)
			hero:SetAbsOrigin(point)
			FindClearSpaceForUnit(hero, point, true)
			hero:Stop()
			hero:RemoveModifierByName("modifier_fountain_invulnerability")
			UTIL_Remove(item_ground)

			::continue::
		end
	end
	StopSoundEvent("Outpost.Channel", self:GetCaster())
end

-- function ability_capture_lua:OnChannelFinish( bInterrupted )
-- 	if not IsServer() then return end

-- 	local pos = self.respawnPos
-- 	self.respawnPos = nil

-- 	if not bInterrupted and pos then
-- 		local items_on_the_ground = Entities:FindAllByClassnameWithin("dota_item_drop", pos, 200)
-- 		for _,item_ground in pairs(items_on_the_ground) do
-- 			if not item_ground or item_ground:IsNull() then
-- 				goto continue
-- 			end

-- 			local item = item_ground:GetContainedItem()
-- 			if not item or item:IsNull() then
-- 				goto continue
-- 			end

-- 			local item_name = item:GetAbilityName()
-- 			if item_name ~= "item_tombstone" then
-- 				goto continue
-- 			end

-- 			local hero = item:GetPurchaser()
-- 			local point = pos
-- 			local hRelay = Entities:FindByName( nil, "logic_teleport" )
-- 			if hRelay then
-- 				hRelay:Trigger(nil,nil)
-- 			end
-- 			hero:RespawnHero(false, false)
-- 			hero:SetAbsOrigin( point )
-- 			FindClearSpaceForUnit(hero, point, true)
-- 			hero:Stop()
-- 			hero:RemoveModifierByName("modifier_fountain_invulnerability")
-- 			UTIL_Remove(item_ground)

-- 			::continue::
-- 		end
-- 	end
-- 	StopSoundEvent("Outpost.Channel", self:GetCaster())
-- end

--------------------------

modifier_magic_resist_lua = class({})

function modifier_magic_resist_lua:IsHidden()
	return true
end

function modifier_magic_resist_lua:IsPurgeException()
	return false
end

function modifier_magic_resist_lua:IsPurgable()
	return false
end

function modifier_magic_resist_lua:RemoveOnDeath()
	return false
end

function modifier_magic_resist_lua:IsPermanent()
	return true
end

function modifier_magic_resist_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}
end

function modifier_magic_resist_lua:GetModifierMagicalResistanceDirectModification()
	return -0.1 * self:GetParent():GetIntellect(true)
end

------------------------------

function modifier_magic_resist_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:CalculateValue()
end

function modifier_magic_resist_lua:CalculateValue()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end

	self.fDifficulty = _G.Game_Difficulty

	self:SendBuffRefreshToClients()
end

function modifier_magic_resist_lua:AddCustomTransmitterData()
	return {
		fDifficulty = self.fDifficulty,
	}
end

function modifier_magic_resist_lua:HandleCustomTransmitterData(data)
	self.fDifficulty = data.fDifficulty
end

function modifier_magic_resist_lua:GetModifierOverrideAbilitySpecial(params)
	if not params.ability or params.ability:IsNull() then
		return 0
	end

	local name = params.ability_special_value
	if name == "ExtraIntelligenceDamage" then
		return 1
	end
	return 0
end

function modifier_magic_resist_lua:GetModifierOverrideAbilitySpecialValue(params)
	if not self.fDifficulty then
		return 0
	end

	local ability = params.ability
	if not ability or ability:IsNull() then
		return 0
	end

	local name = params.ability_special_value
	local level = ability:GetLevel() - 1
	if level < 0 then
		level = 0
	end

	return 0.05 * self.fDifficulty
end