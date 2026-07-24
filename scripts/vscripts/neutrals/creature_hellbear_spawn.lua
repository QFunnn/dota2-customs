--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_creature_hellbear_spawn", "neutrals/creature_hellbear_spawn", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

creature_hellbear_spawn_1 = class({})
function creature_hellbear_spawn_1:GetIntrinsicModifierName()
    return "modifier_creature_hellbear_spawn"
end
creature_hellbear_spawn_2 = class({})
function creature_hellbear_spawn_2:GetIntrinsicModifierName()
    return "modifier_creature_hellbear_spawn"
end
creature_hellbear_spawn_3 = class({})
function creature_hellbear_spawn_3:GetIntrinsicModifierName()
    return "modifier_creature_hellbear_spawn"
end
creature_hellbear_spawn_4 = class({})
function creature_hellbear_spawn_4:GetIntrinsicModifierName()
    return "modifier_creature_hellbear_spawn"
end
creature_hellbear_spawn_5 = class({})
function creature_hellbear_spawn_5:GetIntrinsicModifierName()
    return "modifier_creature_hellbear_spawn"
end

modifier_creature_hellbear_spawn = class({})
function modifier_creature_hellbear_spawn:IsHidden() return true end
function modifier_creature_hellbear_spawn:IsPurgable() return false end
function modifier_creature_hellbear_spawn:IsPurgeException() return false end
function modifier_creature_hellbear_spawn:OnCreated()
    if not IsServer() then return end
    self.creep_unit = nil
    self:StartIntervalThink(0.3)
end
function modifier_creature_hellbear_spawn:OnIntervalThink()
    if not IsServer() then return end
    local units = 
    {
        ["creature_hellbear_spawn_1"] = "npc_woda_boss_heal_bear_2",
        ["creature_hellbear_spawn_2"] = "npc_woda_boss_heal_bear_3",
        ["creature_hellbear_spawn_3"] = "npc_woda_boss_heal_bear_4",
        ["creature_hellbear_spawn_4"] = "npc_woda_boss_heal_bear_5",
        ["creature_hellbear_spawn_5"] = "npc_woda_boss_heal_bear_6",
    }
    local creep_name = units[self:GetAbility():GetAbilityName()]
    if creep_name == nil then return end
    self:GetCaster():StartGestureFadeWithSequenceSettings(ACT_DOTA_CAST_ABILITY_1)
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_neutral_cast", {})
    self:GetCaster():EmitSound("n_creep_Ursa.Clap")
    Timers:CreateTimer(0.5, function()
        local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/ursa_thunderclap.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
		ParticleManager:SetParticleControl(trail_pfx, 1, Vector(radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(trail_pfx)
		self:GetParent():RemoveModifierByName("modifier_neutral_cast")
        local creep = CreateUnitByName(creep_name, self:GetParent():GetAbsOrigin(), true, nil, nil, 4)
        if creep then
            creep:SetForwardVector(self:GetParent():GetForwardVector())
            creep:SetMinimumGoldBounty(0)
            creep:SetMaximumGoldBounty(0)
            creep:SetDeathXP(0)
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_meepo/meepo_poof_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, creep)
            ParticleManager:SetParticleControl(particle, 0, creep:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
            if creep_name ~= "npc_woda_pig_pve" and creep_name ~= "npc_woda_frog_pve" then
                Timers:CreateTimer(FrameTime()*2, function()
                    Timers:CreateTimer(FrameTime()*2, function()
                        arena_system:UpgradeCreepPVELastRound(PVE_CURRENT_WAVE, creep, false)
                    end)
                end)
            end
            Timers:CreateTimer(0.1, function()
                Timers:CreateTimer(0.1, function()
                    local modifier_multiplier = creep:AddNewModifier(creep, nil, "modifier_wodaduel_boss_multiplier", {players = player_system:GetPlayerCountAll()})
                    creep:SetMana(creep:GetMaxMana())
                end)
            end)
            FindClearSpaceForUnit(creep, creep:GetAbsOrigin(), true)
            self.creep_unit = creep
        end
	end)
    self:StartIntervalThink(-1)
end