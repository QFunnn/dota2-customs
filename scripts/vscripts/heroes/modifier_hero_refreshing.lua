--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_fountain_thinker = class({}) ---@class CDOTA_Modifier_Lua

function modifier_fountain_thinker:IsHidden()
	return true
end

function modifier_fountain_thinker:IsDebuff()
	return false
end

function modifier_fountain_thinker:IsPurgable()
	return false
end

function modifier_fountain_thinker:IsPurgeException()
	return false
end

function modifier_fountain_thinker:AllowIllusionDuplicate()
	return false
end

function modifier_fountain_thinker:OnDestroy()
	if IsServer() then
		local hParent = self:GetParent()
		if IsValid(hParent) then
			hParent:RemoveSelf()
		end
	end
end

function modifier_fountain_thinker:CheckState()
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end

function modifier_fountain_thinker:IsAura()
	return true
end

function modifier_fountain_thinker:GetAuraRadius()
	return 2000
end

function modifier_fountain_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_fountain_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_fountain_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_OTHER
end

function modifier_fountain_thinker:GetModifierAura()
	return "modifier_hero_refreshing"
end

function modifier_fountain_thinker:IsAuraActiveOnDeath()
	return true
end

-----------------------------------
modifier_hero_refreshing = class({}) ---@class CDOTA_Modifier_Lua


function modifier_hero_refreshing:GetTexture()
	return "fountain_heal"
end

function modifier_hero_refreshing:IsHidden()
	return false
end

function modifier_hero_refreshing:IsDebuff()
	return false
end

function modifier_hero_refreshing:IsPurgable()
	return false
end

function modifier_hero_refreshing:RemoveOnDeath()
	local hParent = self:GetParent()
	return (not hParent:IsRealHero())
end

function modifier_hero_refreshing:OnCreated(kv)
	if not IsServer() then return end
	local hParent = self:GetParent()
	self.flInterval = 0.2
	if not hParent:IsRealHero() then return end

	local vPos = GoodFrogPos or Vector(0, 0, 128)
	local particleID = ParticleManager:CreateParticle("particles/generic_gameplay/radiant_fountain_regen.vpcf",
		PATTACH_ABSORIGIN_FOLLOW, hParent)
	ParticleManager:SetParticleControl(particleID, 1, vPos)
	self:AddParticle(particleID, true, false, -1, false, false)

	self:StartIntervalThink(self.flInterval)
	self.disableAbilityList = {
		"furion_teleportation",
		"wisp_relocate",
		"phoenix_supernova",
		"shredder_timber_chain",
		"ancient_apparition_ice_blast",
		"brewmaster_primal_split",
		"life_stealer_infest",
		"shadow_demon_disruption",
		"queenofpain_blink",
		"antimage_blink"
	}

	self.disableItems = {
		"item_blink",
		"item_swift_blink",
		"item_arcane_blink",
		"item_overwhelming_blink"
	}

	if hParent:HasAbility("legion_commander_duel") then
		local ability = hParent:FindAbilityByName("legion_commander_duel")
		if ability then
			ability.bRoundDueled = false
		end
	end

	if hParent:HasModifier("modifier_oracle_false_promise_lua") then
		hParent:RemoveModifierByName("modifier_oracle_false_promise_lua")
	end

	hParent:Purge(false, true, false, true, true)
	ProjectileManager:ProjectileDodge(hParent)

	self:OnIntervalThink()
end

function modifier_hero_refreshing:OnDestroy(kv)
	if not IsServer() then return end

	local hParent = self:GetParent()

	if hParent:IsRealHero() then
		for _, sAbilityName in ipairs(self.disableAbilityList) do
			if hParent:HasAbility(sAbilityName) then
				hParent:FindAbilityByName(sAbilityName):SetActivated(true)
			end
		end
		-- for _, itemName in ipairs(self.disableItems) do
		-- 	if hParent:HasItemInInventory(itemName) then
		-- 		hParent:FindItemInInventory(itemName):EndCooldown()
		-- 	end
		-- end
	end
end

function modifier_hero_refreshing:OnIntervalThink()
	if not IsServer() then return end

	local hParent = self:GetParent()

	if (not IsValid(hParent)) or (not hParent:IsAlive()) then
		self:Destroy()
	end

	if hParent:HasModifier("modifier_ice_blast") then
		hParent:RemoveModifierByName("modifier_ice_blast")
	end

	for _, sAbilityName in ipairs(self.disableAbilityList) do
		if hParent:HasAbility(sAbilityName) then
			hParent:FindAbilityByName(sAbilityName):SetActivated(false)
		end
	end

	-- for _, itemName in ipairs(self.disableItems) do
	-- 	if hParent:HasItemInInventory(itemName) then
	-- 		local hItem = hParent:FindItemInInventory(itemName)
	-- 		local flHoldCooldown = self.flInterval * 3
	-- 		if hItem:GetCooldownTimeRemaining() < flHoldCooldown then
	-- 			hItem:EndCooldown()
	-- 			hItem:StartCooldown(flHoldCooldown)
	-- 		end
	-- 	end
	-- end

	self.chargeRestoreProgress = self.chargeRestoreProgress or {}

	for i = 0, hParent:GetAbilityCount() - 1 do
		local hAbility = hParent:GetAbilityByIndex(i)
		if hAbility and hAbility:GetAbilityType() ~= DOTA_ABILITY_TYPE_ATTRIBUTES then
			local maxCharges = hAbility:GetMaxAbilityCharges(-1)
			if maxCharges > 0 then
				local key = hAbility:GetAbilityName()
				local currentCharges = hAbility:GetCurrentAbilityCharges()
				if currentCharges < maxCharges then
					local restoreTime = hAbility:GetAbilityChargeRestoreTime(-1)
					if restoreTime and restoreTime > 0 then
						local tickInterval = math.max(restoreTime / 2, self.flInterval)
						self.chargeRestoreProgress[key] = (self.chargeRestoreProgress[key] or 0) + self.flInterval
						if self.chargeRestoreProgress[key] >= tickInterval then
							if currentCharges + 1 >= maxCharges then
								hAbility:RefreshCharges()
							else
								hAbility:SetCurrentAbilityCharges(currentCharges + 1)
							end
							hAbility:EndCooldown()
							hAbility:MarkAbilityButtonDirty()
							self.chargeRestoreProgress[key] = 0
						end
					end
				else
					self.chargeRestoreProgress[key] = nil
				end
			else
				local flRemaining = hAbility:GetCooldownTimeRemaining()
				if flRemaining > self.flInterval then
					hAbility:EndCooldown()
					hAbility:StartCooldown(flRemaining - self.flInterval)
				end
			end
		end
	end

	if hParent:FindItemInInventory("item_bottle") then
		local hItem = hParent:FindItemInInventory("item_bottle")
		if hItem then
			local nCurrentCharges = hItem:GetCurrentCharges()
			if nCurrentCharges < 3 and nCurrentCharges >= 0 then
				hItem:SetCurrentCharges(nCurrentCharges + 1)
			end
		end
	end
end

function modifier_hero_refreshing:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_hero_refreshing:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
	}
end

function modifier_hero_refreshing:GetModifierHealthRegenPercentage(params)
	return 8
end

function modifier_hero_refreshing:GetModifierTotalPercentageManaRegen(params)
	return 8
end