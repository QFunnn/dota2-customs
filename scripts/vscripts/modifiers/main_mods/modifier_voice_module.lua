--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_voice_module_damage_cd", "modifiers/main_mods/modifier_voice_module", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "modifier_voice_module_lasthit_cd", "modifiers/main_mods/modifier_voice_module", LUA_MODIFIER_MOTION_NONE)

modifier_voice_module = class(mod_hidden)
function modifier_voice_module:RemoveOnDeath() return false end

function modifier_voice_module:OnCreated(table)

self.parent = self:GetParent()

if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_inc(self, true)
    self.parent:AddSpellEvent(self, true)
    self.parent:AddOrderEvent(self, true)
    self.parent:AddDeathEvent(self, true)
end

self.sound = nil
self.for_player = nil
self.more_players = -1

self.attack_move_cd = 6
self.cast_cd = 6
self.lasthit_cd = 30
self.damage_cd = 12
self.kill_timer = 2

self.rivaL_chance = 30

self.normal = 
{
    ["models/heroes/crystal_maiden/crystal_maiden.vmdl"] = true,
    ["models/heroes/crystal_maiden/crystal_maiden_arcana.vmdl"] = true,
    ["models/heroes/terrorblade/terrorblade.vmdl"] = true,
    ["models/heroes/terrorblade/terrorblade_arcana.vmdl"] = true,
    ["models/heroes/antimage/antimage.vmdl"] = true,
}

self.arcana =
{
    ["models/items/axe/ti9_jungle_axe/axe_bare.vmdl"] = true
}

self.persona =
{
    ["models/heroes/crystal_maiden_persona/crystal_maiden_persona.vmdl"] = true,
    ["models/heroes/antimage_female/antimage_female.vmdl"] = true,
    ["models/items/antimage_female/mh_antimage_kirin/antimage_female_kirin.vmdl"] = true,
    ["models/items/antimage_female/mh_antimage_kirin/antimage_female_kirin_rainbow.vmdl"] = true,
    ["models/items/axe/axe_carnival/axe_carnival_base.vmdl"] = true,
    ["models/items/legion_commander/dark_carnival_legion_commander/dark_carnival_legion_commander_base.vmdl"] = true,
    ["models/items/morphling/morphling_automaton/morphling_automaton.vmdl"] = true,
    ["models/items/bristleback/bristlebot/bristlebot.vmdl"] = true,
}


if test then 
    self.rivaL_chance = 100
    self.cast_cd = 2
    self.lasthit_cd = 1
    self.attack_move_cd = 2
end 

if false then 
    self:Destroy()
    return
end 

if not IsServer() then return end

self.cd_time = 0
self.current_cd = 0

self.move_cd_time = 0
self.cast_cd_time = 0

self.unit_name = self.parent:GetUnitName()
self.model_name = self.parent:GetModelName()
end

function modifier_voice_module:GetNumber(number, hundred)

local str = tostring(number)

if hundred and hundred == 1 then 
    
    if number < 10 then 
        str = "00"..tostring(number)
    elseif number < 100 then 
        str = "0"..tostring(number)
    end 

    return str
end 


if number < 10 then 
    str = "0"..tostring(number)
end    

return str
end 



function modifier_voice_module:OnIntervalThink()
if not IsServer() then return end 
if self.sound == nil then return end 
if self.for_player == nil then return end 

local sound = self.sound
self.sound = nil

self:MakeSound(sound, self.for_player, 0, self.more_players, self.priority, self.global)


self.global = nil
self.priority = nil
self.for_player = nil
self.more_players = -1

self:StartIntervalThink(-1)
end 



function modifier_voice_module:MakeSound(sound, player_only, timer, more_players, priority, global)
if not IsServer() then return end 
if self:GetParent():IsHexed() then return end
if self.sound ~= nil and not priority then return false end

if timer and timer > 0 then 
    
    self.sound = sound
    self.for_player = player_only or false
    self.more_players = more_players or -1
    self.global = global or false
    self.priority = priority or false

    self:StartIntervalThink(timer)
    return
end 

if GameRules:GetDOTATime(false, false) - self.cd_time < self.current_cd and not priority then return false end

if test then
    print(sound)
end

if more_players and more_players ~= -1 then 
    EmitAnnouncerSoundForPlayer(sound, more_players)
end

local duration = self.parent:GetSoundDuration(sound, nil)
if duration >= 0 then
    self.cd_time = GameRules:GetDOTATime(false, false)
    self.current_cd = duration
end

if global and global == true then 
    EmitAnnouncerSound(sound)
    return
end 

if player_only then 
    EmitAnnouncerSoundForPlayer(sound, self.parent:GetPlayerOwnerID())
else
    self.parent:EmitSound(sound)
end 

return true
end 



function modifier_voice_module:OrderEvent(params)
if not IsServer() then return end
if GameRules:GetDOTATime(false, false) - self.cd_time < self.current_cd then return end

local type = params.order_type
local ability = params.ability
local new_pos = params.pos
local target = params.target

local sounds = {}
local activity = 0
local string_table = {}

if GameRules:GetDOTATime(false, false) - self.move_cd_time > self.attack_move_cd then 
    if type == DOTA_UNIT_ORDER_MOVE_TO_POSITION or type == DOTA_UNIT_ORDER_MOVE_TO_TARGET then 
        activity = 1
        string_table = self:GetMoveVoice()
    end

    if type == DOTA_UNIT_ORDER_ATTACK_MOVE or type == DOTA_UNIT_ORDER_ATTACK_TARGET then 
        activity = 1
        string_table = self:GetAttackVoice(target)
    end
end

if ability and ability:GetName() ~= "invoker_sun_strike_custom" and GameRules:GetDOTATime(false, false) - self.cast_cd_time > self.cast_cd 
    and (type == DOTA_UNIT_ORDER_CAST_POSITION or type == DOTA_UNIT_ORDER_CAST_TARGET) and ability:GetCastRange(self.parent:GetAbsOrigin(), nil) then 

    local range = ability:GetCastRange(self.parent:GetAbsOrigin(), nil) + self.parent:GetCastRangeBonus()
    local point = new_pos 

    if target then 
        point = target:GetAbsOrigin()
    end

    if (point - self.parent:GetAbsOrigin()):Length2D() >= math.min(300 + range, range*2) then 
        activity = 2
        string_table = self:GetCastVoice()
    end 
end 

for _,data in pairs(string_table) do 
    for i = data[2],data[3] do 
        table.insert(sounds, data[1]..self:GetNumber(i))
    end 
end  

if #sounds > 0 then 
    if self:MakeSound(sounds[RandomInt(1, #sounds)], true) == true then 
        if activity == 1 then 
            self.move_cd_time = GameRules:GetDOTATime(false, false)
        end 
        if activity == 2 then 
            self.cast_cd_time = GameRules:GetDOTATime(false, false)
        end 
    end 
end 

return true
end 

function modifier_voice_module:IsLcArcana()
if self.persona[self.model_name] then return end
local weapon_model = self.parent:GetItemWearableHandle("weapon")
return weapon_model and weapon_model:GetModelName() == "models/items/legion_commander/demon_sword.vmdl"
end

function modifier_voice_module:IsMkArcana()
return self.parent:HasModifier("modifier_monkey_king_arcana_custom_v1") or self.parent:HasModifier("modifier_monkey_king_arcana_custom_v2") or self.parent:HasModifier("modifier_monkey_king_arcana_custom_v3") or self.parent:HasModifier("modifier_monkey_king_arcana_custom_v4")
end


function modifier_voice_module:JuggKill()

local name = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_trigger.vpcf"

if self.parent:HasModifier("modifier_juggernaut_arcana_v2") then 
    name = "particles/econ/items/juggernaut/jugg_arcana/juggernaut_arcana_v2_trigger.vpcf"
end 

self.parent:EmitSound("Hero_Juggernaut.ArcanaTrigger")

self.parent:StartGesture(ACT_DOTA_TAUNT_SPECIAL)

local trail_pfx = ParticleManager:CreateParticle(name, PATTACH_ABSORIGIN, self.parent)
ParticleManager:ReleaseParticleIndex(trail_pfx)

end 

function modifier_voice_module:DeathEvent(params)
if not IsServer() then return end 
if not params.attacker then return end

local unit = params.unit
local sounds = {}
local timer = 0
local for_player = false
local more_players = -1
local is_last_hit = false
local priority = false
local global = false
local string_table = {}


if (self.parent == params.attacker or (params.attacker.owner and params.attacker.owner == self.parent)) and unit:GetTeamNumber() ~= self.parent:GetTeamNumber() then 

    if unit:IsCreep() and not self.parent:HasModifier("modifier_voice_module_lasthit_cd") then 
        for_player = true
        is_last_hit = true

        string_table = self:GetLastHitVoice()
    end 

    if unit:IsRealHero() and unit:IsValidKill(self.parent) then 

        timer = self.kill_timer

        if dota1x6.KillCount == 1 then 
            global = true
            priority = true
        end

        string_table = self:GetKillVoice(unit)

        if global == false then 
            more_players = unit:GetPlayerOwnerID()
        end
    end 
end

if self.parent == unit then 

    priority = true
    more_players = self.parent:GetPlayerOwnerID()

    string_table = self:GetDeathVoice(self.parent:IsReincarnating(), params.attacker)
end 


if #sounds == 0 then 

    for _,data in pairs(string_table) do 
        for i = data[2],data[3] do 

            local hundred = 0 
            if data[4] and data[4] == 1 then 
                hundred = 1
            end  

            table.insert(sounds, data[1]..self:GetNumber(i, hundred))
        end 
    end  
end 
    

if #sounds > 0 then 
    local sound = sounds[RandomInt(1, #sounds)]

    if self:MakeSound(sound, for_player, timer, more_players, priority, global) then 
        if is_last_hit == true then 
            self.parent:AddNewModifier(self.parent, nil, "modifier_voice_module_lasthit_cd", {duration = self.lasthit_cd})
        end
    end 

end 

end 



function modifier_voice_module:DamageEvent_inc(params)
if not IsServer() then return end 
if GameRules:GetDOTATime(false, false) - self.cd_time < self.current_cd then return end
if params.unit ~= self.parent then return end
if not IsValid(params.attacker) or not params.attacker:IsHero() then return end 
if params.attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return end 
if self.parent:HasModifier("modifier_voice_module_damage_cd") then return end

local sounds = {}
local string_table = self:GetDamageVoice()

for _,data in pairs(string_table) do 
    for i = data[2],data[3] do 
        table.insert(sounds, data[1]..self:GetNumber(i))
    end 
end 

if #sounds > 0 then 
    if self:MakeSound(sounds[RandomInt(1, #sounds)], true) == true then 
        self.parent:AddNewModifier(self.parent, nil, "modifier_voice_module_damage_cd", {duration = self.damage_cd})
    end 
end

end 



function modifier_voice_module:SpellEvent(params)
if not IsServer() then return end 
if not params.ability then return end
if params.unit ~= self:GetCaster() then return end

local ability = params.ability
local sounds = {}
local priority = false
local for_player = false
local string_table = {}
local ability_name = ability:GetName()

if self.unit_name == "npc_dota_hero_juggernaut" then 

    if ability_name == "custom_juggernaut_blade_fury" then

        priority = true
        if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
            string_table = 
            {
                {"juggernaut_custom_jug_arc_ability_bladefury_", 2, 3},
                {"juggernaut_custom_jug_arc_ability_bladefury_", 5, 9},
            }
        else 
            string_table = 
            {
                {"juggernaut_custom_jug_ability_bladefury_", 2, 3},
                {"juggernaut_custom_jug_ability_bladefury_", 5, 5},
                {"juggernaut_custom_jugg_ability_bladefury_", 10, 18},
            }
        end 
    end 

     if ability_name == "custom_juggernaut_whirling_blade_custom" then 

        if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then

            string_table = 
            {
                {"juggernaut_custom_jugsc_arc_ability_bladefury_", 6, 8},
            }
        else 

            string_table = 
            {
                {"juggernaut_custom_jug_ability_bladefury_", 6, 8},
            }
        end 
    end 

    if ability:GetName() == "custom_juggernaut_omnislash" then 
        for_player = true
        priority = true
        if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
            string_table = 
            {
                {"juggernaut_custom_jug_arc_ability_omnislash_", 1, 3},
            }
        else 

            string_table = 
            {
                {"juggernaut_custom_jug_ability_omnislash_", 1, 3},
            }
        end 
    end
end 


if self.unit_name == "npc_dota_hero_phantom_assassin" then 

    if self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then
        for_player = true    

        if ability_name == "custom_phantom_assassin_stifling_dagger" then 
            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_dagger_", 1, 15},
            }
        end 
        if ability_name == "custom_phantom_assassin_phantom_strike" then 

            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_strike_", 1, 11},
            }
        end 
        if ability_name == "custom_phantom_assassin_blur" then 

            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_blur_", 1, 11},
            }
        end 
        if ability_name == "custom_phantom_assassin_fan_of_knives" then 

            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_fan_of_knives_", 1, 10},
            }
        end 
    end 
end 



if self.unit_name == "npc_dota_hero_legion_commander" then 

    if ability_name == "custom_legion_commander_overwhelming_odds" then
        for_player = true 

        if self:IsLcArcana() then
            string_table = 
            {
                {"legion_commander_custom_legcom_dem_overwhelmingodds_", 2, 4},
            }
        elseif self.persona[self.model_name] then
            string_table = 
            {
                {"legion_commander_auto_custom_legcom_overwhelmingodds_", 2, 4},
            }
        else
            string_table = 
            {
                {"legion_commander_custom_legcom_overwhelmingodds_", 2, 4},
            }
        end 
    end 

    if ability_name == "custom_legion_commander_press_the_attack" then
        for_player = true 

        if self:IsLcArcana() then
            string_table = 
            {
                {"legion_commander_custom_legcom_dem_presstheattack_", 3, 6},
            }
        elseif self.persona[self.model_name] then
            string_table = 
            {
                {"legion_commander_auto_custom_legcom_presstheattack_", 3, 6},
            }
        else
            string_table = 
            {
                {"legion_commander_custom_legcom_presstheattack_", 3, 6},
            }
        end 
    end 


    if ability_name == "custom_legion_commander_duel" then

        if self:IsLcArcana() then
            string_table = 
            {
                {"legion_commander_custom_legcom_dem_duel_", 1, 9},
            }
        elseif self.persona[self.model_name] then
            string_table = 
            {
                {"legion_commander_auto_custom_legcom_duel_", 1, 9},
            }
        else 
            string_table = 
            {
                {"legion_commander_custom_legcom_duel_", 1, 9},
            }
        end 
    end 
end 


if self.unit_name == "npc_dota_hero_nevermore" then 

    if ability_name == "custom_nevermore_requiem" then
        priority = true
        if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
        
            string_table = 
            {
                {"nevermore_custom_nev_arc_ability_requiem_", 1, 8},
                {"nevermore_custom_nev_arc_ability_requiem_", 11, 14},
            }
        else 
            string_table = 
            {
                {"nevermore_custom_nev_ability_requiem_", 1, 8},
                {"nevermore_custom_nev_ability_requiem_", 11, 14},
            }
        end 
    end
end 




if self.unit_name == "npc_dota_hero_razor" then 


    if ability_name == "razor_plasma_field_custom" then
        priority = true
        if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
        
            string_table = 
            {
                {"razor_rz_custom_vsa_ability_plasma_", 1, 4},
                {"razor_rz_custom_vsa_ability_plasma_", 7, 11},
            }
        else 
            string_table = 
            {
                {"razor_raz_custom_ability_plasma_", 1, 9}
            }
        end 
    end

    if ability_name == "razor_static_link_custom" then
        for_player = true
        if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then

            string_table = 
            {
                {"razor_rz_custom_vsa_ability_static_", 1, 12},
            }
        else 
            string_table = 
            {
                {"razor_raz_custom_ability_static_", 1, 5}
            }
        end 
    end

    if ability_name == "razor_eye_of_the_storm_custom" then
        for_player = true
        if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then

            string_table = 
            {
                {"razor_rz_custom_vsa_ability_storm_", 1, 10},
            }
        else 
            string_table = 
            {
                {"razor_raz_custom_ability_storm_", 1, 6}
            }
        end 
    end
end 



if self.unit_name == "npc_dota_hero_skeleton_king" then 


    if ability_name == "skeleton_king_hellfire_blast_custom" then
        priority = true
        if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
        
            string_table = 
            {
                {"skeleton_king_custom_skel_arc_ability_hellfire_", 1, 7},
            }
        else 
            string_table = 
            {
                {"skeleton_king_custom_wraith_ability_hellfire_", 1, 7}
            }
        end 
    end

    if ability_name == "skeleton_king_vampiric_aura_custom" then
        priority = true
        if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then

            string_table = 
            {
                {"skeleton_king_custom_skel_arc_ability_mortalstrike_", 7, 12},
                {"skeleton_king_custom_skel_arc_ability_mortalstrike_", 18, 21},
            }

        end 
    end

end 

if self.unit_name == "npc_dota_hero_monkey_king" then 


    if ability_name == "monkey_king_boundless_strike_custom" and not self.parent:HasTalent("modifier_monkey_king_boundless_7") then
        priority = true
        if self:IsMkArcana() then
        
            string_table = 
            {
                {"monkey_king_custom_monkey_crown_ability2_", 1, 3},
                {"monkey_king_custom_monkey_crown_ability2_", 6, 10},
                {"monkey_king_custom_monkey_crown_attack_big_", 1, 4},
            }
        else 
            string_table = 
            {
                {"monkey_king_custom_monkey_ability2_", 1, 3},
                {"monkey_king_custom_monkey_ability2_", 6, 10},
                {"monkey_king_custom_monkey_attack_big_", 1, 4},
            }
        end 
    end

    if ability_name == "monkey_king_tree_dance_custom" then
       for_player = true
       if self:IsMkArcana() then

            string_table = 
            {
                {"monkey_king_custom_monkey_crown_ability1_", 1, 6},
                {"monkey_king_custom_monkey_crown_ability1_", 8, 12},
                {"monkey_king_custom_monkey_crown_ability1_", 16, 16},
            }

        else 
            string_table = 
            {
                {"monkey_king_custom_monkey_ability1_", 1, 6},
                {"monkey_king_custom_monkey_ability1_", 8, 12},
                {"monkey_king_custom_monkey_ability1_", 16, 16},
            }

        end 
    end

    if ability_name == "monkey_king_primal_spring_custom" then
       for_player = true
       if self:IsMkArcana() then

            string_table = 
            {
                {"monkey_king_custom_monkey_crown_ability1_", 7, 7},
                {"monkey_king_custom_monkey_crown_ability3_", 1, 1},
                {"monkey_king_custom_monkey_crown_ability3_", 5, 5},
                {"monkey_king_custom_monkey_crown_ability5_", 1, 1},
            }

        else 
            string_table = 
            {
                {"monkey_king_custom_monkey_ability1_", 7, 7},
                {"monkey_king_custom_monkey_ability3_", 1, 1},
                {"monkey_king_custom_monkey_ability3_", 5, 5},
                {"monkey_king_custom_monkey_ability5_", 1, 1},
            }

        end 
    end

    if ability_name == "monkey_king_wukongs_command_custom" then
        priority = true
       if self:IsMkArcana() then

            string_table = 
            {
                {"monkey_king_custom_monkey_crown_ability5_", 5, 5},
                {"monkey_king_custom_monkey_crown_ability5_", 8, 8},
                {"monkey_king_custom_monkey_crown_ability2_", 4, 4},
                {"monkey_king_custom_monkey_crown_bottle_", 6, 6}
            }

        else 
            string_table = 
            {
                {"monkey_king_custom_monkey_ability5_", 5, 5},
                {"monkey_king_custom_monkey_ability5_", 8, 8},
                {"monkey_king_custom_monkey_ability2_", 4, 4},
                {"monkey_king_custom_monkey_bottle_", 6, 6}
            }

        end 
    end
end 


if self.unit_name == "npc_dota_hero_pudge" then 

    if ability_name == "custom_pudge_dismember" then
        priority = true
        if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then

            string_table = 
            {
                {"pudge_custom_pud_arc_ability_devour_", 2, 4},
                {"pudge_custom_pud_arc_ability_devour_", 11, 13},
                {"pudge_custom_pud_arc_ability_devour_", 15, 18},
                {"pudge_custom_pud_arc_ability_devour_", 22, 22},
            }
        elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

            string_table = 
            {
                {"pudge_custom_toy_pug_ability_devour_", 1, 3},
                {"pudge_custom_toy_pug_ability_devour_", 6, 11},
                {"pudge_custom_toy_pug_ability_devour_", 13, 15},
                {"pudge_custom_toy_pug_ability_devour_", 22, 23},
            }
        else
            string_table = 
            {
                {"pudge_custom_pud_ability_devour_", 2, 4},
                {"pudge_custom_pud_ability_devour_", 7, 7},
                {"pudge_custom_pud_ability_devour_", 12, 12},
                {"pudge_custom_pud_ability_devour_", 15, 16},
            }
        end 
    end
end 

if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if ability_name == "drow_ranger_wave_of_silence_custom" then
        priority = true
        if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
            string_table = 
            {
                {"drowranger_custom_drow_arc_gust_", 1, 15},
            }
        elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
            string_table = 
            {
                {"drowranger_custom_dro_ability_", 1, 7},
            }
        end 
    end

    if ability_name == "drow_ranger_multishot_custom" then
        if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
            string_table = 
            {
                {"drowranger_custom_drow_arc_multishot_", 1, 14},
            }
        end 
    end
end 

if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if ability_name == "skywrath_mage_mystic_flare_custom" then
        priority = true
        if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
        
            string_table = 
            {
                {"skywrath_mage_custom_drag_mystic_flare_", 1, 5},
            }
        elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_mystic_flare_", 1, 13},
            }
        end 
    end

    if ability_name == "skywrath_mage_ancient_seal_custom" then
        priority = true
        for_player = true
        if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
        
            string_table = 
            {
                {"skywrath_mage_custom_drag_ancient_seal_", 1, 3},
            }
        elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_ancient_seal_", 1, 12},
            }
        end 
    end

    if ability_name == "skywrath_mage_concussive_shot_custom" then
        priority = true
        for_player = true
        if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
        
            string_table = 
            {
                {"skywrath_mage_custom_drag_concussive_shot_", 1, 3},
            }
        elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_concussive_shot_", 1, 10},
            }
        end 
    end

    if ability_name == "skywrath_mage_arcane_bolt_custom" then
        for_player = true
        if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
            string_table = 
            {
                {"skywrath_mage_custom_drag_arcanebolt_", 1, 3},
                {"skywrath_mage_custom_drag_arcanebolt_", 6, 6},
            }
        elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_arcanebolt_", 1, 12},
            }
        end 
    end
end 

if self.unit_name == "npc_dota_hero_antimage" then 
    if ability_name == "antimage_mana_void_custom" then
        priority = true
        if self.persona[self.model_name] then
            string_table = 
            {
                {"antimage_custom_amp_wei_ability2_", 1, 2},
                {"antimage_custom_amp_wei_ability2_", 4, 12},
            }
        end 
    end
end 


if self.unit_name == "npc_dota_hero_axe" then 

    if ability_name == "axe_battle_hunger_custom" then
        priority = true
        if self.model_name == "models/heroes/axe/axe.vmdl" then
        
            string_table = 
            {
                {"axe_axe_custom_ability_battlehunger_", 1, 3},
            }
        elseif self.arcana[self.model_name] then
            string_table = 
            {
                {"axe_jung_custom_axe_ability_battlehunger_", 1, 6},
            }
        elseif self.persona[self.model_name] then
            string_table = 
            {
                {"axe_auto_custom_axe_ability_battlehunger_", 1, 3},
            }
        end
    end

    if ability_name == "axe_berserkers_call_custom" then
        priority = true
        if self.model_name == "models/heroes/axe/axe.vmdl" then
        
            string_table = 
            {
                {"axe_axe_custom_ability_berserk_", 1, 9},
            }
        elseif self.arcana[self.model_name] then
            string_table = 
            {
                {"axe_jung_custom_axe_ability_berserk_", 1, 13},
            }
        elseif self.persona[self.model_name] then
            string_table = 
            {
                {"axe_auto_custom_axe_ability_berserk_", 1, 9},
            }
        end
    end
end


if self.unit_name == "npc_dota_hero_ogre_magi" then 

    if ability_name == "ogre_magi_fireblast_custom" or ability_name == "ogre_magi_unrefined_fireblast_custom" then
        priority = true
        if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
        
            string_table = 
            {
                {"ogre_magi_custom_ogmag_ability_firebl_", 1, 6},
            }
        elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
            string_table = 
            {
                {"ogre_magi_custom_ogm_arc_ability_firebl_", 1, 9},
            }
        end 
    end

    if ability_name == "ogre_magi_ignite_custom" then
        priority = true
        if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
        
            string_table = 
            {
                {"ogre_magi_custom_ogmag_ability_ignite_", 1, 3},
            }
        elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
            string_table = 
            {
                {"ogre_magi_custom_ogm_arc_ability_ignite_", 1, 4},
                {"ogre_magi_custom_ogm_arc_ability_ignite_05_", 2, 2},
                {"ogre_magi_custom_ogm_arc_ability_ignite_", 6, 7},
            }
        end 
    end

    if ability_name == "ogre_magi_bloodlust_custom" then
        for_player = true
        if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
        
            string_table = 
            {
                {"ogre_magi_custom_ogmag_ability_bloodlust_", 1, 4},
            }
        elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
            string_table = 
            {
                {"ogre_magi_custom_ogm_arc_ability_bloodlust_", 1, 2},
                {"ogre_magi_custom_ogm_arc_ability_bloodlust_02_", 2, 2},
                {"ogre_magi_custom_ogm_arc_ability_bloodlust_", 4, 7},
            }
        end 
    end
    if ability_name == "ogre_magi_bloodlust_custom_charge" then
        priority = true
        if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
        
            string_table = 
            {
                {"ogre_magi_custom_ogmag_attack_", 8, 8},
                {"ogre_magi_custom_ogmag_attack_", 1, 2},
                {"ogre_magi_custom_ogmag_cast_", 3, 3},
            }
        elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
            string_table = 
            {
                {"ogre_magi_custom_ogm_arc_attack_", 8, 8},
                {"ogre_magi_custom_ogm_arc_attack_", 1, 2},
                {"ogre_magi_custom_ogm_arc_cast_", 3, 3},
            }
        end 
    end
end


if self.unit_name == "npc_dota_hero_invoker" then 

    if ability_name == "invoker_alacrity_custom" then
        for_player = true
        priority = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_alacrity_", 1, 5},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_alacrity_", 1, 5},
                {"invoker_custom_kidvoker_ability_alacrity_06_", 2, 2},
                {"invoker_custom_kidvoker_ability_alacrity_", 7, 8},
            }
        end 
    end

    if ability_name == "invoker_emp_custom" then
        priority = true
        for_player = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_emp_", 1, 7},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_emp_", 1, 10},
            }
        end 
    end

    if ability_name == "invoker_tornado_custom" then
        priority = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_tornado_", 1, 5},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_tornado_", 1, 8},
            }
        end 
    end

    if ability_name == "invoker_cold_snap_custom" then
        priority = true
        for_player = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_coldsnap_", 1, 5},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_coldsnap_", 1, 5},
                {"invoker_custom_kidvoker_ability_coldsnap_", 8, 8},
            }
        end 
    end

    if ability_name == "invoker_ghost_walk_custom" then
        for_player = true
        priority = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_ghostwalk_", 1, 5},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_ghostwalk_", 1, 5},
                {"invoker_custom_kidvoker_ability_ghostwalk_", 8, 8},
            }
        end 
    end

    if ability_name == "invoker_ice_wall_custom" then
        priority = true
        for_player = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_icewall_", 1, 5},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_icewall_", 1, 6},
                {"invoker_custom_kidvoker_ability_icewall_", 8, 8},
            }
        end 
    end

    if ability_name == "invoker_sun_strike_custom" then
        for_player = true
        priority = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_sunstrike_", 1, 5},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_sunstrike_", 1, 7},
                {"invoker_custom_kidvoker_ability_sunstrike_", 9, 9},
            }
        end 
    end

    if ability_name == "invoker_chaos_meteor_custom" then
        priority = true
        for_player = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_chaosmeteor_", 1, 7},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_chaosmeteor_", 1, 7},
                {"invoker_custom_kidvoker_ability_chaosmeteor_", 10, 10},
            }
        end 
    end

    if ability_name == "invoker_forge_spirit_custom" then
        for_player = true
        priority = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_forgespirit_", 1, 6},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_forgespirit_", 1, 9},
            }
        end 
    end

    if ability_name == "invoker_deafening_blast_custom" then
        priority = true
        if self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_ability_deafeningblast_", 1, 6},
            }
        elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

            string_table = 
            {
                {"invoker_custom_kidvoker_ability_deafeningblast_", 1, 6},
                {"invoker_custom_kidvoker_ability_deafeningblast_", 8, 11},
            }
        end 
    end
end


if self.unit_name == "npc_dota_hero_crystal_maiden" then
    priority = true

    if ability_name == "crystal_maiden_frostbite_custom" then
        if  self.persona[self.model_name] then
            string_table = 
            {
                {"crystalmaiden_custom_cm_wolf_frostbite_", 1, 2},
                {"crystalmaiden_custom_cm_wolf_frostbite_", 4, 8},
                {"crystalmaiden_custom_cm_wolf_frostbite_", 10, 10},
            }
        end
    end
    if ability_name == "crystal_maiden_crystal_nova_custom" then
        if  self.persona[self.model_name] then
            string_table = 
            {
                {"crystalmaiden_custom_cm_wolf_nova_", 1, 8},
            }
        end
    end
    if ability_name == "crystal_maiden_freezing_field_custom" then
        for_player = true
        if  self.persona[self.model_name] then
            string_table = 
            {
                {"crystalmaiden_custom_cm_wolf_freezing_field_", 1, 8},
            }
        end
    end
end
    



if self.unit_name == "npc_dota_hero_terrorblade" then


    if ability_name == "custom_terrorblade_conjure_image" then
        for_player = true
        if self.normal[self.model_name] then
            string_table = 
            {
                {"terrorblade_terr_custom_conjureimage_", 1, 3},
            }
        elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
            string_table = 
            {
                {"terrorblade_terr_custom_morph_conjureimage_", 1, 3},
            }
        end
    end

    if ability_name == "custom_terrorblade_reflection" and not ability:GetAutoCastState() then
        for_player = true
        priority = true
        if self.normal[self.model_name] then
            string_table = 
            {
                {"terrorblade_terr_custom_reflection_", 1, 7},
            }
        elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
            string_table = 
            {
                {"terrorblade_terr_custom_morph_reflection_", 1, 7},
            }
        end
    end

    if ability_name == "custom_terrorblade_metamorphosis" or ability_name == "terrorblade_demon_zeal_custom" then
        priority = true
        for_player = true
        if self.normal[self.model_name] then
            string_table = 
            {
                {"terrorblade_terr_custom_morph_metamorphosis_", 1, 9},
            }
        elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
            string_table = 
            {
                {"terrorblade_terr_custom_morph_metamorphosis_", 1, 9},
            }
        end
    end

    if ability_name == "custom_terrorblade_sunder" then
        priority = true
        if self.normal[self.model_name] then
            string_table = 
            {
                {"terrorblade_terr_custom_sunder_", 1, 11},
            }
        elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
            string_table = 
            {
                {"terrorblade_terr_custom_morph_sunder_", 1, 11},
            }
        end
    end
end


if self.unit_name == "npc_dota_hero_bristleback" then
    priority = true
    if ability_name == "bristleback_viscous_nasal_goo_custom" and RollPercentage(50) then
        if self.persona[self.model_name] then
            string_table = 
            {
                {"bristleback_auto_bristle_custom_nasal_goo_", 1, 7},
            }
        else
            string_table = 
            {
                {"bristleback_bristle_custom_nasal_goo_", 1, 7},
            }
        end
    end
end
    

for _,data in pairs(string_table) do 
    for i = data[2],data[3] do 
        table.insert(sounds, data[1]..self:GetNumber(i))
    end 
end 


if #sounds > 0 then 
    self:MakeSound(sounds[RandomInt(1, #sounds)], for_player, 0, -1, priority)
end 

end 





function modifier_voice_module:LevelEvent()
if not IsServer() then return end 

local sounds = {}
local string_table = {}
local timer = 1

if self.unit_name == "npc_dota_hero_juggernaut" then 

    if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
    
        string_table = 
        {
            {"juggernaut_custom_jug_arc_level_", 2, 9},
        }
    else 

        string_table = 
        {
            {"juggernaut_custom_jug_level_", 2, 6},
        }
    end 
end 


if self.unit_name == "npc_dota_hero_phantom_assassin" then 

    if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then
    
        string_table = 
        {
            {"phantom_assassin_custom_phass_arc_level_", 1, 8},
        }
    elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 

        string_table = 
        {
            {"phantom_assassin_custom_pa_asan_levelup_", 1, 21},
        }

    else 
        string_table = 
        {
            {"phantom_assassin_custom_phass_level_", 1, 8},
        }
    end 
end 

if self.unit_name == "npc_dota_hero_legion_commander" then 

    if self:IsLcArcana() then
    
        string_table = 
        {
            {"legion_commander_custom_legcom_dem_levelup_", 1, 5},
            {"legion_commander_custom_legcom_dem_levelup_", 7, 14},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"legion_commander_auto_custom_legcom_levelup_", 1, 5},
            {"legion_commander_auto_custom_legcom_levelup_", 7, 14},
        }
    else 
        string_table = 
        {
            {"legion_commander_custom_legcom_levelup_", 1, 5},
            {"legion_commander_custom_legcom_levelup_", 7, 14},
        }
    end 
end 

if self.unit_name == "npc_dota_hero_nevermore" then 

    if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
    
        string_table = 
        {
            {"nevermore_custom_nev_arc_level_", 1, 10},
        }
    else 
        string_table = 
        {
            {"nevermore_custom_nev_level_", 1, 10},
        }
    end 

end 



if self.unit_name == "npc_dota_hero_razor" then 

    if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
    
        string_table = 
        {
            {"razor_rz_custom_vsa_level_", 1, 10},
        }
    else 
        string_table = 
        {
            {"razor_raz_custom_level_", 1, 10}
        }
    end 
end 


if self.unit_name == "npc_dota_hero_queenofpain" then 

    if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
    
        string_table = 
        {
            {"queenofpain_custom_qop_arc_levelup_", 1, 24},
        }
    else 
        string_table = 
        {
            {"queenofpain_custom_pain_levelup_", 1, 11},
        }
    end 
end 

if self.unit_name == "npc_dota_hero_skeleton_king" then 

    if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
    
        string_table = 
        {
            {"skeleton_king_custom_skel_arc_level_", 1, 17},
            {"skeleton_king_custom_skel_arc_level_", 19, 20},
            {"skeleton_king_custom_skel_arc_level_", 22, 22},
        }
    else 
        string_table = 
        {
            {"skeleton_king_custom_wraith_level_", 1, 14},
        }
    end 

end 

if self.unit_name == "npc_dota_hero_monkey_king" then 

    if self:IsMkArcana() then
        string_table = 
        {
            {"monkey_king_custom_monkey_crown_levelup_", 1, 10},
        }
    else 
        string_table = 
        {
            {"monkey_king_custom_monkey_levelup_", 1, 10},
        }
        
    end 
end 

if self.unit_name == "npc_dota_hero_zuus" then 

    if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then

        string_table = 
        {
            {"zuus_custom_zuus_arc_level_", 1, 6},
        }
    else 
        string_table = 
        {
            {"zuus_custom_zuus_level_", 1, 6},
        }
    end 
end 

if self.unit_name == "npc_dota_hero_pudge" then 

    if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then

        string_table = 
        {
            {"pudge_custom_pud_arc_level_", 1, 15},
        }
    elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

        string_table = 
        {
            {"pudge_custom_toy_pug_level_", 1, 11},
            {"pudge_custom_toy_pug_level_", 13, 16},
            {"pudge_custom_toy_pug_level_12_", 2, 2},
        }
    else
        string_table = 
        {
            {"pudge_custom_pud_level_", 1, 11},
        }
    end 
end 


if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
        string_table = 
        {
            {"drowranger_custom_drow_arc_levelup_", 1, 20},
        }
    elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
        string_table = 
        {
            {"drowranger_custom_drow_levelup_", 1, 8},
        }
    end 
end 

if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
    
        string_table = 
        {
            {"skywrath_mage_custom_drag_levelup_", 1, 10},
        }
    elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
        string_table = 
        {
            {"skywrath_mage_custom_skywrath_crown_levelup_", 1, 19},
        }
    end 
end 

if self.unit_name == "npc_dota_hero_antimage" then 
    if self.normal[self.model_name] then
        string_table = 
        {
            {"antimage_custom_anti_level_", 1, 5},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"antimage_custom_amp_wei_levelup_", 1, 15},
        }
    end 
end 


if self.unit_name == "npc_dota_hero_axe" then 
    if self.model_name == "models/heroes/axe/axe.vmdl" then
    
        string_table = 
        {
            {"axe_axe_custom_level_", 1, 11},
        }
    elseif self.arcana[self.model_name] then
        string_table = 
        {
            {"axe_jung_custom_axe_level_", 1, 13},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"axe_auto_custom_axe_level_", 1, 11},
        }
    end
end 

if self.unit_name == "npc_dota_hero_ogre_magi" then 
    if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
    
        string_table = 
        {
            {"ogre_magi_custom_ogmag_level_", 1, 7},
        }
    elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
        string_table = 
        {
            {"ogre_magi_custom_ogm_arc_level_", 1, 7},
            {"ogre_magi_custom_ogm_arc_level_08_", 2, 2},
            {"ogre_magi_custom_ogm_arc_level_", 9, 12},
        }
    end 
end 


if self.unit_name == "npc_dota_hero_invoker" then 
    if self.model_name == "models/heroes/invoker/invoker.vmdl" then
    
        string_table = 
        {
            {"invoker_custom_invo_level_", 1, 14},
        }
    elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

        string_table = 
        {
            {"invoker_custom_kidvoker_level_", 1, 14},
        }
    end 
end

if self.unit_name == "npc_dota_hero_crystal_maiden" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_levelup_", 1, 7},
        }

    elseif self.persona[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_wolf_levelup_", 1, 15},
        }
    end
end

if self.unit_name == "npc_dota_hero_terrorblade" then
    if self.normal[self.model_name] then
        string_table = 
        {
            {"terrorblade_terr_custom_levelup_", 1, 11},
        }
    elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
        string_table = 
        {
            {"terrorblade_terr_custom_morph_levelup_", 1, 11},
        }
    end
end

if self.unit_name == "npc_dota_hero_morphling" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"morphling_auto_mrph_custom_level_", 1, 12},
        }
    else
        string_table = 
        {
            {"morphling_mrph_custom_level_", 1, 12},
        }
    end
end

if self.unit_name == "npc_dota_hero_bristleback" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"bristleback_auto_bristle_custom_levelup_", 1, 7},
        }
    else
        string_table = 
        {
            {"bristleback_bristle_custom_levelup_", 1, 7},
        }
    end
end

for _,data in pairs(string_table) do 
    for i = data[2],data[3] do 
        table.insert(sounds, data[1]..self:GetNumber(i))
    end 
end 

if #sounds > 0 then 
    self:MakeSound(sounds[RandomInt(1, #sounds)], true, timer)
end 

end 





function modifier_voice_module:BountyEvent()
if not IsServer() then return end 

local sounds = {}

if self.unit_name == "npc_dota_hero_juggernaut" then 
    if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then

        table.insert(sounds, "juggernaut_custom_jug_arc_bounty_01")
        table.insert(sounds, "juggernaut_custom_jug_arc_bounty_04")
        table.insert(sounds, "juggernaut_custom_jug_arc_lasthit_05")
    else 
        table.insert(sounds, "juggernaut_custom_jug_lasthit_05")
    end 
end 

if self.unit_name == "npc_dota_hero_phantom_assassin" then 
    if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then

        table.insert(sounds, "phantom_assassin_custom_phass_arc_purch_01")
    elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 

        table.insert(sounds, "phantom_assassin_custom_pa_asan_bounty_01")
        table.insert(sounds, "phantom_assassin_custom_pa_asan_bounty_01_02")
        table.insert(sounds, "phantom_assassin_custom_pa_asan_bounty_02")
    else 
        table.insert(sounds, "phantom_assassin_custom_phass_purch_01")
    end 
end 


if self.unit_name == "npc_dota_hero_legion_commander" then 

    if self:IsLcArcana() then
    
        table.insert(sounds, "legion_commander_custom_legcom_dem_itemcommon_01")
        table.insert(sounds, "legion_commander_custom_legcom_dem_itemcommon_02")
    elseif self.persona[self.model_name] then
        table.insert(sounds, "legion_commander_auto_custom_legcom_itemcommon_01")
        table.insert(sounds, "legion_commander_auto_custom_legcom_itemcommon_02")
    else  
        table.insert(sounds, "legion_commander_custom_legcom_itemcommon_01")
        table.insert(sounds, "legion_commander_custom_legcom_itemcommon_02")
    end 

end 

if self.unit_name == "npc_dota_hero_nevermore" then 

    if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
    
        table.insert(sounds, "nevermore_custom_nev_arc_lasthit_03")
    else 
        table.insert(sounds, "nevermore_custom_nev_lasthit_03")
    end 

end 



if self.unit_name == "npc_dota_hero_razor" then 

    if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
    
        table.insert(sounds, "razor_rz_custom_vsa_bounty_01")
        table.insert(sounds, "razor_rz_custom_vsa_bounty_01_02")
        table.insert(sounds, "razor_rz_custom_vsa_bounty_02")
        table.insert(sounds, "razor_rz_custom_vsa_bounty_03")
    else 
        table.insert(sounds, "razor_raz_custom_lasthit_07")
        table.insert(sounds, "razor_raz_custom_lasthit_01")
    end 

end 

if self.unit_name == "npc_dota_hero_queenofpain" then 

    if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
    
        table.insert(sounds, "queenofpain_custom_qop_arc_lasthit_03")
        table.insert(sounds, "queenofpain_custom_qop_arc_lasthit_06")
        table.insert(sounds, "queenofpain_custom_qop_arc_lasthit_08")
    else 
        table.insert(sounds, "queenofpain_custom_pain_lasthit_03")
        table.insert(sounds, "queenofpain_custom_pain_lasthit_06")
    end 

end 


if self.unit_name == "npc_dota_hero_skeleton_king" then 

    if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
    
        table.insert(sounds, "skeleton_king_custom_skel_arc_bounty_01")
        table.insert(sounds, "skeleton_king_custom_skel_arc_bounty_01_02")
        table.insert(sounds, "skeleton_king_custom_skel_arc_bounty_02")
    else 
        table.insert(sounds, "skeleton_king_custom_wraith_lasthit_04")
        table.insert(sounds, "skeleton_king_custom_wraith_lasthit_07")
        table.insert(sounds, "skeleton_king_custom_wraith_lasthit_05")
    end 

end 

if self.unit_name == "npc_dota_hero_monkey_king" then 

    if self:IsMkArcana() then
        table.insert(sounds, "monkey_king_custom_monkey_crown_bounty_01")
        table.insert(sounds, "monkey_king_custom_monkey_crown_bounty_02")
        table.insert(sounds, "monkey_king_custom_monkey_crown_bounty_03")
    else 
        table.insert(sounds, "monkey_king_custom_monkey_bounty_01")
        table.insert(sounds, "monkey_king_custom_monkey_bounty_02")
        table.insert(sounds, "monkey_king_custom_monkey_bounty_03")
    end 
end 


if self.unit_name == "npc_dota_hero_zuus" then 

    if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then

        table.insert(sounds, "zuus_custom_zeus_arc_bounty_01_05")
        table.insert(sounds, "zuus_custom_zeus_arc_bounty_02_03")
        table.insert(sounds, "zuus_custom_zeus_arc_bounty_03_03")
        table.insert(sounds, "zuus_custom_zeus_arc_bounty_04_02")
    else 
        table.insert(sounds, "zuus_custom_zeus_bounty_01_05")
        table.insert(sounds, "zuus_custom_zeus_bounty_02_03")
        table.insert(sounds, "zuus_custom_zeus_bounty_03_03")
        table.insert(sounds, "zuus_custom_zeus_bounty_04_02")
    end 
end 

if self.unit_name == "npc_dota_hero_pudge" then 

    if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then

        table.insert(sounds, "pudge_custom_pud_arc_bounty_01")
        table.insert(sounds, "pudge_custom_pud_arc_bounty_02")
    elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

        table.insert(sounds, "pudge_custom_toy_pug_bounty_01")
        table.insert(sounds, "pudge_custom_toy_pug_bounty_01_02")
        table.insert(sounds, "pudge_custom_toy_pug_bounty_02")
        table.insert(sounds, "pudge_custom_toy_pug_bounty_03")
        table.insert(sounds, "pudge_custom_toy_pug_bounty_04")
    else
        table.insert(sounds, "pudge_custom_pud_lasthit_06")
        table.insert(sounds, "pudge_custom_pud_lasthit_08")
    end 
end 


if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then

        table.insert(sounds, "drowranger_custom_drow_arc_bounty_01")
        table.insert(sounds, "drowranger_custom_drow_arc_bounty_01_02")
        table.insert(sounds, "drowranger_custom_drow_arc_bounty_02")
        table.insert(sounds, "drowranger_custom_drow_arc_bounty_03")

    elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
        table.insert(sounds, "drowranger_custom_dro_lasthit_02")
        table.insert(sounds, "drowranger_custom_drow_lasthit_09")
        table.insert(sounds, "drowranger_custom_dro_lasthit_03")
    end 
end 


if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then

        table.insert(sounds, "skywrath_mage_custom_drag_lasthit_05")
        table.insert(sounds, "skywrath_mage_custom_drag_lasthit_11")
        table.insert(sounds, "skywrath_mage_custom_drag_lasthit_10")

    elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then

        table.insert(sounds, "skywrath_mage_custom_skywrath_crown_bounty_01")
        table.insert(sounds, "skywrath_mage_custom_skywrath_crown_bounty_02")
        table.insert(sounds, "skywrath_mage_custom_skywrath_crown_bounty_03")
        table.insert(sounds, "skywrath_mage_custom_skywrath_crown_bounty_04")
        table.insert(sounds, "skywrath_mage_custom_skywrath_crown_bounty_04_02")
    end 
end 


if self.unit_name == "npc_dota_hero_antimage" then 
    if self.normal[self.model_name] then
        table.insert(sounds, "antimage_custom_anti_deny_09")
        table.insert(sounds, "antimage_custom_anti_lasthit_03")
        table.insert(sounds, "antimage_custom_anti_lasthit_10")
    elseif self.persona[self.model_name] then

        table.insert(sounds, "antimage_custom_amp_wei_bounty_01")
        table.insert(sounds, "antimage_custom_amp_wei_bounty_02")
        table.insert(sounds, "antimage_custom_amp_wei_bounty_03")
    end 
end 



if self.unit_name == "npc_dota_hero_axe" then 
    if self.model_name == "models/heroes/axe/axe.vmdl" then
    
        table.insert(sounds, "axe_axe_custom_lasthit_05")
        table.insert(sounds, "axe_axe_custom_lasthit_06")
        table.insert(sounds, "axe_axe_custom_lasthit_02")

    elseif self.arcana[self.model_name] then

        table.insert(sounds, "axe_jung_custom_axe_bounty_01")
        table.insert(sounds, "axe_jung_custom_axe_bounty_02")
    elseif self.persona[self.model_name] then

        table.insert(sounds, "axe_auto_custom_axe_lasthit_05")
        table.insert(sounds, "axe_auto_custom_axe_lasthit_06")
        table.insert(sounds, "axe_auto_custom_axe_lasthit_02")
    end
end 


if self.unit_name == "npc_dota_hero_ogre_magi" then 
    if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
    
        table.insert(sounds, "ogre_magi_custom_ogmag_lasthit_01")
        table.insert(sounds, "ogre_magi_custom_ogmag_lasthit_06")
        table.insert(sounds, "ogre_magi_custom_ogmag_lasthit_03")

    elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
 
        table.insert(sounds, "ogre_magi_custom_ogm_arc_bounty_01")
        table.insert(sounds, "ogre_magi_custom_ogm_arc_bounty_02")
        table.insert(sounds, "ogre_magi_custom_ogm_arc_bounty_02_02")
    end 
end 

if self.unit_name == "npc_dota_hero_invoker" then 
    if self.model_name == "models/heroes/invoker/invoker.vmdl" then
    
        table.insert(sounds, "invoker_custom_invo_lasthit_04")
        table.insert(sounds, "invoker_custom_invo_lasthit_06")
        table.insert(sounds, "invoker_custom_invo_lasthit_07")

    elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

        table.insert(sounds, "invoker_custom_kidvoker_bounty_01")
        table.insert(sounds, "invoker_custom_kidvoker_bounty_02")
        table.insert(sounds, "invoker_custom_kidvoker_bounty_03")
        table.insert(sounds, "invoker_custom_kidvoker_bounty_04")
    end 
end

if self.unit_name == "npc_dota_hero_crystal_maiden" then
    if self.normal[self.model_name] then

        table.insert(sounds, "crystalmaiden_custom_cm_lasthit_01")
        table.insert(sounds, "crystalmaiden_custom_cm_lasthit_05")
        table.insert(sounds, "crystalmaiden_custom_cm_lasthit_03")

    elseif self.persona[self.model_name] then

        table.insert(sounds, "crystalmaiden_custom_cm_wolf_bounty_01")
        table.insert(sounds, "crystalmaiden_custom_cm_wolf_bounty_02")
    end
end


if self.unit_name == "npc_dota_hero_terrorblade" then
    if self.normal[self.model_name] then

        table.insert(sounds, "terrorblade_terr_custom_lasthit_06")
        table.insert(sounds, "terrorblade_terr_custom_lasthit_05")

    elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
   
        table.insert(sounds, "terrorblade_terr_custom_morph_lasthit_05")
        table.insert(sounds, "terrorblade_terr_custom_morph_lasthit_06")
    end
end

if self.unit_name == "npc_dota_hero_morphling" then
    if self.persona[self.model_name] then
        table.insert(sounds, "morphling_auto_mrph_custom_lasthit_01")
        table.insert(sounds, "morphling_auto_mrph_custom_lasthit_04")
    else
        table.insert(sounds, "morphling_mrph_custom_lasthit_01")
        table.insert(sounds, "morphling_mrph_custom_lasthit_04")
    end
end

if self.unit_name == "npc_dota_hero_bristleback" then
    if self.persona[self.model_name] then
        table.insert(sounds, "bristleback_auto_bristle_custom_lasthit_01")
        table.insert(sounds, "bristleback_auto_bristle_custom_lasthit_05")
    else
        table.insert(sounds, "bristleback_bristle_custom_lasthit_01")
        table.insert(sounds, "bristleback_bristle_custom_lasthit_05")
    end
end

if #sounds > 0 then 
    self:MakeSound(sounds[RandomInt(1, #sounds)], true)
end 

end 


function modifier_voice_module:RespawnEvent()
if not IsServer() then return end 

local sounds = {}
local string_table = {}

if self.unit_name == "npc_dota_hero_juggernaut" then 

    if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
        string_table = 
        {
            {"juggernaut_custom_jug_arc_respawn_", 1, 7},
        }
    else 
        string_table = 
        {
            {"juggernaut_custom_jug_respawn_", 1, 7},
        }
    end 
end 

if self.unit_name == "npc_dota_hero_phantom_assassin" then 

    if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then
        string_table = 
        {
            {"phantom_assassin_custom_phass_arc_respawn_", 1, 10},
        }
    elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 

        string_table = 
        {
            {"phantom_assassin_custom_pa_asan_respawn_", 1, 13},
        }
    else
        string_table = 
        {
            {"phantom_assassin_custom_phass_respawn_", 1, 10},
        }
    end 
end 


if self.unit_name == "npc_dota_hero_legion_commander" then 

    if self:IsLcArcana() then
        string_table = 
        {
            {"legion_commander_custom_legcom_dem_respawn_", 1, 5},
            {"legion_commander_custom_legcom_dem_respawn_", 10, 14},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"legion_commander_auto_custom_legcom_respawn_", 1, 5},
            {"legion_commander_auto_custom_legcom_respawn_", 10, 14},
        }
    else 
        string_table = 
        {
            {"legion_commander_custom_legcom_respawn_", 1, 5},
            {"legion_commander_custom_legcom_respawn_", 10, 14},
        }
    end 
end 


if self.unit_name == "npc_dota_hero_nevermore" then 

    if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
    
        string_table = 
        {
            {"nevermore_custom_nev_arc_respawn_", 1, 10},
        }
    else 
        string_table = 
        {
            {"nevermore_custom_nev_respawn_", 1, 10},
        }
    end 

end 



if self.unit_name == "npc_dota_hero_razor" then 

    if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
    
        string_table = 
        {
            {"razor_rz_custom_vsa_respawn_", 1, 14},
        }
    else 
        string_table = 
        {
            {"razor_raz_custom_respawn_", 1, 10}
        }
    end 
end 


if self.unit_name == "npc_dota_hero_queenofpain" then 

    if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
    
        string_table = 
        {
            {"queenofpain_custom_qop_arc_respawn_", 1, 29},
        }
    else 
        string_table = 
        {
            {"queenofpain_custom_pain_respawn_", 1, 10},
        }
    end 
end 



if self.unit_name == "npc_dota_hero_skeleton_king" then 

    if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
    
        string_table = 
        {
            {"skeleton_king_custom_skel_arc_respawn_", 1, 21},
        }
    else 
        string_table = 
        {
            {"skeleton_king_custom_wraith_respawn_", 1, 11},
        }
    end 

end 


if self.unit_name == "npc_dota_hero_monkey_king" then 

    if self:IsMkArcana() then
        string_table = 
        {
            {"monkey_king_custom_monkey_crown_respawn_", 1, 2},
            {"monkey_king_custom_monkey_crown_respawn_", 4, 14},
            {"monkey_king_custom_monkey_crown_respawn_", 16, 16},
        }
    else 
        string_table = 
        {
            {"monkey_king_custom_monkey_respawn_", 1, 2},
            {"monkey_king_custom_monkey_respawn_", 4, 14},
            {"monkey_king_custom_monkey_respawn_", 16, 16},
        }
    end 

end 


if self.unit_name == "npc_dota_hero_zuus" then 

    if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then
    
        string_table = 
        {
            {"zuus_custom_zuus_arc_respawn_", 1, 10},
        }
    else 
        string_table = 
        {
            {"zuus_custom_zuus_respawn_", 1, 10},
        }
    end 
end 


if self.unit_name == "npc_dota_hero_pudge" then 

    if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
        string_table = 
        {
            {"pudge_custom_pud_arc_respawn_", 1, 12},
        }
    elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

        string_table = 
        {
            {"pudge_custom_toy_pug_respawn_", 1, 3},
            {"pudge_custom_toy_pug_respawn_", 5, 9},
            {"pudge_custom_toy_pug_respawn_", 11, 13},
            {"pudge_custom_toy_pug_respawn_10_", 3, 3},
            {"pudge_custom_toy_pug_respawn_04_", 2, 2},
        }
    else
        string_table = 
        {
            {"pudge_custom_pud_respawn_", 1, 10},
        }
    end 
end 


if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
    
        string_table = 
        {
            {"drowranger_custom_drow_arc_respawn_", 1, 13},
        }
    elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
        string_table = 
        {
            {"drowranger_custom_dro_respawn_", 1, 7},
        }
    end 
end 


if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
    
        string_table = 
        {
            {"skywrath_mage_custom_drag_respawn_", 1, 10},
        }
    elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
        string_table = 
        {
            {"skywrath_mage_custom_skywrath_crown_respawn_", 1, 18},
        }
    end 
end 



if self.unit_name == "npc_dota_hero_antimage" then 
    if self.normal[self.model_name] then
        string_table = 
        {
            {"antimage_custom_anti_respawn_", 1, 10},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"antimage_custom_amp_wei_respawn_", 1, 12},
            {"antimage_custom_amp_wei_respawn_", 15, 15},
        }
    end 
end 

if self.unit_name == "npc_dota_hero_axe" then 
    if self.model_name == "models/heroes/axe/axe.vmdl" then
    
        string_table = 
        {
            {"axe_axe_custom_respawn_", 1, 10},
        }
    elseif self.arcana[self.model_name] then
        string_table = 
        {
            {"axe_jung_custom_axe_respawn_", 1, 11},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"axe_auto_custom_axe_respawn_", 1, 10},
        }
    end
end     


if self.unit_name == "npc_dota_hero_ogre_magi" then 
    if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
    
        string_table = 
        {
            {"ogre_magi_custom_ogmag_respawn_", 1, 14},
        }
    elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
        string_table = 
        {
            {"ogre_magi_custom_ogm_arc_respawn_", 1, 17},
        }
    end 
end 

if self.unit_name == "npc_dota_hero_invoker" then 
    if self.model_name == "models/heroes/invoker/invoker.vmdl" then
    
        string_table = 
        {
            {"invoker_custom_invo_respawn_", 1, 10},
        }
    elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then
        string_table = 
        {
            {"invoker_custom_kidvoker_respawn_", 1, 11},
            {"invoker_custom_kidvo_la_respawn_", 1, 10}
        }
    end 
end

if self.unit_name == "npc_dota_hero_crystal_maiden" then
    if self.normal[self.model_name] then
        string_table = 
        {
            {"crystalmaiden_custom_cm_respawn_", 1, 7},
        }
    elseif self.persona[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_wolf_respawn_", 1, 11},
        }
    end
end
    

if self.unit_name == "npc_dota_hero_terrorblade" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"terrorblade_terr_custom_respawn_", 1, 11},
        }
    elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
        string_table =
        {
            {"terrorblade_terr_custom_morph_respawn_", 1, 11}
        }
    end
end

if self.unit_name == "npc_dota_hero_morphling" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"morphling_auto_mrph_custom_respawn_", 1, 9},
        }
    else
        string_table =
        {
            {"morphling_mrph_custom_respawn_", 1, 9},
        }
    end
end

if self.unit_name == "npc_dota_hero_bristleback" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"bristleback_auto_bristle_custom_respawn_", 1, 1},
            {"bristleback_auto_bristle_custom_respawn_", 3, 12},
        }
    else
        string_table =
        {
            {"bristleback_bristle_custom_respawn_", 1, 1},
            {"bristleback_bristle_custom_respawn_", 3, 12},
        }
    end
end

for _,data in pairs(string_table) do 
    for i = data[2],data[3] do 
        table.insert(sounds, data[1]..self:GetNumber(i))
    end 
end 


if #sounds > 0 then 
    self:MakeSound(sounds[RandomInt(1, #sounds)], true, 1)
end 

end 


modifier_voice_module_lasthit_cd = class({})
function modifier_voice_module_lasthit_cd:IsHidden() return true end
function modifier_voice_module_lasthit_cd:IsPurgable() return false end
function modifier_voice_module_lasthit_cd:RemoveOnDeath() return false end

modifier_voice_module_damage_cd = class({})
function modifier_voice_module_damage_cd:IsHidden() return true end
function modifier_voice_module_damage_cd:IsPurgable() return false end
function modifier_voice_module_damage_cd:RemoveOnDeath() return false end




function modifier_voice_module:GetDamageVoice()
if not IsServer() then return end

local string_table = {}

if self.unit_name == "npc_dota_hero_juggernaut" then 

    if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
    
        string_table = 
        {
            {"juggernaut_custom_jug_arc_underattack_", 1, 1},
            {"juggernaut_custom_jug_arc_pain_", 1, 23},
        }
    else 
        string_table = 
        {
            {"juggernaut_custom_jugg_underattack_", 1, 1},
            {"juggernaut_custom_jug_pain_", 1, 10},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_phantom_assassin" then 

    if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then
    
        string_table = 
        {
            {"phantom_assassin_custom_phass_arc_pain_", 1, 14},
        }
    elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 
        string_table = 
        {
            {"phantom_assassin_custom_pa_asan_pain_", 1, 9},
            {"phantom_assassin_custom_pa_asan_underattack_", 1, 4},
        }

    else 
        string_table = 
        {
            {"phantom_assassin_custom_phass_underattack_", 1, 1},
            {"phantom_assassin_custom_phass_pain_", 1, 14},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_legion_commander" then 

    if self:IsLcArcana() then
    
        string_table = 
        {
            {"legion_commander_custom_legcom_dem_pain_", 1, 13},
            {"legion_commander_custom_legcom_dem_underattack_", 1, 1},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"legion_commander_auto_custom_legcom_pain_", 1, 13},
            {"legion_commander_auto_custom_legcom_underattack_", 1, 1},
        }
    else 
        string_table = 
        {
            {"legion_commander_custom_legcom_pain_", 1, 13},
            {"legion_commander_custom_legcom_underattack_", 1, 1},
        }
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_nevermore" then 

    if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
    
        string_table = 
        {
            {"nevermore_custom_nev_arc_pain_", 1, 9},
            {"nevermore_custom_nev_arc_underattack_", 1, 1},
        }
    else 
        string_table = 
        {
            {"nevermore_custom_nev_pain_", 1, 9},
            {"nevermore_custom_nev_underattack_", 1, 1},
        }
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_razor" then 

    if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
    
        string_table = 
        {
            {"razor_rz_custom_vsa_pain_", 1, 6},
            {"razor_rz_custom_vsa_underattack_", 1, 3},
        }
    else 
        string_table = 
        {
            {"razor_raz_custom_pain_", 1, 12},
            {"razor_raz_custom_underattack_", 1, 1}
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_queenofpain" then 

    if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
    
        string_table = 
        {
            {"queenofpain_custom_qop_arc_pain_", 1, 12},
            {"queenofpain_custom_qop_arc_underattack_", 1, 3},
        }
    else 
        string_table = 
        {
            {"queenofpain_custom_pain_pain_", 1, 9},
            {"queenofpain_custom_pain_underattack_", 1, 1}
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_skeleton_king" then 

    if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
    
        string_table = 
        {
            {"skeleton_king_custom_skel_arc_pain_", 1, 3},
            {"skeleton_king_custom_skel_arc_pain_", 5, 7},
            {"skeleton_king_custom_skel_arc_pain_", 10, 14},
            {"skeleton_king_custom_skel_arc_underattack_", 1, 2},
        }
    else 
        string_table = 
        {
            {"skeleton_king_custom_wraith_pain_", 1, 11},
            {"skeleton_king_custom_wraith_underattack_", 1, 1}
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_monkey_king" then 

    if self:IsMkArcana() then
    
        string_table = 
        {
            {"monkey_king_custom_monkey_crown_pain_", 2, 22},
            {"monkey_king_custom_monkey_crown_pain_", 24, 24},
            {"monkey_king_custom_monkey_crown_underattack_", 1, 3},
        }
    else 
        string_table = 
        {
            {"monkey_king_custom_monkey_pain_", 2, 22},
            {"monkey_king_custom_monkey_pain_", 24, 24},
            {"monkey_king_custom_monkey_underattack_", 1, 3}
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_zuus" then 

    if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then
    
        string_table = 
        {
            {"zuus_custom_zuus_arc_pain_", 1, 5},
            {"zuus_custom_zuus_arc_underattack_", 1, 1}
        }
    else 
        string_table = 
        {
            {"zuus_custom_zuus_pain_", 1, 5},
            {"zuus_custom_zuus_underattack_", 1, 1},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_pudge" then 

    if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
    
        string_table = 
        {
            {"pudge_custom_pud_arc_pain_", 1, 7},
            {"pudge_custom_pud_arc_underattack_01_", 1, 1}
        }
    elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

        string_table = 
        {
            {"pudge_custom_toy_pug_pain_01_", 2, 2},
            {"pudge_custom_toy_pug_pain_03_", 2, 2},
            {"pudge_custom_toy_pug_pain_", 5, 5},
            {"pudge_custom_toy_pug_pain_", 7, 11},
            {"pudge_custom_toy_pug_underattack_", 1, 3},
        }
    else
        string_table = 
        {
            {"pudge_custom_pud_pain_", 1, 7},
            {"pudge_custom_pud_underattack_", 1, 1},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
    
        string_table = 
        {
            {"drowranger_custom_drow_arc_pain_", 1, 1},
            {"drowranger_custom_drow_arc_pain_", 3, 3},
            {"drowranger_custom_drow_arc_pain_", 5, 5},
            {"drowranger_custom_drow_arc_pain_", 7, 9},
            {"drowranger_custom_drow_arc_underattack_", 1, 4}
        }
    elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
        string_table = 
        {
            {"drowranger_custom_dro_pain_", 1, 5},
            {"drowranger_custom_dro_pain_", 7, 7},
            {"drowranger_custom_drow_underattack_", 1, 1},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
    
        string_table = 
        {
            {"skywrath_mage_custom_drag_pain_", 1, 9},
            {"skywrath_mage_custom_drag_underattack_", 1, 1}
        }
    elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
        string_table = 
        {
            {"skywrath_mage_custom_skywrath_crown_pain_", 1, 5},
            {"skywrath_mage_custom_skywrath_crown_pain_", 10, 10},
            {"skywrath_mage_custom_skywrath_crown_underattack_", 1, 2},
        }
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_antimage" then 
    if self.normal[self.model_name] then
    
        string_table = 
        {
            {"antimage_custom_anti_underattack_", 1, 1},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"antimage_custom_amp_wei_underattack_", 1, 2},
        }
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_axe" then 
    if self.model_name == "models/heroes/axe/axe.vmdl" then
    
        string_table = 
        {
            {"axe_axe_custom_underattack_", 1, 1},
        }
    elseif self.arcana[self.model_name] then
        string_table = 
        {
            {"axe_jung_custom_axe_underattack_", 1, 2},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"axe_auto_custom_axe_underattack_", 1, 1},
        }
    end
    return string_table
end 


if self.unit_name == "npc_dota_hero_ogre_magi" then 
    if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
    
        string_table = 
        {
            {"ogre_magi_custom_ogmag_underattack_", 1, 1},
        }
    elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
        string_table = 
        {
            {"ogre_magi_custom_ogm_arc_underattack_", 1, 3},
        }
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_invoker" then 
    if self.model_name == "models/heroes/invoker/invoker.vmdl" then
    
        string_table = 
        {
            {"invoker_custom_invo_underattack_", 1, 2},
        }
    elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then
        string_table = 
        {
            {"invoker_custom_kidvoker_underattack_", 1, 3},
        }
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_crystal_maiden" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_underattack_", 1, 2},
        }
    elseif self.persona[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_wolf_underattack_", 1, 4},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_terrorblade" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"terrorblade_terr_custom_underattack_", 1, 1},
        }
    elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
        string_table =
        {
            {"terrorblade_terr_custom_morph_underattack_", 1, 1}
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_morphling" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"morphling_auto_mrph_custom_underattack_", 1, 1},
        }
    else
        string_table =
        {
            {"morphling_mrph_custom_underattack_", 1, 1},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_bristleback" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"bristleback_auto_bristle_custom_underattack_", 1, 3},
        }
    else
        string_table =
        {
            {"bristleback_bristle_custom_underattack_", 1, 3},
        }
    end
    return string_table
end

return string_table
end











function modifier_voice_module:GetMoveVoice()
if not IsServer() then return end

self.model_name = self.parent:GetModelName()

local string_table = {}
if self.unit_name == "npc_dota_hero_juggernaut" then  

    if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then 

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"juggernaut_custom_jug_arc_move_pain_", 1, 7},
                {"juggernaut_custom_jug_arc_move_pain_", 9, 19},
                {"juggernaut_custom_jug_arc_acknow_", 1, 9},
            }
        else 
            string_table = 
            {
                {"juggernaut_custom_jug_arc_move_", 1, 7},
                {"juggernaut_custom_jug_arc_move_", 9, 19},
                {"juggernaut_custom_jug_arc_acknow_", 1, 9},
            }
        end 
    else 
        string_table = 
        {
            {"juggernaut_custom_jug_move_", 1, 7},
            {"juggernaut_custom_jug_move_", 9, 19},
            {"juggernaut_custom_jug_acknow_", 1, 5},
        }
    end

    return string_table
end

if self.unit_name == "npc_dota_hero_phantom_assassin" then  

    if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then 
        string_table = 
        {
            {"phantom_assassin_custom_phass_arc_move_", 1, 19},
        }
    elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_move_pain_", 1, 10},
            }
        else 
            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_move_", 1, 22},
            }
        end 
    else
        string_table = 
        {
            {"phantom_assassin_custom_phass_move_", 1, 19},
        }
    end
    return string_table
end


if self.unit_name == "npc_dota_hero_legion_commander" then 

    if self:IsLcArcana() then
        string_table = 
        {
            {"legion_commander_custom_legcom_dem_econ_move_", 1, 5},
            {"legion_commander_custom_legcom_dem_move_", 1, 18},
            {"legion_commander_custom_legcom_dem_move_", 22, 22},
            {"legion_commander_custom_legcom_dem_move_", 25, 27},
            {"legion_commander_custom_legcom_dem_move_", 30, 30},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"legion_commander_auto_custom_legcom_move_", 1, 18},
            {"legion_commander_auto_custom_legcom_move_", 22, 22},
            {"legion_commander_auto_custom_legcom_move_", 25, 27},
            {"legion_commander_auto_custom_legcom_move_", 30, 30},
        }
    else 
        string_table = 
        {
            {"legion_commander_custom_legcom_move_", 1, 18},
            {"legion_commander_custom_legcom_move_", 22, 22},
            {"legion_commander_custom_legcom_move_", 25, 27},
            {"legion_commander_custom_legcom_move_", 30, 30},
        }
    end

    return string_table
end


if self.unit_name == "npc_dota_hero_nevermore" then 

    if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
    
        string_table = 
        {
            {"nevermore_custom_nev_arc_move_", 1, 7},
            {"nevermore_custom_nev_arc_move_", 9, 15},
        }
    else 
        string_table = 
        {
            {"nevermore_custom_nev_move_", 1, 7},
            {"nevermore_custom_nev_move_", 9, 15},
        }
    end 

    return string_table
end 




if self.unit_name == "npc_dota_hero_razor" then 

    if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
    
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"razor_rz_custom_vsa_move_pain_", 1, 8},
            }
        else 
            string_table = 
            {
                {"razor_rz_custom_vsa_move_", 1, 21},
            }

        end
    else 
        string_table = 
        {
            {"razor_raz_custom_move_", 1, 13},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_queenofpain" then 

    if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
    
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"queenofpain_custom_qop_arc_move_exhausted_", 1, 14},
            }
        else 
            string_table = 
            {
                {"queenofpain_custom_qop_arc_move_", 1, 26},
            }

        end 
    else 
        string_table = 
        {
            {"queenofpain_custom_pain_move_", 1, 13},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_skeleton_king" then 

    if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
    
        string_table = 
        {
            {"skeleton_king_custom_skel_arc_move_", 1, 31},
        }
    else 
        string_table = 
        {
            {"skeleton_king_custom_wraith_move_", 1, 22},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_monkey_king" then 

    if self:IsMkArcana() then
    
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"monkey_king_custom_monkey_crown_move_pain_", 1, 39},
            }
        else 
            string_table = 
            {
                {"monkey_king_custom_monkey_crown_move_", 1, 27},
            }
        end 
    else 
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"monkey_king_custom_monkey_move_pain_", 1, 39},
            }
        else 
            string_table = 
            {
                {"monkey_king_custom_monkey_move_", 1, 27},
            }
        end 
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_zuus" then 

    if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then
    
        string_table = 
        {
            {"zuus_custom_zuus_arc_move_", 1, 7},
            {"zuus_custom_zuus_arc_move_", 9, 10}
        }
    else 
        string_table = 
        {
            {"zuus_custom_zuus_move_", 1, 7},
            {"zuus_custom_zuus_move_", 9, 10},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_pudge" then 

    if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
        
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"pudge_custom_pud_arc_move_pain_", 1, 28},
            }
        else 
            string_table = 
            {
                {"pudge_custom_pud_arc_move_", 1, 13},
                {"pudge_custom_pud_arc_move_", 15, 28},
                {"pudge_custom_pud_arc_move_13_", 1, 1},
                {"pudge_custom_pud_arc_move_14_", 9, 9},
                {"pudge_custom_pud_arc_move_27_", 1, 1},
                {"pudge_custom_pud_arc_move_28_", 1, 2},
            }
        end
    elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

        string_table = 
        {
            {"pudge_custom_toy_pug_move_", 1, 29},
            {"pudge_custom_toy_pug_move_05_", 2, 2},
            {"pudge_custom_toy_pug_move_06_", 2, 2},
            {"pudge_custom_toy_pug_move_07_", 2, 2},
            {"pudge_custom_toy_pug_move_23_", 2, 2},
            {"pudge_custom_toy_pug_move_30_", 2, 2},
        }
    else
        string_table = 
        {
            {"pudge_custom_pud_move_", 1, 1},
            {"pudge_custom_pud_move_", 3, 7},
            {"pudge_custom_pud_move_", 9, 13},
            {"pudge_custom_pud_move_", 15, 17},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_drow_ranger" then 
    if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
    
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"drowranger_custom_drow_arc_move_pain_", 1, 10},
            }
        else 
            string_table = 
            {
                {"drowranger_custom_drow_arc_move_", 1, 31},
                {"drowranger_custom_drow_arc_move_lgc_", 1, 14},
            }
        end

    elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
        string_table = 
        {
            {"drowranger_custom_dro_move_", 1, 14},
        }
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
        string_table = 
        {
            {"skywrath_mage_custom_drag_move_", 1, 22},
        }
    elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_move_pain_", 1, 10},
            }
        else 
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_move_", 1, 34},
            }
        end
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_antimage" then 
    if self.normal[self.model_name] then
        string_table = 
        {
            {"antimage_custom_anti_move_", 1, 13},
        }
    elseif self.persona[self.model_name] then
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"antimage_custom_amp_wei_move_pain_", 1, 11},
            }
        else 
            string_table = 
            {
                {"antimage_custom_amp_wei_move_", 1, 27},
            }
        end
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_axe" then 
    if self.model_name == "models/heroes/axe/axe.vmdl" then
    
        string_table = 
        {
            {"axe_axe_custom_move_", 1, 11},
        }
    elseif self.arcana[self.model_name] then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"axe_jung_custom_axe_move_pain_", 1, 14},
            }
        else 
            string_table = 
            {
                {"axe_jung_custom_axe_move_", 1, 13},
            }
        end
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"axe_auto_custom_axe_move_", 1, 11},
        }
    end
    return string_table
end 



if self.unit_name == "npc_dota_hero_ogre_magi" then 
    if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
    
        string_table = 
        {
            {"ogre_magi_custom_ogmag_move_", 1, 24},
        }
    elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
        string_table = 
        {
            {"ogre_magi_custom_ogm_arc_move_", 1, 1},
            {"ogre_magi_custom_ogm_arc_move_02_", 2, 2},
            {"ogre_magi_custom_ogm_arc_move_", 3, 25},
            {"ogre_magi_custom_ogm_arc_move_26_", 2, 2},
            {"ogre_magi_custom_ogm_arc_move_", 27, 33},
        }
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_invoker" then 
    if self.model_name == "models/heroes/invoker/invoker.vmdl" then
    
        string_table = 
        {
            {"invoker_custom_invo_move_", 1, 24},
        }
    elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"invoker_custom_kidvoker_move_pain_", 1, 6},
                {"invoker_custom_kidvoker_move_pain_", 6, 24},
            }
        else
            string_table = 
            {
                {"invoker_custom_kidvoker_move_", 1, 24},
                {"invoker_custom_kidvoker_move_25_", 6, 6},
                {"invoker_custom_kidvoker_move_25_", 8, 8},
            }
        end
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_crystal_maiden" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_move_", 1, 15},
        }
    elseif self.persona[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_wolf_move_", 1, 22},
        }
    end
    return string_table
end


if self.unit_name == "npc_dota_hero_terrorblade" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"terrorblade_terr_custom_move_", 1, 14},
        }
    elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
        string_table =
        {
            {"terrorblade_terr_custom_morph_move_", 1, 14},
            {"terrorblade_terr_custom_morph_movedemon_", 1, 13},
            {"terrorblade_terr_custom_morph_movedemon_", 15, 15},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_morphling" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"morphling_auto_mrph_custom_move_", 1, 15},
        }
    else
        string_table =
        {
            {"morphling_mrph_custom_move_", 1, 15},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_bristleback" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"bristleback_auto_bristle_custom_move_", 1, 17},
        }
    else
        string_table =
        {
            {"bristleback_bristle_custom_move_", 1, 17},
        }
    end
    return string_table
end

return string_table
end






function modifier_voice_module:GetAttackVoice(target)
if not IsServer() then return end

local string_table = {}

if self.unit_name == "npc_dota_hero_juggernaut" then  
    if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then 
        string_table = 
        {
            {"juggernaut_custom_jug_arc_attack_", 1, 13},
        }
    else 
        string_table = 
        {
            {"juggernaut_custom_jug_attack_", 1, 13},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_phantom_assassin" then  
    if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then 
        string_table = 
        {
            {"phantom_assassin_custom_phass_arc_attack_", 1, 10},
        }
    elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_attack_pain_", 1, 10},
            }
        else 
            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_attack_", 1, 20},
                {"phantom_assassin_custom_pa_asan_attack_big_", 1, 1},
                {"phantom_assassin_custom_pa_asan_attack_emote_", 1, 2},
                {"phantom_assassin_custom_pa_asan_attack_small_", 8, 8}
            }
        end 
    else  
        string_table = 
        {
            {"phantom_assassin_custom_phass_attack_", 1, 10},
        }
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_legion_commander" then 

    if self:IsLcArcana() then

        string_table = 
        {
            {"legion_commander_custom_legcom_dem_attack_", 1, 2},
            {"legion_commander_custom_legcom_dem_attack_", 4, 10},
            {"legion_commander_custom_legcom_dem_attack_", 12, 12},
            {"legion_commander_custom_legcom_dem_attack_", 14, 15},
            {"legion_commander_custom_legcom_dem_econ_attack_", 1, 3},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"legion_commander_auto_custom_legcom_attack_", 1, 2},
            {"legion_commander_auto_custom_legcom_attack_", 4, 10},
            {"legion_commander_auto_custom_legcom_attack_", 12, 12},
            {"legion_commander_auto_custom_legcom_attack_", 14, 15},
        }
    else 
        string_table = 
        {
            {"legion_commander_custom_legcom_attack_", 1, 2},
            {"legion_commander_custom_legcom_attack_", 4, 10},
            {"legion_commander_custom_legcom_attack_", 12, 12},
            {"legion_commander_custom_legcom_attack_", 14, 15},
        }
    end

    return string_table
end


if self.unit_name == "npc_dota_hero_nevermore" then 

    if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
    
        string_table = 
        {
            {"nevermore_custom_nev_arc_attack_", 1, 12},
        }
    else 
        string_table = 
        {
            {"nevermore_custom_nev_attack_", 1, 12},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_razor" then 

    if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
    
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"razor_rz_custom_vsa_attack_pain_", 1, 8},
            }
        else 
            string_table = 
            {
                {"razor_rz_custom_vsa_attack_", 1, 17},
                {"razor_rz_custom_vsa_attack_close_", 1, 10}
            }

        end
    else 
        string_table = 
        {
            {"razor_raz_custom_attack_", 1, 12},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_queenofpain" then 

    if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
    
        if target and not target:IsNull() and (target:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= 350 then 
            string_table = 
            {
                {"queenofpain_custom_qop_arc_attack_whip_", 1, 12},
            }
        else 
            string_table = 
            {
                {"queenofpain_custom_qop_arc_attack_", 1, 24},
            }

        end 
    else 
        string_table = 
        {
            {"queenofpain_custom_pain_attack_", 1, 12},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_skeleton_king" then 

    if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
    
        string_table = 
        {
            {"skeleton_king_custom_skel_arc_attack_", 1, 21},
        }
    else 
        string_table = 
        {
            {"skeleton_king_custom_wraith_attack_", 1, 15},
        }
    end 

    return string_table
end 




if self.unit_name == "npc_dota_hero_monkey_king" then 

    if self:IsMkArcana() then
        string_table = 
        {
            {"monkey_king_custom_monkey_crown_attack_", 1, 14},
        }
    else 
        string_table = 
        {
            {"monkey_king_custom_monkey_attack_", 1, 14},
        }
        
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_zuus" then 

    if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then
    
        string_table = 
        {
            {"zuus_custom_zuus_arc_attack_", 1, 9},
        }
    else 
        string_table = 
        {
            {"zuus_custom_zuus_attack_", 1, 9},
        }
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_pudge" then 

    if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
        
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"pudge_custom_pud_arc_attack_pain_", 1, 20},
            }
        else 
            string_table = 
            {
                {"pudge_custom_pud_arc_attack_", 1, 1},
                {"pudge_custom_pud_arc_attack_02_", 3, 3},
                {"pudge_custom_pud_arc_attack_", 3, 20},
            }
        end
    elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

        string_table = 
        {
            {"pudge_custom_toy_pug_attack_", 1, 16},
            {"pudge_custom_toy_pug_attack_17_", 2, 2},
            {"pudge_custom_toy_pug_attack_", 18, 24},
        }
    else
        string_table = 
        {
            {"pudge_custom_pud_attack_", 1, 6},
            {"pudge_custom_pud_attack_", 8, 16},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
    
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"drowranger_custom_drow_arc_attack_pain_", 1, 10},
            }
        else 
            string_table = 
            {
                {"drowranger_custom_drow_arc_attack_", 1, 23},
                {"drowranger_custom_drow_arc_attack_lgc_", 1, 11},
            }
        end

    elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
        string_table = 
        {
            {"drowranger_custom_dro_attack_", 1, 11},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
        string_table = 
        {
            {"skywrath_mage_custom_drag_attack_", 1, 14},
        }
    elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_attack_", 1, 10},
            }
        else 
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_attack_", 1, 21},
            }
        end
    end 
    return string_table
end


if self.unit_name == "npc_dota_hero_antimage" then 
    if self.normal[self.model_name] then
    
        string_table = 
        {
            {"antimage_custom_anti_attack_", 1, 10},
        }
    elseif self.persona[self.model_name] then
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"antimage_custom_amp_wei_attack_pain_", 1, 10},
            }
        else 
            string_table = 
            {
                {"antimage_custom_amp_wei_attack_", 1, 17},
                {"antimage_custom_amp_wei_attack_", 19, 24},
            }
        end
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_axe" then 
    if self.model_name == "models/heroes/axe/axe.vmdl" then
    
        string_table = 
        {
            {"axe_axe_custom_attack_", 1, 10},
        }
    elseif self.arcana[self.model_name] then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"axe_jung_custom_axe_attack_pain_", 2, 16},
            }
        else 
            string_table = 
            {
                {"axe_jung_custom_axe_attack_", 1, 23},
            }
        end
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"axe_auto_custom_axe_attack_", 1, 10},
        }
    end
    return string_table
end 

if self.unit_name == "npc_dota_hero_ogre_magi" then 
    if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
    
        string_table = 
        {
            {"ogre_magi_custom_ogmag_attack_", 1, 13},
        }
    elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
        string_table = 
        {
            {"ogre_magi_custom_ogm_arc_attack_", 1, 17},
            {"ogre_magi_custom_ogm_arc_attack_18_", 2, 2},
        }
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_invoker" then 
    if self.model_name == "models/heroes/invoker/invoker.vmdl" then
    
        string_table = 
        {
            {"invoker_custom_invo_attack_", 1, 12},
        }
    elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"invoker_custom_kidvoker_attack_pain_", 1, 12},
            }
        else
            string_table = 
            {
                {"invoker_custom_kidvoker_attack_", 1, 14},
                {"invoker_custom_kidvoker_attack_15_", 2, 2},
                {"invoker_custom_kidvoker_attack_", 16, 19},
            }
        end
    end 
    return string_table
end 



if self.unit_name == "npc_dota_hero_crystal_maiden" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_attack_", 1, 9},
        }
    elseif self.persona[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_wolf_attack_", 1, 12},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_terrorblade" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"terrorblade_terr_custom_attack_", 1, 10},
        }
    elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
        string_table =
        {
            {"terrorblade_terr_custom_morph_attack_", 1, 10},
            {"terrorblade_terr_custom_morph_demonattack_", 1, 10},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_morphling" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"morphling_auto_mrph_custom_attack_", 1, 10},
        }
    else
        string_table =
        {
            {"morphling_mrph_custom_attack_", 1, 10},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_bristleback" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"bristleback_auto_bristle_custom_attack_", 1, 21},
        }
    else
        string_table =
        {
            {"bristleback_bristle_custom_attack_", 1, 21},
        }
    end
    return string_table
end

return string_table
end











function modifier_voice_module:GetCastVoice()
if not IsServer() then return end

local string_table = {}

if self.unit_name == "npc_dota_hero_juggernaut" then  

    if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then 
        string_table = 
        {
            {"juggernaut_custom_jug_arc_cast_", 1, 3},
        }
    else 
        string_table = 
        {
            {"juggernaut_custom_jug_cast_", 1, 3},
        }
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_phantom_assassin" then  

    if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then 
        string_table = 
        {
            {"phantom_assassin_custom_phass_arc_cast_", 1, 4},
        }
    elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 

        if self.parent:GetHealthPercent() <= 30 then 

            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_cast_pain_", 1, 4},
            }
        else 
            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_cast_", 1, 6},
            }
        end
    else  
        string_table = 
        {
            {"phantom_assassin_custom_phass_cast_", 1, 4},
        }
    end 

    return string_table
end



if self.unit_name == "npc_dota_hero_legion_commander" then 

    if self:IsLcArcana() then
        string_table = 
        {
            {"legion_commander_custom_legcom_dem_cast_", 1, 3},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"legion_commander_auto_custom_legcom_cast_", 1, 3},
        }
    else  
        string_table = 
        {
            {"legion_commander_custom_legcom_cast_", 1, 3},
        }
    end 
    return string_table
end 



if self.unit_name == "npc_dota_hero_nevermore" then 

    if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
    
        string_table = 
        {
            {"nevermore_custom_nev_arc_cast_", 1, 3},
        }
    else 
        string_table = 
        {
            {"nevermore_custom_nev_cast_", 1, 3},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_razor" then 

    if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
    
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"razor_rz_custom_vsa_cast_pain_", 1, 4},
            }
        else 
            string_table = 
            {
                {"razor_rz_custom_vsa_cast_", 1, 5},
            }

        end
    else 
        string_table = 
        {
            {"razor_raz_custom_cast_", 1, 2},
        }
    end 

    return string_table
end 




if self.unit_name == "npc_dota_hero_queenofpain" then 

    if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
        string_table = 
        {
            {"queenofpain_custom_qop_arc_cast_", 1, 5},
        }

    else 
        string_table = 
        {
            {"queenofpain_custom_pain_cast_", 1, 3},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_skeleton_king" then 

    if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
    
        string_table = 
        {
            {"skeleton_king_custom_skel_arc_cast_", 1, 6},
        }
    else 
        string_table = 
        {
            {"skeleton_king_custom_wraith_cast_", 1, 3},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_monkey_king" then 

    if self:IsMkArcana() then
        string_table = 
        {
            {"monkey_king_custom_monkey_crown_cast_", 2, 3},
        }
    else 
        string_table = 
        {
            {"monkey_king_custom_monkey_cast_", 2, 3},
        }
        
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_zuus" then 

    if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then
    
        string_table = 
        {
            {"zuus_custom_zuus_arc_cast_", 1, 2},
        }
    else 
        string_table = 
        {
            {"zuus_custom_zuus_cast_", 1, 2},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_pudge" then 

    if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
        
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"pudge_custom_pud_arc_cast_pain_", 1, 4},
            }
        else 
            string_table = 
            {
                {"pudge_custom_pud_arc_cast_", 1, 4},
            }
        end
    elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

        string_table = 
        {
            {"pudge_custom_toy_pug_cast_", 1, 1},
            {"pudge_custom_toy_pug_cast_", 3, 5},
            {"pudge_custom_toy_pug_cast_02_", 2, 2},
        }
    else
        string_table = 
        {
            {"pudge_custom_pud_cast_", 1, 4},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
    
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"drowranger_custom_drow_arc_cast_pain_", 1, 4},
            }
        else 
            string_table = 
            {
                {"drowranger_custom_drow_arc_cast_", 1, 5},
                {"drowranger_custom_drow_arc_cast_lgc_", 1, 4},
            }
        end

    elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
        string_table = 
        {
            {"drowranger_custom_dro_cast_", 1, 3},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
        string_table = 
        {
            {"skywrath_mage_custom_drag_cast_", 1, 3},
        }
    elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_cast_pain_", 1, 10},
            }
        else 
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_cast_", 1, 6},
            }
        end
    end 
    return string_table
end


if self.unit_name == "npc_dota_hero_antimage" then 
    if self.normal[self.model_name] then
    
        string_table = 
        {
            {"antimage_custom_anti_cast_", 1, 3},
        }
    elseif self.persona[self.model_name] then
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"antimage_custom_amp_wei_cast_pain_", 1, 4},
            }
        else 
            string_table = 
            {
                {"antimage_custom_amp_wei_cast_", 1, 4},
            }
        end
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_axe" then 
    if self.model_name == "models/heroes/axe/axe.vmdl" then
    
        string_table = 
        {
            {"axe_axe_custom_cast_", 1, 2},
        }
    elseif self.arcana[self.model_name] then
        string_table = 
        {
            {"axe_jung_custom_axe_cast_", 1, 2},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"axe_auto_custom_axe_cast_", 1, 2},
        }
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_ogre_magi" then 
    if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
    
        string_table = 
        {
            {"ogre_magi_custom_ogmag_cast_", 1, 4},
        }
    elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
        string_table = 
        {
            {"ogre_magi_custom_ogm_arc_cast_", 1, 6},
        }
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_invoker" then 
    if self.model_name == "models/heroes/invoker/invoker.vmdl" then
    
        string_table = 
        {
            {"invoker_custom_invo_cast_", 1, 3},
        }
    elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"invoker_custom_kidvoker_cast_pain_", 1, 4},
            }
        else
            string_table = 
            {
                {"invoker_custom_kidvoker_cast_", 1, 4},
            }
        end
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_crystal_maiden" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_cast_", 1, 5},
        }
    elseif self.persona[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_wolf_cast_", 1, 4},
        }
    end
    return string_table
end
    

if self.unit_name == "npc_dota_hero_terrorblade" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"terrorblade_terr_custom_cast_", 1, 3},
        }
    elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
        string_table =
        {
            {"terrorblade_terr_custom_morph_cast_", 1, 3},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_morphling" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"morphling_auto_mrph_custom_cast_", 1, 3},
        }
    else
        string_table =
        {
            {"morphling_mrph_custom_cast_", 1, 3},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_bristleback" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"bristleback_auto_bristle_custom_cast_", 1, 5},
        }
    else
        string_table =
        {
            {"bristleback_bristle_custom_cast_", 1, 5},
        }
    end
    return string_table
end

return string_table
end







function modifier_voice_module:GetLastHitVoice()
if not IsServer() then return end

local string_table = {}

if self.unit_name == "npc_dota_hero_juggernaut" then 

    if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
        string_table = 
        {
            {"juggernaut_custom_jug_arc_lasthit_", 1, 12},
        }

    else 
        string_table = 
        {
            {"juggernaut_custom_jug_lasthit_", 1, 12},
        }
    end

    return string_table
end 

if self.unit_name == "npc_dota_hero_phantom_assassin" then 

    if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then
        string_table = 
        {
            {"phantom_assassin_custom_phass_arc_lasthit_", 1, 10},
        }

    elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_lasthit_pain_", 1, 10},
            }
        else
            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_lasthit_", 1, 15},
            }
        end  
    else  
        string_table = 
        {
            {"phantom_assassin_custom_phass_lasthit_", 1, 10},
        }
    end
    return string_table
end 


if self.unit_name == "npc_dota_hero_legion_commander" then 

    if self:IsLcArcana() then
        string_table = 
        {
            {"legion_commander_custom_legcom_dem_lasthit_", 1, 5},
            {"legion_commander_custom_legcom_dem_lasthit_", 7, 13},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"legion_commander_auto_custom_legcom_lasthit_", 1, 5},
            {"legion_commander_auto_custom_legcom_lasthit_", 7, 13},
        }
    else  
        string_table = 
        {
            {"legion_commander_custom_legcom_lasthit_", 1, 5},
            {"legion_commander_custom_legcom_lasthit_", 7, 13},
        }
    end 
    return string_table
end 



if self.unit_name == "npc_dota_hero_nevermore" then 

    if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
    
        string_table = 
        {
            {"nevermore_custom_nev_arc_lasthit_", 1, 7},
        }
    else 
        string_table = 
        {
            {"nevermore_custom_nev_lasthit_", 1, 7},
        }
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_razor" then 

    if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
    
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"razor_rz_custom_vsa_lasthit_pain_", 1, 8},
            }
        else 
            string_table = 
            {
                {"razor_rz_custom_vsa_lasthit_", 1, 11},
            }

        end
    else 
        string_table = 
        {
            {"razor_raz_custom_lasthit_", 1, 8},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_queenofpain" then 

    if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
        string_table = 
        {
            {"queenofpain_custom_qop_arc_lasthit_", 1, 19},
        }

    else 
        string_table = 
        {
            {"queenofpain_custom_pain_lasthit_", 1, 8},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_skeleton_king" then 

    if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
    
        string_table = 
        {
            {"skeleton_king_custom_skel_arc_lasthit_", 1, 19},
        }
    else 
        string_table = 
        {
            {"skeleton_king_custom_wraith_lasthit_", 1, 14},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_monkey_king" then 

    if self:IsMkArcana() then
        string_table = 
        {
            {"monkey_king_custom_monkey_crown_lasthit_", 1, 19},
            {"monkey_king_custom_monkey_crown_lasthit_", 22, 22},
        }
    else 
        string_table = 
        {
            {"monkey_king_custom_monkey_lasthit_", 1, 19},
            {"monkey_king_custom_monkey_lasthit_", 22, 22},
        }
        
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_zuus" then 

    if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then
    
        string_table = 
        {
            {"zuus_custom_zuus_arc_lasthit_", 1, 8},
        }
    else 
        string_table = 
        {
            {"zuus_custom_zuus_lasthit_", 1, 8},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_pudge" then 

    if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
        
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"pudge_custom_pud_arc_lasthit_pain_", 1, 6},
                {"pudge_custom_pud_arc_lasthit_pain_", 8, 10},
                {"pudge_custom_pud_arc_lasthit_pain_", 12, 12},
                {"pudge_custom_pud_arc_lasthit_pain_01_", 2, 3},
            }
        else 
            string_table = 
            {
                {"pudge_custom_pud_arc_lasthit_", 2, 6},
                {"pudge_custom_pud_arc_lasthit_", 8, 10},
                {"pudge_custom_pud_arc_lasthit_", 12, 12},
                {"pudge_custom_pud_arc_lasthit_11_", 1, 1},
                {"pudge_custom_pud_arc_lasthit_06_", 1, 1},
                {"pudge_custom_pud_arc_lasthit_01_", 1, 1},
                {"pudge_custom_pud_arc_lasthit_07_", 1, 1},
            }
        end
    elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

        string_table = 
        {
            {"pudge_custom_toy_pug_lasthit_", 1, 15},
            {"pudge_custom_toy_pug_lasthit_09_", 2, 2},
        }
    else
        string_table = 
        {
            {"pudge_custom_pud_lasthit_", 1, 9},
        }
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"drowranger_custom_drow_arc_lasthit_pain_", 1, 10}
            }
        else 
            string_table = 
            {
                {"drowranger_custom_drow_arc_lasthit_", 1, 15},
            }
        end
    elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
        string_table = 
        {
            {"drowranger_custom_dro_lasthit_", 1, 3},
            {"drowranger_custom_drow_lasthit_", 4, 10},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
        string_table = 
        {
            {"skywrath_mage_custom_drag_lasthit_", 1, 11},
        }
    elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_lasthit_pain_", 1, 10},
            }
        else 
            string_table = 
            {
                {"skywrath_mage_custom_skywrath_crown_lasthit_", 1, 22},
            }
        end
    end 
    return string_table
end


if self.unit_name == "npc_dota_hero_antimage" then 
    if self.normal[self.model_name] then
    
        string_table = 
        {
            {"antimage_custom_anti_lasthit_", 1, 10},
        }
    elseif self.persona[self.model_name] then
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"antimage_custom_amp_wei_lasthit_pain_", 1, 10},
            }
        else 
            string_table = 
            {
                {"antimage_custom_amp_wei_lasthit_", 1, 23},
            }
        end
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_axe" then 
    if self.model_name == "models/heroes/axe/axe.vmdl" then
    
        string_table = 
        {
            {"axe_axe_custom_lasthit_", 1, 7},
        }
    elseif self.arcana[self.model_name] then
        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"axe_jung_custom_axe_lasthit_pain_", 1, 5},
                {"axe_jung_custom_axe_lasthit_pain_", 7, 9},
            }
        else 
            string_table = 
            {
                {"axe_jung_custom_axe_lasthit_", 1, 12},
            }
        end
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"axe_auto_custom_axe_lasthit_", 1, 7},
        }
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_ogre_magi" then 
    if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
    
        string_table = 
        {
            {"ogre_magi_custom_ogmag_lasthit_", 1, 10},
        }
    elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
        string_table = 
        {
            {"ogre_magi_custom_ogm_arc_lasthit_", 1, 5},
            {"ogre_magi_custom_ogm_arc_lasthit_06_", 3, 3},
            {"ogre_magi_custom_ogm_arc_lasthit_", 7, 13},
            {"ogre_magi_custom_ogm_arc_lasthit_14_", 2, 2},
            {"ogre_magi_custom_ogm_arc_lasthit_", 15, 15},
        }
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_invoker" then 
    if self.model_name == "models/heroes/invoker/invoker.vmdl" then
    
        string_table = 
        {
            {"invoker_custom_invo_lasthit_", 1, 10},
        }
    elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then

        if self.parent:GetHealthPercent() <= 30 then 
            string_table = 
            {
                {"invoker_custom_kidvoker_lasthit_pain_", 1, 10},
            }
        else
            string_table = 
            {
                {"invoker_custom_kidvoker_lasthit_", 1, 10},
                {"invoker_custom_kidvo_la_lasthit_", 1, 5},
                {"invoker_custom_kidvo_la_lasthit_", 7, 10},
            }
        end
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_crystal_maiden" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_lasthit_", 1, 13},
        }
    elseif self.persona[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_wolf_lasthit_", 1, 15},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_terrorblade" then
    if self.normal[self.model_name] then

        string_table = 
        {
            {"terrorblade_terr_custom_lasthit_", 1, 10},
        }
    elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
        string_table =
        {
            {"terrorblade_terr_custom_morph_lasthit_", 1, 10},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_morphling" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"morphling_auto_mrph_custom_lasthit_", 1, 8},
        }
    else
        string_table =
        {
            {"morphling_mrph_custom_lasthit_", 1, 8},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_bristleback" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"bristleback_auto_bristle_custom_lasthit_", 1, 15},
        }
    else
        string_table =
        {
            {"bristleback_bristle_custom_lasthit_", 1, 15},
        }
    end
    return string_table
end

return string_table
end 







function modifier_voice_module:GetDeathVoice(is_reinc, attacker)
if not IsServer() then return end

local string_table = {}
if self.unit_name == "npc_dota_hero_juggernaut" then 

    if is_reinc then 

    else 

        if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
            string_table = 
            {
                {"juggernaut_custom_jug_arc_death_", 1, 1},
                {"juggernaut_custom_jug_arc_death_", 3, 12},
            }
        else 
            string_table = 
            {
                {"juggernaut_custom_jug_death_", 1, 1},
                {"juggernaut_custom_jug_death_", 3, 12},
            }
        end 
    end

    return string_table
end 


if self.unit_name == "npc_dota_hero_phantom_assassin" then 

    if is_reinc then 

    else 

        if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then
            string_table = 
            {
                {"phantom_assassin_custom_phass_arc_death_", 1, 9},
            }
        elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 
            
            string_table = 
            {
                {"phantom_assassin_custom_pa_asan_death_", 1, 20},
            }
        else  
            string_table = 
            {
                {"phantom_assassin_custom_phass_death_", 1, 9},
            }
        end 
    end

    return string_table
end 


if self.unit_name == "npc_dota_hero_legion_commander" then 
   
    if is_reinc then 

    else 

        if self:IsLcArcana() then
            string_table = 
            {
                {"legion_commander_custom_legcom_dem_death_", 1, 4},
                {"legion_commander_custom_legcom_dem_death_", 6, 8},
                {"legion_commander_custom_legcom_dem_death_", 10, 14},
                {"legion_commander_custom_legcom_dem_econ_death_", 1, 3},
            }
        elseif self.persona[self.model_name] then
            string_table = 
            {
                {"legion_commander_auto_custom_legcom_death_", 1, 4},
                {"legion_commander_auto_custom_legcom_death_", 6, 8},
                {"legion_commander_auto_custom_legcom_death_", 10, 14},
            }
        else 
            string_table = 
            {
                {"legion_commander_custom_legcom_death_", 1, 4},
                {"legion_commander_custom_legcom_death_", 6, 8},
                {"legion_commander_custom_legcom_death_", 10, 14},
            }
        end 
    end

    return string_table
end 



if self.unit_name == "npc_dota_hero_nevermore" then 

    if is_reinc then 

    else 
        if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
        
            string_table = 
            {
                {"nevermore_custom_nev_arc_death_", 1, 1},
                {"nevermore_custom_nev_arc_death_", 3, 11},
                {"nevermore_custom_nev_arc_death_", 15, 19},
            }
        else 
            string_table = 
            {
                {"nevermore_custom_nev_death_", 1, 1},
                {"nevermore_custom_nev_death_", 3, 11},
                {"nevermore_custom_nev_death_", 15, 19},
            }
        end 
    end

    return string_table
end 


if self.unit_name == "npc_dota_hero_razor" then 

    if is_reinc then 

    else 

        if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then

            string_table = 
            {
                {"razor_rz_custom_vsa_death_", 1, 12},
            }

        else 
            string_table = 
            {
                {"razor_raz_custom_death_", 1, 11},
            }
        end 
    end

    return string_table
end 


if self.unit_name == "npc_dota_hero_queenofpain" then 

    if is_reinc then 

    else 

        if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
            string_table = 
            {
                {"queenofpain_custom_qop_arc_death_", 1, 18},
            }

        else 
            string_table = 
            {
                {"queenofpain_custom_pain_death_", 1, 14},
            }
        end 
    end

    return string_table
end 


if self.unit_name == "npc_dota_hero_skeleton_king" then 

    if is_reinc then 

        if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
        
            string_table = 
            {
                {"skeleton_king_custom_skel_arc_fastres_", 1, 3},
                {"skeleton_king_custom_skel_arc_death_", 41, 50},
                {"skeleton_king_custom_skel_arc_death_", 56, 56},
                {"skeleton_king_custom_skel_arc_death_", 61, 61},
                {"skeleton_king_custom_skel_arc_ability_incarn2_", 1, 3},
            }
        else 
            string_table = 
            {
                {"skeleton_king_custom_wraith_fastres_", 1, 3},
                {"skeleton_king_custom_wraith_death_", 32, 35},
                {"skeleton_king_custom_wraith_death_", 15, 15},
                {"skeleton_king_custom_wraith_ability_incarn2_", 1, 3}
            }
        end 
    else 

        if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
        
            string_table = 
            {
                {"skeleton_king_custom_skel_arc_death_", 1, 12},
                {"skeleton_king_custom_skel_arc_death_", 23, 31},
                {"skeleton_king_custom_skel_arc_death_", 36, 39},
                {"skeleton_king_custom_skel_arc_death_long_", 1, 14},
                {"skeleton_king_custom_skel_arc_death_long_", 16, 17},
                {"skeleton_king_custom_skel_arc_ability_incarn1_", 2, 16}
            }
        else 
            string_table = 
            {
                {"skeleton_king_custom_wraith_death_long_", 1, 14},
                {"skeleton_king_custom_wraith_death_long_", 16, 17},
                {"skeleton_king_custom_wraith_death_", 1, 12},
                {"skeleton_king_custom_wraith_death_", 22, 31},
                {"skeleton_king_custom_wraith_death_", 36, 39},
                {"skeleton_king_custom_wraith_ability_incarn1_", 2, 5}
            }
        end 
    end

    return string_table
end 



if self.unit_name == "npc_dota_hero_monkey_king" then 

    if self:IsMkArcana() then
        string_table = 
        {
            {"monkey_king_custom_monkey_crown_death_", 1, 2},
            {"monkey_king_custom_monkey_crown_death_", 4, 16},
        }
    else 
        string_table = 
        {
            {"monkey_king_custom_monkey_death_", 1, 2},
            {"monkey_king_custom_monkey_death_", 4, 16},
        }
        
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_zuus" then 

    if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then

        if attacker and attacker:GetUnitName() == "npc_dota_hero_mars" then 
            string_table = 
            {
                {"zuus_custom_zeus_arc_mars_death_", 1, 1},
                {"zuus_custom_zeus_arc_mars_death_02_", 2, 2},
                {"zuus_custom_zeus_arc_mars_death_03_", 3, 3},
                {"zuus_custom_zeus_arc_mars_death_", 4, 4},
                {"zuus_custom_zeus_arc_mars_death_05_", 2, 2},
                {"zuus_custom_zeus_arc_mars_death_06_", 2, 2},
                {"zuus_custom_zeus_arc_mars_death_07_", 2, 2},
                {"zuus_custom_zeus_arc_mars_death_", 8, 8},
                {"zuus_custom_zeus_arc_mars_death_09_", 3, 3},
                {"zuus_custom_zeus_arc_mars_death_10_", 4, 4},
                {"zuus_custom_zeus_arc_mars_death_", 11, 11},
                {"zuus_custom_zeus_arc_mars_death_12_", 2, 2},
                {"zuus_custom_zeus_arc_mars_death_13_", 5, 5},
                {"zuus_custom_zeus_arc_mars_death_14_", 2, 2},
                {"zuus_custom_zeus_arc_mars_death_15_", 8, 8},
            }
        else 
            string_table = 
            {
                {"zuus_custom_zuus_arc_death_", 1, 9},
            }
        end
    else 
        if attacker and attacker:GetUnitName() == "npc_dota_hero_mars" then 
            string_table = 
            {
                {"zuus_custom_zeus_mars_death_", 1, 1},
                {"zuus_custom_zeus_mars_death_02_", 2, 2},
                {"zuus_custom_zeus_mars_death_03_", 3, 3},
                {"zuus_custom_zeus_mars_death_", 4, 4},
                {"zuus_custom_zeus_mars_death_05_", 2, 2},
                {"zuus_custom_zeus_mars_death_06_", 2, 2},
                {"zuus_custom_zeus_mars_death_07_", 2, 2},
                {"zuus_custom_zeus_mars_death_", 8, 8},
                {"zuus_custom_zeus_mars_death_09_", 3, 3},
                {"zuus_custom_zeus_mars_death_10_", 4, 4},
                {"zuus_custom_zeus_mars_death_", 11, 11},
                {"zuus_custom_zeus_mars_death_12_", 2, 2},
                {"zuus_custom_zeus_mars_death_13_", 5, 5},
                {"zuus_custom_zeus_mars_death_14_", 2, 2},
                {"zuus_custom_zeus_mars_death_15_", 8, 8},
            }
        else 
            string_table = 
            {
                {"zuus_custom_zuus_death_", 1, 9},
            }
        end
    end 

    return string_table
end



if self.unit_name == "npc_dota_hero_pudge" then 

    if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
        string_table = 
        {
            {"pudge_custom_pud_arc_death_", 3, 10},
            {"pudge_custom_pud_arc_death_", 12, 15},
            {"pudge_custom_pud_arc_death_02_", 2, 2},
            {"pudge_custom_pud_arc_death_11_", 1, 1},
        }
    elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then
        string_table = 
        {
            {"pudge_custom_toy_pug_death_", 1, 17},
        }
    else
        string_table = 
        {
            {"pudge_custom_pud_death_", 1, 11},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
        string_table = 
        {
            {"drowranger_custom_drow_arc_death_", 1, 15},
        }
    elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
        string_table = 
        {
            {"drowranger_custom_dro_death_", 1, 6},
            {"drowranger_custom_dro_death_", 8, 8},
            {"drowranger_custom_drow_death_", 9, 14},
        }
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_skywrath_mage" then 
    if self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
        string_table = 
        {
            {"skywrath_mage_custom_drag_death_", 1, 11},
        }
    elseif self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
        string_table = 
        {
            {"skywrath_mage_custom_skywrath_crown_death_", 1, 21},
        }
    end 
    return string_table
end

if self.unit_name == "npc_dota_hero_antimage" then 
    if self.normal[self.model_name] then
        string_table = 
        {
            {"antimage_custom_anti_death_", 1, 14},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"antimage_custom_amp_wei_death_", 1, 2},
            {"antimage_custom_amp_wei_death_", 4, 6},
            {"antimage_custom_amp_wei_death_", 8, 18},
        }
    end 
    return string_table
end 

if self.unit_name == "npc_dota_hero_axe" then 
    if self.model_name == "models/heroes/axe/axe.vmdl" then
    
        string_table = 
        {
            {"axe_axe_custom_death_", 1, 10},
        }
    elseif self.arcana[self.model_name] then

        string_table = 
        {
            {"axe_jung_custom_axe_death_", 1, 1},
            {"axe_jung_custom_axe_death_01_", 3, 3},
            {"axe_jung_custom_axe_death_02_", 3, 3},
            {"axe_jung_custom_axe_death_03_", 2, 2},
            {"axe_jung_custom_axe_death_04_", 3, 3},
            {"axe_jung_custom_axe_death_", 5, 5},
            {"axe_jung_custom_axe_death_06_", 3, 3},
            {"axe_jung_custom_axe_death_07_", 3, 3},
            {"axe_jung_custom_axe_death_08_", 3, 3},
            {"axe_jung_custom_axe_death_", 9, 9},
            {"axe_jung_custom_axe_death_10_", 3, 3},
            {"axe_jung_custom_axe_death_", 11, 11},
            {"axe_jung_custom_axe_death_11_", 3, 3},
        }
    elseif self.persona[self.model_name] then
        string_table = 
        {
            {"axe_auto_custom_axe_death_", 1, 10},
        }
    end  
    return string_table
end 


if self.unit_name == "npc_dota_hero_ogre_magi" then 
    if self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
    
        string_table = 
        {
            {"ogre_magi_custom_ogmag_death_", 1, 17},
        }
    elseif self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
        string_table = 
        {
            {"ogre_magi_custom_ogm_arc_death_", 1, 22},
        }
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_invoker" then 
    if self.model_name == "models/heroes/invoker/invoker.vmdl" then
    
        string_table = 
        {
            {"invoker_custom_invo_death_", 1, 13},
        }
    elseif self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then
        string_table = 
        {
            {"invoker_custom_kidvoker_death_", 1, 16},
        }
    end 
    return string_table
end 


if self.unit_name == "npc_dota_hero_crystal_maiden" then
    if self.normal[self.model_name] then

        if attacker and attacker:GetUnitName() == "npc_dota_hero_lina" then 

            string_table = 
            {
                {"crystalmaiden_custom_cm_lina_", 16, 19},
            }
        else

            string_table = 
            {
                {"crystalmaiden_custom_cm_death_", 1, 7},
            }
        end
    elseif self.persona[self.model_name] then

        string_table = 
        {
            {"crystalmaiden_custom_cm_wolf_death_", 1, 15},
        }
    end
    return string_table
end
    

if self.unit_name == "npc_dota_hero_terrorblade" then
    if self.normal[self.model_name] then
        string_table = 
        {
            {"terrorblade_terr_custom_death_", 1, 11},
        }
    elseif self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
        string_table =
        {
            {"terrorblade_terr_custom_morph_death_", 1, 11},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_morphling" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"morphling_auto_mrph_custom_death_", 1, 11},
        }
    else
        string_table =
        {
            {"morphling_mrph_custom_death_", 1, 11},
        }
    end
    return string_table
end

if self.unit_name == "npc_dota_hero_bristleback" then
    if self.persona[self.model_name] then
        string_table = 
        {
            {"bristleback_auto_bristle_custom_death_", 1, 11},
        }
    else
        string_table =
        {
            {"bristleback_bristle_custom_death_", 1, 11},
        }
    end
    return string_table
end

return string_table
end 




function modifier_voice_module:GetKillVoice(unit)
if not IsServer() then return end

local string_table = {}

local target_name = unit:GetUnitName()
local unit_table = nil

if self.unit_name == "npc_dota_hero_juggernaut" then 

    if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
        self:JuggKill()
    end 

    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
            string_table = {{"juggernaut_custom_jug_arc_firstblood_", 1, 1}}
        else 
            string_table = {{"juggernaut_custom_jugg_firstblood_", 1, 1}}
        end
    else

        local key = ""
        if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
            unit_table = rival_table.juggernaut_arc[target_name]
            key = "juggernaut_custom_jug_arc_rival_"
        else 
            unit_table = rival_table.juggernaut[target_name]
            key = "juggernaut_custom_jugg_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            string_table = {{key, unit_table[1], unit_table[#unit_table]}}
        else 

            if self.model_name == "models/heroes/juggernaut/juggernaut_arcana.vmdl" then
                string_table = 
                {
                    {"juggernaut_custom_jug_arc_kill_", 1, 12},
                }
            else
                string_table = 
                {
                    {"juggernaut_custom_jug_kill_", 1, 12},
                }
            end 
        end 
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_phantom_assassin" then 

    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then
            string_table = {{"phantom_assassin_custom_phass_arc_firstblood_", 1, 2}}
        elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 
            string_table = {{"phantom_assassin_custom_pa_asan_firstblood_", 1, 6}}
        else 
            string_table = {{"phantom_assassin_custom_phass_firstblood_", 1, 2}}
        end
    else

        local key = ""
        if self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then
            key = "phantom_assassin_custom_pa_asan_rival_"
            unit_table = rival_table.pa_persona[target_name]
        end 


        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 

            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], 1})
            end 

        else 

            if self.model_name == "models/heroes/phantom_assassin/pa_arcana.vmdl" then
                string_table = 
                {
                    {"phantom_assassin_custom_phass_arc_kill_", 1, 13},
                    {"phantom_assassin_custom_phass_arc_ability_blur_", 2, 2},
                    {"phantom_assassin_custom_phass_arc_ability_phantomstrike_", 1, 3},
                    {"phantom_assassin_custom_phass_arc_laugh_", 1, 7}
                }
            elseif self.model_name == "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl" then 

                string_table = 
                {
                    {"phantom_assassin_custom_pa_asan_big_crit_", 1, 8},
                    {"phantom_assassin_custom_pa_asan_crit_kill_", 1, 18},
                    {"phantom_assassin_custom_pa_asan_dagger_kill_", 1, 10},
                    {"phantom_assassin_custom_pa_asan_kill_", 1, 20},
                    {"phantom_assassin_custom_pa_asan_laugh_", 1, 6}
                }

            else 
                string_table = 
                {
                    {"phantom_assassin_custom_phass_kill_", 1, 13},
                    {"phantom_assassin_custom_phass_ability_blur_", 2, 2},
                    {"phantom_assassin_custom_phass_ability_phantomstrike_", 1, 3},
                    {"phantom_assassin_custom_phass_laugh_", 1, 7}
                }
            end 
        end 
    end 

    return string_table
end 




if self.unit_name == "npc_dota_hero_legion_commander" then 


    if dota1x6.KillCount == 1 then 

    if self:IsLcArcana() then
            string_table = {{"legion_commander_custom_legcom_dem_firstblood_", 1, 3}}
        elseif self.persona[self.model_name] then
            string_table = {{"legion_commander_auto_custom_legcom_firstblood_", 1, 3}}
        else 
            string_table = {{"legion_commander_custom_legcom_firstblood_", 1, 3}}
        end
    else

        local key = ""
        if self:IsLcArcana() then
            unit_table = rival_table.legion_arc[target_name]
            key = "legion_commander_custom_legcom_dem_rival_"
        elseif self.persona[self.model_name] then
            unit_table = rival_table.legion[target_name]
            key = "legion_commander_auto_custom_legcom_rival_"
        else 
            unit_table = rival_table.legion[target_name]
            key = "legion_commander_custom_legcom_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 

            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], 0})
            end 

        else 
            if self:IsLcArcana() then
                string_table = 
                {
                    {"legion_commander_custom_legcom_dem_kill_", 1, 10},
                    {"legion_commander_custom_legcom_dem_kill_", 12, 19},
                    {"legion_commander_custom_legcom_dem_laugh_", 4, 7},
                }
            elseif self.persona[self.model_name] then
                string_table = 
                {
                    {"legion_commander_auto_custom_legcom_kill_", 1, 10},
                    {"legion_commander_auto_custom_legcom_kill_", 12, 19},
                    {"legion_commander_auto_legcom_laugh_", 4, 7},
                }
            else 
                string_table = 
                {
                    {"legion_commander_custom_legcom_kill_", 1, 10},
                    {"legion_commander_custom_legcom_kill_", 12, 19},
                    {"legion_commander_legcom_laugh_", 4, 7},
                }
            end 
        end 
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_nevermore" then 


    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
            string_table = {{"nevermore_custom_nev_arc_firstblood_", 1, 3}}
        else 
            string_table = {{"nevermore_custom_nev_firstblood_", 1, 3}}
        end
    else

        local key = ""
        if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
            unit_table = rival_table.nevermore_arc[target_name]
            key = "nevermore_custom_nev_arc_rival_"
        else 
            unit_table = rival_table.nevermore[target_name]
            key = "nevermore_custom_nev_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], 0})
            end 
        
        else 

            if self.model_name == "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl" then
                string_table = 
                {
                    {"nevermore_custom_nev_arc_kill_", 1, 13},
                    {"nevermore_custom_nev_arc_laugh_", 2, 4},
                }
            else
                string_table = 
                {
                    {"nevermore_custom_nev_kill_", 1, 13},
                    {"nevermore_custom_nev_laugh_", 2, 4},
                }
            end 
        end 
    end 

    return string_table
end 




if self.unit_name == "npc_dota_hero_razor" then 


    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
            string_table = {{"razor_rz_custom_vsa_firstblood_", 1, 5}}
        else 
            string_table = {{"razor_raz_custom_firstblood_", 1, 1}}
        end
    else

        local key = ""
        if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
            unit_table = rival_table.razor_arc[target_name]
            key = "razor_rz_custom_vsa_rival_"
        else 
            unit_table = rival_table.razor[target_name]
            key = "razor_raz_custom_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], 0})
            end 
        
        else 

            if self.model_name == "models/items/razor/razor_arcana/razor_arcana.vmdl" then
                string_table = 
                {
                    {"razor_rz_custom_vsa_kill_", 1, 18},
                    {"razor_rz_custom_vsa_laugh_", 4, 10},
                }
            else
                string_table = 
                {
                    {"razor_raz_custom_kill_", 1, 15},
                    {"razor_raz_custom_laugh_", 1, 6},
                }
            end 
        end 
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_queenofpain" then 


    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
            string_table = {{"queenofpain_custom_qop_arc_first_", 2, 7}}
        else 
            string_table = {{"queenofpain_custom_pain_first_", 2, 2}}
        end
    else

        local key = ""

        if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
            unit_table = rival_table.queen_arc[target_name]
            key = "queenofpain_custom_qop_arc_rival_"
        else 
            unit_table = rival_table.queen[target_name]
            key = "queenofpain_custom_pain_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], 0})
            end 
        
        else 

            if self.model_name == "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl" then
                string_table = 
                {
                    {"queenofpain_custom_qop_arc_kill_", 1, 38},
                    {"queenofpain_custom_qop_arc_ability_screamofpain_", 1, 4},
                    {"queenofpain_custom_qop_arc_ability_sonicwave_", 1, 4},
                }
            else
                string_table = 
                {
                    {"queenofpain_custom_pain_kill_", 1, 16},
                    {"queenofpain_custom_pain_ability_screamofpain_", 1, 4},
                    {"queenofpain_custom_pain_ability_sonicwave_", 1, 4}
                }
            end 
        end 
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_skeleton_king" then 


    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
            string_table = {{"skeleton_king_custom_skel_arc_firstblood_", 1, 4}}
        else 
            string_table = {{"skeleton_king_custom_wraith_firstblood_", 1, 2}}
        end
    else

        local key = ""

        if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
            unit_table = rival_table.skelet_arc[target_name]
            key = "skeleton_king_custom_skel_arc_rival_"
        else 
            unit_table = rival_table.skelet[target_name]
            key = "skeleton_king_custom_wraith_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], 0})
            end 
        
        else 

            if self.model_name == "models/items/wraith_king/arcana/wraith_king_arcana.vmdl" then
                string_table = 
                {
                    {"skeleton_king_custom_skel_arc_kill_", 1, 23},
                    {"skeleton_king_custom_skel_arc_kill_", 25, 27},
                    {"skeleton_king_custom_skel_arc_laugh_", 1, 10},
                }
            else
                string_table = 
                {
                    {"skeleton_king_custom_wraith_kill_", 1, 23},
                    {"skeleton_king_custom_wraith_laugh_", 1, 9}
                }
            end 
        end 
    end 

    return string_table
end 




if self.unit_name == "npc_dota_hero_monkey_king" then 


    if dota1x6.KillCount == 1 then 

        if self:IsMkArcana() then
            string_table = {{"monkey_king_custom_monkey_crown_firstblood_", 1, 5}}
        else 
            string_table = {{"monkey_king_custom_monkey_firstblood_", 1, 5}}
        end
    else

        local key = ""

        if self:IsMkArcana() then
            unit_table = rival_table.monkey[target_name]
            key = "monkey_king_custom_monkey_crown_rival_"
        else 
            unit_table = rival_table.monkey[target_name]
            key = "monkey_king_custom_monkey_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], 0})
            end 
        
        else 

            if self:IsMkArcana() then
                string_table = 
                {
                    {"monkey_king_custom_monkey_crown_kill_", 1, 12},
                    {"monkey_king_custom_monkey_crown_laugh_", 1, 14}
                }
            else
                string_table = 
                {
                    {"monkey_king_custom_monkey_kill_", 1, 12},
                    {"monkey_king_custom_monkey_laugh_", 1, 14}
                }
            end 
        end 
    end 

    return string_table
end 

if self.unit_name == "npc_dota_hero_zuus" then 


    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then
            string_table = {{"zuus_custom_zuus_arc_firstblood_", 1, 1}}
        else 
            string_table = {{"zuus_custom_zuus_firstblood_", 1, 1}}
        end
    else

        local key = ""


        if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then

            if target_name == "npc_dota_hero_mars" then 
                unit_table = rival_table.zuus_mars[target_name]
                key = "zuus_custom_zeus_arc_mars_kill_"
            else 
                unit_table = rival_table.zuus[target_name]
                key = "zuus_custom_zuus_arc_rival_"
            end
        else 
            if target_name == "npc_dota_hero_mars" then 
                unit_table = rival_table.zuus_mars[target_name]
                key = "zuus_custom_zeus_mars_kill_"
            else 
                unit_table = rival_table.zuus[target_name]
                key = "zuus_custom_zuus_rival_"
            end
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], 0})
            end 
        else 
            if self.model_name == "models/heroes/zeus/zeus_arcana.vmdl" then
                string_table = 
                {
                    {"zuus_custom_zuus_arc_kill_", 1, 15},
                    {"zuus_custom_zuus_arc_laugh_", 1, 4}
                }
            else
                string_table = 
                {
                    {"zuus_custom_zuus_kill_", 1, 15},
                    {"zuus_custom_zuus_laugh_", 1, 4}
                }
            end 
        end 
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_pudge" then 


    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
            string_table = {{"pudge_custom_pud_arc_firstblood_", 1, 3}}
        elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then
            string_table = {{"pudge_custom_toy_pug_firstblood_", 1, 4}}
        else 
            string_table = {{"pudge_custom_pud_firstblood_", 1, 1}}
        end
    else

        local key = ""

        if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
            unit_table = rival_table.pudge_arcana[target_name]
            key = "pudge_custom_pud_arc_rival_"
        elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

            unit_table = rival_table.pudge_toy[target_name]
            key = "pudge_custom_toy_pug_rival_"
        else 
            unit_table = rival_table.pudge[target_name]
            key = "pudge_custom_pud_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], 0})
            end 
        
        else 

            if self.model_name == "models/items/pudge/arcana/pudge_arcana_base.vmdl" then
                string_table = 
                {
                    {"pudge_custom_pud_arc_kill_", 1, 15},
                    {"pudge_custom_pud_arc_laugh_", 2, 15}
                }
            elseif self.model_name == "models/heroes/pudge_cute/pudge_cute.vmdl" then

                string_table = 
                {
                    {"pudge_custom_toy_pug_kill_", 1, 17},
                    {"pudge_custom_toy_pug_laugh_", 1, 12}
                }
            else 
                string_table = 
                {
                    {"pudge_custom_pud_kill_", 1, 11},
                    {"pudge_custom_pud_laugh_", 1, 6}
                }
            end 
        end 
    end 

    return string_table
end 




if self.unit_name == "npc_dota_hero_drow_ranger" then 

    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
            string_table = {{"drowranger_custom_drow_arc_firstblood_", 1, 5}}
        elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
            string_table = {{"drowranger_custom_drow_firstblood_", 1, 1}}
        end
    else

        local key = ""

        if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
            unit_table = rival_table.drow_arcana[target_name]
            key = "drowranger_custom_drow_arc_rival_"
        elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then
            unit_table = rival_table.drow[target_name]
            key = "drowranger_custom_drow_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            
            local zero = 0
            if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then 
                zero = 1
            end

            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], zero})
            end 
        
        else 

            if self.model_name == "models/items/drow/drow_arcana/drow_arcana.vmdl" then
                string_table = 
                {
                    {"drowranger_custom_drow_arc_frost_arrow_kill_", 1, 10},
                    {"drowranger_custom_drow_arc_kill_", 1, 19},
                    {"drowranger_custom_drow_arc_multishot_kill_", 1, 14},
                    {"drowranger_custom_drow_arc_laugh_", 2, 2},
                    {"drowranger_custom_drow_arc_laugh_", 4, 7},
                    {"drowranger_custom_drow_arc_laugh_", 9, 10},
                }
            elseif self.model_name == "models/heroes/drow/drow_base.vmdl" then

                string_table = 
                {
                    {"drowranger_custom_drow_kill_", 8, 17},
                    {"drowranger_custom_dro_kill_", 2, 2},
                    {"drowranger_custom_dro_kill_", 5, 7},
                    {"drowranger_custom_dro_laugh_", 4, 8},
                }
            end 
        end 
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_skywrath_mage" then 

    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
            string_table = {{"skywrath_mage_custom_skywrath_crown_firstblood_", 1, 5}}
        elseif self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
            string_table = {{"skywrath_mage_custom_drag_firstblood_", 1, 1}}
        end
    else

        local key = ""

        if self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
            unit_table = rival_table.sky_arcana[target_name]
            key = "skywrath_mage_custom_skywrath_crown_rival_"
        elseif self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then
            unit_table = rival_table.sky[target_name]
            key = "skywrath_mage_custom_drag_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            
            local zero = 0
            if self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then 
                zero = 1
            end

            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], zero})
            end 
        
        else 

            if self.model_name == "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl" then
                string_table = 
                {
                    {"skywrath_mage_custom_skywrath_crown_kill_", 1, 22},
                    {"skywrath_mage_custom_skywrath_crown_laugh_", 1, 8},
                }
            elseif self.model_name == "models/heroes/skywrath_mage/skywrath_mage.vmdl" then

                string_table = 
                {
                    {"skywrath_mage_custom_drag_kill_", 1, 12},
                    {"skywrath_mage_custom_drag_laugh_", 1, 3},
                    {"skywrath_mage_custom_drag_laugh_", 5, 5},
                    {"skywrath_mage_custom_drag_laugh_", 7, 7},
                }
            end 
        end 
    end 

    return string_table
end 

  
if self.unit_name == "npc_dota_hero_axe" then 
    if dota1x6.KillCount == 1 then 
        if self.arcana[self.model_name] then
            string_table = 
            {
                {"axe_jung_custom_axe_firstblood_", 1, 2},
            }
        elseif self.model_name == "models/heroes/axe/axe.vmdl" then
            string_table = {{"axe_axe_custom_firstblood_", 1, 2}}
        elseif self.persona[self.model_name] then
            string_table = 
            {
                {"axe_auto_custom_axe_firstblood_", 1, 2},
            }
        end 
    else

        local key = ""

        if self.arcana[self.model_name] then
            unit_table = rival_table.axe_persona[target_name]
            key = "axe_jung_custom_axe_rival_"
        elseif self.model_name == "models/heroes/axe/axe.vmdl" then
            unit_table = rival_table.axe[target_name]
            key = "axe_axe_custom_rival_"
        elseif self.persona[self.model_name] then
            unit_table = rival_table.axe[target_name]
            key = "axe_auto_custom_axe_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], zero})
            end 
        else 

            if self.arcana[self.model_name] then
                string_table = 
                {
                    {"axe_jung_custom_axe_kill_", 1, 11},
                    {"axe_jung_custom_axe_kill_", 13, 20},
                    {"axe_jung_custom_axe_kill_", 22, 23},
                    {"axe_jung_custom_axe_rival_", 21, 22}
                }
            elseif self.model_name == "models/heroes/axe/axe.vmdl" then
                string_table = 
                {
                    {"axe_axe_custom_kill_", 1, 20},
                    {"axe_axe_custom_rival_", 22, 23},
                }
            elseif self.persona[self.model_name] then
                 string_table = 
                {
                    {"axe_auto_custom_axe_kill_", 1, 20},
                    {"axe_auto_custom_axe_rival_", 22, 23},
                }
            end 
        end 
    end 

    return string_table
end 




if self.unit_name == "npc_dota_hero_ogre_magi" then 

    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
            string_table = 
            {
                {"ogre_magi_custom_ogm_arc_firstblood_", 1, 4},
            }
        elseif self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
            string_table = 
            {
                {"ogre_magi_custom_ogmag_firstblood_", 1, 2}
            }
        end
    else

        local key = ""

        if self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
            unit_table = rival_table.ogre_arcana[target_name]
            key = "ogre_magi_custom_ogm_arc_rival_"
        elseif self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then
            unit_table = rival_table.ogre[target_name]
            key = "ogre_magi_custom_ogmag_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], zero})
            end 
        else 

            if self.model_name == "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl" then
                string_table = 
                {
                    {"ogre_magi_custom_ogm_arc_kill_", 1, 18},
                    {"ogre_magi_custom_ogm_arc_laugh_", 2, 11},
                    {"ogre_magi_custom_ogm_arc_rival_", 54, 55},
                }
            elseif self.model_name == "models/heroes/ogre_magi/ogre_magi.vmdl" then

                string_table = 
                {
                    {"ogre_magi_custom_ogmag_kill_", 1, 13},
                    {"ogre_magi_custom_ogmag_laugh_", 3, 10},
                    {"ogre_magi_custom_ogmag_rival_", 4, 5}
                }
            end 
        end 
    end 

    return string_table
end 




if self.unit_name == "npc_dota_hero_invoker" then 

    if dota1x6.KillCount == 1 then 

        if self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then
            string_table = 
            {
                {"invoker_custom_kidvoker_first_", 1, 2},
                {"invoker_custom_kidvoker_first_03_", 2, 2},
                {"invoker_custom_kidvoker_first_", 4, 6},
            }
        elseif self.model_name == "models/heroes/invoker/invoker.vmdl" then
            string_table = 
            {
                {"invoker_custom_invo_first_", 1, 1}
            }
        end
    else

        local key = ""

        if self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then
            unit_table = rival_table.invoker_arcana[target_name]
            key = "invoker_custom_kidvoker_rival_"
        elseif self.model_name == "models/heroes/invoker/invoker.vmdl" then
            unit_table = rival_table.invoker[target_name]
            key = ""
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], zero})
            end 
        else 

            if self.model_name == "models/heroes/invoker_kid/invoker_kid.vmdl" then
                string_table = 
                {
                    {"invoker_custom_kidvoker_kill_", 1, 24},
                    {"invoker_custom_kidvoker_kill_25_", 2, 2},
                    {"invoker_custom_kidvo_la_laugh_", 2, 7},
                }
            elseif self.model_name == "models/heroes/invoker/invoker.vmdl" then

                string_table = 
                {
                    {"invoker_custom_invo_kill_", 1, 19},
                    {"invoker_custom_invo_laugh_", 2, 7},
                }
            end 
        end 
    end 

    return string_table
end 



if self.unit_name == "npc_dota_hero_crystal_maiden" then 

    if dota1x6.KillCount == 1 then 

        if self.persona[self.model_name] then
            string_table = 
            {
                {"crystalmaiden_custom_cm_wolf_firstblood_", 1, 6},
            }
        elseif self.normal[self.model_name] then
            string_table = 
            {
                {"crystalmaiden_custom_cm_firstblood_", 1, 1}
            }
        end
    else

        local key = ""

        if self.persona[self.model_name] then
            unit_table = rival_table.crystal_persona[target_name]
            key = "crystalmaiden_custom_cm_wolf_rival_"
        elseif self.normal[self.model_name] then
            unit_table = rival_table.crystal[target_name]
            key = "crystalmaiden_custom_cm_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 

            local zero = 0
            if self.persona[self.model_name] then 
                zero = 1
            end
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], zero})
            end 
        else 

            if self.persona[self.model_name] then
                string_table = 
                {
                    {"crystalmaiden_custom_cm_wolf_kill_", 1, 15},
                    {"crystalmaiden_custom_cm_wolf_frostbite_kill_", 1, 10},
                }
            elseif self.normal[self.model_name] then

                string_table = 
                {
                    {"crystalmaiden_custom_cm_kill_", 1, 20},
                }
            end 
        end 
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_terrorblade" then 

    if dota1x6.KillCount == 1 then 

        if self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
            string_table = 
            {
                {"terrorblade_terr_custom_morph_firstblood_", 1, 4},
            }
        elseif self.normal[self.model_name] then
            string_table = 
            {
                {"terrorblade_terr_custom_firstblood_", 1, 4}
            }
        end
    else

        local key = ""

        if self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
            unit_table = rival_table.terror[target_name]
            key = "terrorblade_terr_custom_morph_rival_"
        elseif self.normal[self.model_name] then
            unit_table = rival_table.terror[target_name]
            key = "terrorblade_terr_custom_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], zero})
            end 
        else 

            if self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
                string_table = 
                {
                    {"terrorblade_terr_custom_morph_kill_", 1, 14},
                    {"terrorblade_terr_custom_morph_laugh_", 2, 3},
                    {"terrorblade_terr_custom_morph_laugh_", 7, 9},
                }
            elseif self.normal[self.model_name] then

                string_table = 
                {
                    {"terrorblade_terr_custom_kill_", 1, 14},
                    {"terrorblade_terr_custom_laugh_", 2, 3},
                    {"terrorblade_terr_custom_laugh_", 7, 9},
                }
            end 
        end 
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_morphling" then 

    if dota1x6.KillCount == 1 then 

        if self.persona[self.model_name] then
            string_table = 
            {
                {"morphling_auto_mrph_custom_firstblood_", 1, 2},
            }
        else
            string_table = 
            {
                {"morphling_mrph_custom_firstblood_", 1, 2},
            }
        end
    else

        local key = ""
        if self.persona[self.model_name] then
          --  unit_table = rival_table.terror[target_name]
          --  key = "terrorblade_terr_custom_morph_rival_"
        else
          --  unit_table = rival_table.terror[target_name]
           -- key = "terrorblade_terr_custom_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], zero})
            end 
        else 
        if self.persona[self.model_name] then
                string_table = 
                {
                    {"morphling_auto_mrph_custom_kill_", 1, 10},
                    {"morphling_auto_mrph_custom_laugh_", 1, 5},
                }
            else
                string_table = 
                {
                    {"morphling_mrph_custom_kill_", 1, 10},
                    {"morphling_mrph_custom_laugh_", 1, 5},
                }
            end 
        end 
    end 

    return string_table
end 


if self.unit_name == "npc_dota_hero_bristleback" then 

    if dota1x6.KillCount == 1 then 

        if self.persona[self.model_name] then
            string_table = 
            {
                {"bristleback_auto_bristle_custom_firstblood_", 1, 3},
            }
        else
            string_table = 
            {
                {"bristleback_bristle_custom_firstblood_", 1, 3},
            }
        end
    else

        local key = ""
        if self.persona[self.model_name] then
          --  unit_table = rival_table.terror[target_name]
          --  key = "terrorblade_terr_custom_morph_rival_"
        else
          --  unit_table = rival_table.terror[target_name]
           -- key = "terrorblade_terr_custom_rival_"
        end 

        if unit_table and RollPseudoRandomPercentage(self.rivaL_chance,4251,self.parent) then 
            for i = 1, #unit_table do 
                table.insert(string_table, {key, unit_table[i], unit_table[i], zero})
            end 
        else 
        if self.persona[self.model_name] then
                string_table = 
                {
                    {"bristleback_auto_bristle_custom_kill_", 1, 13},
                    {"bristleback_auto_bristle_custom_laugh_", 1, 5},
                }
            else
                string_table = 
                {
                    {"bristleback_bristle_custom_kill_", 1, 13},
                    {"bristleback_bristle_custom_laugh_", 1, 5},
                }
            end 
        end 
    end 
    return string_table
end 

return string_table
end

