--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_abilities_optimization_thinker = class({})
function modifier_abilities_optimization_thinker:IsHidden() return false end
function modifier_abilities_optimization_thinker:IsPurgable() return false end

modifier_abilities_optimization_thinker.heal_recived_mods = 
{
    "modifier_oracle_false_promise_custom",
}
modifier_abilities_optimization_thinker.full_cast_mods =
{
    "modifier_oracle_false_promise_custom",
    "modifier_hero_unique_modifier_skywrath_mage_concussive_shot",
    "modifier_ability_marci_unleash",
}
modifier_abilities_optimization_thinker.executed_mods =
{
    "modifier_multicast_lua",
    "modifier_monkey_king_jingu_mastery_lua_buff",
}
modifier_abilities_optimization_thinker.takedamage_unit =
{
    "modifier_abaddon_borrowed_time_custom",
    "modifier_tempest_double_illusion",
    "modifier_invoker_cold_snap_lua",
    "modifier_fatal_bonds_debuff",
    "modifier_primal_beast_uproar_custom_creep",
    "modifier_abaddon_borrowed_time_custom",
    "modifier_hero_unique_modifier_tinker_defense_matrix",
    "modifier_hero_unique_modifier_abaddon_aphotic_shield",
    "modifier_hero_unique_modifier_slark_dark_pact",
    "modifier_hero_unique_modifier_spectre_spectral_dagger",
    "modifier_item_panzer_custom_active",
    "modifier_ability_undying_reincarnate",
    "modifier_ability_batrider_sticky_napalm",
}
modifier_abilities_optimization_thinker.takedamage_attacker =
{
    "modiifer_bloodseeker_bloodrage_custom",
    "modifier_meepo_ransack_custom",
    "modifier_item_bloodstone_2",
    "modifier_item_summoner_crown_buff_int",
    "modifier_life_stealer_feast_custom",
    "modifier_keeper_of_the_light_spirit_form_custom",
    "modifier_skills_bonuses",
    "modifier_skeleton_king_vampiric_aura_custom",
    "modifier_hero_unique_modifier_weaver_shukuchi",
    "modifier_hero_unique_modifier_dazzle_poison_touch",
    "modifier_hero_unique_modifier_queenofpain_scream_of_pain",
    "modifier_ability_legion_commander_overwhelming_odds_lifesteal",
    "modifier_item_hellmask",
    "modifier_item_magilys_custom",
    "modifier_item_revenants_brooch_custom",
}
modifier_abilities_optimization_thinker.attacklanded_targets =
{
    "modifier_axe_counter_helix_lua",
    "modifier_zuus_cloud_custom",
    "modifier_item_panzer_custom",
    "modifier_ability_phoenix_supernova",
    "modifier_minigames_arena",
    "modifier_item_wraith_pact_custom_totem",
}
modifier_abilities_optimization_thinker.attacklanded_attacker =
{
    "modifier_zuus_lightning_hands_custom_tracker",
    "modifier_wisp_overcharge_custom",
    "modifier_omniknight_hammer_of_purity_custom",
    "modifier_item_bfury_2",
    "modifier_item_bfury_3",
    "modifier_item_disperser_custom",
    "modifier_item_ranged_cleave",
    "modifier_item_ranged_cleave_2",
    "modifier_item_ranged_cleave_3",
    "modifier_ninja_gear_custom",
    "modifier_creep_controll",
    "modifier_item_desolator_2_custom",
    "modifier_nian_bash",
    "modifier_drow_ranger_marksmanship_custom",
    "modifier_invoker_forge_spirit_lua",
    "modifier_liquid_fire_lua_orb",
    "modifier_liquid_ice_lua_orb",
    "modifier_monkey_king_jingu_mastery_lua",
    "modifier_gold_roshan_bash",
    "modifier_monkey_king_jingu_mastery_lua_buff",
    "modifier_naga_siren_rip_tide_lua",
    "modifier_troll_warlord_fervor_custom",
    "modifier_undying_tombstone_lua_passive",
    "modifier_faceless_void_time_lock_custom",
    "modifier_item_wraith_dominator_aura_buff",
    "modifier_item_wraith_pact_custom_aura",
    "modifier_vengefulspirit_magic_missile_custom_passive",
    "modifier_snapfire_lil_shredder_custom",
    "modifier_hero_unique_modifier_chaos_knight_chaos_bolt",
    "modifier_hero_unique_modifier_phantom_assassin_phantom_strike",
    "modifier_hero_unique_modifier_ursa_overpower",
    "modifier_hero_unique_modifier_earthshaker_enchant_totem",
    "modifier_dawnbreaker_luminosity_custom_buff",
    "modifier_dawnbreaker_luminosity_custom",
    "modifier_hero_unique_modifier_mars_gods_rebuke",
    "modifier_hero_unique_modifier_dragon_knight_breathe_fire",
    "modifier_underlord_atrophy_aura_custom",
    "modifier_hero_unique_modifier_skeleton_king_hellfire_blast",
}
modifier_abilities_optimization_thinker.attackstart_mods = 
{
    "modifier_item_rapier_custom",
    "modifier_chen_penitence_custom_debuff",
    "modifier_muerta_gunslinger_custom",
    "modifier_drow_ranger_marksmanship_custom",
}
modifier_abilities_optimization_thinker.attackstart_mods_target = 
{
    "modifier_ability_legion_commander_overwhelming_odds",
}
modifier_abilities_optimization_thinker.onattack_mods = 
{
    "modifier_gyrocopter_flak_cannon_lua",
    "modifier_drow_ranger_marksmanship_custom",
    "modifier_liquid_ice_lua_orb",
    "modifier_oracle_false_promise_custom",
    "modifier_liquid_fire_lua_orb",
    "modifier_frostivus2018_weaver_geminate_attack_custom",
    "modifier_item_desolator_2_custom",
    "modifier_drow_ranger_frost_arrows_custom_orb",
    "modifier_snapfire_lil_shredder_custom",
    "modifier_storm_spirit_overload_custom_buff",
    "modifier_muerta_gunslinger_custom",
    "modifier_spectre_desolate_custom",
    "modifier_ability_snapfire_ricochet",
    "modifier_ability_bounty_hunter_big_game_hunter",
}
modifier_abilities_optimization_thinker.death_target_modifiers = 
{
    "modifier_axe_battle_hunger_custom_debuff",
    "modifier_drow_ranger_frost_arrows_custom_debuff",
    "modifier_cha_boss_drop_nian",
    "modifier_dark_seer_wall_of_replica_nb2017",
    "modifier_duel_buff",
    "modifier_lion_finger_of_death_custom_buff",
    "modifier_sand_king_caustic_finale_lua_debuff",
    "modifier_bounty_hunter_track_creep",
    "modifier_skelet_reincarnation",
    "modifier_ability_phoenix_supernova",
}

modifier_abilities_optimization_thinker.death_attacker_modifiers = 
{
    "modifier_pudge_flesh_heap_lua",
    "modifier_item_bloodstone_2",
    "modifier_item_hellmask",
    "modifier_bloodseeker_blood_mist_custom",
    "modifier_underlord_atrophy_aura_custom",
    "modifier_hero_unique_modifier_nevermore_dark_lord",
    "modifier_ability_bounty_hunter_big_game_hunter",
    "modifier_lina_laguna_blade_custom_passive",
    "modifier_ability_marci_unleash"
}

function modifier_abilities_optimization_thinker:CheckState()
    return 
    {
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
    }
end

function modifier_abilities_optimization_thinker:DeclareFunctions()
	return
	{
        MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
        MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
		MODIFIER_EVENT_ON_HEAL_RECEIVED
	}
end

function modifier_abilities_optimization_thinker:OnAttackRecord(event)
    local attacker = event.attacker
    local target = event.target
    if target and target:IsBaseNPC() and attacker:GetAttackTarget() == target and attacker._dont_stop_attack_flag == nil then
        local bResult, PID = Players:IsUnitCanAttackOrCastOnThis(attacker, target)
        if not bResult then
            if PID ~= nil then
                local player = PlayerResource:GetPlayer(PID)
                if player then
                    CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_cant_attack_on_other_arena"})
                end
            end
            ExecuteOrderFromTable({
                UnitIndex = attacker:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = attacker:GetAbsOrigin(),
                Queue = false
            })
        end
    end
end

function modifier_abilities_optimization_thinker:OnHealReceived( params )
    local unit = params.unit
	if unit == nil then return end
    for _, modifier_name in pairs(self.heal_recived_mods) do
        local modifier = unit:FindModifierByName(modifier_name)
        if modifier then
            modifier:OnAbilityHealRecive( params )
        end
    end
end

function modifier_abilities_optimization_thinker:OnAbilityFullyCast( params )
	local unit = params.unit
	if unit == nil then return end
    if not unit:IsRealHero() then return end
    for _, modifier_name in pairs(self.full_cast_mods) do
        local modifier = unit:FindModifierByName(modifier_name)
        if modifier then
            modifier:OnAbilityfullCastCustom( params )
        end
    end
end

LinkLuaModifier("modifier_windrunner_focus_fire_debuff", "modifiers/modifier_windrunner_focus_fire_debuff", LUA_MODIFIER_MOTION_NONE)

function modifier_abilities_optimization_thinker:OnAbilityExecuted( params )
	if not IsServer() then return end
	if not params.ability then return end
	local unit = params.unit
	if unit == nil then return end
    if not unit:IsRealHero() then return end
    for _, modifier_name in pairs(self.executed_mods) do
        local modifier = unit:FindModifierByName(modifier_name)
        if modifier then
            modifier:OnAbilityExecutedCustom( params )
        end
    end
    local ability_name = params.ability:GetAbilityName()
    if ability_name == "windrunner_focusfire" then
        if params.target then
            params.target:AddNewModifier(unit, nil, "modifier_windrunner_focus_fire_debuff", {})
        end
    elseif ability_name == "ursa_enrage" then
        if unit:HasModifier("modifier_ursa_enrage") then
            unit:RemoveModifierByName("modifier_ursa_enrage")
        end
    elseif ability_name == "skeleton_king_vampiric_aura_custom" then
	    for _, warlock_gl in pairs(FindUnitsInRadius(unit:GetTeamNumber(), unit:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)) do
	        if warlock_gl:GetUnitName() == "npc_dota_wraith_king_skeleton_warrior" and warlock_gl:GetOwner() == unit then
	            warlock_gl:Destroy()             
	       	end
	    end
	elseif ability_name == "snapfire_mortimer_kisses" then
	    unit:AddNewModifier(unit, params.ability, "modifier_magic_immune_buff", {duration = 3})
	elseif ability_name == "mars_spear" then
        self:TriplleSpell(params.ability, unit)
	end
end

function modifier_abilities_optimization_thinker:RotateVector2D(vector, theta)
    local xp = vector.x*math.cos(theta)-vector.y*math.sin(theta)
    local yp = vector.x*math.sin(theta)+vector.y*math.cos(theta)
    return Vector(xp,yp,vector.z):Normalized()
end

function modifier_abilities_optimization_thinker:ToRadians(degrees)
    return degrees * math.pi / 180
end

function modifier_abilities_optimization_thinker:TriplleSpell(ability, unit)
    if not IsServer() then return end
    local direction = unit:GetForwardVector()
    local angle = 20
    for i = 1, 2 do
        local newAngle = 20 * math.ceil(i / 2) * (-1)^i
        local newDir = self:RotateVector2D( direction, self:ToRadians( newAngle ) )
        local new_point = unit:GetAbsOrigin() + newDir * 100
        Timers:CreateTimer(FrameTime()*i, function()
            unit:SetCursorPosition(new_point)
            ability:OnSpellStart()
        end)
    end
end

function modifier_abilities_optimization_thinker:OnTakeDamage(params)
	if not IsServer() then return end
	local attacker = params.attacker
	local unit = params.unit
	local inflictor = params.inflictor
	if attacker == nil or unit == nil then return end
    for _, modifier_name in pairs(self.takedamage_unit) do
        local modifier = unit:FindModifierByName(modifier_name)
        if modifier then
            modifier:TakeDamageScriptModifier( params )
        end
    end
    for _, modifier_name in pairs(self.takedamage_attacker) do
        local modifier = attacker:FindModifierByName(modifier_name)
        if modifier then
            modifier:TakeDamageScriptModifier( params )
        end
    end
end

function modifier_abilities_optimization_thinker:OnAttackLanded(params)
	if not IsServer() then return end
	local attacker = params.attacker
	local target = params.target
	if attacker == nil or target == nil then return end

    for _, modifier_name in pairs(self.attacklanded_targets) do
        local modifier = target:FindModifierByName(modifier_name)
		if modifier then
			modifier:AttackLandedModifier( params )
		end
    end

    for _, modifier_name in pairs(self.attacklanded_attacker) do
        local modifier = attacker:FindModifierByName(modifier_name)
		if modifier then
			modifier:AttackLandedModifier( params )
		end
    end
end

function modifier_abilities_optimization_thinker:OnAttackStart(params)
	if not IsServer() then return end
	local attacker = params.attacker
	local target = params.target
	if attacker == nil or target == nil or attacker:IsNull() or target:IsNull() then return end
    for _, modifier_name in pairs(self.attackstart_mods) do
        local modifier = attacker:FindModifierByName(modifier_name)
		if modifier then
			modifier:AttackStartModifier( params )
		end
    end

    for _, modifier_name in pairs(self.attackstart_mods_target) do
        local modifier = target:FindModifierByName(modifier_name)
		if modifier then
			modifier:AttackStartModifier( params )
		end
    end
end

function modifier_abilities_optimization_thinker:OnAttack(params)
	if not IsServer() then return end
	local attacker = params.attacker
	local target = params.target
	if attacker == nil or target == nil then return end
    for _, modifier_name in pairs(self.onattack_mods) do
        local modifier = attacker:FindModifierByName(modifier_name)
		if modifier then
			modifier:AttackModifier( params )
		end
    end
end

function modifier_abilities_optimization_thinker:OnDeath(params)
	if not IsServer() then return end
	local attacker = params.attacker
	local target = params.unit

	if attacker == nil or attacker:IsNull() or target == nil or target:IsNull() then return end

    for _, modifier_name in pairs(self.death_target_modifiers) do
        local modifier = target:FindModifierByName(modifier_name)
		if modifier then
			modifier:OnDeathEvent( params )
		end
    end

    if attacker:HasModifier("modifier_windrunner_focusfire") and target:HasModifier("modifier_windrunner_focus_fire_debuff") and attacker:HasTalent("special_bonus_unique_windranger_2") then
        local windrunner_focusfire = attacker:FindAbilityByName("windrunner_focusfire")
        if windrunner_focusfire then
            local cooldown = windrunner_focusfire:GetCooldownTimeRemaining()
            windrunner_focusfire:EndCooldown()
            if cooldown - 18 > 0 then
                windrunner_focusfire:StartCooldown(cooldown - 18)
            end
        end
    end

    for _, modifier_name in pairs(self.death_attacker_modifiers) do
        local modifier = attacker:FindModifierByName(modifier_name)
		if modifier then
			modifier:OnDeathEvent( params )
		end
    end

	if (not attacker:IsHero() or attacker:IsTempestDouble()) then
		local owner = attacker:GetOwner()
		if owner ~= nil and not owner:IsNull() then
			if owner.HasModifier and owner:HasModifier("modifier_item_bloodstone_2") then
				local modifier = owner:FindModifierByName("modifier_item_bloodstone_2")
				if modifier then
					modifier:OnDeathEvent(params)
				end
			end
			if owner.HasModifier and owner:HasModifier("modifier_item_hellmask") then
				local modifier = owner:FindModifierByName("modifier_item_hellmask")
				if modifier then
					modifier:OnDeathEvent(params)
				end
			end
		end
		if attacker.owner ~= nil and not attacker.owner:IsNull() then
			if attacker.owner:HasModifier("modifier_item_bloodstone_2") then
				local modifier = attacker.owner:FindModifierByName("modifier_item_bloodstone_2")
				if modifier then
					modifier:OnDeathEvent(params)
				end
			end
			if attacker.owner:HasModifier("modifier_item_hellmask") then
				local modifier = attacker.owner:FindModifierByName("modifier_item_hellmask")
				if modifier then
					modifier:OnDeathEvent(params)
				end
			end
		end
	end
end