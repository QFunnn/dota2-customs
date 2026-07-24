--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tempest_double_illusion = class({})

function modifier_tempest_double_illusion:IsHidden() return false end
function modifier_tempest_double_illusion:IsPurgable() return false end
-- function modifier_tempest_double_illusion:RemoveOnDeath()
-- 	return false
-- end
function modifier_tempest_double_illusion:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

function modifier_tempest_double_illusion:GetEffectName()
	return "particles/units/heroes/hero_arc_warden/arc_warden_tempest_buff.vpcf"
end

function modifier_tempest_double_illusion:GetStatusEffect(...)
	return "particles/status_fx/status_effect_arc_warden_tempest.vpcf"
end

function modifier_tempest_double_illusion:GetModifierSuperIllusion()
	return 1
end

function modifier_tempest_double_illusion:GetIsIllusion()
	return true
end

function modifier_tempest_double_illusion:GetModifierIllusionLabel()
	return true
end
function modifier_tempest_double_illusion:GetModifierTempestDouble()
	return 1
end
function modifier_tempest_double_illusion:OnCreated()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end

	self.bounty = ability:GetSpecialValueFor("bounty")

	self.parent = self:GetParent()
	self.caster = caster
	self.ability = ability
	self:StartIntervalThink(0.5)
end
function modifier_tempest_double_illusion:OnRefresh()
	if IsServer() then
		self:StartIntervalThink(0.5)
	end
end
function modifier_tempest_double_illusion:DeclareFunctions()
	return {
		-- MODIFIER_EVENT_ON_TAKEDAMAGE, -- OnTakeDamage
		MODIFIER_PROPERTY_LIFETIME_FRACTION, -- GetUnitLifetimeFraction
		MODIFIER_PROPERTY_SUPER_ILLUSION,
		-- MODIFIER_PROPERTY_ILLUSION_LABEL,
		-- MODIFIER_PROPERTY_IS_ILLUSION,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_TEMPEST_DOUBLE,
	}
end

function modifier_tempest_double_illusion:GetUnitLifetimeFraction(params)
	return ((self:GetDieTime() - GameRules:GetGameTime()) / self:GetDuration())
end

-- function modifier_tempest_double_illusion:OnTakeDamage(params)
-- 	if not IsServer() then return end
-- 	if not params.attacker or params.attacker:IsNull() then return end
-- 	if not self.parent or self.parent:IsNull() then return end

-- 	if params.unit ~= self.parent then return end

-- 	if params.damage >= self.parent:GetHealth() then -- seems like we are dead!
-- 		if params.attacker and params.attacker.GetPlayerOwnerID and params.attacker:GetPlayerOwnerID() then
-- 			local hKillerHero = PlayerResource:GetSelectedHeroEntity(params.attacker:GetPlayerOwnerID())
-- 			if hKillerHero and hKillerHero.IsRealHero and hKillerHero:IsRealHero() then
-- 				if hKillerHero:GetTeamNumber() ~= self.parent:GetTeamNumber() then
-- 					--hKillerHero:ModifyGold(self.bounty, false, 12)
-- 					--SendOverheadEventMessage(hKillerHero, OVERHEAD_ALERT_GOLD, hKillerHero, self.bounty, nil)
-- 					--hKillerHero:AddExperience(self.bounty, 1, false, true)
-- 				end
-- 			end
-- 		end
-- 		self:Destroy()
-- 	end
-- end
function modifier_tempest_double_illusion:OnRemoved()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	local hAbility = self:GetAbility()
	if IsServer() then
		hParent:AddNewModifier(hCaster, hAbility, "modifier_tempest_double_dying", { duration = 3 })
	end
end
function modifier_tempest_double_illusion:OnDestroy()
	if not IsServer() then return end
	if not self.parent or self.parent:IsNull() then return end

	--钻出
	self.parent:RemoveModifierByName("modifier_life_stealer_infest")
	--如果被钻，将体内英雄弹出
	if self.parent:HasModifier("modifier_life_stealer_infest_effect") then
		local modifier = self.parent:FindModifierByName("modifier_life_stealer_infest_effect")
		local hInfester = modifier:GetCaster()
		hInfester:RemoveModifierByName("modifier_life_stealer_infest")
	end
	--关闭腐烂
	-- self.parent:RemoveModifierByName("modifier_pudge_rot")
	-- --关闭脉冲新星
	-- self.parent:RemoveModifierByName("modifier_leshrac_pulse_nova")
	-- --关闭血雾
	-- self.parent:RemoveModifierByName("modifier_bloodseeker_blood_mist")

	-- self.parent:StartGestureWithPlaybackRate(ACT_DOTA_DIE, 1.1)

	local hParent = self:GetParent()
	if hParent:IsAlive() then
		local reincarnation = hParent:FindAbilityByName("skeleton_king_reincarnation")
		local reincarnation_buff = hParent:FindModifierByName("modifier_special_bonus_reincarnation")

		if IsValid(reincarnation) then
			if reincarnation:IsCooldownReady() then
				reincarnation:StartCooldown(1)
			end
		end
		if reincarnation_buff then
			if reincarnation_buff:GetDuration() == -1 then
				hParent:RemoveModifierByName("modifier_special_bonus_reincarnation")
			end
		end
	end
	hParent:Kill(nil, nil)
end

function modifier_tempest_double_illusion:GetModifierPercentageCooldown()
	if self:GetAbility() ~= nil then
		return self:GetAbility():GetSpecialValueFor("cooldown_reduction")
	else
		return 0
	end

end
function modifier_tempest_double_illusion:OnIntervalThink()
	local hCaster = self:GetCaster()
	local hParent = self:GetParent()

	if self:GetAbility() == nil then
		if IsValid(hParent) then
			hParent:RemoveSelf()
		end
	else
		hParent:SetAbilityPoints(0)
		--同步A杖和魔晶
		if hCaster:HasModifier("modifier_item_ultimate_scepter_consumed") then
			if not hParent:HasModifier("modifier_item_ultimate_scepter_consumed") then
				-- hParent:AddItemByName("item_ultimate_scepter_2")
				hParent:AddNewModifier(hCaster, nil, "modifier_item_ultimate_scepter_consumed", {})
			end
		else
			hParent:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
		end
		if hCaster:HasModifier("modifier_item_aghanims_shard") then
			if not hParent:HasModifier("modifier_item_aghanims_shard") then
				-- hParent:AddItemByName("item_aghanims_shard")
				hParent:AddNewModifier(hCaster, nil, "modifier_item_aghanims_shard", {})
			end
		else
			hParent:RemoveModifierByName("modifier_item_aghanims_shard")
		end

		--同步技能状态
		for i = 0, hCaster:GetAbilityCount() - 1 do
			local hAbility = hCaster:GetAbilityByIndex(i)
			if hAbility ~= nil then
				local AbilityName = hAbility:GetAbilityName()
				local hNewAbility = hParent:FindAbilityByName(AbilityName)
				if hNewAbility ~= nil then
					if hNewAbility:GetLevel() ~= hAbility:GetLevel() then
						if string.find(AbilityName, "special_bonus_") ~= nil then
							hParent:SetAbilityPoints(1)
							hParent:UpgradeAbility(hNewAbility)
						else
							hNewAbility:SetLevel(hAbility:GetLevel())
							if hNewAbility:GetAutoCastState() ~= hAbility:GetAutoCastState() then
								hNewAbility:ToggleAutoCast()
							end
						end

					end
					if AbilityName == "arc_warden_tempest_double_lua" or Illusion.abilityException[AbilityName] then
						hNewAbility:SetActivated(false)
					end
				end
			end
		end
		hParent:SetAbilityPoints(0)
	end
end