--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_BaseNPC:ResetCooldown(last)
    if self:IsNull() then return end
	
    local ignores_toggle = 
    {
        ["medusa_split_shot_custom"] = true,
        ["muerta_gunslinger"] = true,
        ["crystal_maiden_freezing_field_custom"] = true,
    }

    local ignore_refresh = 
    {
        ["undying_ceaseless_dirge_custom"] = true,
        ["roshan_strength_of_the_immortal_custom"] = true,
        ["item_eldwurms_edda"] = true,
    }

    for i = 0, self:GetAbilityCount()-1 do
		local ability = self:GetAbilityByIndex(i)
        if ability then
            if not ignore_refresh[ability:GetAbilityName()] then
                ability:RefreshCharges()
                ability:EndCooldown()
                if ability.RefreshCustomCharges then
                    ability:RefreshCustomCharges()
                end
            end
            if last == nil and ignores_toggle[ability:GetAbilityName()] == nil then
                if ability:GetToggleState() then 
                    ability:ToggleAbility()
                end
            end
        end
	end

	for i = 0,20 do
		local item = self:GetItemInSlot(i)
		if item then
            if not ignore_refresh[item:GetName()] then
			    item:EndCooldown()
                item:RefreshCharges()
            end
		end
	end

    if self.fake_dazzle and not self.fake_dazzle:IsNull() then
        self.fake_dazzle:ResetCooldown()
    end

    local dazzle_nothl_projection = self:FindModifierByName("modifier_dazzle_nothl_projection")
    if dazzle_nothl_projection then
        Timers:CreateTimer(1, function()
            if dazzle_nothl_projection and not dazzle_nothl_projection:IsCooldownReady() then
                dazzle_nothl_projection:EndCooldown()
            end
        end)
    end
end

function CDOTA_BaseNPC:IsMuertaDebuff()
    if self:HasModifier("modifier_muerta_parting_shot_knockback") then return true end
    if self:HasModifier("modifier_muerta_parting_shot_physical_body_debuff") then return true end
    if self:HasModifier("modifier_muerta_parting_shot_projectile_return") then return true end
    if self:HasModifier("modifier_muerta_parting_shot_soul_clone") then return true end
    if self:HasModifier("modifier_muerta_parting_shot_soul_debuff") then return true end
    return false
end

function CDOTA_BaseNPC:IgnoreWispAndInvisAndRelax(is_relax, is_wisp, is_smoke)
    local next_avial = true
    if self:HasModifier("modifier_woda_stunned") and is_wisp then
        next_avial = false 
    end
    if self:HasModifier("modifier_wodarelax") and is_relax then
        next_avial = false 
    end
    if self:HasModifier("modifier_wodawisp") and is_wisp then
        next_avial = false 
    end
    if self:HasModifier("modifier_wodarelax_invul") and is_relax then
        next_avial = false 
    end
    if self:HasModifier("modifier_smoke_of_deceit") and is_smoke then
        next_avial = false 
    end
    return next_avial
end

function CDOTA_BaseNPC:ResetHealthAndMana()
    if self:IsNull() then return end

    local modifiers_cooldown = 
    {
        "modifier_crystal_maiden_frostbite_custom_cooldown",
        "modifier_dragon_knight_dragon_blood_custom_death_buff_cooldown",
        "modifier_omniknight_martyr_custom_talent_passive_cooldown",
        "modifier_tidehunter_kraken_shell_custom_cooldown",
        "modifier_dragon_knight_13_buff_cooldown",
        "modifier_dragon_knight_18_cooldown",
        "modifier_modifier_lone_druid_9_cooldown",
        "modifier_tidehunter_2_cooldown",
        "modifier_modifier_windrunner_20_buff_cooldown",
        "modifier_lone_druid_unity_with_nature",
        "modifier_item_mekansm_noheal",
        "modifier_vengefulspirit_10_buff_cooldown",
        "modifier_lion_11_buff_cooldown",
        "modifier_pudge_meat_hook_custom",
        "modifier_pudge_meat_hook_custom_cooldown_talent",
        "modifier_modifier_muerta_4_cooldown",
        "modifier_spirit_breaker_18_cooldown",
        "modifier_bristleback_bristleback_cooldown",
        "modifier_kunkka_torrent_custom_talent_cooldown",
        "modifier_spirit_breaker_greater_bash_custom_cooldown",
        "modifier_ancient_apparition_ice_blast_custom_talent_cooldown",
        "modifier_lich_frost_shield_custom_scream_cooldown",
        "modifier_medusa_mystic_snake_custom_handler_cooldown",
        "modifier_techies_sticky_bomb_handler_cooldown",
        "modifier_techies_suicide_custom_magic_immune_cooldown",
        "modifier_huskar_1_buff_cooldown",
        "modifier_riki_permanent_invisibility_custom_immortality_cooldown",
        "modifier_luna_lucent_beam_custom_cooldown",
        "modifier_winter_wyvern_19_buff_cooldown",
        "modifier_bounty_hunter_wind_walk_custom_passive_cooldown",
    }

    local modifiers_delete_buffs = 
    {
        "modifier_antimage_blink_custom_magic_immune",
        "modifier_antimage_counterspell_custom_active",
        "modifier_crystal_maiden_crystal_nova_custom_buff_regeneration",
        "modifier_crystal_maiden_frostbite_custom_magic_immune",
        "modifier_dragon_knight_dragon_blood_custom_death_buff",
        "modifier_dragon_knight_elder_dragon_form_custom_1",
        "modifier_dragon_knight_elder_dragon_form_custom_2",
        "modifier_dragon_knight_elder_dragon_form_custom_3",
        "modifier_dragon_knight_elder_dragon_form_custom_4",
        "modifier_earthshaker_enchant_totem_custom",
        "modifier_lone_druid_true_form_custom",
        "modifier_omniknight_guardian_angel_custom",
        "modifier_omniknight_rain_of_purification",
        "modifier_phantom_assassin_blur_custom_active",
        "modifier_tidehunter_kraken_shell_custom_active",
        "modifier_windrunner_focusfire_custom",
        "modifier_windrunner_powershot_custom_magic_immune",
        "modifier_windrunner_windrun_custom",
        "modifier_item_aeon_boots_buff",
        "modifier_item_ogre_seal_totem_custom",
        "modifier_item_spider_legs_custom_buff",
        "modifier_item_force_field_custom_buff",
        "modifier_force_boots_active",
        "modifier_item_book_of_shadows_custom_buff",
        "modifier_item_bullwhip_custom_buff",
        "modifier_item_overflowing_elixir_custom",
        "modifier_item_third_eye_custom_buff",
        "modifier_item_minotaur_horn_custom_buff",
        "modifier_black_king_bar_immune",
        "modifier_item_aeon_disk_buff",
        "modifier_item_madness_blade_mail_buff",
        "modifier_item_solar_crest_custom_buff",
        "modifier_item_medallion_of_courage_custom_buff",
        "modifier_item_witch_mask_buff",
        "modifier_item_eye_of_thor_buff",
        "modifier_item_silver_edge_custom_active",
        "modifier_item_shadow_blade_custom_active",
        "modifier_item_shadow_amulet_custom_active",
        "modifier_item_glimmer_cape_custom_active",
        "modifier_item_glimmer_shiled_active",
        "modifier_item_evasion_cape_active",
        "modifier_witch_doctor_maledict_custom",
        "modifier_lone_druid_true_form_custom",
        "modifier_rune_arcane",
        "modifier_rune_doubledamage",
        "modifier_rune_extradamage",
        "modifier_rune_flying_haste",
        "modifier_rune_haste",
        "modifier_rune_regen",
        "modifier_rune_shield",
        "modifier_rune_super_arcane",
        "modifier_rune_super_invis",
        "modifier_rune_super_regen",
        "modifier_dragon_knight_dragon_tail_custom_aggro",
        "modifier_pudge_meat_hook_custom",
        "modifier_pudge_chain_binding",
        "modifier_pudge_chain_binding_damage",
        "modifier_nevermore_necromastery_fear",
        "modifier_nevermore_requiem_fear",
        "modifier_lone_druid_savage_roar_custom",
        "modifier_death_prophet_spirit_siphon_custom",
        "modifier_death_prophet_spirit_siphon_counter",
        "modifier_death_prophet_spirit_siphon_custom_debuff",
        "modifier_death_prophet_silence_custom_debuff",
        "modifier_death_prophet_exorcism_custom",
        "modifier_doom_bringer_doom_custom",
        "modifier_doom_bringer_infernal_blade_custom_debuff",
        "modifier_doom_bringer_scorched_earth_custom",
        "modifier_invoker_alacrity_custom",
        "modifier_custom_terrorblade_metamorphosis_transform",
        "modifier_custom_terrorblade_metamorphosis",
        "modifier_terrorblade_reflection_custom_debuff",
        "modifier_undying_decay_custom_buff",
        "modifier_undying_decay_custom_buff_counter",
        "modifier_undying_decay_custom_debuff",
        "modifier_undying_decay_custom_debuff_counter",
        "modifier_undying_decay_custom_agility_buff",
        "modifier_undying_decay_custom_agility_buff_counter",
        "modifier_undying_decay_custom_agility_debuff",
        "modifier_undying_decay_custom_agility_debuff_counter",
        "modifier_undying_decay_custom_intellect_buff",
        "modifier_undying_decay_custom_intellect_buff_counter",
        "modifier_undying_decay_custom_intellect_debuff",
        "modifier_undying_decay_custom_intellect_debuff_counter",
        "modifier_vengefulspirit_10_buff",
        "modifier_terrorblade_7_buff",
        "modifier_lion_11_buff",
        "modifier_slark_shadow_dance_custom",
        "modifier_slardar_slithereen_crush_custom_puddle_attack_speed",
        "modifier_slardar_amplify_damage_custom",
        "modifier_oracle_rain_of_destiny_custom",
        "modifier_oracle_fates_edict_custom",
        "modifier_oracle_false_promise_custom",
        "modifier_oracle_change_of_fate",
        "modifier_morphling_replicate_custom_manager",
        "modifier_morphling_replicate_custom",
        "modifier_morphling_replicate_custom_stats_debuff",
        "modifier_morphling_replicate_custom_stats_buff",
        "modifier_kunkka_attacker_delay",
        "modifier_kunkka_attacker_cast",
        "modifier_kunkka_rum",
        "modifier_kunkka_rum_debuff",
        "modifier_kunkka_x_marks_the_spot_custom_debuff",
        "modifier_slark_essence_shift_custom_debuff",
        "modifier_slark_essence_shift_custom_debuff_stack",
        "modifier_slark_essence_shift_custom_stack",
        "modifier_slark_essence_shift_custom_buff",
        "modifier_slark_essence_shift_custom_stack_strength",
        "modifier_slark_essence_shift_custom_buff_strength",
        "modifier_oracle_purifying_flames_custom",
        "modifier_spectre_dispersion_custom_aggresive",
        "modifier_lich_sinister_gaze_custom_debuff",
        "modifier_aghanim_blink_attack_backawards",
        "modifier_item_revenants_brooch_counter",
        "modifier_item_revenants_brooch_internal_cd",
        "modifier_item_bloodstone_drained",
        "modifier_item_bloodstone_active",
        "modifier_bounty_hunter_track_custom",
        "modifier_muerta_dead_shot_custom_fear",
        "modifier_morphling_waveform_custom",
        "modifier_vengefulspirit_wave_of_terror_custom_spirit",
        "modifier_naga_siren_mirror_image_custom",
        "modifier_naga_siren_song_of_the_siren_custom",
        "modifier_tiny_toss_custom",
        "modifier_night_stalker_darkness_custom",
        "modifier_medusa_stone_gaze_custom",
        "modifier_abaddon_aphotic_shield_custom",
        "modifier_abaddon_borrowed_time_custom_buff",
        "modifier_abaddon_frostmourne_custom_aggresive",
        "modifier_nyx_assassin_burrow_custom",
        "modifier_roshan_bash_custom_active",
        "modifier_nyx_assassin_vendetta_custom",
        "modifier_huskar_life_break_custom_debuff_aggresive",
        "modifier_ancient_apparition_ice_blast_custom_debuff",
        "modifier_huskar_burning_spear_custom_debuff",
        "modifier_pangolier_gyroshell_custom",
        "modifier_pangolier_rollup_custom",
        "modifier_pangolier_gyroshell_custom_rollup",
        "modifier_huskar_life_break_custom_debuff_immune",
        "modifier_huskar_life_break_custom",
        "modifier_luna_lucent_beam_custom_damage_boost",
        "modifier_luna_eclipse_custom",
        "modifier_axe_berserkers_call_custom_debuff",
        "modifier_axe_berserkers_call_custom_fear",
        "modifier_ursa_fury_swipes_custom_debuff",
        "modifier_phoenix_supernova_custom_buff",
        "modifier_phoenix_super_supernova_custom_buff",
        "modifier_phoenix_sun_ray_custom_caster_dummy",
        "modifier_phoenix_icarus_dive_custom_dash_dummy",
        "modifier_razor_armor_link_custom_target",
        "modifier_razor_armor_link_custom_caster",
        "modifier_razor_eye_of_the_storm_custom",
        "modifier_razor_magic_link_custom_target",
        "modifier_razor_magic_link_custom_caster",
        "modifier_razor_magic_link_custom",
        "modifier_razor_armor_link_custom",
        "modifier_razor_spell_link_custom",
        "modifier_razor_spell_link_custom_target",
        "modifier_razor_spell_link_custom_caster",
        "modifier_razor_static_link_custom_target",
        "modifier_razor_static_link_custom_caster",
        "modifier_razor_static_link_custom_attacking",
        "modifier_wisp_relocate_custom_cast_delay",
        "modifier_wisp_relocate_custom",
        "modifier_custom_void_dissimilate",
        "modifier_phoenix_ice_debuff",
        "modifier_monkey_king_mischief_custom",
        "modifier_monkey_king_transform",
        "modifier_monkey_king_transform_courier",
        "modifier_monkey_king_transform_runes",
        "modifier_dazzle_nothl_projection_physical_body_debuff",
        "modifier_kunkka_admirals_rum_custom_buff",
        "modifier_kunkka_admirals_rum_custom_debuff",
        "modifier_generic_arc_lua",
        "modifier_rubick_curiosity",
        "modifier_dazzle_bad_juju_custom",
    }

    if GetMapName() == "arena" then
        if not self:IsAlive() and not player_system:IsLose(self:GetPlayerOwnerID()) then 
            Timers:CreateTimer({ endTime = 0.01, 
                callback = function()
                self:RespawnHero(false, false)
            end})
        end
    else
    	if not self:IsAlive() and not self:GetRespawnsDisabled() and not player_system:IsLose(self:GetPlayerOwnerID()) then 
            Timers:CreateTimer({ endTime = 0.01, 
                callback = function()
                self:RespawnHero(false, false)
            end})
    	end
    end

    local modifier_skeleton_king_vampiric_aura_custom_ghost_buff = self:FindModifierByName("modifier_skeleton_king_vampiric_aura_custom_ghost_buff")
    if modifier_skeleton_king_vampiric_aura_custom_ghost_buff then
        modifier_skeleton_king_vampiric_aura_custom_ghost_buff.close_death = true
    end

    ProjectileManager:ProjectileDodge(self)

    Timers:CreateTimer({endTime = 0.2,  callback = function()
        if string.find(GetMapName(), "rating") then
            self:RemoveAllUnitsOwnerPlayer()
            local pudge_meat_hook_custom = self:FindAbilityByName("pudge_meat_hook_custom")
            if pudge_meat_hook_custom then
                for id, hook in pairs(pudge_meat_hook_custom.hooks) do
                    if hook ~= nil then
                        if pudge_meat_hook_custom.hooks[id].hVictim and not pudge_meat_hook_custom.hooks[id].hVictim:IsNull() then
                            pudge_meat_hook_custom.hooks[id].hVictim:RemoveModifierByName("modifier_pudge_meat_hook_custom_debuff")
                            if pudge_meat_hook_custom.hooks[id].hVictim and pudge_meat_hook_custom.hooks[id].hVictim:GetUnitName() == "npc_dota_companion" then 
                                UTIL_Remove(pudge_meat_hook_custom.hooks[id].hVictim)
                            end
                            if pudge_meat_hook_custom.hooks[id].thinker then 
                                UTIL_Remove(pudge_meat_hook_custom.hooks[id].thinker)
                            end
                        end
                        ProjectileManager:DestroyLinearProjectile(id)
                    end
                end
            end
        else
            for _, unit in pairs(FindUnitsInRadius(self:GetTeamNumber(), self:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
                if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" then
                    unit:Heal(999999, nil)              
                end
            end
        end

        for _, unit in pairs(FindUnitsInRadius(self:GetTeamNumber(), self:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + MODIFIER_STATE_OUT_OF_GAME, FIND_ANY_ORDER, false)) do 
            if unit:IsIllusion() then
                unit:ForceKill(false) 
            end 
        end

        local modifier_skeleton_king_vampiric_aura_custom_ghost_buff = self:FindModifierByName("modifier_skeleton_king_vampiric_aura_custom_ghost_buff")
        if modifier_skeleton_king_vampiric_aura_custom_ghost_buff then
            modifier_skeleton_king_vampiric_aura_custom_ghost_buff.close_death = true
            modifier_skeleton_king_vampiric_aura_custom_ghost_buff:Destroy()
        end

        local thinkers = Entities:FindAllByClassname("npc_dota_thinker")
        for _, thinker in pairs(thinkers) do
            if thinker:GetTeamNumber() == self:GetTeamNumber() then
                if not thinker:HasModifier("modifier_luna_lunar_orbit_custom_glaive") and not thinker:HasModifier("modifier_dawnbreaker_celestial_hammer_custom_thinker") then
                    UTIL_Remove(thinker)
                end
            end
        end

        local monkey_king_wukongs_command_custom = self:FindAbilityByName("monkey_king_wukongs_command_custom")
        if monkey_king_wukongs_command_custom and monkey_king_wukongs_command_custom.soldiers then
            for i, monkey_scepter in pairs(monkey_king_wukongs_command_custom.soldiers) do
                local modifier_monkey_king_wukongs_command_custom_soldier_active = monkey_scepter:FindModifierByName("modifier_monkey_king_wukongs_command_custom_soldier_active")
                if modifier_monkey_king_wukongs_command_custom_soldier_active then
                    modifier_monkey_king_wukongs_command_custom_soldier_active:Destroy()
                end
            end
        end

        for _, modifier_cd in pairs(modifiers_cooldown) do
            self:RemoveModifierByName(modifier_cd)
        end

        if self and IsValidCustom(self.fake_dazzle) then
            self.fake_dazzle:RemoveModifierByName("modifier_dazzle_nothl_projection_soul_debuff")
        end

        if string.find(GetMapName(), "rating") then
            for _, modifier_buff in pairs(modifiers_delete_buffs) do
                if modifier_buff == "modifier_death_prophet_exorcism_custom" then
                    local modifier_death_prophet_exorcism_custom = self:FindModifierByName("modifier_death_prophet_exorcism_custom")
                    if modifier_death_prophet_exorcism_custom then
                        modifier_death_prophet_exorcism_custom:DeleteSpirits()
                    end
                end
                local original_mod = self:FindModifierByName(modifier_buff)
                if original_mod then
                    original_mod.reset_cooldown = true
                    original_mod:Destroy()
                end
            end
        end

        local modifier_woda_handler_player = self:FindModifierByName("modifier_woda_handler_player")
        if modifier_woda_handler_player then
            modifier_woda_handler_player.hunt_counter = 0
        end

        self:RemoveModifierByName("modifier_woda_pve_creep_timeout_manacost")
        self:RemoveModifierByName("modifier_woda_pve_creep_timeout_armor_debuff")

    	self:Purge(false, true, false, true, true)

    	local maxhealth = self:GetMaxHealth()
    	local maxmana = self:GetMaxMana()

    	self:SetHealth(maxhealth)
    	self:SetMana(maxmana)
    end})
end

function CDOTA_BaseNPC:RemoveAllUnitsOwnerPlayer()
    local units_to_removed = FindUnitsInRadius(self:GetTeamNumber(), self:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
    for _, unit in pairs(units_to_removed) do
        if unit:GetOwner() == self and unit:GetUnitName() ~= "npc_dota_lone_druid_bear_custom" and not unit:IsIllusion() and not unit:IsHero() and unit:IsControllableByAnyPlayer() then
            unit:ForceKill(false) 
        end
    end
    for _, unit in pairs(FindUnitsInRadius(self:GetTeamNumber(), self:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
        if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" then
            unit:ForceKill(false)               
        end
    end
    for k, v in pairs(Entities:FindAllInSphere(self:GetAbsOrigin(), 99999)) do
        if v:GetName() == "npc_dota_unit_undying_tombstone" and (v:FindModifierByName("modifier_undying_tombstone_custom") and v:FindModifierByName("modifier_undying_tombstone_custom"):GetCaster() == self) then
            v:ForceKill(false)
        end
    end
end

function CDOTA_BaseNPC:PlayerForceKillAndLose()
    if self:IsNull() then return end
    local wisp_modifier = self:FindModifierByName("modifier_wodawispdeath")

    if wisp_modifier then
        if wisp_modifier.wisp ~= nil then
            wisp_modifier.wisp:Destroy()
        end
    end

    for _, modifier in pairs(self:FindAllModifiers()) do
        if modifier and not modifier:IsNull() and modifier:GetName() ~= "modifier_wodaduel1" and modifier:GetName() ~= "modifier_wodaduel_duo" then
            modifier:Destroy()
        end
    end

    for _, unit in pairs(FindUnitsInRadius(self:GetTeamNumber(), self:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
        if unit:GetUnitName() == "npc_dota_lone_druid_bear_custom" then
            unit:ForceKill(false)               
        end
    end

    local thinkers = Entities:FindAllByClassname("npc_dota_thinker")
    for _, thinker in pairs(thinkers) do
        if thinker and thinker:GetTeamNumber() == self:GetTeamNumber() then
            UTIL_Remove(thinker)
        end
    end

    local monkey_king_wukongs_command_custom = self:FindAbilityByName("monkey_king_wukongs_command_custom")
    Timers:CreateTimer(FrameTime(), function()
        if monkey_king_wukongs_command_custom and monkey_king_wukongs_command_custom.soldiers then
            for _, monkey_scepter in pairs(monkey_king_wukongs_command_custom.soldiers) do
                UTIL_Remove(monkey_scepter)
            end
        end
    end)

    self.IS_LOSE_GAME = true

    player_system:SetLosePlayer(self:GetPlayerOwnerID())

    Timers:CreateTimer({ endTime = 0.02, 
        callback = function()
        self:RespawnHero(false, false)
    end})

    self:SetRespawnsDisabled(true)

    self:RemoveModifierByName("modifier_fountain_invulnerability")

    Timers:CreateTimer({ endTime = 0.2, callback = function()
        for _, modifier in pairs(self:FindAllModifiers()) do
            if modifier and not modifier:IsNull() and modifier:GetName() ~= "modifier_wodaduel_duo" then
                modifier:Destroy()
            end
        end
        self:SetBuyBackDisabledByDevilsBargain(true)
        self:ForceKill(false)
        self:SetRespawnsDisabled(true)
        self:SetAbsOrigin(Vector(99990, 99990, -5000))
        if self:IsAlive() then
            return 0.2
        end
    end})
end

function PrintTable(t, indent, done)
    if type(t) ~= "table" then return end

    done = done or {}
    done[t] = true
    indent = indent or 0

    local l = {}
    for k, v in pairs(t) do
        table.insert(l, k)
    end

    table.sort(l)
    for k, v in ipairs(l) do
        if v ~= 'FDesc' then
            local value = t[v]

            if type(value) == "table" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..":")
                PrintTable (value, indent + 2, done)
            elseif type(value) == "userdata" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
            else
                if t.FDesc and t.FDesc[v] then
                    print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
                else
                    print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                end
            end
        end
    end
end

function CDOTA_BaseNPC:SetCamera(target, start_arena)
	local player = PlayerResource:GetPlayer(self:GetPlayerID())
    if player then
        CustomGameEventManager:Send_ServerToPlayer(player, "set_camera_target", {id = target:entindex(), } )
    end
    local hero = self
    if start_arena then
        PlayerResource:SetOverrideSelectionEntity(self:GetPlayerOwnerID(), target)
    end
    PlayerResource:SetCameraTarget(self:GetPlayerOwnerID(), target) 
    Timers:CreateTimer({ endTime = FrameTime(), callback = function()
        PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), nil)
        if start_arena then
            PlayerResource:SetOverrideSelectionEntity(hero:GetPlayerOwnerID(), nil)
        end
    end})
end

function CDOTA_BaseNPC:SetOverridehero(target)
    local player = PlayerResource:GetPlayer(self:GetPlayerID())
    if player then
        CustomGameEventManager:Send_ServerToPlayer(player, "set_unit_target", {unit = target:entindex(), } )
    end
    --PlayerResource:SetOverrideSelectionEntity(self:GetPlayerOwnerID(), target)
    --local hero = self
    --Timers:CreateTimer({ endTime = FrameTime(), callback = function()
    --    PlayerResource:SetOverrideSelectionEntity(hero:GetPlayerOwnerID(), nil)
    --end})
end
    

function CDOTA_BaseNPC:SetUnit(target)
    local player = PlayerResource:GetPlayer(self:GetPlayerID())
    if player then
        CustomGameEventManager:Send_ServerToPlayer(player, "set_unit_target", {unit = target:GetEntityIndex(), } )
    end
end

function CDOTA_BaseNPC:GetTalentLevel( mod )
   if self:HasModifier(mod) then 
        return self:GetModifierStackCount(mod, self)
    else 
        return 0 
    end 
end

function CDOTA_BaseNPC:AbilityIsCooldown( name )
    local ability = self:FindAbilityByName(name)
    if ability and ability:IsFullyCastable() then
        return false
    end
    return true
end

function CDOTA_BaseNPC:StartCooldownAbil( name, sec )
    local ability = self:FindAbilityByName(name)
    if ability then
        ability:StartCooldown(sec)
    end
end

function CDOTA_BaseNPC:IllusionCopyUpgrades(ill)
    
    local copy_modifiers = 
    {
        "modifier_woda_talent_hp1", 
        "modifier_woda_talent_regenhp1",
        "modifier_woda_talent_attack1",
        "modifier_woda_talent_str3",
        "modifier_woda_talent_cloak",
        "modifier_woda_talent_quickhp",
        "modifier_woda_talent_str4",
        "modifier_woda_talent_hp2",
        "modifier_woda_talent_sliver",
        "modifier_woda_talent_sasha",
        "modifier_woda_talent_armor2",
        "modifier_woda_talent_regenhp2",
        "modifier_woda_talent_str5",
        "modifier_woda_talent_octar",
        "modifier_woda_talent_str6",
        "modifier_woda_talent_armor1",
        "modifier_woda_talent_speed1",
        "modifier_woda_talent_attackspeed1",
        "modifier_woda_talent_agi3",
        "modifier_woda_talent_miss1",
        "modifier_woda_talent_mask1",
        "modifier_woda_talent_agi4",
        "modifier_woda_talent_speed2",
        "modifier_woda_talent_grovebow",
        "modifier_woda_talent_yasha",
        "modifier_woda_talent_attack2",
        "modifier_woda_talent_attackspeed2",
        "modifier_woda_talent_agi5",
        "modifier_woda_talent_miss2",
        "modifier_woda_talent_agi6",
        "modifier_woda_talent_mp1",
        "modifier_woda_talent_regenmp1",
        "modifier_woda_talent_spell",
        "modifier_woda_talent_int3",
        "modifier_woda_talent_fairy",
        "modifier_woda_talent_mask2",
        "modifier_woda_talent_int4",
        "modifier_woda_talent_mp2",
        "modifier_woda_talent_blood",
        "modifier_woda_talent_kaya",
        "modifier_woda_talent_spellprism",
        "modifier_woda_talent_regenmp2",
        "modifier_woda_talent_int5",
        "modifier_woda_talent_timeless",
        "modifier_woda_talent_int6",
        "modifier_spectre_8",
        "modifier_spectre_9",
        "modifier_spectre_12",
        "modifier_spectre_13",
        "nevermore_necromastery_custom",
        "modifier_dragon_knight_elder_dragon_form_custom_3_talent",
        "modifier_dragon_knight_elder_dragon_form_custom_2_talent",
        "modifier_dragon_knight_elder_dragon_form_custom_1_talent",
        "modifier_dragon_knight_elder_dragon_form_custom_1",
        "modifier_dragon_knight_elder_dragon_form_custom_2",
        "modifier_dragon_knight_elder_dragon_form_custom_3",
        "modifier_lone_druid_true_form_custom",
        "modifier_nevermore_dark_lord_custom_aura",
        "modifier_nevermore_necromastery_custom",
        "modifier_undying_flesh_golem_custom",
        "modifier_naga_siren_18",
        "modifier_naga_siren_1",
        "modifier_naga_siren_14",
        "modifier_nyx_assassin_21",
        "modifier_chen_1",
        "modifier_chen_2",
        "modifier_chen_3",
        "modifier_chen_4",
        "modifier_chen_8",
        "modifier_chen_9",
        "modifier_chen_10",
        "modifier_chen_11",
        "modifier_chen_12",
        "modifier_chen_13",
        "modifier_chen_14",
        "modifier_chen_15",
        "modifier_chen_16",
        "modifier_chen_17",
        "modifier_chen_18",
        "modifier_chen_19",
        "modifier_chen_20",
        "modifier_chen_21",
        "modifier_chen_1_buff",
        "modifier_chen_8_buff",
        "modifier_chen_15_buff",
        "modifier_antimage_1",
        "modifier_marci_21",
        "modifier_marci_15",
        "modifier_warlock_8",
        "modifier_warlock_9",
        "modifier_warlock_10",
        "modifier_warlock_11",
        "modifier_spectre_6",
        "modifier_sniper_1",
        "modifier_sniper_2",
        "modifier_sniper_7",
        "modifier_sniper_3",
        "modifier_sniper_4",
        "modifier_sniper_10",
        "modifier_sniper_16",
        "modifier_sniper_17",
        "modifier_sniper_19",
        "modifier_antimage_16",
    }

    local original_hero = nil
    local modifier_illusion = ill:FindModifierByName("modifier_illusion")
    if modifier_illusion then
        original_hero = modifier_illusion:GetCaster()
    end
    local owner_id = ill:GetPlayerOwnerID()
    if PlayerResource:GetSelectedHeroEntity(owner_id) then
        original_hero = PlayerResource:GetSelectedHeroEntity(owner_id)
    end
    if original_hero ~= nil then
        for _, modifier_name in pairs(copy_modifiers) do
            local next_av = true
            if ill:HasModifier("modifier_riki_permanent_invisibility_custom_illusion") and string.find(modifier_name, "_hp") then
                next_av = false
            end
            if next_av then
                local modifier = original_hero:FindModifierByName(modifier_name)
                if modifier then
                    local dur_new = -1
                    local full_dur = -1
                    if modifier:GetRemainingTime() > 0 then
                        dur_new = modifier:GetRemainingTime()
                        full_dur = modifier:GetDuration()
                    end
                    local new_modifier = self:AddNewModifier(self, modifier:GetAbility(), modifier_name, {duration = full_dur})
                    if new_modifier then
                        if dur_new > 0 then
                            new_modifier:SetDuration(dur_new, true)
                        end
                        new_modifier:SetStackCount(modifier:GetStackCount())
                        if new_modifier:GetName() == "modifier_woda_talent_blood" then
                            new_modifier:UpdateShieldFast()
                        end
                    end
                end
            end
            if original_hero.SetAttribute then
                ill.SetAttribute = original_hero.SetAttribute
                ill:SetPrimaryAttribute(original_hero.SetAttribute)
            end
        end
        if original_hero:HasModifier("modifier_item_spear_of_mordiggian_active") then
            local modifier_item_spear_of_mordiggian_active = original_hero:FindModifierByName("modifier_item_spear_of_mordiggian_active")
            if modifier_item_spear_of_mordiggian_active then
                local new_modifier = self:AddNewModifier(self, modifier_item_spear_of_mordiggian_active:GetAbility(), "modifier_item_spear_of_mordiggian_active", {})
            end
        end
        local modifiers = original_hero:FindAllModifiers() 
        for _,modifier in pairs(modifiers) do 
            if modifier:GetName() == "modifier_invoker_quas_custom" then
                local modifier_2 = self:AddNewModifier(self, self:FindAbilityByName( "invoker_quas_custom" ), "modifier_invoker_quas_custom", {})
                self:FindAbilityByName( "invoker_invoke_custom" ):OnUpgrade()
                self:FindAbilityByName( "invoker_invoke_custom" ):AddOrb( modifier_2, "particles/units/heroes/hero_invoker/invoker_quas_orb.vpcf" )
            elseif modifier:GetName() == "modifier_invoker_wex_custom" then
                local modifier_2 = self:AddNewModifier(self, self:FindAbilityByName( "invoker_wex_custom" ), "modifier_invoker_wex_custom", {})
                self:FindAbilityByName( "invoker_invoke_custom" ):OnUpgrade()
                self:FindAbilityByName( "invoker_invoke_custom" ):AddOrb( modifier_2, "particles/units/heroes/hero_invoker/invoker_wex_orb.vpcf" )
            elseif modifier:GetName() == "modifier_invoker_exort_custom" then
                local modifier_2 = self:AddNewModifier(self, self:FindAbilityByName( "invoker_exort_custom" ), "modifier_invoker_exort_custom", {})
                self:FindAbilityByName( "invoker_invoke_custom" ):OnUpgrade()
                self:FindAbilityByName( "invoker_invoke_custom" ):AddOrb( modifier_2, "particles/units/heroes/hero_invoker/invoker_exort_orb.vpcf" )
            end
        end
    end
end

function CDOTA_BaseNPC:IsCustomHasTethered()
    for _, mod in pairs(self:FindAllModifiers()) do
        local tables = {}
        mod:CheckStateToTable(tables)
        for state_name, mod_table in pairs(tables) do
            if tostring(state_name) == tostring(MODIFIER_STATE_TETHERED) then
                return true
            end
        end
    end
    return false
end

function CDOTA_BaseNPC:IsDisarmedCustom(ignore_mod_table)
    for _, mod in pairs(self:FindAllModifiers()) do
        if not ignore_mod_table[mod:GetName()] then
            local tables = {}
            mod:CheckStateToTable(tables)
            for state_name, mod_table in pairs(tables) do
                if tostring(state_name) == tostring(MODIFIER_STATE_DISARMED) then
                    return true
                end
            end
        end
    end
    return false
end

function CDOTA_BaseNPC:IsStunnedCustom(ignore_mod_table)
    for _, mod in pairs(self:FindAllModifiers()) do
        if not ignore_mod_table[mod:GetName()] then
            local tables = {}
            mod:CheckStateToTable(tables)
            for state_name, mod_table in pairs(tables) do
                if tostring(state_name) == tostring(MODIFIER_STATE_STUNNED) then
                    return true
                end
            end
        end
    end
    return false
end


function CDOTA_BaseNPC:IsTrueSightImmune(ignore_mod_table)
    for _, mod in pairs(self:FindAllModifiers()) do
        if not ignore_mod_table[mod:GetName()] then
            local tables = {}
            mod:CheckStateToTable(tables)
            for state_name, mod_table in pairs(tables) do
                if tostring(state_name) == tostring(MODIFIER_STATE_TRUESIGHT_IMMUNE) then
                    return true
                end
            end
        end
    end
    return false
end

function AddCreepBonusSkill(count, boss, has_skill)
    local list = {}

    local skills = 
    {
        "woda_neutral_steal_weapon",
        "woda_neutral_speed_aura",
        "woda_neutral_break",
        "woda_neutral_heal_amplification_aura",
        "woda_neutral_envenomed_weapon",
        "woda_neutral_swiftness_aura",
        "woda_neutral_thunder_clap",
        "woda_neutral_tornado",
        "woda_neutral_hurricane",
        "woda_neutral_toughness_aura",
        "woda_neutral_vex",
        "woda_neutral_frost_attack",
        "woda_neutral_chain_lightning",
        "woda_neutral_cloak_aura",
        "woda_neutral_war_stomp",
        "woda_neutral_ensnare",
        "woda_neutral_rally",
        "woda_neutral_seed_shot",
        "woda_neutral_fireball",
        "woda_neutral_splash_attack",
        "woda_neutral_intimidate",
        "woda_neutral_critical_strike",
        "woda_neutral_packleader_aura",
        "woda_neutral_purge",
        "woda_neutral_mana_burn",
        "woda_neutral_weakening_aura",
        "woda_neutral_granite_aura",
        "woda_neutral_war_drums_aura",
        "woda_neutral_frenzy",
        "woda_neutral_icegire_bomb",
        "woda_neutral_smash",
        "woda_neutral_smash_hop",
        "woda_neutral_ice_armor",
        "woda_neutral_hurl_boulder",
        "woda_neutral_shockwave",
        "woda_neutral_unholy_aura",
        "woda_neutral_purification",
        "woda_neutral_ogre_seal",
        "roshan_spell_block",
        "roshan_bash",
        "roshan_slam",
        "woda_neutral_from_1",
        "woda_neutral_from_2",
        "woda_neutral_from_3",
        "woda_neutral_from_4",
    }

    if boss ~= nil then
        skills = 
        {
            "boss_keeper_mana",
            "boss_keeper_light",
            "boss_keeper_horse",
            "boss_sand_king_burrow",
            "boss_sand_king_sandstorm",
            "boss_sand_king_burrowstrike",
            "tiny_boss_toss",
            "tiny_boss_avalanche",
            "tiny_boss_stone_throw",
            "boss_ursa_fury_swipes",
            "boss_ursa_enrage",
            "boss_ursa_jump",
            "morphling_boss_morphling_storm",
            "morphling_boss_tidal_wave",
            "morphling_boss_waveform",
            "boss_medusa_split",
            "boss_medusa_stone",
            "boss_medusa_aura",
            "phoenix_boss_egg",
            "phoenix_boss_wave",
            "phoenix_boss_beam",
            "creature_hellbear_spawn_1",
            "creature_hellbear_spawn_1",
            "creature_hellbear_spawn_3",
            "creature_hellbear_spawn_4",
            "creature_hellbear_spawn_5",
            "boss_shadow_fiend_passive_shadowraze",
            "boss_shadow_fiend_passive_ultimate",
            "boss_shadow_fiend_passive_dark_cyclone",
        }
    end

    local bear_abilities =
    {
        ["creature_hellbear_spawn_1"] = true,
        ["creature_hellbear_spawn_1"] = true,
        ["creature_hellbear_spawn_3"] = true,
        ["creature_hellbear_spawn_4"] = true,
        ["creature_hellbear_spawn_5"] = true,
    }
    
    for i = 1, count do
        local ab_name = table.remove(skills, RandomInt(1, #skills))
        if ab_name == has_skill then
            ab_name = table.remove(skills, RandomInt(1, #skills))
        end
        if bear_abilities[ab_name] then
            for d=#skills, 1, -1 do
                if bear_abilities[skills[d]] then
                    table.remove(skills, d)
                end
            end
        end
        table.insert(list, ab_name)
    end

    return list
end

if not CDOTA_BaseNPC.oldSwapAbilities then
	CDOTA_BaseNPC.oldSwapAbilities = CDOTA_BaseNPC.SwapAbilities
end

function CDOTA_BaseNPC:SwapAbilities(pAbilityName1, pAbilityName2, bEnable1, bEnable2)
    local ability_first = self:FindAbilityByName(pAbilityName1)
    local ability_second = self:FindAbilityByName(pAbilityName2)
    if not ability_first or ability_first:IsNull() then
        --ErrorTracking.SendMyMessage("Oshibka!! Slomalas smena sposobnosti "..pAbilityName1.." "..pAbilityName2.." Ne najdena sposobnost"..pAbilityName1)
        return
    end
    if not ability_second or ability_second:IsNull() then
        --ErrorTracking.SendMyMessage("Oshibka!! Slomalas smena sposobnosti "..pAbilityName1.." "..pAbilityName2.." Ne najdena sposobnost"..pAbilityName2)
        return
    end
    if ability_second.main_slot and ability_first:GetAbilityIndex() ~= ability_second.main_slot then
        return
    end
    self:oldSwapAbilities(pAbilityName1, pAbilityName2, bEnable1, bEnable2)
    if bEnable2 then
        ability_second:SetHidden(false)
    end
    if bEnable1 then
        ability_first:SetHidden(false)
    end
end

if not CDOTA_BaseNPC.oldAddAbility then
	CDOTA_BaseNPC.oldAddAbility = CDOTA_BaseNPC.AddAbility
end

function CDOTA_BaseNPC:AddAbility(pAbilityName)
    local old_ability = self:FindAbilityByName(pAbilityName)
    if old_ability and not old_ability:IsNull() then
        --ErrorTracking.SendMyMessage("Oshibka!! CHelu dobavilas sposobnost kotoraya uzhe u nego byla lol "..pAbilityName)
        return old_ability
    end
    local ability_new = self:oldAddAbility(pAbilityName)
    if not ability_new or ability_new:IsNull() then
        --ErrorTracking.SendMyMessage("Oshibka!! Slomalas dobavlenie sposobnosti, ee tupo net "..pAbilityName)
    end
    return ability_new
end


function CDOTA_BaseNPC:GetChanceToEvasion(target)
    if self:IsHasMKB() then
        return true
    end
    if RollPercentage(100 - (target:GetEvasion() * 100)) then
        return true
    end
    return false
end

function CDOTA_BaseNPC:IsHasMKB()
    for _, mod in pairs(self:FindAllModifiers()) do
        local tables = {}
        mod:CheckStateToTable(tables)
        for state_name, mod_table in pairs(tables) do
            if tostring(state_name) == tostring(MODIFIER_STATE_CANNOT_MISS) then
                return true
            end
        end
    end
    return false
end

function IsValidCustom(...)
    for i = 1, select("#", ...) do
        local entity = select(i, ...)
        if not entity or not entity.IsNull or entity:IsNull() then
            return false
        end
    end
    return true
end

function CreateEffectGold( hero, gold, creep )
    local pID = hero:GetPlayerOwnerID()

    local player = PlayerResource:GetPlayer( pID )

    EmitSoundOnLocationForPlayer("General.Coins", creep:GetAbsOrigin(), pID)

    if player then
	    local particlegold = ParticleManager:CreateParticleForPlayer( "particles/generic_gameplay/lasthit_coins.vpcf", PATTACH_WORLDORIGIN, nil, player)
	    ParticleManager:SetParticleControl( particlegold, 0, creep:GetAbsOrigin() )
	    ParticleManager:SetParticleControl( particlegold, 1, creep:GetAbsOrigin() )
	end

    local value = gold
    local symbol = 0
    local color = Vector(255, 200, 33)
    local lifetime = 2.0
    local digits = string.len(tostring(math.floor(value))) + 1

    if player then
	    local particle = ParticleManager:CreateParticleForPlayer( "particles/msg_fx/msg_gold.vpcf", PATTACH_WORLDORIGIN, nil, player )
	    ParticleManager:SetParticleControl( particle, 0, creep:GetAbsOrigin() )
	    ParticleManager:SetParticleControl( particle, 1, Vector( symbol, value, 0) )
	    ParticleManager:SetParticleControl( particle, 2, Vector( lifetime, digits, 0) )
	    ParticleManager:SetParticleControl( particle, 3, color )
	end
end

function CDOTA_BaseNPC:MoveToPositionAggressive(point)
    local order = 
    {
        UnitIndex = self:entindex(),
        OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
        Position = point,
        Queue = false
    }
    ExecuteOrderFromTable(order)
end

function StartTeleportFXPlayers(duration, players)
    for id, player in pairs(PLAYERS) do 
		if player.hero ~= nil and not player_system:IsLose(id) and not player.hero:IsNull() then
            local next_step = true
            if GetMapName() == "rating" or GetMapName() == "rating_300" then
                if players and players[1].id ~= id and players[2].id ~= id then
                    next_step = false
                end
            elseif GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
                if players and players[1].teamnumber ~= PlayerResource:GetTeam(id) and players[2].teamnumber ~= PlayerResource:GetTeam(id) then
                    next_step = false
                end
            end
            if next_step then
                player.hero:AddNewModifier(player.hero, nil, "modifier_teleport_fx_client", {duration = duration})
            end
        end
    end
end

function CDOTA_BaseNPC:AddNewModifierDelay(parent, ability, modifier_name, params)
    local parent = self
    Timers:CreateTimer(FrameTime(), function()
        if not parent:IsAlive() then return FrameTime() end
        self:AddNewModifier(parent, ability, modifier_name, params)
    end)
end

function CDOTA_BaseNPC:GetAoeBonus(value)
    if self and self:HasModifier("modifier_item_gungir") then
        value = value + 75
    elseif self and self:HasModifier("modifier_item_shivas_guard") then
        value = value + 75
    elseif self and self:HasModifier("modifier_item_chasm_stone") then
        value = value + 40
    end
    if self and self:HasModifier("modifier_doom_bringer_devour_custom") then
        local modifier_doom_bringer_devour_custom = self:FindModifierByName("modifier_doom_bringer_devour_custom")
        if modifier_doom_bringer_devour_custom then
            value = value + modifier_doom_bringer_devour_custom:GetModifierAoEBonusConstantStacking()
        end
    end
    if self and self:HasModifier("modifier_rune_radius") then
        local modifier_rune_radius = self:FindModifierByName("modifier_rune_radius")
        if modifier_rune_radius then
            value = value + modifier_rune_radius:GetModifierAoEBonusConstantStacking()
        end
    end
    if self and self:HasModifier("modifier_tidehunter_2") then
        local modifier_tidehunter_2 = self:FindModifierByName("modifier_tidehunter_2")
        if modifier_tidehunter_2 then
            value = value + modifier_tidehunter_2:GetModifierAoEBonusConstantStacking()
        end
    end
    if self and self:HasModifier("modifier_item_dezun_bloodrite") then
        value = value + (value / 100 * 16)
    end
    return value
end

function SetCustomTimeOfDay(time)
    Timers:CreateTimer(FrameTime(), function()
        if WODAGameMode.OnlyDayTime then return FrameTime() end
        GameRules:SetTimeOfDay(time)
    end)
end

function SetOnlyDay(time)
    WODAGameMode.OnlyDayTime = true
    local save_time = GameRules:GetTimeOfDay()
    GameRules:SetTimeOfDay(0.5)
    Timers:CreateTimer(1, function()
        time = time - 1
        if time <= 0 then
            WODAGameMode.OnlyDayTime = nil
            GameRules:SetTimeOfDay(save_time)
            return
        end
        return 1
    end)
end

function IsArenaAfk(player_id)
    if GetMapName() == "arena" then
        if PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_ABANDONED or PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_DISCONNECTED then
            return true
        end
    end
    return false
end