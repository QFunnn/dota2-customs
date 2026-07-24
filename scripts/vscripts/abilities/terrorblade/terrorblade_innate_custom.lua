--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_terrorblade_innate_custom", "abilities/terrorblade/terrorblade_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_terrorblade_innate_custom_tracker", "abilities/terrorblade/terrorblade_innate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_terrorblade_innate_custom_aura_damage", "abilities/terrorblade/terrorblade_innate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_terrorblade_innate_custom_aura_damage_count", "abilities/terrorblade/terrorblade_innate_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_terrorblade_innate_custom_damage_reduce", "abilities/terrorblade/terrorblade_innate_custom", LUA_MODIFIER_MOTION_NONE)

terrorblade_innate_custom = class({})


function terrorblade_innate_custom:GetIntrinsicModifierName()
if self:GetCaster():IsRealHero() then
	return "modifier_terrorblade_innate_custom"
else
	return "modifier_terrorblade_innate_custom_tracker"
end

end

function terrorblade_innate_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "soundfile", "soundevents/npc_dota_hero_terrorblade.vsndevts", context )
PrecacheResource( "soundfile", "soundevents/vo_custom/terrorblade_vo_custom.vsndevts", context ) 
end



modifier_terrorblade_innate_custom_tracker = class({})
function modifier_terrorblade_innate_custom_tracker:IsHidden() return true end
function modifier_terrorblade_innate_custom_tracker:IsPurgable() return false end
function modifier_terrorblade_innate_custom_tracker:OnCreated()
if not IsServer() then return end
self.ability = self:GetAbility()
self.parent = self:GetParent()

self:StartIntervalThink(0.1)
end

function modifier_terrorblade_innate_custom_tracker:OnIntervalThink()
if not IsServer() then return end
if not self.parent.owner or self.parent.owner:IsNull() then return end

self.parent:AddNewModifier(self.parent.owner, self.ability, "modifier_terrorblade_innate_custom", {})

if self.parent:HasModifier("modifier_terrorblade_innate_custom") then
	self:StartIntervalThink(-1)
end

end



modifier_terrorblade_innate_custom = class({})
function modifier_terrorblade_innate_custom:IsHidden() return self:GetParent():IsIllusion() end
function modifier_terrorblade_innate_custom:IsPurgable() return false end
function modifier_terrorblade_innate_custom:RemoveOnDeath() return false end
function modifier_terrorblade_innate_custom:OnCreated(table)
self.parent = self:GetParent()
self.parent:AddDeathEvent(self)

self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.radius = self.ability:GetSpecialValueFor("radius")
self.damage_inc = self.ability:GetSpecialValueFor("damage_inc") + self.caster:GetTalentValue("modifier_terror_illusion_4", "damage")
self.damage_reduce = self.ability:GetSpecialValueFor("damage_reduce")

self.status_bonus = self.caster:GetTalentValue("modifier_terror_meta_6", "status", true)

self.range_bonus = self.caster:GetTalentValue("modifier_terror_meta_2", "bonus", true)

self.agility_max = self.caster:GetTalentValue("modifier_terror_illusion_4", "max", true)

self.burn_radius = self.caster:GetTalentValue("modifier_terror_illusion_1", "radius", true)
self.meta_radius = self.caster:GetTalentValue("modifier_terror_illusion_1", "radius_meta", true)

self.health_bonus = 0
self.magic_bonus = 0
self.move_bonus = 0
self.agi_bonus = 0
self.attack_range = 0

if not IsServer() then return end

if self.parent:HasTalent("modifier_terror_illusion_6") and self.parent:IsIllusion() then
	self.parent:AddNewModifier(self.parent, self.ability, "modifier_terrorblade_innate_custom_damage_reduce", {duration = self.parent:GetTalentValue("modifier_terror_illusion_6", "duration")})
end

self:UpdateTalent()
self:SetHasCustomTransmitterData(true)
if not self.parent:IsRealHero() then return end
self.interval = 0.2
self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end


function modifier_terrorblade_innate_custom:UpdateTalent()
self.health_bonus = self.parent:GetTalentValue("modifier_terror_sunder_2", "health")
self.magic_bonus = self.parent:GetTalentValue("modifier_terror_illusion_3", "magic")
self.move_bonus = self.parent:GetTalentValue("modifier_terror_illusion_3", "move")
self.agi_bonus = self.parent:GetTalentValue("modifier_terror_illusion_4", "agility")
self.attack_range = self.parent:GetTalentValue("modifier_terror_meta_2", "range")

self:SendBuffRefreshToClients()
end

function modifier_terrorblade_innate_custom:AddCustomTransmitterData() 
return 
{
    health_bonus = self.health_bonus,
    magic_bonus = self.magic_bonus,
    move_bonus = self.move_bonus,
    agi_bonus = self.agi_bonus,
    attack_range = self.attack_range,
} 
end

function modifier_terrorblade_innate_custom:HandleCustomTransmitterData(data)
self.health_bonus = data.health_bonus
self.magic_bonus = data.magic_bonus
self.move_bonus = data.move_bonus
self.agi_bonus = data.agi_bonus
self.attack_range = data.attack_range
end



function modifier_terrorblade_innate_custom:OnIntervalThink()
if not IsServer() then return end
self:SetStackCount(#self.parent:FindIllusions(self.radius))
end


function modifier_terrorblade_innate_custom:CheckState()
if not self.parent:HasTalent("modifier_terror_illusion_6") then return end
if not self.parent:IsIllusion() then return end
return
{
	[MODIFIER_STATE_UNSLOWABLE] = true
}
end


function modifier_terrorblade_innate_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
}
end

function modifier_terrorblade_innate_custom:DeathEvent(params)
    if not IsServer() then return end
    if params.unit ~= self.parent then return end
    if not self.parent:IsRealHero() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_death_custom.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    if self.parent.current_model == "models/heroes/terrorblade/terrorblade_arcana.vmdl" then
        local color = self.parent:GetTerrorbladeColor()
        ParticleManager:SetParticleControl(particle, 15, color)
        ParticleManager:SetParticleControl(particle, 16, Vector(1,0,0))
    else
        ParticleManager:SetParticleControl(particle, 15, Vector(0,152,255))
        ParticleManager:SetParticleControl(particle, 16, Vector(1,0,0))
    end
    local parent = self.parent
    Timers:CreateTimer(FrameTime(), function()
        if parent:IsAlive() then
            ParticleManager:DestroyParticle(particle, true)
            ParticleManager:ReleaseParticleIndex(particle)
        end
        return FrameTime()
    end)
end

function modifier_terrorblade_innate_custom:GetModifierStatusResistanceStacking()
if not self.parent:HasTalent("modifier_terror_meta_6") then return end
return self.status_bonus
end

function modifier_terrorblade_innate_custom:GetModifierHealthBonus()
return self.health_bonus*self.parent:GetAgility()
end

function modifier_terrorblade_innate_custom:GetModifierAttackRangeBonus()
local bonus = self.attack_range
if self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
	bonus = bonus*self.range_bonus
end
return bonus 
end

function modifier_terrorblade_innate_custom:GetModifierBonusStats_Agility()
local stack = self:GetStackCount()
if self.parent:IsIllusion() and self.caster:HasModifier(self:GetName()) then
	stack = self.caster:GetUpgradeStack(self:GetName())
end
stack = math.min(stack, self.agility_max)
return self.agi_bonus*stack
end


function modifier_terrorblade_innate_custom:GetModifierMagicalResistanceBonus()
if self.parent:IsIllusion() or self:GetStackCount() == 0 then return end
return self.magic_bonus
end


function modifier_terrorblade_innate_custom:GetModifierMoveSpeedBonus_Constant()
if self.parent:IsRealHero() and self:GetStackCount() == 0 then return end
return self.move_bonus
end

function modifier_terrorblade_innate_custom:GetModifierIncomingDamage_Percentage(params)
if not self.parent:IsIllusion() then return end
if self.parent:HasModifier("modifier_terrorblade_innate_custom_damage_reduce") then return end
if not params.damage_type then return end
if params.damage_type ~= DAMAGE_TYPE_MAGICAL then return end

return self.magic_bonus*-1
end


function modifier_terrorblade_innate_custom:GetModifierTotalDamageOutgoing_Percentage(params)
if not self.parent:IsIllusion() then return end
if not params.target:IsUnit() then return end
if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
if params.inflictor then return end

local stack = self.damage_inc
if (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then 
	stack = self.damage_reduce
end
return stack
end


function modifier_terrorblade_innate_custom:GetModifierDamageOutgoing_Percentage(params)
if not self.parent:IsIllusion() then return end
if IsServer() then return end

local stack = self.damage_inc
if (self.caster:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then 
	stack = self.damage_reduce
end
return stack
end



function modifier_terrorblade_innate_custom:GetAuraRadius() 
if self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
	return self.meta_radius
else
	return self.burn_radius 
end

end

function modifier_terrorblade_innate_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_terrorblade_innate_custom:GetAuraSearchType()  return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_terrorblade_innate_custom:GetModifierAura() return "modifier_terrorblade_innate_custom_aura_damage" end
function modifier_terrorblade_innate_custom:IsAura() return self.caster:HasTalent("modifier_terror_illusion_1") end



modifier_terrorblade_innate_custom_aura_damage = class({})
function modifier_terrorblade_innate_custom_aura_damage:IsHidden() return true end
function modifier_terrorblade_innate_custom_aura_damage:IsPurgable() return false end
function modifier_terrorblade_innate_custom_aura_damage:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_terrorblade_innate_custom_aura_damage:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
self.caster = self:GetCaster()
if self.caster.owner then
	self.caster = self.caster.owner
end
self.ability = self.caster:FindAbilityByName(self:GetAbility():GetName())

self.parent:AddNewModifier(self.caster, self.ability, "modifier_terrorblade_innate_custom_aura_damage_count", {})
end

function modifier_terrorblade_innate_custom_aura_damage:OnDestroy()
if not IsServer() then return end
local mod = self.parent:FindModifierByName("modifier_terrorblade_innate_custom_aura_damage_count")
if mod then 
	mod:DecrementStackCount()
	if mod:GetStackCount() < 1 then 
		mod:Destroy()
	end
end

end



modifier_terrorblade_innate_custom_aura_damage_count = class({})
function modifier_terrorblade_innate_custom_aura_damage_count:IsHidden() return false end
function modifier_terrorblade_innate_custom_aura_damage_count:IsPurgable() return false end
function modifier_terrorblade_innate_custom_aura_damage_count:GetTexture() return "buffs/illusion_burn" end
function modifier_terrorblade_innate_custom_aura_damage_count:GetEffectName() return "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf" end
function modifier_terrorblade_innate_custom_aura_damage_count:OnCreated(table)

self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.interval = self.caster:GetTalentValue("modifier_terror_illusion_1", "interval")
self.slow = self.caster:GetTalentValue("modifier_terror_illusion_1", "slow")
self.damage = self.caster:GetTalentValue("modifier_terror_illusion_1", "damage")*self.interval

if not IsServer() then return end

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_MAGICAL}

self:SetStackCount(1)
self:StartIntervalThink(self.interval)
end

function modifier_terrorblade_innate_custom_aura_damage_count:OnIntervalThink()
if not IsServer() then return end
local damage = self.damage*self:GetStackCount()
self.damageTable.damage = damage
DoDamage(self.damageTable, "modifier_terror_illusion_1")
end

function modifier_terrorblade_innate_custom_aura_damage_count:OnRefresh(table)
if not IsServer() then return end
self:IncrementStackCount()
end


function modifier_terrorblade_innate_custom_aura_damage_count:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_terrorblade_innate_custom_aura_damage_count:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end





modifier_terrorblade_innate_custom_damage_reduce = class({})
function modifier_terrorblade_innate_custom_damage_reduce:IsHidden() return true end
function modifier_terrorblade_innate_custom_damage_reduce:IsPurgable() return false end
function modifier_terrorblade_innate_custom_damage_reduce:OnCreated()
self.parent = self:GetParent()

if self.parent:IsRealHero() then
	self.damage_reduce = self.parent:GetTalentValue("modifier_terror_illusion_6", "damage_self")
else
	self.damage_reduce = self.parent:GetTalentValue("modifier_terror_illusion_6", "damage_reduce")
end

if not IsServer() then return end
self.effect = ParticleManager:CreateParticle("particles/terrorblade/illusion_damage_reduce.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(self.effect, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.effect, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
self:AddParticle(self.effect, false, false, -1, false, false)
end

function modifier_terrorblade_innate_custom_damage_reduce:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
}
end

function modifier_terrorblade_innate_custom_damage_reduce:GetModifierIncomingDamage_Percentage()
return self.damage_reduce
end