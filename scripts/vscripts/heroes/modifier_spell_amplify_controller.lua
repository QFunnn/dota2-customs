--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spell_amplify_controller = class({})
function modifier_spell_amplify_controller:IsHidden() return true end
function modifier_spell_amplify_controller:IsDebuff() return false end
function modifier_spell_amplify_controller:IsPurgable() return false end
function modifier_spell_amplify_controller:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_spell_amplify_controller:RemoveOnDeath() return false end

function modifier_spell_amplify_controller:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_spell_amplify_controller:OnCreated()
    self.parent = self:GetParent()
	self:SetHasCustomTransmitterData(true)
	if IsClient() then return end
	Timers:CreateTimer(0.05, function()
		self:OnRefresh()
		return 0.05
	end)
	self:OnRefresh()
end

function modifier_spell_amplify_controller:OnRefresh()
	if IsClient() then return end
	if self:IsNull() then return end
	self:SetValues()
	self:SendBuffRefreshToClients()
end

function modifier_spell_amplify_controller:SetValues()
    if self and (not self:IsNull()) and self.parent and (not self.parent:IsNull()) and self.parent.GetIntellect and self.parent.flSP then
       self.spell_amplify = self.parent.flSP * self.parent:GetIntellect(false)
    else
       self.spell_amplify = 0
    end
end

function modifier_spell_amplify_controller:AddCustomTransmitterData()
    self.TransmitterTable = self.TransmitterTable or {}

    self.TransmitterTable.spell_amplify = self.spell_amplify

	return self.TransmitterTable
end

function modifier_spell_amplify_controller:HandleCustomTransmitterData(data)
	self.spell_amplify = tonumber(data.spell_amplify)
end

if IsClient() then 
	function modifier_spell_amplify_controller:GetModifierSpellAmplify_Percentage(params)	
        return self.spell_amplify
	end 
end

if IsServer() then
    local percentage_abilities = 
    {
        ["abyssal_underlord_firestorm_custom"] = true,
        ["ability_elder_titan_earth_splitter"] = true,
        ["winter_wyvern_arctic_burn"] = true,
        ["doom_bringer_infernal_blade"] = true,
        -- [#25] enigma_midnight_pulse_custom убран отсюда — обрабатывается отдельным блоком
        -- ниже (амп множит только флат-часть base_damage, %HP не усиливается).
        ["enigma_black_hole"] = true,
        ["huskar_life_break"] = true,
        ["phoenix_sun_ray"] = true,
        ["spectre_dispersion_custom"] = true,
        ["death_prophet_spirit_siphon"] = true,
        ["custom_phantom_assassin_fan_of_knives"] = true,
        ["bloodseeker_rupture"] = true,
        ["item_spirit_vessel"] = true,
        ["terrorblade_reflection_lua"] = true,
        ["venomancer_poison_nova_custom"] = true,
        ["necrolyte_heartstopper_aura_lua"] = true,
        ["zuus_static_field"] = true,
        ["item_blade_mail"] = true,
        ["item_panzer_custom"] = true,
        ["item_iron_talon"] = true,
        ["sandking_caustic_finale"] = true,
        ["sandking_caustic_finale_lua"] = true,
        ["jakiro_liquid_ice"] = true,
        -- [#25] jakiro_liquid_ice_lua убран — обрабатывается base_split-блоком ниже
        -- (усиливается только база, %HP не усиливается).
        ["witch_doctor_maledict_custom"] = true,
        ["bloodseeker_blood_mist_custom"] = true,
        ["witch_doctor_voodoo_restoration_custom"] = true,
        ["item_shivas_guard_2"] = true,
        ["meepo_ransack_custom"] = true,
        ["shadow_demon_disseminate_custom"] = true,
        ["dragon_knight_elder_dragon_form_custom"] = true,
        ["muerta_pierce_the_veil"] = true,
        ["zuus_arc_lightning_custom"] = true,
        ["venomancer_noxious_plague"] = true,
        ["drow_ranger_frost_arrows_custom"] = true,
        ["item_revenants_brooch"] = true,
        ["item_revenants_brooch_custom"] = true,
        ["kez_kazurai_katana"] = true,
        ["kez_raptor_dance"] = true,
        ["zuus_heavenly_jump_custom"] = true,
        ["zuus_static_field_custom"] = true,
        ["death_prophet_spirit_siphon"] = true,
        ["life_stealer_infest"]=true,
        ["item_hydras_breath"]=true,
    }

    local dot_abilities=
    {
        ["venomancer_venomous_gale"] = true,
        ["venomancer_poison_sting"] = true,
        ["viper_poison_attack"] = true,
        ["viper_corrosive_skin"] = true,
        ["viper_nethertoxin"] = true,
        ["crystal_maiden_frostbite_custom"] = true,
        ["axe_battle_hunger_custom"] = true,
        ["doom_bringer_doom"] = true,
        ["earth_spirit_magnetize"] = true,
        ["huskar_burning_spear"] = true,
        ["huskar_burning_spear_custom"] = true,
        ["phoenix_icarus_dive"] = true,
        ["phoenix_fire_spirits"] = true,
        -- inflictor у DoT-урона — linked sub-ability phoenix_launch_fire_spirit,
        -- не сама fire_spirits. Запись нужна для серверной амплификации.
        ["phoenix_launch_fire_spirit"] = true,
        ["pudge_rot"] = true,
        ["alchemist_acid_spray"] = true,
        ["treant_natures_grasp"] = true,
        ["treant_leech_seed_custom"] = true,
        ["treant_overgrowth"] = true,
        ["ember_spirit_searing_chains"] = true,
        ["bane_fiends_grip"] = true,
        ["dazzle_poison_touch_custom"] = true,
        ["disruptor_thunder_strike"] = true,
        ["disruptor_static_storm_custom"] = true,
        ["jakiro_dual_breath"] = true,
        ["jakiro_liquid_fire_lua"] = true,
        ["ogre_magi_ignite_custom"] = true,
        ["shadow_demon_shadow_poison"] = true,
        ["silencer_curse_of_the_silent"] = true,
        ["warlock_shadow_word"] = true,
        ["skeleton_king_hellfire_blast"] = true,
        ["queenofpain_shadow_strike"] = true,
        ["shredder_chakram_lua"] = true,
        ["shredder_chakram_2_lua"] = true,
        ["sniper_shrapnel"] = true,
        ["ancient_apparition_cold_feet_custom"] = true,
        ["item_meteor_hammer"] = true,
        ["item_urn_of_shadows_custom"] = true,
        ["item_fallen_sky"] = true,
        ["item_radiance"] = true,
        ["dark_seer_ion_shell"] = true,
        ["jakiro_macropyre"] = true,
        ["batrider_flamebreak"] = true,
        ["batrider_flaming_lasso_custom"] = true,
        ["templar_assassin_psionic_trap"] = true,
        ["brewmaster_cinder_brew"] = true,
        ["dark_willow_bramble_maze"] = true,
        ["shadow_shaman_shackles_custom"] = true,
        ["batrider_firefly"] = true,
        ["sandking_sand_storm"] = true,
        ["sandking_epicenter"] = true,
        ["broodmother_silken_bola"] = true,
        ["dragon_knight_fireball"] = true,
        ["ancient_apparition_ice_vortex"] = true,
        ["dawnbreaker_celestial_hammer"] = true,
        -- DoT-тики Celestial Hammer наносятся через sub-ability dawnbreaker_converge,
        -- inflictor для них — она. Запись celestial_hammer выше нужна только для UI
        -- (полоска в тултипе на главной способности), а серверный Pipe-amp идёт через converge.
        ["dawnbreaker_converge"] = true,
        ["dawnbreaker_solar_guardian"] = true,
        ["shredder_flamethrower"] = true,
        ["grimstroke_spirit_walk_custom"] = true,
        ["pugna_life_drain_custom"]= true,
        ["doom_bringer_scorched_earth_custom"]= true,
        ["warlock_upheaval"] = true,
        ["slark_dark_pact"] = true,
        ["ember_spirit_flame_guard_custom"]= true,
        ["viper_viper_strike_custom"]= true,
        ["furion_curse_of_the_forest"] = true,
        ["witch_doctor_voodoo_restoration_custom"] = true,
        ["item_giants_ring_custom"] = true,
        ["night_stalker_crippling_fear"] = true,
        ["ember_spirit_fire_remnant_custom"] = true,
        ["pudge_dismember"] = true,
        ["ember_spirit_immolation"] = true,
        ["ability_lich_frost_shield"] = true,
        ["invoker_chaos_meteor_lua"] = true,
        ["arc_warden_flux"] = true,
        ["phoenix_dying_light"] = true,
    }

    -- Прокидываем список на клиент: ability_note.js использует его
    -- чтобы добавить в тултип строку "усиливается предметом Pipe"
    CustomNetTables:SetTableValue("globals", "dot_abilities", dot_abilities)

    function modifier_spell_amplify_controller:GetModifierSpellAmplify_Percentage(params)
        local inflictor = params.inflictor
        local target = params.target
        if inflictor and not inflictor:IsNull() then
            local ability_name = inflictor:GetAbilityName()
            local parent = self.parent
            if percentage_abilities[ability_name]
            and (ability_name ~= "enigma_black_hole" or parent:HasScepter())
            and (ability_name ~= "witch_doctor_voodoo_restoration_custom" or parent:HasTalent("special_bonus_unique_witch_doctor_2"))
            then
                return 0
            end

            local bonus_modifier_rubick_arcane_supremacy = 0
            local modifier_rubick_arcane_supremacy = parent:FindModifierByName("modifier_rubick_arcane_supremacy")
            if modifier_rubick_arcane_supremacy then
                bonus_modifier_rubick_arcane_supremacy = parent:GetIntellect(false) * 0.5
            end

            local bHeroTarget = false
            if target and not target:IsNull() then
                if target.IsRealHero and target:IsRealHero() and target.GetUnitName and string.find(target:GetUnitName(),"npc_dota_hero") == 1 then
                bHeroTarget = true
                end
            end

            -- [#19/#31] huskar burning spear (vanilla слот 2 наносит 0.5% макс.HP + фикс одним
            -- магическим инстансом; кастомная — только фикс). Спелл-амп движка множит ВЕСЬ инстанс,
            -- поэтому масштабируем амп на долю ФИКС-части (burn_damage/total) → %HP-часть эффективно
            -- не усиливается. Делаем это для ОБОИХ случаев (с Pipe и без), иначе без Pipe (flDotSP=nil)
            -- защита не срабатывала и Force of Star усиливал %HP.
            if ability_name == "huskar_burning_spear" or ability_name == "huskar_burning_spear_custom" then
                local burnScale = 1
                if target and not target:IsNull() and target.GetMaxHealth then
                    local burn_damage = inflictor:GetSpecialValueFor("burn_damage") or 0
                    local max_pct = (inflictor:GetSpecialValueFor("burn_damage_max_pct") or 0) / 100
                    local total = burn_damage + max_pct * target:GetMaxHealth()
                    if total > 0 then burnScale = burn_damage / total end
                end

                local amp
                if parent.GetIntellect and parent.flDotSP then
                    -- есть Torture Pipe — как в DoT-ветке ниже
                    local bonus = bonus_modifier_rubick_arcane_supremacy
                    if modifier_rubick_arcane_supremacy then bonus = parent:GetIntellect(false) * 0.25 end
                    local stats = parent:GetIntellect(false) + parent:GetStrength() + parent:GetAgility()
                    if bHeroTarget then
                        amp = (0.35 * parent.flDotSP * stats + self.spell_amplify * 0.2) + bonus
                    else
                        amp = (parent.flDotSP * stats + self.spell_amplify) + bonus
                    end
                else
                    -- нет Pipe — как в общем возврате
                    if bHeroTarget then
                        amp = (self.spell_amplify + bonus_modifier_rubick_arcane_supremacy) * 0.2
                    else
                        amp = self.spell_amplify
                    end
                end

                return amp * burnScale
            end

            -- [#25] Способности вида «база + %макс.HP» в ОДНОМ инстансе ApplyDamage.
            -- Движковый спелл-амп множит весь инстанс, но %HP усиливать нельзя. Масштабируем
            -- амп на долю флат-части (base/total) → усиливается только база. Для ancient
            -- (Roshan/Nian) применяется только база (см. Lua способности) → scale=1.
            -- Чтобы добавить новую такую способность — допиши строку в base_split (ключи KV).
            -- ancient_base_only=true: способность по ancient наносит ТОЛЬКО базу (см. её Lua) →
            -- усиливаем целиком (scale=1). Без флага: по ancient идёт база+%HP → усиливаем
            -- только базу (scale=base/total), как и по обычным целям.
            local base_split = {
                enigma_midnight_pulse_custom = { base = "base_damage", pct = "damage_percent", ancient_base_only = true },
                jakiro_liquid_ice_lua        = { base = "base_damage", pct = "pct_health_damage" },
            }
            local split_cfg = base_split[ability_name]
            if split_cfg then
                local scale = 1
                local isAncient = target and target.IsAncient and target:IsAncient()
                if target and not target:IsNull() and target.GetMaxHealth then
                    if isAncient and split_cfg.ancient_base_only then
                        scale = 1
                    else
                        local base = inflictor:GetSpecialValueFor(split_cfg.base) or 0
                        local pct = (inflictor:GetSpecialValueFor(split_cfg.pct) or 0) / 100
                        local total = base + pct * target:GetMaxHealth()
                        if total > 0 then scale = base / total end
                    end
                end
                local amp
                if bHeroTarget then
                    amp = (self.spell_amplify + bonus_modifier_rubick_arcane_supremacy) * 0.2
                else
                    amp = self.spell_amplify
                end
                return amp * scale
            end

            if dot_abilities[ability_name] and parent.GetIntellect and parent.flDotSP then
                if modifier_rubick_arcane_supremacy then
                    bonus_modifier_rubick_arcane_supremacy = parent:GetIntellect(false) * 0.25
                end
                local amp
                if bHeroTarget then
                    amp = (0.35 * parent.flDotSP * (parent:GetIntellect(false)+parent:GetStrength()+parent:GetAgility()) + self.spell_amplify * 0.2) + bonus_modifier_rubick_arcane_supremacy
                else
                    amp = (parent.flDotSP * (parent:GetIntellect(false)+parent:GetStrength()+parent:GetAgility()) + self.spell_amplify) + bonus_modifier_rubick_arcane_supremacy
                end

                -- (huskar burning spear обрабатывается выше единым блоком — и с Pipe, и без)

                -- dawnbreaker_celestial_hammer: ability наносит initial impact (моментный)
                -- И DoT через fire-wake-зону одним inflictor'ом. Pipe должен усиливать
                -- только DoT. Из контроллера возвращаем только базовый spell_amp,
                -- а Pipe-составляющую для DoT-тиков добавляем в DamageFilter.
                if ability_name == "dawnbreaker_celestial_hammer" then
                    if bHeroTarget then
                        return (self.spell_amplify * 0.2) + bonus_modifier_rubick_arcane_supremacy
                    else
                        return self.spell_amplify + bonus_modifier_rubick_arcane_supremacy
                    end
                end

                return amp
            end
            if inflictor and inflictor:GetAbilityName() == "item_devastator" then
                return self.spell_amplify * 0.5
            end
            if bHeroTarget then
                if inflictor and inflictor:GetAbilityName() == "silencer_glaives_of_wisdom" then
                    return self.spell_amplify * 0
                end

                return (self.spell_amplify + bonus_modifier_rubick_arcane_supremacy) * 0.2
            end
        end
        return self.spell_amplify
    end
end