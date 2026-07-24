--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rubick_spell_steal_custom", "heroes/npc_dota_hero_rubick_custom/rubick_spell_steal_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_rubick_spell_steal_custom_scepter", "heroes/npc_dota_hero_rubick_custom/rubick_spell_steal_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_rubick_spell_steal_custom_hidden", "heroes/npc_dota_hero_rubick_custom/rubick_spell_steal_custom", LUA_MODIFIER_MOTION_NONE )

if not rubick_spell_steal_custom then
	rubick_spell_steal_custom = class({})
	rubick_spell_steal_custom.heroesData = {}
	rubick_spell_steal_custom.currentSpell = nil
	rubick_spell_steal_custom.currentSpell_2 = nil
	rubick_spell_steal_custom.stolenSpell = nil
    rubick_spell_steal_custom.modifier_rubick_19 = {10,20,30}
    rubick_spell_steal_custom.modifier_rubick_20 = -4
    rubick_spell_steal_custom.proj_data = {}
end

function rubick_spell_steal_custom:GetCooldown(nLevel)
    local cooldown = self.BaseClass.GetCooldown(self, nLevel)
    if self:GetCaster():HasModifier("modifier_rubick_20") then
        cooldown = cooldown + self.modifier_rubick_20
    end
    return cooldown
end

rubick_empty1_custom = class({})
rubick_empty2_custom = class({})

rubick_spell_steal_custom.bonus_spell_name =
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
rubick_spell_steal_custom.ignore_abilities_list = 
{
    ["monkey_king_wukongs_command_custom"] = true,
    ["naga_siren_song_of_the_siren_cancel_custom"] = true,
    ["ability_lamp_use"] = true,
    ["ability_pluck_famango"] = true,
    ["visage_stone_form_self_cast_custom"] = true,
    ["twin_gate_portal_warp"] = true,
    ["backdoor_protection"] = true,
    ["tinker_rearm_custom"] = true,
    ["ability_capture"] = true,
    ["filler_ability"] = true,
    ["faceless_void_time_walk_reverse_custom"] = true,
    ["faceless_void_bash_wave"] = true,
    ["faceless_void_face_ward"] = true,
    ["kunkka_return_custom"] = true,
    ["kunkka_attacker"] = true,
    ["witch_doctor_voodoo_switchero_custom"] = true,
    ["witch_doctor_auto_wodoo"] = true,
    ["antimage_mana_overload_custom"] = true,
    ["weaver_auto_swarm"] = true,
    ["tiny_toss_tree_custom"] = true,
    ["doom_bringer_fueling_hell"] = true,
    ["morphling_replicate_custom"] = true,
    ["morphling_morph_replicate_custom"] = true,
    ["techies_focused_detonate_custom"] = true,
    ["dawnbreaker_converge_custom"] = true,
    ["techies_reactive_tazer_stop_custom"] = true,
    ["morphling_morph_agi_custom"] = true,
    ["morphling_morph_str_custom"] = true,
    ["ancient_apparition_ice_blast_release_custom"] = true,
    ["rubick_telekinesis_custom"] = true,
    ["rubick_fade_bolt_custom"] = true,
    ["rubick_arcane_supremacy_custom"] = true,
    ["rubick_empty1_custom"] = true,
    ["rubick_empty2_custom"] = true,
    ["rubick_spell_steal_custom"] = true,
    ["rubick_telekinesis_land_custom"] = true,
    ["rubick_telekinesis_land_self_custom"] = true,
    ["rubick_fade_bolt_custom_magic_immune"] = true,
    ["rubick_fade_lightning_custom"] = true,
    ["rubick_flash_bolt_custom"] = true,
    ["tidehunter_arm_of_the_deep_custom"] = true,
    ["skeleton_king_mortal_strike_custom"] = true,
    ["invoker_quas_custom"] = true,
    ["invoker_wex_custom"] = true,
    ["invoker_exort_custom"] = true,
    ["invoker_invoke_custom"] = true,
    ["kez_switch_weapons_custom"] = true,
    ["pangolier_gyroshell_stop_custom"] = true,
    ["pangolier_rollup_stop_custom"] = true,
    ["zuus_cloud_custom"] = true,
    ["zuus_cloud_self_custom"] = true,
    ["high_five_custom"] = true,
    ["abyssal_underlord_portal_warp"] = true,
    ["wisp_spirits_in_custom"] = true,
    ["wisp_spirits_out_custom"] = true,
    ["wisp_tether_break_custom"] = true,
    ["phoenix_icarus_dive_stop_custom"] = true,
    ["phoenix_launch_fire_spirit_custom"] = true,
    ["phoenix_sun_ray_stop_custom"] = true,
    ["phoenix_sun_ray_toggle_move_custom"] = true,
    ["aghanim_ray_stop"] = true,
    ["monkey_king_primal_spring_custom"] = true,
    ["monkey_king_tree_dance_custom"] = true,
    ["keeper_of_the_light_light_illusion_point"] = true,
    ["keeper_of_the_light_illuminate_end_custom"] = true,
    ["juggernaut_swift_slash_custom"] = true,
    ["ogre_magi_dumb_luck_custom"] = true,
}

rubick_spell_steal_custom.swapable_abilities_list = 
{
    ["kunkka_rum"] = "kunkka_ghostship_custom",
    ["oracle_change_of_fate"] = "oracle_fates_edict_custom",
    ["lion_speed_rain"] = "lion_mana_drain_custom",
    ["undying_tombstone_body"] = "undying_tombstone_custom",
    ["windrunner_ultra_powershot_custom"] = "windrunner_focusfire_custom",
    ["drow_ranger_multishot_2_custom"] = "drow_ranger_multishot_custom",
    --["disruptor_static_mana"] = "disruptor_thunder_strike_custom",
    ["earthshaker_fissure_2_custom"] = "earthshaker_fissure_custom",
    --["earthshaker_enchant_moment"] = "earthshaker_enchant_totem_custom",
    --["lone_druid_moonlight"] = "lone_druid_spirit_bear_custom",
    --["lone_druid_entanglig_root"] = "lone_druid_spirit_link_custom",
    --["nevermore_righteous_lord"] = "nevermore_requiem_custom",
    ["terrorblade_demon_hunter"] = "terrorblade_metamorphosis_custom",
    ["tidehunter_gush_2_custom"] = "tidehunter_gush_custom",
    ["spectre_reality_custom"] = "spectre_haunt_custom",
}

rubick_spell_steal_custom.ignore_cast_point =
{
    ["monkey_king_boundless_strike_custom"] = true,
    ["nevermore_requiem_custom"] = true,
    ["sniper_assassinate_custom"] = true,
    ["furion_teleportation_custom"] = true,
    ["techies_suicide_custom"] = true,
}

function rubick_spell_steal_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_rubick_12") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function rubick_spell_steal_custom:Spawn()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_rubick_spell_steal_custom_hidden") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_rubick_spell_steal_custom_hidden", {})
    end
end

function rubick_spell_steal_custom:CastFilterResultTarget( hTarget )
	if IsServer() then
		if self:GetLastSpell( hTarget ) == nil then
			return UF_FAIL_OTHER
		end
	end
    local team = DOTA_UNIT_TARGET_TEAM_ENEMY
    if GetMapName() == "arena" or GetMapName() == "maps/arena.vpk" then
        team = DOTA_UNIT_TARGET_TEAM_FRIENDLY
    end
	local nResult = UnitFilter(
		hTarget,
		team,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)
	if hTarget == self:GetCaster() then
		return UF_FAIL_OTHER
	end
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end

function rubick_spell_steal_custom:GetIntrinsicModifierName()
    if self:GetCaster():IsIllusion() then return end
	return "modifier_rubick_spell_steal_custom_hidden"
end

function rubick_spell_steal_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    if self:GetCaster():GetUnitName() ~= "npc_dota_hero_rubick" then return end
    if self:GetCaster():HasModifier("modifier_rubick_12") then
        self:GetCaster():EmitSound("Hero_Rubick.SpellSteal.Target")
        self:CastRandomAbility()
        return
    end
	if target:TriggerSpellAbsorb( self ) then return end
    local get_stolen_spell = self:GetLastSpell(target)
	local info = 
    {
		Target = self:GetCaster(),
		Source = target,
		Ability = self,	
		EffectName = "particles/units/heroes/hero_rubick/rubick_spell_steal.vpcf",
		iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
		vSourceLoc = target:GetAbsOrigin(),             
		bDrawsOnMinimap = false,                         
		bDodgeable = false,                               
		bVisibleToEnemies = true,                        
		bReplaceExisting = false,                         
	}
	local projectile = ProjectileManager:CreateTrackingProjectile(info)
    self.proj_data[projectile] = get_stolen_spell
	target:EmitSound("Hero_Rubick.SpellSteal.Target")
end

function rubick_spell_steal_custom:OnProjectileHitHandle( target, location, proj_id )
    if not IsServer() then return end
	if target == nil then return end
	if not target:IsAlive() then return end
    if self:GetCaster():HasModifier("modifier_rubick_2") then return end
    if self.proj_data[proj_id] == nil then return end
    local copy_ability = self.proj_data[proj_id]
    local steal_duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_rubick_20") then
        steal_duration = -1
    end
	if self:GetScepterEffect() then
		self:SetStolenSpellScepter(copy_ability)
	else
        if self:GetCaster():HasModifier("modifier_rubick_spell_steal_custom_scepter") then
            self:GetCaster():RemoveModifierByName("modifier_rubick_spell_steal_custom_scepter")
        end
		self:SetStolenSpell(copy_ability)
	end
    target:AddNewModifier( self:GetCaster(), self, "modifier_rubick_spell_steal_custom", {duration = steal_duration})
    target:EmitSound("Hero_Rubick.SpellSteal.Complete")
end

function rubick_spell_steal_custom:CastRandomAbility()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_rubick_2") then return end
    local steal_duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_rubick_20") then
        steal_duration = -1
    end
    local get_stolen_spell = self:GetRandomAbilityList()
    if self:GetScepterEffect() then
		self:SetStolenSpellScepter(get_stolen_spell)
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_rubick_spell_steal_custom", {duration = steal_duration})
    else
        if self:GetCaster():HasModifier("modifier_rubick_spell_steal_custom_scepter") then
            self:GetCaster():RemoveModifierByName("modifier_rubick_spell_steal_custom_scepter")
        end
		self:SetStolenSpell(get_stolen_spell)
    end
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_rubick_spell_steal_custom", {duration = steal_duration})
    self:GetCaster():EmitSound("Hero_Rubick.SpellSteal.Complete")
end

-- Ворование способностей без аганима
function rubick_spell_steal_custom:SetStolenSpell(original_ability)
    if not IsServer() then return end
    if original_ability == nil then return end
    if original_ability:IsNull()then return end
    local ability_name = original_ability:GetAbilityName()
    local modifier_rubick_spell_steal_custom_hidden = self:GetCaster():FindModifierByName("modifier_rubick_spell_steal_custom_hidden")
    if modifier_rubick_spell_steal_custom_hidden == nil then return end
    local current_ability_default = self.currentSpell
    local current_ability_scepter = self.currentSpell_2

    -- Поменять уровень текущей абилки (Если украл ту же абилку)
	if current_ability_default and not current_ability_default:IsNull() then
		if current_ability_default:GetAbilityName() == ability_name then
            current_ability_default:SetLevel(original_ability:GetLevel())
			return
		end
	end
    -- Поменять уровень текущей абилки (Если украл ту же абилку) -- Второй
    if current_ability_scepter and not current_ability_scepter:IsNull() then
        if current_ability_scepter:GetAbilityName() == ability_name then
            current_ability_scepter:SetLevel(original_ability:GetLevel())
            local steal_duration = self:GetSpecialValueFor("duration")
            if self:GetCaster():HasModifier("modifier_rubick_20") then
                steal_duration = -1
            end
		    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_rubick_spell_steal_custom_scepter", { duration = steal_duration } )
            return
        end
    end

    -- Забыть старую дефолтную способность
    self:ForgetSpell()

    -- Если такая абилка у нас уже давно скрыта, но осталась для сохранения модификатора
    local old_spell = false
    for _, old_ability in pairs(modifier_rubick_spell_steal_custom_hidden.spell_steal_history) do
        if old_ability ~= nil and not old_ability:IsNull() and old_ability:GetAbilityName() == ability_name then
            old_spell = true
            break
        end
    end

    -- Если старая абилка то удаляем ее из массива на удаление
    -- Если новая абилка, то добавляем ее герою
    if old_spell then
        modifier_rubick_spell_steal_custom_hidden:DeleteAbilityFromList(ability_name)
        self.currentSpell = self:GetCaster():FindAbilityByName(ability_name)
    else
        self.currentSpell = self:GetCaster():AddAbility( ability_name )
    end

    if self.currentSpell and not self.currentSpell:IsNull() then
        self.currentSpell.original_owner = original_ability:GetCaster()
        self.currentSpell:SetHidden(true)
        self.currentSpell:SetRefCountsModifiers(true)

        if not self.ignore_cast_point[self.currentSpell:GetAbilityName()] then
            self.currentSpell:SetOverrideCastPoint(0)
        end
        if self.currentSpell:GetAbilityName() == "luna_eclipse_custom" then
            local luna_lucent_beam_custom = self.currentSpell.original_owner:FindAbilityByName("luna_lucent_beam_custom")
            if luna_lucent_beam_custom then
                self.currentSpell.damage = luna_lucent_beam_custom:GetSpecialValueFor("beam_damage")
            end
        end
        local rubick_empty1_custom = self:GetCaster():FindAbilityByName("rubick_empty1_custom")
        self.currentSpell:SetLevel(original_ability:GetLevel())
        self.currentSpell.main_slot = rubick_empty1_custom:GetAbilityIndex()
        self:GetCaster():SwapAbilities("rubick_empty1_custom", ability_name, false, true)
        self.currentSpell:SetHidden(false)
        self.currentSpell:SetStolen(true)
        if self.bonus_spell_name[ability_name] and self.currentSpell.additional_ability == nil then
            self.currentSpell.additional_ability = self:GetCaster():AddAbility( self.bonus_spell_name[ability_name] )
            if self.currentSpell.additional_ability then
                self.currentSpell.additional_ability:SetLevel(self.currentSpell:GetLevel())
                self.currentSpell.additional_ability:SetStolen(true)
            end
        end
    end
end

function rubick_spell_steal_custom:ForgetSpell()
    if not IsServer() then return end
    local modifier_rubick_spell_steal_custom_hidden = self:GetCaster():FindModifierByName("modifier_rubick_spell_steal_custom_hidden")
    if modifier_rubick_spell_steal_custom_hidden == nil then return end
	if self.currentSpell and not self.currentSpell:IsNull() then
        if self.currentSpell.additional_ability and not self.currentSpell.additional_ability:IsNull() then
            if self.currentSpell:GetAbilityIndex() ~= self.currentSpell.main_slot then
                self:GetCaster():SwapAbilities(self.currentSpell:GetAbilityName(), self:GetCaster():GetAbilityByIndex(self.currentSpell.main_slot):GetAbilityName(), false, true)
            end
            self:GetCaster():RemoveAbilityByHandle(self.currentSpell.additional_ability)
            self.currentSpell.additional_ability = nil
        end
		self:GetCaster():SwapAbilities(self.currentSpell:GetAbilityName(), "rubick_empty1_custom", false, true)
        self.currentSpell:SetRefCountsModifiers(true)
        self.currentSpell:SetHidden(true)
        table.insert(modifier_rubick_spell_steal_custom_hidden.spell_steal_history, self.currentSpell)
		self.currentSpell = nil
	end
end

-- Ворование способности с аганимом
function rubick_spell_steal_custom:SetStolenSpellScepter(original_ability)
    if not IsServer() then return end
    if original_ability == nil then return end
    if original_ability:IsNull()then return end
    local ability_name = original_ability:GetAbilityName()
    local modifier_rubick_spell_steal_custom_hidden = self:GetCaster():FindModifierByName("modifier_rubick_spell_steal_custom_hidden")
    if modifier_rubick_spell_steal_custom_hidden == nil then return end
    local current_ability_default = self.currentSpell
    local current_ability_scepter = self.currentSpell_2

    -- Поменять уровень текущей абилки (Если украл ту же абилку)
	if current_ability_default and not current_ability_default:IsNull() then
		if current_ability_default:GetAbilityName() == ability_name then
            current_ability_default:SetLevel(original_ability:GetLevel())
			return
		end
	end

    -- Поменять уровень текущей абилки (Если украл ту же абилку) -- Второй
    if current_ability_scepter and not current_ability_scepter:IsNull() then
        if current_ability_scepter:GetAbilityName() == ability_name then
            current_ability_scepter:SetLevel(original_ability:GetLevel())
            local steal_duration = self:GetSpecialValueFor("duration")
            if self:GetCaster():HasModifier("modifier_rubick_20") then
                steal_duration = -1
            end
		    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_rubick_spell_steal_custom_scepter", { duration = steal_duration } )
            return
        end
    end

    -- Удаление аганимной способности
    self:ForgetSpellScepterDelete()

    -- Перемещение способности из 1 слота во второй
    self:ForgetSpellScepter()

    -- Если такая абилка у нас уже давно скрыта, но осталась для сохранения модификатора
    local old_spell = false
    for _, old_ability in pairs(modifier_rubick_spell_steal_custom_hidden.spell_steal_history) do
        if old_ability ~= nil and not old_ability:IsNull() and old_ability:GetAbilityName() == ability_name then
            old_spell = true
            break
        end
    end

    -- Если старая абилка то удаляем ее из массива на удаление
    -- Если новая абилка, то добавляем ее герою
    if old_spell then
        modifier_rubick_spell_steal_custom_hidden:DeleteAbilityFromList(ability_name)
        self.currentSpell = self:GetCaster():FindAbilityByName(ability_name)
    else
        self.currentSpell = self:GetCaster():AddAbility( ability_name )
    end

    if self.currentSpell and not self.currentSpell:IsNull() then
        self.currentSpell.original_owner = original_ability:GetCaster()
        self.currentSpell:SetHidden(true)
        if not self.ignore_cast_point[self.currentSpell:GetAbilityName()] then
            self.currentSpell:SetOverrideCastPoint(0)
        end
        if self.currentSpell:GetAbilityName() == "luna_eclipse_custom" then
            local luna_lucent_beam_custom = self.currentSpell.original_owner:FindAbilityByName("luna_lucent_beam_custom")
            if luna_lucent_beam_custom then
                self.currentSpell.damage = luna_lucent_beam_custom:GetSpecialValueFor("beam_damage")
            end
        end
        self.currentSpell:SetRefCountsModifiers(true)
        local rubick_empty1_custom = self:GetCaster():FindAbilityByName("rubick_empty1_custom")
        self.currentSpell:SetLevel(original_ability:GetLevel())
        self.currentSpell.main_slot = rubick_empty1_custom:GetAbilityIndex()
        self:GetCaster():SwapAbilities("rubick_empty1_custom", ability_name, false, true)
        self.currentSpell:SetHidden(false)
        self.currentSpell:SetStolen(true)
        if self.bonus_spell_name[ability_name] and self.currentSpell.additional_ability == nil then
            self.currentSpell.additional_ability = self:GetCaster():AddAbility( self.bonus_spell_name[ability_name] )
            if self.currentSpell.additional_ability then
                self.currentSpell.additional_ability:SetLevel(self.currentSpell:GetLevel())
                self.currentSpell.additional_ability:SetStolen(true)
            end
        end
    end
end

function rubick_spell_steal_custom:ForgetSpellScepterDelete()
    if not IsServer() then return end
    local modifier_rubick_spell_steal_custom_hidden = self:GetCaster():FindModifierByName("modifier_rubick_spell_steal_custom_hidden")
    if modifier_rubick_spell_steal_custom_hidden == nil then return end
	if self.currentSpell_2 and not self.currentSpell_2:IsNull() then
        if self.currentSpell_2.additional_ability and not self.currentSpell_2.additional_ability:IsNull() then
            if self.currentSpell_2:GetAbilityIndex() ~= self.currentSpell_2.main_slot then
                self:GetCaster():SwapAbilities(self.currentSpell_2:GetAbilityName(), self:GetCaster():GetAbilityByIndex(self.currentSpell_2.main_slot):GetAbilityName(), false, true)
            end
            self:GetCaster():RemoveAbilityByHandle(self.currentSpell_2.additional_ability)
            self.currentSpell_2.additional_ability = nil
        end
        self:GetCaster():SwapAbilities( self.currentSpell_2:GetAbilityName(), "rubick_empty2_custom", false, true )
		self.currentSpell_2:SetRefCountsModifiers(true)
        self.currentSpell_2:SetHidden(true)
		table.insert(modifier_rubick_spell_steal_custom_hidden.spell_steal_history, self.currentSpell_2)
		self.currentSpell_2 = nil
	end
end

function rubick_spell_steal_custom:ForgetSpellScepter()
    if not IsServer() then return end
    local modifier_rubick_spell_steal_custom_hidden = self:GetCaster():FindModifierByName("modifier_rubick_spell_steal_custom_hidden")
    if modifier_rubick_spell_steal_custom_hidden == nil then return end
	if self.currentSpell and not self.currentSpell:IsNull() then
		self.currentSpell:SetRefCountsModifiers(true)
        local rubick_empty2_custom = self:GetCaster():FindAbilityByName("rubick_empty2_custom")
        local save_ability = self:GetCaster():GetAbilityByIndex(3):GetAbilityName()
		self:GetCaster():SwapAbilities(save_ability, "rubick_empty1_custom", false, true )
        self.currentSpell.main_slot = rubick_empty2_custom:GetAbilityIndex()
		self:GetCaster():SwapAbilities( "rubick_empty2_custom", save_ability, false, true )
		self.currentSpell_2 = self.currentSpell
		local steal_duration = self:GetSpecialValueFor("duration")
        if self:GetCaster():HasModifier("modifier_rubick_20") then
            steal_duration = -1
        end
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_rubick_spell_steal_custom_scepter", { duration = steal_duration } )
		self.currentSpell = nil
	end
end

modifier_rubick_spell_steal_custom = class({})
function modifier_rubick_spell_steal_custom:IsHidden() return false end
function modifier_rubick_spell_steal_custom:IsDebuff() return false end
function modifier_rubick_spell_steal_custom:IsPurgable() return false end
function modifier_rubick_spell_steal_custom:RemoveOnDeath() return false end
function modifier_rubick_spell_steal_custom:OnDestroy()
    if not IsServer() then return end
	self:GetAbility():ForgetSpell()
end

modifier_rubick_spell_steal_custom_scepter = class({})
function modifier_rubick_spell_steal_custom_scepter:IsHidden() return false end
function modifier_rubick_spell_steal_custom_scepter:IsDebuff() return false end
function modifier_rubick_spell_steal_custom_scepter:IsPurgable() return false end
function modifier_rubick_spell_steal_custom_scepter:RemoveOnDeath() return false end
function modifier_rubick_spell_steal_custom_scepter:OnDestroy( kv )
    if not IsServer() then return end
	self:GetAbility():ForgetSpellScepterDelete()
end

modifier_rubick_spell_steal_custom_hidden = class({})
function modifier_rubick_spell_steal_custom_hidden:IsHidden() return true end
function modifier_rubick_spell_steal_custom_hidden:IsPurgable() return false end
function modifier_rubick_spell_steal_custom_hidden:IsPurgeException() return false end
function modifier_rubick_spell_steal_custom_hidden:RemoveOnDeath() return false end
function modifier_rubick_spell_steal_custom_hidden:OnCreated()
    self.rubick_abilities = 
    {
        ["rubick_telekinesis_custom"] = true,
        ["rubick_fade_bolt_custom"] = true,
        ["rubick_arcane_supremacy_custom"] = true,
        ["rubick_empty1_custom"] = true,
        ["rubick_empty2_custom"] = true,
        ["rubick_spell_steal_custom"] = true,
        ["rubick_telekinesis_land_custom"] = true,
        ["rubick_telekinesis_land_self_custom"] = true,
        ["rubick_fade_bolt_custom_magic_immune"] = true,
        ["rubick_fade_lightning_custom"] = true,
        ["rubick_flash_bolt_custom"] = true,
    }
    if not IsServer() then return end
    self.ability_think = {}
    self.spell_steal_history = {}
    self:StartIntervalThink(0.1)
end
function modifier_rubick_spell_steal_custom_hidden:DeclareFunctions()
	return
    {
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function modifier_rubick_spell_steal_custom_hidden:GetModifierSpellAmplify_Percentage(params)
    if self:GetCaster():HasModifier("modifier_rubick_19") then
        if params.inflictor and not params.inflictor:IsItem() then
            if not self.rubick_abilities[params.inflictor:GetAbilityName()] then
                return self:GetAbility().modifier_rubick_19[self:GetCaster():GetTalentLevel("modifier_rubick_19")]
            end
        end
    end 
end
function modifier_rubick_spell_steal_custom_hidden:GetModifierPercentageCooldown(params)
    if params.ability and not params.ability:IsItem() then
        if not self.rubick_abilities[params.ability:GetAbilityName()] then
            return self:GetAbility():GetSpecialValueFor("stolen_spell_cooldown_percent")
        end
    end
end
function modifier_rubick_spell_steal_custom_hidden:OnAbilityExecuted(params)
	if not IsServer() then return end
    if params.unit == self:GetParent() then return end
    if params.ability == nil then return end
    if params.ability:IsItem() then return end
    if params.unit:IsIllusion() then return end
    if params.ability:IsStolen() then return end
    local useless_abilities = self:GetAbility().ignore_abilities_list
    local swap_ability_list = self:GetAbility().swapable_abilities_list
    if useless_abilities[params.ability:GetAbilityName()] then return end
    if params.ability:GetAbilityIndex() > 5 then return end
    if swap_ability_list[params.ability:GetAbilityName()] then
        local new_ability = params.unit:FindAbilityByName(swap_ability_list[params.ability:GetAbilityName()])
        if new_ability then
            self:GetAbility():SetLastSpell( params.unit, new_ability )
        end
    else
        self:GetAbility():SetLastSpell( params.unit, params.ability )
    end
end
function modifier_rubick_spell_steal_custom_hidden:OnIntervalThink()
    if not IsServer() then return end
    for i=#self.spell_steal_history, 1, -1 do
        local ability = self.spell_steal_history[i]
        self:UpdateAbility(ability, i)
    end
end
function modifier_rubick_spell_steal_custom_hidden:UpdateAbility(ability, table_index)
    if not IsServer() then return end
    if ability == nil then return end
    if ability:IsNull() then return end
    if ability:IsToggle() and ability:GetToggleState() then
        ability:ToggleAbility()
    end
    if ability:GetIntrinsicModifierName() ~= nil then
        local modifier = self:GetParent():FindModifierByName(ability:GetIntrinsicModifierName())
        if modifier then
            modifier:Destroy()
        end
    end
    self.ability_think[ability:GetAbilityName()] = (self.ability_think[ability:GetAbilityName()] or 0) + 0.1
    if (ability:NumModifiersUsingAbility() <= 0 or self.ability_think[ability:GetAbilityName()] >= 20) and not ability:IsChanneling() then
        self.ability_think[ability:GetAbilityName()] = nil
        ability:SetHidden(true)
        local ability_name = ability:GetAbilityName()
        self:GetParent():RemoveAbilityByHandle(ability)
        if ability:IsNull() then
            print("Удалена способность ", ability_name)
            table.remove(self.spell_steal_history, table_index)
        end
    end
end
function modifier_rubick_spell_steal_custom_hidden:DeleteAbilityFromList(ability_name)
    for i=#self.spell_steal_history, 1, -1 do
        if self.spell_steal_history[i] ~= nil and self.spell_steal_history[i]:GetAbilityName() == ability_name then
            table.remove(self.spell_steal_history, i)
        end
    end
end

-- Rubick Utils
function rubick_spell_steal_custom:SetLastSpell(hero, ability)
	rubick_spell_steal_custom.heroesData[hero:entindex()] = ability
end

function rubick_spell_steal_custom:GetLastSpell(hero)
    if rubick_spell_steal_custom.heroesData[hero:entindex()] then
        return rubick_spell_steal_custom.heroesData[hero:entindex()]
    end
	return nil
end

function rubick_spell_steal_custom:GetScepterEffect()
    if self:GetCaster():HasModifier("modifier_rubick_21") then
        return true
    end
    return false
end

function rubick_spell_steal_custom:GetRandomAbilityList()
    local abilities_list = {}
    local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
    for _,unit in pairs(units) do
        if unit and unit:IsAlive() and unit ~= self:GetCaster() and unit:IsRealHero() then
            local ability_1 = unit:GetAbilityByIndex(0)
            if ability_1 and ability_1:GetLevel() > 0 then
                table.insert(abilities_list, ability_1)
            end
            local ability_2 = unit:GetAbilityByIndex(1)
            if ability_2 and ability_2:GetLevel() > 0 then
                table.insert(abilities_list, ability_2)
            end
            local ability_3 = unit:GetAbilityByIndex(2)
            if ability_3 and ability_3:GetLevel() > 0 then
                table.insert(abilities_list, ability_3)
            end
            local ability_6 = unit:GetAbilityByIndex(5)
            if ability_6 and ability_6:GetLevel() > 0 then
                table.insert(abilities_list, ability_6)
            end
        end
    end
    for i=#abilities_list,1,-1 do
        local ability = abilities_list[i]
        if ability and not ability:IsNull() then
            if not self:GetCaster():HasModifier("modifier_rubick_13") and ability:IsPassive() then
                table.remove(abilities_list, i)
            end
            if self.ignore_abilities_list[ability:GetAbilityName()] then
                table.remove(abilities_list, i)
            end
            if self.swapable_abilities_list[ability:GetAbilityName()] then
                abilities_list[i] = ability:GetCaster():FindAbilityByName(self.swapable_abilities_list[ability:GetAbilityName()])
            end
            if self.currentSpell and self.currentSpell:GetAbilityName() == ability:GetAbilityName() then
                table.remove(abilities_list, i)
            end
        end
    end
    return abilities_list[RandomInt(1, #abilities_list)]
end