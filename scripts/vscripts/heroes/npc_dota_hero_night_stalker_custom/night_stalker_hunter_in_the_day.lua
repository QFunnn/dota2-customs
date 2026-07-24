--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_hunter_in_the_day", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_hunter_in_the_day", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_hunter_in_the_day_buff", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_hunter_in_the_day", LUA_MODIFIER_MOTION_NONE)

night_stalker_hunter_in_the_day = class({})

function night_stalker_hunter_in_the_day:GetIntrinsicModifierName()
	return "modifier_night_stalker_hunter_in_the_day"
end

modifier_night_stalker_hunter_in_the_day = class({})
function modifier_night_stalker_hunter_in_the_day:IsPurgable() return false end
function modifier_night_stalker_hunter_in_the_day:IsHidden() return true end
function modifier_night_stalker_hunter_in_the_day:IsPurgable() return false end
function modifier_night_stalker_hunter_in_the_day:IsPurgeException() return false end
function modifier_night_stalker_hunter_in_the_day:RemoveOnDeath() return false end
function modifier_night_stalker_hunter_in_the_day:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_night_stalker_hunter_in_the_day:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_morphling_replicate_custom_manager") and not self:GetParent():HasModifier("modifier_morphling_replicate_custom") then return end
    if GameRules:IsDaytime() or self:GetCaster():HasModifier("modifier_night_stalker_revelation_thinker_night_buff") or self:GetCaster():HasModifier("modifier_night_stalker_day_walker") or self:GetCaster():HasModifier("modifier_night_stalker_14") then 
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_night_stalker_hunter_in_the_day_buff", {})
    else
        self:GetCaster():RemoveModifierByName("modifier_night_stalker_hunter_in_the_day_buff")
    end
end

modifier_night_stalker_hunter_in_the_day_buff = class({})
function modifier_night_stalker_hunter_in_the_day_buff:IsPurgable() return false end
function modifier_night_stalker_hunter_in_the_day_buff:IsPurgeException() return false end

function modifier_night_stalker_hunter_in_the_day_buff:OnCreated()
    if not IsServer() then return end
    Timers:CreateTimer(FrameTime(), function()
        if self:GetParent():IsRealHero() then        
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_change_day.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
            ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
            ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())    
            ParticleManager:ReleaseParticleIndex(particle)
        end
    end)

    self.models = {}
    self:SpawnItems()

    local particle_buff = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_night_buff_day.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())    
	ParticleManager:SetParticleControl(particle_buff, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_buff, 1, Vector(1,0,0))
	self:AddParticle(particle_buff, false, false, -1, false, false)
    self:StartIntervalThink(0.1)
end

function modifier_night_stalker_hunter_in_the_day_buff:SpawnItems()
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

function modifier_night_stalker_hunter_in_the_day_buff:OnIntervalThink()
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

function modifier_night_stalker_hunter_in_the_day_buff:OnDestroy()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_change_day.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())    
    ParticleManager:ReleaseParticleIndex(particle)
    for _, model in pairs(self.models) do
        UTIL_Remove(model)
    end
end

function modifier_night_stalker_hunter_in_the_day_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
        MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_night_stalker_hunter_in_the_day_buff:GetModifierProcAttack_Feedback(params)
    if not IsServer() then return end
    local damage = params.original_damage
	local splash_damage = damage * self:GetAbility():GetSpecialValueFor("cleave_damage") / 100
    DoCleaveAttack(self:GetCaster(), params.target, self:GetAbility(), splash_damage, 150, 360, 650, "particles/items_fx/battlefury_cleave.vpcf")
end

function modifier_night_stalker_hunter_in_the_day_buff:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("movement_speed")
end

function modifier_night_stalker_hunter_in_the_day_buff:GetModifierModelChange()
    return "models/heroes/nightstalker/nightstalker_night.vmdl"
end