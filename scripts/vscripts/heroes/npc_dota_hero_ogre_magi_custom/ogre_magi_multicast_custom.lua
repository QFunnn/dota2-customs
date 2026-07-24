--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ogre_magi_multicast_custom", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_multicast_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ogre_magi_multicast_custom_use", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_multicast_custom", LUA_MODIFIER_MOTION_NONE )

ogre_magi_multicast_custom = class({})

ogre_magi_multicast_custom.modifier_ogre_magi_10 = {30,20}
ogre_magi_multicast_custom.modifier_ogre_magi_17 = {30,20}

function ogre_magi_multicast_custom:GetIntrinsicModifierName()
    return "modifier_ogre_magi_multicast_custom"
end

function ogre_magi_multicast_custom:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function ogre_magi_multicast_custom:GetMulticastChance(times)
    local chance = self:GetSpecialValueFor("multicast_"..times.."_times")
    if chance <= 0 then return 0 end
    local caster = self:GetCaster()
    local strength_for_one_pct = self:GetSpecialValueFor("strength_for_one_pct")
    if strength_for_one_pct > 0 then
        chance = chance + (caster:GetStrength() / strength_for_one_pct)
    end
    if caster:HasModifier("modifier_ogre_magi_10") then
        chance = chance + caster:GetAgility() / self.modifier_ogre_magi_10[caster:GetTalentLevel("modifier_ogre_magi_10")]
    end
    if caster:HasModifier("modifier_ogre_magi_17") then
        chance = chance + caster:GetIntellect(false) / self.modifier_ogre_magi_17[caster:GetTalentLevel("modifier_ogre_magi_17")]
    end
    return chance
end

modifier_ogre_magi_multicast_custom = class({})
function modifier_ogre_magi_multicast_custom:IsHidden() return true end
function modifier_ogre_magi_multicast_custom:IsPurgable() return false end
function modifier_ogre_magi_multicast_custom:IsPurgeException() return false end
function modifier_ogre_magi_multicast_custom:RemoveOnDeath() return false end

modifier_ogre_magi_multicast_custom.one_target =
{
	["ogre_magi_fireblast_custom"] = true,
	["ogre_magi_unrefined_fireblast_custom"] = true,
}

modifier_ogre_magi_multicast_custom.item_exceptions =
{
	["item_holy_locket"] = true,
	["item_moon_shard"] = true,
	["item_harpoon"] = true,
    ["item_madstone_bundle"] = true,
    ["item_tpscroll"] = true,
    ["item_clarity"] = true,
    ["item_faerie_fire"] = true,
    ["item_smoke_of_deceit"] = true,
    ["item_ward_observer"] = true,
    ["item_ward_sentry"] = true,
    ["item_enchanted_mango"] = true,
    ["item_flask"] = true,
    ["item_tango"] = true,
    ["item_blood_grenade"] = true,
    ["item_dust"] = true,
    ["item_bottle"] = true,
    ["item_aghanims_shard"] = true,
    ["item_ward_dispenser"] = true,
    ["item_refresher"] = true,
    ["item_aegis"] = true,
    ["item_smoke_of_deceit"] = true,
    ["item_ward_sentry"] = true,
    ["item_ex_machina"] = true,
    ["item_manta"] = true,
    ["item_ward_dispenser_custom"] = true,
    ["item_gods_locket"] = true,
    ["item_meteor_hammer"] = true,

    ["item_talant_book"] = true,
    ["item_book_str"] = true,
    ["item_book_agi"] = true,
    ["item_book_int"] = true,
    ["item_blink"] = true,
    ["item_arcane_blink"] = true,
    ["item_overwhelming_blink"] = true,
    ["item_swift_blink"] = true,
    ["item_clarity"] = true,
    ["item_faerie_fire"] = true,
    ["item_smoke_of_deceit"] = true,
    ["item_ward_observer"] = true,
    ["item_ward_sentry"] = true,
    ["item_enchanted_mango"] = true,
    ["item_flask"] = true,
    ["item_tango"] = true,
    ["item_blood_grenade"] = true,
    ["item_dust"] = true,
    ["item_bottle"] = true,
    ["item_aghanims_shard"] = true,
    ["item_ward_dispenser"] = true,
    ["item_madstone_bundle"] = true,
    ["item_power_treads"] = true,
    ["item_refresher"] = true,
    ["item_book_of_shadows"] = true,
    ["item_aegis"] = true,
    ["item_force_staff"] = true,
    ["item_hurricane_pike"] = true,
    ["item_black_king_bar"] = true,
    ["item_smoke_of_deceit"] = true,
    ["item_ward_sentry"] = true,
    ["item_ex_machina"] = true,
    ["item_manta"] = true,
    ["item_clarity"] = true,
    ["item_spear_of_mordiggian"] = true,
    ["item_necronomicon"] = true,
    ["item_necronomicon_2"] = true,
    ["item_necronomicon_3"] = true,
    ["item_demonicon"] = true,
    ["item_fusion_rune"] = true,
    ["item_fallen_sky"] = true,
    ["item_third_eye_custom"] = true,
    ["item_necronomicon_custom"] = true,
    ["item_fusion_rune_custom"] = true,
    ["item_flicker_custom"] = true,
    ["item_greater_faerie_fire_custom"] = true,
    ["item_arcane_ring_custom"] = true,
    ["item_force_boots_custom"] = true,
    ["item_demonicon_custom"] = true,
    ["item_banana_custom"] = true,
    ["item_mango_tree_custom"] = true,
    ["item_enchanted_mango_custom"] = true,
    ["item_necronomicon_melee_custom"] = true,
    ["item_tome_of_aghanim_custom"] = true,
    ["item_overflowing_elixir_custom"] = true,
    ["item_health_radiance"] = true,
    ["item_mana_radiance"] = true,
    ["item_radiance_custom"] = true,
    ["item_aghanims_shard_custom"] = true,
    ["item_elemental_ringmaster"] = true,
    ["item_aghanims_treads"] = true,

    ["item_moon_aghanim"] = true,
    ["item_moon_kaya"] = true,
    ["item_moon_yasha"] = true,
    ["item_moon_sange"] = true,
    ["item_force_platemail"] = true,
}

function modifier_ogre_magi_multicast_custom:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_ogre_magi_multicast_custom:OnIntervalThink()
    if not IsServer() then return end
    if self.parent:HasModifier("modifier_ogre_magi_3") and self.parent:HasModifier("modifier_ogre_magi_10") and self.parent:HasModifier("modifier_ogre_magi_17") then
        if not self.head_particle then
            self.head_particle = ParticleManager:CreateParticle("particles/ogre_magi_head/ogre_magi_head.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
            self:AddParticle(self.head_particle, false, false, -1, false, false)
        end
        self:StartIntervalThink(-1)
    end
end

function RollMulticast(chance_2, chance_3, chance_4)
    local multicast_multi = 1
    local roll = RandomInt(1, 100)

    if roll <= chance_4 then
        multicast_multi = 4
    elseif roll <= chance_4 + chance_3 then
        multicast_multi = 3
    elseif roll <= chance_4 + chance_3 + chance_2 then
        multicast_multi = 2
    end

    return multicast_multi
end

function modifier_ogre_magi_multicast_custom:OnAbilityFullyCast( params )
    if params.unit ~= self.parent then return end
    if params.ability == self.ability then return end
    if self.parent:PassivesDisabled() then return end
    if self.item_exceptions[params.ability:GetName()] then return end
    if params.ability:GetName() == "" then return end
    if not params.is_fast_multicast then
        if params.ability:GetName() == "ogre_magi_fireblast_custom" then return end
        if params.ability:GetName() == "ogre_magi_unrefined_fireblast_custom" then return end
    end
    local selt_target = false
    local target = params.target
    if target and target:GetTeamNumber() == self.parent:GetTeamNumber() then
        if params.ability:GetName() == "item_cyclone" then return end
        if params.ability:GetName() == "item_wind_waker" then return end
    end
    local point = nil
    local triple = self:GetCaster():HasModifier("modifier_ogre_magi_3") and self:GetCaster():HasModifier("modifier_ogre_magi_10") and self:GetCaster():HasModifier("modifier_ogre_magi_17")
    local is_point = bit.band( params.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_POINT ) ~= 0

    if not params.ogre_magi_fireblast_upgrade then
        if not selt_target then
            if is_point then
                if not triple then return end
            elseif not target then
                if not triple then return end
            else
                if bit.band( params.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET ) ~= 0 then return end
            end
        end
    end

    if is_point then
        point = params.ability:GetCursorPosition()
    elseif selt_target or (triple and not target) then
        target = self.parent
    end

    
    local chance_2 = self.ability:GetMulticastChance(2)
    local chance_3 = self.ability:GetMulticastChance(3)
    local chance_4 = self.ability:GetMulticastChance(4)
    print(chance_2, chance_3, chance_4)
    local multicast_multi = RollMulticast(chance_2, chance_3, chance_4)

    local delay = params.ability:GetSpecialValueFor( "multicast_delay" ) or 0
    local single = self.one_target[params.ability:GetAbilityName()] or false
    local repeat_target = false
    if triple then
        delay = 0.3
        repeat_target = true
    end
    if params.ability:GetAbilityName() == "item_hand_of_midas_custom" then
        repeat_target = false
    end
    if multicast_multi == 1 then return end
    if point == nil then
        self.parent:AddNewModifier( self.parent, self.ability, "modifier_ogre_magi_multicast_custom_use", { ability = params.ability:entindex(), target = target:entindex(), multicast = multicast_multi, delay = delay, single = single, repeat_target = repeat_target and 1 or 0, } )
    else
        self.parent:AddNewModifier( self.parent, self.ability, "modifier_ogre_magi_multicast_custom_use", { ability = params.ability:entindex(), x = point.x, y = point.y, z = point.z, multicast = multicast_multi, delay = delay, single = single, repeat_target = repeat_target and 1 or 0, } )
    end
end

modifier_ogre_magi_multicast_custom_use = class({})
function modifier_ogre_magi_multicast_custom_use:IsHidden() return true end
function modifier_ogre_magi_multicast_custom_use:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_ogre_magi_multicast_custom_use:IsPurgable() return false end
function modifier_ogre_magi_multicast_custom_use:RemoveOnDeath() return false end
function modifier_ogre_magi_multicast_custom_use:OnCreated( kv )
    if not IsServer() then return end
    self.caster = self:GetParent()
    self.ability = EntIndexToHScript( kv.ability )
    self.main_ability = self:GetAbility()
    self.point = nil 
    self.target = nil 
    if kv.target then 
        self.target = EntIndexToHScript( kv.target )
    else 
        self.point = Vector(kv.x, kv.y, kv.z)
    end
    self.multicast = kv.multicast
    self.delay = kv.delay
    self.single = kv.single==1
    self.repeat_target = kv.repeat_target==1
    self.buffer_range = 600
    self:SetStackCount( self.multicast )
    self.casts = 0
    if self.multicast==1 then
        self:Destroy()
        return
    end
    self.targets = {}
    self.no_target = 0

    if self.target ~= nil then
        if self.ability:GetAbilityName() ~= "ogre_magi_ignite_custom" and not self.repeat_target then
            self.targets[self.target] = true
        end
        if self:GetCaster() == self.target and bit.band( self.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_NO_TARGET ) ~= 0 then
            self.no_target = 1
        end
        self.radius = self.ability:GetCastRange( self.target:GetOrigin(), self.target ) + self.buffer_range
        self.target_team = DOTA_UNIT_TARGET_TEAM_FRIENDLY

        if self.target:GetTeamNumber()~=self.caster:GetTeamNumber() then
            self.target_team = DOTA_UNIT_TARGET_TEAM_ENEMY
        end
    end
    self.target_type = self.ability:GetAbilityTargetType()

    if self.target_type == DOTA_UNIT_TARGET_CUSTOM then
        self.target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
    end

    self.target_flags = DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
    
    if bit.band( self.ability:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES ) ~= 0 then
        self.target_flags = self.target_flags + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
    end

    local target = self.caster
    if self.single and self.target then
        target = self.target
    end

    self:PlayEffects( self.multicast, target )
    self:StartIntervalThink( self.delay )
end

function modifier_ogre_magi_multicast_custom_use:OnIntervalThink()
    local current_target = nil
    if self.no_target == 1 then
        self.ability:OnSpellStart()
    elseif self.point ~= nil then
        self.caster:SetCursorPosition(self.point)
        if self.ability:IsItem() then
            self.ability:OnSpellStart()
        else
            self.ability:OnSpellStart(nil, self.point)
        end
    else
        if self.single then
            current_target = self.target
        else
            local units = FindUnitsInRadius( self.caster:GetTeamNumber(), self.caster:GetOrigin(), nil, self.radius, self.target_team, self.target_type, self.target_flags, FIND_ANY_ORDER, false )
            for _,unit in pairs(units) do
                if not self.targets[unit] then
                    local filter = false
                    if self.ability.CastFilterResultTarget then
                        filter = self.ability:CastFilterResultTarget( unit ) == UF_SUCCESS
                    else
                        filter = true
                    end
                    if filter then
                        if #units > 1 and self.ability:GetAbilityName() ~= "ogre_magi_ignite_custom" and not self.repeat_target then
                            self.targets[unit] = true
                        end
                        current_target = unit
                        break
                    end
                end
            end
            if not current_target then
                self:StartIntervalThink( -1 )
                self:Destroy()
                return
            end
        end
        if self.ability:IsItem() or self.ability:GetAbilityName() == "ogre_magi_smash" then
            if current_target and not current_target:IsNull() then 
                self.caster:SetCursorCastTarget( current_target )
                if self.ability:GetAbilityName() == "item_hand_of_midas_custom" then
                    if current_target and not current_target:IsNull() then
                        self.ability:OnSpellStart(current_target)
                    end
                else
                    self.ability:OnSpellStart()
                end
            end
        else
            if self.point ~= nil then 
                self.ability:OnSpellStart(nil, self.point)
            else 
                if current_target and not current_target:IsNull() then 
                    self.ability:OnSpellStart(current_target)
                end
            end
        end
    end
    self.casts = self.casts + 1
    if self.casts >= (self.multicast-1) then
        self:StartIntervalThink( -1 )
        self:Destroy()
    end
end

function modifier_ogre_magi_multicast_custom_use:PlayEffects( value, target )
    local effect_name = "particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf"
    local effect_cast = ParticleManager:CreateParticle(effect_name, PATTACH_OVERHEAD_FOLLOW, target )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( value, 0, 0 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    local sound = math.min( value-1, 3 )
    local sound_cast = "Hero_OgreMagi.Fireblast.x" .. sound
    if sound>0 then
        target:EmitSound(sound_cast)
    end
end