--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_hero_refreshing", "heroes/modifier_hero_refreshing", LUA_MODIFIER_MOTION_NONE )

modifier_hero_refreshing = class({})

function modifier_hero_refreshing:GetTexture()
	return "rune_regen"
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

function modifier_hero_refreshing:OnCreated( kv )
	if IsServer() then
		self:GetParent():RemoveModifierByName("modifier_razor_static_link")
		if not self:GetParent():IsRealHero() then return end
		self.flInterval=0.5
		--self.nParticleIndex = ParticleManager:CreateParticle("particles/items_fx/bottle.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		self:StartIntervalThink( self.flInterval )
	    self:OnIntervalThink()
	end
end

function modifier_hero_refreshing:OnDestroy( kv )
	if IsServer() then
		if not self:GetParent():IsRealHero() then return end

		if not IsCheatsEnabled() then
			for i=0, self:GetParent():GetAbilityCount()-1 do
				local hAbility = self:GetParent():GetAbilityByIndex(i)
				if hAbility then
					local Name = hAbility:GetName()
					local AbilitySettings = ABILITIES_SETTINGS[Name]
					if AbilitySettings and AbilitySettings.bIsDisabledOnHub == true then
						hAbility:SetActivated(true)
					end
				end
			end
		end

		for _, unit in pairs(FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)) do
            if unit:GetOwner() == self:GetCaster() and (unit:GetUnitName() == "npc_dota_lone_druid_bear1" or unit:GetUnitName() == "npc_dota_lone_druid_bear2" or unit:GetUnitName() == "npc_dota_lone_druid_bear3" or unit:GetUnitName() == "npc_dota_lone_druid_bear4") then
                local modifier_heal = unit:FindModifierByName("modifier_hero_refreshing")     
                if modifier_heal then modifier_heal:Destroy() end
            end
	    end
	    if self:GetParent().tempest_double_hClone then
	    	local modifier_heal = self:GetParent().tempest_double_hClone:FindModifierByName("modifier_hero_refreshing")     
            if modifier_heal then modifier_heal:Destroy() end
	    end
	end
end

function modifier_hero_refreshing:OnIntervalThink()
	if IsServer() then
		local save_modifier = 
        {
			["modifier_item_veil_of_discord_debuff"] = true,
			["modifier_item_dustofappearance"] = true,
			["modifier_truesight"] = true,
			["modifier_silencer_global_silence"] = true,
			["modifier_sniper_assassinate"] = true,
			["modifier_sven_stormbolt_hide"] = true,
			["modifier_oracle_fortunes_end_channel_target"] = true,
			["modifier_oracle_fortunes_end_purge"] = true,
			["modifier_item_nullifier_mute"] = true,
			["modifier_item_nullifier_slow"] = true,

		}
		if not IsCheatsEnabled() then
			for _, modifier in pairs( self:GetParent():FindAllModifiers() ) do
				if modifier and modifier:GetCaster() ~= self:GetParent() and modifier:IsDebuff() and save_modifier[modifier:GetName()] == nil then
					local ability_name = ""
					if modifier:GetAbility() then
						ability_name = modifier:GetAbility():GetAbilityName()
					end

					if ability_name ~= "item_nullifier" then
						if modifier:GetDuration() > 1 then
							modifier:Destroy()
						end
					end
				end
			end

			for i=0, self:GetParent():GetAbilityCount()-1 do
				local hAbility = self:GetParent():GetAbilityByIndex(i)
				if hAbility then
					local Name = hAbility:GetName()
					local AbilitySettings = ABILITIES_SETTINGS[Name]
					if AbilitySettings and AbilitySettings.bIsDisabledOnHub == true then
						hAbility:SetActivated(false)
					end
				end
			end
		end

		if self:GetParent():IsRealHero() then
			for _, unit in pairs(FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)) do
	            if unit:GetOwner() == self:GetCaster() and (unit:GetUnitName() == "npc_dota_lone_druid_bear1" or unit:GetUnitName() == "npc_dota_lone_druid_bear2" or unit:GetUnitName() == "npc_dota_lone_druid_bear3" or unit:GetUnitName() == "npc_dota_lone_druid_bear4") and not unit:HasModifier("modifier_hero_refreshing") then
	                unit:AddNewModifier(self:GetParent(), nil, "modifier_hero_refreshing", {})  
	                print("add mod", unit)           
	            end
		    end
		    if self:GetParent().tempest_double_hClone then
		    	self:GetParent().tempest_double_hClone:AddNewModifier(self:GetParent(), nil, "modifier_hero_refreshing", {})  
		    end
		end
	   
	    if self:GetParent():HasModifier("modifier_ice_blast") then
		    self:GetParent():RemoveModifierByName("modifier_ice_blast")
	    end
	    if self:GetParent():HasModifier("modifier_dazzle_weave_armor") then
		    self:GetParent():RemoveModifierByName("modifier_dazzle_weave_armor")
	    end
        for i = 0, self:GetParent():GetAbilityCount()-1 do
                local hAbility = self:GetParent():GetAbilityByIndex(i)
                if hAbility and hAbility.GetCooldownTimeRemaining then
                    local flRemaining = hAbility:GetCooldownTimeRemaining()
                    if self.flInterval <  flRemaining then
                        hAbility:EndCooldown()
                        hAbility:StartCooldown(flRemaining-self.flInterval)
                    end
                end
                if hAbility and hAbility.GetAbilityName and hAbility:GetAbilityName()=="custom_legion_commander_duel" then
                hAbility.bRoundDueled=false
                end
                if hAbility and hAbility.GetAbilityName and hAbility:GetAbilityName()=="necrolyte_reapers_scythe" then
                hAbility.bRoundDueled=false
                end
                if hAbility and hAbility.GetAbilityName and hAbility:GetAbilityName()=="lion_finger_of_death_custom" then
                hAbility.bRoundDueled=false
                end
                if hAbility and hAbility.GetAbilityName and hAbility:GetAbilityName()=="bounty_hunter_track" then
                hAbility.bRoundDueled=false
                end
                if hAbility and hAbility.GetAbilityName and hAbility:GetAbilityName()=="lina_laguna_blade_custom" then
                hAbility.bRoundDueled=false
                end
                if hAbility and hAbility.GetAbilityName and hAbility:GetAbilityName()=="axe_culling_blade_custom" then
                hAbility.bRoundDueled=false
                end
                if hAbility and hAbility.GetAbilityName and hAbility:GetAbilityName()=="doom_bringer_devour_custom" then
                hAbility.cast_round=0
                end
            end
            if self:GetParent() and self:GetParent():IsRealHero() then
                for i=0,32 do
                local hItem=self:GetParent():GetItemInSlot(i)
                if hItem and not hItem:IsNull() and hItem.GetAbilityName and  "item_bottle"==hItem:GetAbilityName() then
                    local nCurrentCharges = hItem:GetCurrentCharges()
                    if nCurrentCharges<3 and nCurrentCharges>=0 then
                        hItem:SetCurrentCharges(nCurrentCharges+1)
                    end
                end
            end
        end
	end
end

function modifier_hero_refreshing:CheckState()
	
	local state =
	{
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
        -- [MODIFIER_STATE_CANNOT_TARGET_ENEMIES] = true,
        [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
	}

	if IsCheatsEnabled() then
		state = {}
	end
	-- if self:GetParent():HasModifier("modifier_muerta_supernatural") or self:GetParent():HasModifier("modifier_item_revenants_brooch_custom_counter") or self:GetParent():HasModifier("modifier_muerta_pierce_the_veil") or self:GetParent():HasModifier("modifier_slardar_bash_active") or self:GetParent():HasModifier("modifier_monkey_king_jingu_mastery_lua") or self:GetParent():HasItemInInventory("item_revenants_brooch") then
	-- 	state =
	-- 	{
	-- 		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	-- 		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
	-- 		-- [MODIFIER_STATE_DISARMED] = true,
    --         -- [MODIFIER_STATE_CANNOT_TARGET_ENEMIES] = true,
    --         [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
	-- 	}
	-- end
	return state
end

function modifier_hero_refreshing:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
	}
	if IsCheatsEnabled() then
		funcs = {
			MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
			MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
		}
	end
	return funcs
end

function modifier_hero_refreshing:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_hero_refreshing:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_hero_refreshing:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_hero_refreshing:GetModifierHealthRegenPercentage(params)
	return 8
end

function modifier_hero_refreshing:GetModifierTotalPercentageManaRegen(params)
	return 8
end

 function modifier_hero_refreshing:GetModifierCastRangeBonusStacking(params)
	if params.ability then
		if params.ability.GetCastRange then
			local new = params.ability:GetCastRange(params.ability:GetCaster():GetAbsOrigin(), params.ability:GetCaster()) + self:GetParent():GetCastRangeBonus()
			if new > 0 then
				return (new * 0.5) * -1
			end
		end
	end
end