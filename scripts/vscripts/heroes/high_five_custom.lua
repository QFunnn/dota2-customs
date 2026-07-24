--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




LinkLuaModifier("modifier_high_five_custom_custom", "heroes/high_five_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_high_five_custom_custom_thinker", "heroes/high_five_custom", LUA_MODIFIER_MOTION_NONE)

high_five_custom = class({})

high_five_custom.particles_data =
{
    [707] = 
    {
        "particles/econ/events/diretide_2020/high_five/high_five_impact.vpcf",
        "particles/econ/events/diretide_2020/high_five/high_five_lvl1_travel.vpcf",
        "particles/econ/events/diretide_2020/high_five/high_five_lvl1_overhead.vpcf",
    },
    [708] = 
    {
        "particles/econ/misc/high_five/aghanim_puppet_2021/high_five_agh_2021_impact.vpcf",
        "particles/econ/misc/high_five/aghanim_puppet_2021/high_five_agh_2021_travel.vpcf",
        "particles/econ/misc/high_five/aghanim_puppet_2021/high_five_agh_2021_overhead.vpcf",
    },
    [709] = 
    {
        "particles/econ/events/fall_2022/high_five/high_five_fall2022_impact.vpcf",
        "particles/econ/events/fall_2022/high_five/high_five_fall2022_travel.vpcf",
        "particles/econ/events/fall_2022/high_five/high_five_fall_2022_overhead.vpcf",
    },
    [710] = 
    {
        "particles/econ/events/fall_2022/high_five/high_five_foam_hand_impact.vpcf",
        "particles/econ/events/fall_2022/high_five/high_five_foam_hand_travel.vpcf",
        "particles/econ/events/fall_2022/high_five/high_five_foam_hand_overhead.vpcf",
    },
    [711] = 
    {
        "particles/econ/events/frostivus_2023/high_five_mug_impact.vpcf",
        "particles/econ/events/frostivus_2023/high_five_mug_travel.vpcf",
        "particles/econ/events/frostivus_2023/high_five_mug_overhead.vpcf",
    },
    [712] = 
    {
        "particles/econ/events/newbloom_2020/high_five_newbloom_impact.vpcf",
        "particles/econ/events/newbloom_2020/high_five_newbloom_travel.vpcf",
        "particles/econ/events/newbloom_2020/high_five_newbloom_overhead.vpcf",
    },
    [713] = 
    {
        "particles/econ/events/plus/high_five/high_five_lvl2_impact.vpcf",
        "particles/econ/events/plus/high_five/high_five_lvl2_travel.vpcf",
        "particles/econ/events/plus/high_five/high_five_lvl2_overhead.vpcf",
    },
    [714] = 
    {
        "particles/econ/events/spring_2021/high_five_spring_2021_impact.vpcf",
        "particles/econ/events/spring_2021/high_five_spring_2021_travel.vpcf",
        "particles/econ/events/spring_2021/high_five_spring_2021_overhead.vpcf",
    },
    [715] = 
    {
        "particles/econ/events/spring_2021/high_five_spring_2021_impact.vpcf",
        "particles/econ/events/plus/high_five/high_five_lvl3_travel.vpcf",
        "particles/econ/events/plus/high_five/high_five_lvl3_overhead.vpcf",
    },
    [716] = 
    {
        "particles/econ/events/newbloom_2020/high_five_newbloom_impact.vpcf",
        "particles/econ/events/ti9/high_five/high_five_lvl3_travel.vpcf",
        "particles/econ/events/ti9/high_five/high_five_lvl3_overhead.vpcf",
    },
    [1013] = 
    {
        "particles/econ/events/monster_hunter/high_five_poogie_impact.vpcf",
        "particles/econ/events/monster_hunter/high_five_poogie_travel.vpcf",
        "particles/econ/events/monster_hunter/high_five_poogie_overhead.vpcf",
    },
    [1014] = 
    {
        "particles/econ/events/monster_hunter/high_five/high_five_monster_hunter_impact.vpcf",
        "particles/econ/events/monster_hunter/high_five/high_five_monster_hunter_travel.vpcf",
        "particles/econ/events/monster_hunter/high_five/high_five_monster_hunter_overhead.vpcf",
    },
    [1015] =
    {
        "particles/econ/events/newbloom_2020/high_five_newbloom_impact.vpcf",
        "particles/econ/events/newbloom_2024/high_five_newbloom_dragon_travel.vpcf",
        "particles/econ/events/newbloom_2024/high_five_newbloom_dragon_overhead.vpcf",
    },
    [1016] =
    {
        "particles/econ/events/ti9/high_five/high_five_impact.vpcf",
        "particles/econ/events/ti9/high_five/high_five_lvl2_travel_2019.vpcf",
        "particles/econ/events/ti9/high_five/high_five_lvl2_overhead_2019.vpcf",
    },
    [1085] =
    {
        "particles/econ/events/dark_carnival/high_five/high_five_dark_carnival_impact.vpcf",
        "particles/econ/events/dark_carnival/high_five/high_five_dark_carnival_travel.vpcf",
        "particles/econ/events/dark_carnival/high_five/high_five_dark_carnival_overhead.vpcf",
    },
}

function high_five_custom:OnSpellStart()
    if not IsServer() then return end
    self:StartCooldown(self:GetCooldown(-1))
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_high_five_custom_custom", {duration = 10})

    if IsInToolsMode() then
        local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
        for k, hero in pairs(units) do
            hero:AddNewModifier(hero, self, "modifier_high_five_custom_custom", {duration = 10})
        end
    end
end

modifier_high_five_custom_custom = class({})
function modifier_high_five_custom_custom:IsHidden() return true end
function modifier_high_five_custom_custom:IsPurgable() return false end
function modifier_high_five_custom_custom:IsPurgeException() return false end
function modifier_high_five_custom_custom:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("high_five.cast")
    self.overhead_effect = "particles/econ/events/plus/high_five/high_five_lvl1_overhead.vpcf"
    self.proj_effect = "particles/econ/events/plus/high_five/high_five_lvl1_travel.vpcf"
    self.target_proj = "particles/econ/events/plus/high_five/high_five_lvl1_travel.vpcf"
    self.explosion_proj = "particles/econ/events/plus/high_five/high_five_impact.vpcf"
    if player_system.PLAYERS_GLOBAL_INFORMATION[self:GetParent():GetPlayerOwnerID()] then
        local five_id = player_system.PLAYERS_GLOBAL_INFORMATION[self:GetParent():GetPlayerOwnerID()].five_id
        if self:GetAbility().particles_data[five_id] then
            self.overhead_effect = self:GetAbility().particles_data[five_id][3]
            self.proj_effect = self:GetAbility().particles_data[five_id][2]
            self.explosion_proj = self:GetAbility().particles_data[five_id][1]
        end
    end
    local particle = ParticleManager:CreateParticle(self.overhead_effect, PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
    self:StartIntervalThink(0.5)
end

function modifier_high_five_custom_custom:StartProj(caster, target, vPoint)
    if not IsServer() then return end
    if player_system.PLAYERS_GLOBAL_INFORMATION[target:GetPlayerOwnerID()] then
        local five_id = player_system.PLAYERS_GLOBAL_INFORMATION[target:GetPlayerOwnerID()].five_id
        if self:GetAbility().particles_data[five_id] then
            self.target_proj = self:GetAbility().particles_data[five_id][2]
        end
    end
    ProjectileManager:CreateLinearProjectile(
    {
        Source = caster,
        Ability = nil,
        vSpawnOrigin = caster:GetAbsOrigin(),
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_NONE,
        EffectName = self.proj_effect,
        fDistance = (vPoint - caster:GetOrigin()):Length2D(),
        fStartRadius = 10,
        fEndRadius = 10,
        vVelocity = (vPoint - caster:GetOrigin()):Normalized() * 700,
    })
    ProjectileManager:CreateLinearProjectile(
    {
        Source = target,
        Ability = nil,
        vSpawnOrigin = target:GetAbsOrigin(),
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_NONE,
        EffectName = self.target_proj,
        fDistance = (vPoint - target:GetOrigin()):Length2D(),
        fStartRadius = 10,
        fEndRadius = 10,
        vVelocity = (vPoint - target:GetOrigin()):Normalized() * 700,
    })
end

function modifier_high_five_custom_custom:OnIntervalThink()
	if not IsServer() then return end
    self:StartIntervalThink(0.1)
    local target = nil
    local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
	for k, hero in pairs(units) do
		if hero ~= self:GetParent() then
			if hero:HasModifier("modifier_high_five_custom_custom") then
                target = hero
                break
            end
        end
    end
    if target == nil then return end
	local vPoint = (target:GetOrigin() + self:GetParent():GetOrigin()) / 2
    self:StartProj(self:GetParent(), target, vPoint)
	CreateModifierThinker(self:GetParent(), nil, "modifier_high_five_custom_custom_thinker", {duration = (vPoint - target:GetOrigin()):Length2D()/700, particle = self.explosion_proj}, vPoint, self:GetParent():GetTeamNumber(), false)
	local modifier_high_five_custom_custom_target = target:FindModifierByName("modifier_high_five_custom_custom")
    if modifier_high_five_custom_custom_target then
        modifier_high_five_custom_custom_target.succes = true
        modifier_high_five_custom_custom_target:Destroy()
    end
    self.succes = true
	self:Destroy()
end

function modifier_high_five_custom_custom:OnDestroy()
    if not IsServer() then return end
    if self.succes then
        self:GetAbility():EndCooldown()
        self:GetAbility():StartCooldown(1)
    else
        self:GetParent():EmitSound("high_five.fail")
    end
end

modifier_high_five_custom_custom_thinker = class({})

function modifier_high_five_custom_custom_thinker:OnCreated(data)
    if not IsServer() then return end
    self.particle = data.particle
end

function modifier_high_five_custom_custom_thinker:OnDestroy()
	if not IsServer() then return end
    local particle = ParticleManager:CreateParticle(self.particle, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
	self:GetParent():EmitSound('high_five.impact')
end