--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_hunter_in_the_night_custom", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_hunter_in_the_night_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_hunter_in_the_night_custom_buff", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_hunter_in_the_night_custom", LUA_MODIFIER_MOTION_NONE)

night_stalker_hunter_in_the_night_custom = class({})
night_stalker_hunter_in_the_night_custom.modifier_night_stalker_16 = {10,20}

function night_stalker_hunter_in_the_night_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_night_stalker.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_night_stalker.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_night_stalker.vpcf", context)
    PrecacheResource("model", "models/heroes/nightstalker/nightstalker_night.vmdl", context)
end

function night_stalker_hunter_in_the_night_custom:GetIntrinsicModifierName()
	return "modifier_night_stalker_hunter_in_the_night_custom"
end

modifier_night_stalker_hunter_in_the_night_custom = class({})
function modifier_night_stalker_hunter_in_the_night_custom:IsPurgable() return false end
function modifier_night_stalker_hunter_in_the_night_custom:IsHidden() return true end
function modifier_night_stalker_hunter_in_the_night_custom:IsPurgable() return false end
function modifier_night_stalker_hunter_in_the_night_custom:IsPurgeException() return false end
function modifier_night_stalker_hunter_in_the_night_custom:RemoveOnDeath() return false end
function modifier_night_stalker_hunter_in_the_night_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_night_stalker_hunter_in_the_night_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_morphling_replicate_custom_manager") and not self:GetParent():HasModifier("modifier_morphling_replicate_custom") then return end
    if self:GetCaster():HasModifier("modifier_night_stalker_darkness_custom") or not GameRules:IsDaytime() or self:GetCaster():HasModifier("modifier_night_stalker_7") or self:GetCaster():HasModifier("modifier_night_stalker_void_custom_thinker_night_buff") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_night_stalker_hunter_in_the_night_custom_buff", {})
    else
        self:GetCaster():RemoveModifierByName("modifier_night_stalker_hunter_in_the_night_custom_buff")
    end
end

modifier_night_stalker_hunter_in_the_night_custom_buff = class({})
function modifier_night_stalker_hunter_in_the_night_custom_buff:IsPurgable() return false end
function modifier_night_stalker_hunter_in_the_night_custom_buff:IsPurgeException() return false end

function modifier_night_stalker_hunter_in_the_night_custom_buff:OnCreated()
    if not IsServer() then return end
    Timers:CreateTimer(FrameTime(), function()
        if self:GetParent():IsRealHero() then        
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_change.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
            ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())    
            ParticleManager:ReleaseParticleIndex(particle)
        end
    end)

    self.models = {}
    self:SpawnItems()
    local particle_buff = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_night_buff.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())    
	ParticleManager:SetParticleControl(particle_buff, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_buff, 1, Vector(1,0,0))
	self:AddParticle(particle_buff, false, false, -1, false, false)
    self:StartIntervalThink(0.1)
end

function modifier_night_stalker_hunter_in_the_night_custom_buff:SpawnItems()
    if not IsServer() then return end
    local wings = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/nightstalker/nightstalker_wings_night.vmdl"})
	local legs = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/nightstalker/nightstalker_legarmor_night.vmdl"})
	local tail = SpawnEntityFromTableSynchronous("prop_dynamic", {model = "models/heroes/nightstalker/nightstalker_tail_night.vmdl"})
	wings:FollowEntity(self:GetCaster(), true)
	legs:FollowEntity(self:GetCaster(), true)
	tail:FollowEntity(self:GetCaster(), true)
    table.insert(self.models, wings)
    table.insert(self.models, legs)
    table.insert(self.models, tail)
end

function modifier_night_stalker_hunter_in_the_night_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_wodawisp") then
        if #self.models > 0 then
            for _, model in pairs(self.models) do
                UTIL_Remove(model)
            end
            self.models = {}
        end
    else
        if #self.models <= 0 then
            self:SpawnItems()
        end
    end
end

function modifier_night_stalker_hunter_in_the_night_custom_buff:OnDestroy()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_change.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())    
    ParticleManager:ReleaseParticleIndex(particle)

    for _, model in pairs(self.models) do
        UTIL_Remove(model)
    end
end

function modifier_night_stalker_hunter_in_the_night_custom_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_night_stalker_hunter_in_the_night_custom_buff:GetModifierSpellAmplify_Percentage()
    if not self:GetCaster():HasModifier("modifier_night_stalker_16") then return end
    return self:GetAbility().modifier_night_stalker_16[self:GetCaster():GetTalentLevel("modifier_night_stalker_16")]
end

function modifier_night_stalker_hunter_in_the_night_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed_pct_night_custom")
end

function modifier_night_stalker_hunter_in_the_night_custom_buff:GetModifierAttackSpeedBonus_Constant()
    if self:GetCaster():HasModifier("modifier_night_stalker_16") then return end
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed_night_custom")
end

function modifier_night_stalker_hunter_in_the_night_custom_buff:GetModifierModelChange()
    return "models/heroes/nightstalker/nightstalker_night.vmdl"
end