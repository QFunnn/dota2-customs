--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_morphling_replicate_custom_manager", "heroes/npc_dota_hero_morphling_custom/morphling_replicate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_replicate_custom", "heroes/npc_dota_hero_morphling_custom/morphling_replicate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_replicate_custom_remove", "heroes/npc_dota_hero_morphling_custom/morphling_replicate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_replicate_custom_stats_debuff", "heroes/npc_dota_hero_morphling_custom/morphling_replicate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_replicate_custom_stats_buff", "heroes/npc_dota_hero_morphling_custom/morphling_replicate_custom", LUA_MODIFIER_MOTION_NONE)

morphling_replicate_custom = class({})

function morphling_replicate_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_replicate.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_replicate_finish.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_replicate_buff.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_morphling_morph_target.vpcf", context )
end

morphling_replicate_custom.modifier_morphling_14 = 14
morphling_replicate_custom.modifier_morphling_19 = {10,20}

function morphling_replicate_custom:GetIntrinsicModifierName()
	return "modifier_morphling_replicate_custom_remove"
end

function morphling_replicate_custom:CastFilterResultTarget(target)
	if target == self:GetCaster() then
		return UF_FAIL_FRIENDLY
	end
	if not target:IsHero() then
		return UF_FAIL_CREEP
	end
    if target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        if GetMapName() == "arena" or GetMapName() == "maps/arena.vpk" then
            return UF_SUCCESS
        else
            return UF_FAIL_FRIENDLY
        end
    end
	if target:IsIllusion() and target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		return UF_FAIL_ILLUSION
	end
	return UF_SUCCESS
end	

function morphling_replicate_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local name = target:GetUnitName()
	local model = target:GetModelName()
    if self:GetCaster():GetUnitName() ~= "npc_dota_hero_morphling" then
        return
    end
    if target:TriggerSpellAbsorb(self) then return end
	local duration = self:GetSpecialValueFor("duration")
	if self:GetCaster():HasModifier("modifier_morphling_19") then
		duration = duration + self.modifier_morphling_19[self:GetCaster():GetTalentLevel("modifier_morphling_19")]
	end
	self:GetCaster():RemoveModifierByName("modifier_morphling_waveform_custom_reverse")
    if target:IsIllusion() then
        local original_target = PlayerResource:GetSelectedHeroEntity(target:GetPlayerOwnerID())
        if original_target and not original_target:IsNull() then
            target = original_target
        end
    end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_morphling_replicate_custom_manager", {duration = duration, name = name, model = model, target = target:entindex()})
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_morphling_replicate_custom", {})
end

morphling_morph_replicate_custom = class({})

function morphling_morph_replicate_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_morphling_waveform_custom_reverse")
	local morphling_replicate_custom = self:GetCaster():FindAbilityByName("morphling_replicate_custom")
	if self:GetCaster():HasModifier("modifier_morphling_replicate_custom") then
		self:GetCaster():RemoveModifierByName("modifier_morphling_replicate_custom")
	else
		self:GetCaster():AddNewModifier(self:GetCaster(), morphling_replicate_custom, "modifier_morphling_replicate_custom", {})
	end
end

modifier_morphling_replicate_custom_manager = class({})
function modifier_morphling_replicate_custom_manager:IsPurgable() return false end
function modifier_morphling_replicate_custom_manager:IsPurgeException() return false end
function modifier_morphling_replicate_custom_manager:GetTexture() return self.name end

function modifier_morphling_replicate_custom_manager:OnCreated(params)
	if not IsServer() then return end
	self:SetHasCustomTransmitterData(true)
	self.name = params.name
	self.model = params.model
	self.target = EntIndexToHScript(params.target)
	self.attack_type = self.target:GetAttackCapability()
	self.strength = self.target:GetBaseStrength()
	self.agility = self.target:GetBaseAgility()
	self.intellect = self.target:GetBaseIntellect()
	self.movespeed = self.target:GetBaseMoveSpeed()
    local bonus_attack_range = 0
    local modifier_chen_15 = self.target:FindModifierByName("modifier_chen_15")
    if modifier_chen_15 then
        bonus_attack_range = 450
    end
	self.attack_range = self.target:GetBaseAttackRange() + bonus_attack_range
	self.proj_name = self.target:GetRangedProjectileName()
	self.abilities_name = {}

	local replace_ab = 
	{
		["kunkka_return_custom"] = "kunkka_x_marks_the_spot_custom",
        ["aghanim_ray_stop"] = "aghanim_ray",
        ["tiny_toss_tree_custom"] = "tiny_tree_grab_custom",
        ["techies_reactive_tazer_stop_custom"] = "techies_reactive_tazer_custom",
        ["pangolier_rollup_stop_custom"] = "pangolier_rollup_custom",
        ["pangolier_gyroshell_stop_custom"] = "pangolier_gyroshell_custom",
        ["wisp_tether_break_custom"] = "wisp_tether_custom",
        ["phoenix_icarus_dive_stop_custom"] = "phoenix_icarus_dive_custom",
		["phoenix_launch_fire_spirit_custom"] = "phoenix_fire_spirits_custom",
		["phoenix_sun_ray_stop_custom"] = "phoenix_sun_ray_custom",
        ["ancient_apparition_ice_blast_release_custom"] = "ancient_apparition_ice_blast_custom",
        ["dawnbreaker_converge_custom"] = "dawnbreaker_celestial_hammer_custom",
        ["nyx_assassin_burrow_custom"] = "generic_hidden",
        ["nyx_assassin_unburrow_custom"] = "generic_hidden",
		["kunkka_rum"] = "kunkka_ghostship_custom",
		["kunkka_attacker"] = "generic_hidden",
		["oracle_change_of_fate"] = "oracle_fates_edict_custom",
		["lion_speed_rain"] = "lion_mana_drain_custom",
		["undying_tombstone_body"] = "undying_tombstone_custom",
		["windrunner_ultra_powershot_custom"] = "windrunner_focusfire_custom",
		["drow_ranger_multishot_2_custom"] = "drow_ranger_multishot_custom",
		["earthshaker_fissure_2_custom"] = "earthshaker_fissure_custom",
		["earthshaker_enchant_moment"] = "earthshaker_enchant_totem_custom",
		["nevermore_righteous_lord"] = "nevermore_requiem_custom",
		["terrorblade_demon_hunter"] = "terrorblade_metamorphosis_custom",
		["tidehunter_gush_2_custom"] = "tidehunter_gush_custom",
		["witch_doctor_voodoo_switchero_custom"] = "generic_hidden",
		["witch_doctor_auto_wodoo"] = "generic_hidden",
        ["antimage_mana_overload_custom"] = "generic_hidden",
        ["weaver_auto_swarm"] = "generic_hidden",
        ["kez_switch_weapons_custom"] = "generic_hidden",
        ["doom_bringer_fueling_hell"] = "generic_hidden",
        ["zuus_cloud_custom"] = "generic_hidden",
        ["zuus_cloud_self_custom"] = "generic_hidden",
        ["wisp_spirits_in_custom"] = "generic_hidden",
        ["wisp_spirits_out_custom"] = "generic_hidden",
        ["keeper_of_the_light_illuminate_end_custom"] = "keeper_of_the_light_illuminate_custom",
		--["invoker_quas_custom"] =  "generic_hidden",
		--["invoker_wex_custom"] =  "generic_hidden",
		--["invoker_exort_custom"] =  "generic_hidden",
		--["invoker_empty1_custom"] =  "generic_hidden",
		--["invoker_empty2_custom"] =  "generic_hidden",
		--["invoker_cold_snap_custom"] =  "generic_hidden",
		--["invoker_ghost_walk_custom"] =  "generic_hidden",
		--["invoker_tornado_custom"] =  "generic_hidden",
		--["invoker_emp_custom"] =  "generic_hidden",
		--["invoker_alacrity_custom"] =  "generic_hidden",
		--["invoker_chaos_meteor_custom"] =  "generic_hidden",
		--["invoker_sun_strike_custom"] =  "generic_hidden",
		--["invoker_forge_spirit_custom"] =  "generic_hidden",
		--["invoker_ice_wall_custom"] =  "generic_hidden",
		--["invoker_deafening_blast_custom"] =  "generic_hidden",
		["phoenix_sun_ray_toggle_move_custom"] = "generic_hidden",
		["juggernaut_swift_slash_custom"] = "generic_hidden",
	}

	for i=0,4 do
		local ability = self.target:GetAbilityByIndex(i)
		if ability then
			self.abilities_name[i] = ability:GetAbilityName()
			if ability:IsHidden() then
				self.abilities_name[i] = "generic_hidden"
			elseif replace_ab[ability:GetAbilityName()] ~= nil then
				self.abilities_name[i] = replace_ab[ability:GetAbilityName()]
			end
            if self.target:GetUnitName() == "npc_dota_hero_rubick" then
                if i==3 or i==4 then
                    self.abilities_name[i] = "generic_hidden"
                end
            end
		end
	end

	if self:GetCaster():HasModifier("modifier_morphling_14") then
		if self.target:GetPrimaryAttribute() == 0 then
			if self.target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
				self.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_replicate_custom_stats_debuff", {duration = self:GetDuration(), str = self.target:GetStrength() / 100 * self:GetAbility().modifier_morphling_14, agi = 0, int = 0, })
			end
			self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_replicate_custom_stats_buff", {duration = self:GetDuration(), str = self.target:GetStrength() / 100 * self:GetAbility().modifier_morphling_14, agi = 0, int = 0, })
		end
		if self.target:GetPrimaryAttribute() == 1 then
			if self.target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
				self.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_replicate_custom_stats_debuff", {duration = self:GetDuration(), str = 0, agi = self.target:GetAgility() / 100 * self:GetAbility().modifier_morphling_14, int = 0, })
			end
			self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_replicate_custom_stats_buff", {duration = self:GetDuration(), str = 0, agi = self.target:GetAgility() / 100 * self:GetAbility().modifier_morphling_14, int = 0, })
		end
		if self.target:GetPrimaryAttribute() == 2 then
			if self.target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
				self.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_replicate_custom_stats_debuff", {duration = self:GetDuration(), str = 0, agi = 0, int = self.target:GetIntellect(false) / 100 * self:GetAbility().modifier_morphling_14, })
			end
			self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_replicate_custom_stats_buff", {duration = self:GetDuration(), str = 0, agi = 0, int = self.target:GetIntellect(false) / 100 * self:GetAbility().modifier_morphling_14, })
		end
		if self.target:GetPrimaryAttribute() == 3 then
			if self.target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
				self.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_replicate_custom_stats_debuff", {duration = self:GetDuration(), str = self.target:GetStrength() / 100 * self:GetAbility().modifier_morphling_14 / 2, agi = self.target:GetAgility() / 100 * self:GetAbility().modifier_morphling_14 / 2, int = self.target:GetIntellect(false) / 100 * self:GetAbility().modifier_morphling_14 / 2, })
			end
			self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_morphling_replicate_custom_stats_buff", {duration = self:GetDuration(), str = self.target:GetStrength() / 100 * self:GetAbility().modifier_morphling_14 / 2, agi = self.target:GetAgility() / 100 * self:GetAbility().modifier_morphling_14 / 2, int = self.target:GetIntellect(false) / 100 * self:GetAbility().modifier_morphling_14 / 2, })
		end
	end

	self:GetParent():SwapAbilities("morphling_replicate_custom", "morphling_morph_replicate_custom", false, true)
	self:SendBuffRefreshToClients()
end

function modifier_morphling_replicate_custom_manager:OnDestroy()
	if not IsServer() then return end
	self:GetParent():SwapAbilities("morphling_morph_replicate_custom", "morphling_replicate_custom", false, true)
	self:GetParent():RemoveModifierByName("modifier_morphling_replicate_custom")
end

function modifier_morphling_replicate_custom_manager:AddCustomTransmitterData() 
	return 
	{
		name = self.name,
		attack_range = self.attack_range,
	} 
end

function modifier_morphling_replicate_custom_manager:HandleCustomTransmitterData(data)
	self.name = data.name
	self.attack_range = data.attack_range
end

modifier_morphling_replicate_custom = class({})

function modifier_morphling_replicate_custom:IsHidden() return true end
function modifier_morphling_replicate_custom:IsPurgeException() return false end
function modifier_morphling_replicate_custom:IsPurgable() return false end

function modifier_morphling_replicate_custom:OnCreated()
	if not IsServer() then return end
	self.attack_type = self:GetParent():GetAttackCapability()
	self.strength = self:GetParent():GetBaseStrength()
	self.agility = self:GetParent():GetBaseAgility()
	self.intellect = self:GetParent():GetBaseIntellect()
	self.movespeed = self:GetParent():GetBaseMoveSpeed()
	self.items_econ = {}

	self.modifier_morphling_15_has = self:GetCaster():HasModifier("modifier_morphling_15")

	self:GetParent():EmitSound("Hero_Morphling.Replicate")

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_morphling/morphling_replicate.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

	local morphling_waveform_custom = self:GetCaster():FindAbilityByName("morphling_waveform_custom")
	if self:GetCaster():HasModifier("modifier_morphling_15") then
		morphling_waveform_custom = self:GetCaster():FindAbilityByName("morphling_waterraze1_custom")
	end
	if morphling_waveform_custom then
		morphling_waveform_custom:SetHidden(true)
	end

	local morphling_adaptive_strike_agi_custom = self:GetCaster():FindAbilityByName("morphling_adaptive_strike_agi_custom")
	if self:GetCaster():HasModifier("modifier_morphling_15") then
		morphling_adaptive_strike_agi_custom = self:GetCaster():FindAbilityByName("morphling_waterraze2_custom")
	end
	if morphling_adaptive_strike_agi_custom then
		morphling_adaptive_strike_agi_custom:SetHidden(true)
	end

	local morphling_replicate_ability_slot = self:GetCaster():FindAbilityByName("morphling_replicate_ability_slot")
	if self:GetCaster():HasModifier("modifier_morphling_15") then
		morphling_replicate_ability_slot = self:GetCaster():FindAbilityByName("morphling_waterraze3_custom")
	end
	if morphling_replicate_ability_slot then
		morphling_replicate_ability_slot:SetHidden(true)
	end

	local morphling_morph_agi_custom = self:GetCaster():FindAbilityByName("morphling_morph_agi_custom")
	if morphling_morph_agi_custom then
		morphling_morph_agi_custom:SetHidden(true)
		if morphling_morph_agi_custom:GetToggleState() then
			morphling_morph_agi_custom:ToggleAbility()
		end
	end

	local morphling_morph_str_custom = self:GetCaster():FindAbilityByName("morphling_morph_str_custom")
	if morphling_morph_str_custom then
		morphling_morph_str_custom:SetHidden(true)
		if morphling_morph_str_custom:GetToggleState() then
			morphling_morph_str_custom:ToggleAbility()
		end
	end

	local morphling_morph = self:GetCaster():FindAbilityByName("morphling_morph")
	if morphling_morph then
		morphling_morph:RemoveSelf()
	end

    local bonus_spell_name =
    {
        ["kunkka_x_marks_the_spot_custom"] = "kunkka_return_custom",
        ["tiny_tree_grab_custom"] = "tiny_toss_tree_custom",
        ["techies_reactive_tazer_custom"] = "techies_reactive_tazer_stop_custom",
        ["ancient_apparition_ice_blast_custom"] = "ancient_apparition_ice_blast_release_custom",
        ["pangolier_rollup_custom"] = "pangolier_rollup_stop_custom",
        ["pangolier_gyroshell_custom"] = "pangolier_gyroshell_stop_custom",
        ["wisp_tether_custom"] = "wisp_tether_break_custom",
        ["phoenix_icarus_dive_custom"] = "phoenix_icarus_dive_stop_custom",
        ["phoenix_fire_spirits_custom"] = "phoenix_launch_fire_spirit_custom",
        ["phoenix_sun_ray_custom"] = "phoenix_sun_ray_stop_custom",
        ["aghanim_ray"] = "aghanim_ray_stop",
        ["dawnbreaker_celestial_hammer_custom"] = "dawnbreaker_converge_custom",
        ["keeper_of_the_light_illuminate_custom"] = "keeper_of_the_light_illuminate_end_custom",
        ["keeper_of_the_light_light_illusion"] = "keeper_of_the_light_light_illusion_point",
    }

	local modifier_morphling_replicate_custom_manager = self:GetCaster():FindModifierByName("modifier_morphling_replicate_custom_manager")
	if modifier_morphling_replicate_custom_manager then
		self.model = modifier_morphling_replicate_custom_manager.model
		self.proj_name = modifier_morphling_replicate_custom_manager.proj_name
		self.attack_range = modifier_morphling_replicate_custom_manager.attack_range
		self.target = modifier_morphling_replicate_custom_manager.target
		self:GetParent():SetAttackCapability(modifier_morphling_replicate_custom_manager.attack_type)
		self:GetParent():SetBaseStrength(modifier_morphling_replicate_custom_manager.strength)
		self:GetParent():SetBaseAgility(modifier_morphling_replicate_custom_manager.agility)
		self:GetParent():SetBaseIntellect(modifier_morphling_replicate_custom_manager.intellect)
		self:GetParent():SetBaseMoveSpeed(modifier_morphling_replicate_custom_manager.movespeed)

		local mod = self

		Timers:CreateTimer(FrameTime(), function()
			if mod == nil then return end
			if mod:IsNull() then return end
			if self.target ~= nil and self.target:IsHero() then
				local children = self.target:GetChildren();
				for k,child in pairs(children) do
					if child:GetClassname() == "dota_item_wearable" and child:GetModelName() ~= "" then
						local item = SpawnEntityFromTableSynchronous("prop_dynamic", {model = child:GetModelName()})
						item:FollowEntity(self:GetParent(), true)
						table.insert(self.items_econ, item)
					end
				end
			end
		end)

		for id, ability_name in pairs(modifier_morphling_replicate_custom_manager.abilities_name) do
			if ability_name ~= "generic_hidden" then
				local old_spell = false
			    for _,hSpell in pairs(self:GetCaster().spell_steal_history) do
			        if hSpell ~= nil and hSpell:GetAbilityName() == ability_name then
			            old_spell = true
			            break
			        end
			    end
			    if old_spell then
					for id,hSpell in pairs(self:GetCaster().spell_steal_history) do
				        if hSpell ~= nil and hSpell:GetAbilityName() == ability_name then
				            table.remove(self:GetCaster().spell_steal_history, id)
				        end
				    end
        			local new_ability = self:GetCaster():FindAbilityByName(ability_name)
        			if new_ability then
        				local original = modifier_morphling_replicate_custom_manager.target
						if original and not original:IsNull() then
							local original_ab = original:FindAbilityByName(ability_name)
							if original_ab and original_ab:GetLevel() > 0 then
								new_ability:SetLevel(original_ab:GetLevel())
							else
								if new_ability:GetIntrinsicModifierName() ~= nil then
							        local modifier_intrinsic = self:GetParent():FindModifierByName(new_ability:GetIntrinsicModifierName())
							        if modifier_intrinsic then
							            self:GetParent():RemoveModifierByName(modifier_intrinsic:GetName())
							        end
							    end
							end
						end
                        new_ability.main_slot = id
						self:GetCaster():SwapAbilities(self:GetCaster():GetAbilityByIndex(id):GetAbilityName(), new_ability:GetAbilityName(), false, true)
                        if bonus_spell_name[ability_name] and new_ability.additional_ability == nil then
                            new_ability.additional_ability = self:GetCaster():AddAbility( bonus_spell_name[ability_name] )
                            if new_ability.additional_ability then
                                new_ability.additional_ability:SetLevel(new_ability:GetLevel())
                                new_ability.additional_ability:SetStolen(true)
                            end
                        end
					end
			    else
					local new_ability = self:GetCaster():AddAbility(ability_name)
					if new_ability then
	        			new_ability:SetRefCountsModifiers(true)
	        			if new_ability:GetAbilityName() == "invoker_quas_custom" or new_ability:GetAbilityName() == "invoker_wex_custom" or new_ability:GetAbilityName() == "invoker_exort_custom" then
	        				new_ability:SetActivated(false)
	        			end
						local original = modifier_morphling_replicate_custom_manager.target
						if original and not original:IsNull() then
							local original_ab = original:FindAbilityByName(ability_name)
							if original_ab and original_ab:GetLevel() > 0 then
								new_ability:SetLevel(original_ab:GetLevel())
							else
								if new_ability:GetIntrinsicModifierName() ~= nil then
							        local modifier_intrinsic = self:GetParent():FindModifierByName(new_ability:GetIntrinsicModifierName())
							        if modifier_intrinsic then
							            self:GetParent():RemoveModifierByName(modifier_intrinsic:GetName())
							        end
							    end
							end
						end
                        new_ability.main_slot = id
						self:GetCaster():SwapAbilities(self:GetCaster():GetAbilityByIndex(id):GetAbilityName(), new_ability:GetAbilityName(), false, true)
                        new_ability:SetStolen(true)
                        if bonus_spell_name[ability_name] and new_ability.additional_ability == nil then
                            new_ability.additional_ability = self:GetCaster():AddAbility( bonus_spell_name[ability_name] )
                            if new_ability.additional_ability then
                                new_ability.additional_ability:SetLevel(new_ability:GetLevel())
                                new_ability.additional_ability:SetStolen(true)
                            end
                        end
					end
				end
			end
		end
	end
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "morph_stats_replicated", {value = 1, mod = self:GetParent():HasModifier("modifier_morphling_15")}) 
	self:GetCaster():CalculateStatBonus(true)
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end

function modifier_morphling_replicate_custom:AddCustomTransmitterData() 
	return 
	{
		attack_range = self.attack_range,
		model = self.model,
		proj_name = self.proj_name,
	} 
end

function modifier_morphling_replicate_custom:HandleCustomTransmitterData(data)
	self.attack_range = data.attack_range
	self.model = data.model
	self.proj_name = data.proj_name
end

function modifier_morphling_replicate_custom:OnDestroy()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_morphling/morphling_replicate_finish.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	self:GetParent():SetAttackCapability(self.attack_type)
	self:GetParent():SetBaseStrength(self.strength)
	self:GetParent():SetBaseAgility(self.agility)
	self:GetParent():SetBaseIntellect(self.intellect)
	self:GetParent():SetBaseMoveSpeed(self.movespeed)
	self:GetParent():EmitSound("Hero_Morphling.ReplicateEnd")

	local morph_abilities = {}
	morph_abilities[0] = "morphling_waveform_custom"
	morph_abilities[1] = "morphling_adaptive_strike_agi_custom"
	morph_abilities[2] = "morphling_replicate_ability_slot"
	morph_abilities[3] = "morphling_morph_agi_custom"
	morph_abilities[4] = "morphling_morph_str_custom"

	if self.modifier_morphling_15_has then
		morph_abilities[0] = "morphling_waterraze1_custom"
		morph_abilities[1] = "morphling_waterraze2_custom"
		morph_abilities[2] = "morphling_waterraze3_custom"
		morph_abilities[3] = "morphling_morph_agi_custom"
		morph_abilities[4] = "morphling_morph_str_custom"
	end

	for id, ability_original in pairs(morph_abilities) do
		local ability_in_slot = self:GetCaster():GetAbilityByIndex(id)
		if ability_in_slot and ability_in_slot:GetAbilityName() ~= ability_original then
            if ability_original.additional_ability and not ability_original.additional_ability:IsNull() then
                if ability_original:GetAbilityIndex() ~= ability_original.main_slot then
                    self:GetCaster():SwapAbilities(ability_original:GetAbilityName(), self:GetCaster():GetAbilityByIndex(ability_original.main_slot):GetAbilityName(), false, true)
                end
                self:GetCaster():RemoveAbilityByHandle(ability_original.additional_ability)
                ability_original.additional_ability = nil
            end
			self:GetCaster():SwapAbilities(ability_in_slot:GetAbilityName(), ability_original, false, true)
			ability_in_slot:SetHidden(true)
			table.insert(self:GetParent().spell_steal_history, ability_in_slot)
		end
	end

	local morphling_waveform_custom = self:GetCaster():FindAbilityByName("morphling_waveform_custom")
	if self.modifier_morphling_15_has then
		morphling_waveform_custom = self:GetCaster():FindAbilityByName("morphling_waterraze1_custom")
	end
	if morphling_waveform_custom then
		morphling_waveform_custom:SetHidden(false)
	end

	local morphling_adaptive_strike_agi_custom = self:GetCaster():FindAbilityByName("morphling_adaptive_strike_agi_custom")
	if self.modifier_morphling_15_has then
		morphling_adaptive_strike_agi_custom = self:GetCaster():FindAbilityByName("morphling_waterraze2_custom")
	end
	if morphling_adaptive_strike_agi_custom then
		morphling_adaptive_strike_agi_custom:SetHidden(false)
	end

	local morphling_replicate_ability_slot = self:GetCaster():FindAbilityByName("morphling_replicate_ability_slot")
	if self.modifier_morphling_15_has then
		morphling_replicate_ability_slot = self:GetCaster():FindAbilityByName("morphling_waterraze3_custom")
	end
	if morphling_replicate_ability_slot then
        if morphling_replicate_ability_slot:GetAbilityName() == "morphling_replicate_ability_slot" then
            morphling_replicate_ability_slot:SetHidden(true)
        else
		    morphling_replicate_ability_slot:SetHidden(false)
        end
	end

	if not self.modifier_morphling_15_has then
		local morphling_morph_agi_custom = self:GetCaster():FindAbilityByName("morphling_morph_agi_custom")
		if morphling_morph_agi_custom then
			morphling_morph_agi_custom:SetHidden(false)
		end

		local morphling_morph_str_custom = self:GetCaster():FindAbilityByName("morphling_morph_str_custom")
		if morphling_morph_str_custom then
			morphling_morph_str_custom:SetHidden(false)
		end
	else
		local morphling_morph_agi_custom = self:GetCaster():FindAbilityByName("morphling_morph_agi_custom")
		if morphling_morph_agi_custom then
			morphling_morph_agi_custom:SetHidden(true)
		end

		local morphling_morph_str_custom = self:GetCaster():FindAbilityByName("morphling_morph_str_custom")
		if morphling_morph_str_custom then
			morphling_morph_str_custom:SetHidden(true)
		end
	end

    self:GetParent():RemoveModifierByName("modifier_night_stalker_hunter_in_the_night_custom_buff")
    self:GetParent():RemoveModifierByName("modifier_night_stalker_hunter_in_the_day_buff")

	self:GetCaster():CalculateStatBonus(true)

	for _, item in pairs(self.items_econ) do
		if item then
			item:Destroy()
		end
	end

    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(self:GetCaster():GetPlayerOwnerID()), "morph_stats_replicated", {value = 0, mod = self:GetParent():HasModifier("modifier_morphling_15")}) 
end

function modifier_morphling_replicate_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BASE_OVERRIDE,
		MODIFIER_PROPERTY_PROJECTILE_NAME
	}
end

function modifier_morphling_replicate_custom:GetModifierProjectileName()
    return self.proj_name
end

function modifier_morphling_replicate_custom:GetModifierModelChange()
    return self.model
end

function modifier_morphling_replicate_custom:GetModifierAttackRangeOverride()
	return self.attack_range
end

function modifier_morphling_replicate_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_morphling_replicate_custom:GetEffectName()
	return "particles/units/heroes/hero_morphling/morphling_replicate_buff.vpcf"
end

function modifier_morphling_replicate_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_morphling_morph_target.vpcf"
end

function  modifier_morphling_replicate_custom:StatusEffectPriority()
	return 10
end

modifier_morphling_replicate_custom_remove = class({})

function modifier_morphling_replicate_custom_remove:IsHidden() 
    return true
end

function modifier_morphling_replicate_custom_remove:IsPurgable() return false end

function modifier_morphling_replicate_custom_remove:OnCreated()
    if IsServer() then
        self:GetParent().spell_steal_history = {}
        self:StartIntervalThink(FrameTime())
    end
end

function modifier_morphling_replicate_custom_remove:OnIntervalThink()
    if IsServer() then
        local caster = self:GetParent()
        for i=#caster.spell_steal_history,1,-1 do
            local hSpell = caster.spell_steal_history[i]
            if hSpell:GetToggleState() then
				hSpell:ToggleAbility()
			end
			if hSpell:GetIntrinsicModifierName() ~= nil then
		        local modifier_intrinsic = self:GetParent():FindModifierByName(hSpell:GetIntrinsicModifierName())
		        if modifier_intrinsic then
		            self:GetParent():RemoveModifierByName(modifier_intrinsic:GetName())
		        end
		    end
            local is_now_charges = true
            if hSpell:GetMaxAbilityCharges(-1) > 0 and hSpell:GetCurrentAbilityCharges() < hSpell:GetMaxAbilityCharges(-1) and caster:HasModifier("modifier_morphling_replicate_custom_manager") then
                is_now_charges = false
            end
            if hSpell:NumModifiersUsingAbility() <= 0 and not hSpell:IsChanneling() and is_now_charges then
            	if hSpell:GetIntrinsicModifierName() ~= nil then
			        local modifier_intrinsic = self:GetParent():FindModifierByName(hSpell:GetIntrinsicModifierName())
			        if modifier_intrinsic then
			            self:GetParent():RemoveModifierByName(modifier_intrinsic:GetName())
			        end
			    end
			    self:GetCaster():RemoveAbilityFromIndexByName(hSpell:GetAbilityName())
                hSpell:RemoveSelf()
                table.remove(caster.spell_steal_history,i)
            end
        end
    end
end

modifier_morphling_replicate_custom_stats_debuff = class({})
function modifier_morphling_replicate_custom_stats_debuff:GetTexture() return "morphling_14" end
function modifier_morphling_replicate_custom_stats_debuff:IsPurgable() return false end
function modifier_morphling_replicate_custom_stats_debuff:IsPurgeException() return false end
function modifier_morphling_replicate_custom_stats_debuff:OnCreated(params)
	if not IsServer() then return end
	self.str = params.str * -1
	self.agi = params.agi * -1
	self.int = params.int * -1
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end

function modifier_morphling_replicate_custom_stats_debuff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_morphling_replicate_custom_stats_debuff:GetModifierBonusStats_Strength()
	return self.str
end

function modifier_morphling_replicate_custom_stats_debuff:GetModifierBonusStats_Agility()
	return self.agi
end

function modifier_morphling_replicate_custom_stats_debuff:GetModifierBonusStats_Intellect()
	return self.int
end

modifier_morphling_replicate_custom_stats_buff = class({})
function modifier_morphling_replicate_custom_stats_buff:GetTexture() return "morphling_14" end
function modifier_morphling_replicate_custom_stats_buff:IsPurgable() return false end
function modifier_morphling_replicate_custom_stats_buff:IsPurgeException() return false end
function modifier_morphling_replicate_custom_stats_buff:OnCreated(params)
	if not IsServer() then return end
	self.str = params.str
	self.agi = params.agi
	self.int = params.int
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end

function modifier_morphling_replicate_custom_stats_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_morphling_replicate_custom_stats_buff:GetModifierBonusStats_Strength()
	return self.str
end

function modifier_morphling_replicate_custom_stats_buff:GetModifierBonusStats_Agility()
	return self.agi
end

function modifier_morphling_replicate_custom_stats_buff:GetModifierBonusStats_Intellect()
	return self.int
end