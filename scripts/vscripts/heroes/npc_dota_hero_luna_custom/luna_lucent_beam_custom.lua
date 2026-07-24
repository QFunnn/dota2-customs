--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_luna_lucent_beam_custom_cooldown", "heroes/npc_dota_hero_luna_custom/luna_lucent_beam_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_luna_lucent_beam_custom_handler", "heroes/npc_dota_hero_luna_custom/luna_lucent_beam_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_luna_lucent_beam_custom_damage_boost", "heroes/npc_dota_hero_luna_custom/luna_lucent_beam_custom", LUA_MODIFIER_MOTION_NONE)

luna_lucent_beam_custom = class({})

luna_lucent_beam_custom.modifier_luna_2 = {4,8,12}
luna_lucent_beam_custom.modifier_luna_2_duration = 15
luna_lucent_beam_custom.modifier_luna_2_manacost = {15,30,45}
luna_lucent_beam_custom.modifier_luna_6 = {0.3,0.6}
luna_lucent_beam_custom.modifier_luna_15_radius = 500
luna_lucent_beam_custom.modifier_luna_15_intellect = 150
luna_lucent_beam_custom.modifier_luna_15_base = 1
luna_lucent_beam_custom.modifier_luna_17 = {25,50}
luna_lucent_beam_custom.modifier_luna_18 = {30, 15}

function luna_lucent_beam_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_luna/luna_lucent_beam_precast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_luna/luna_lucent_beam.vpcf", context)
end

function luna_lucent_beam_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_luna_2") then
        local mana_cost = self.BaseClass.GetManaCost(self, level)
        return mana_cost - (mana_cost / 100 * self.modifier_luna_2_manacost[self:GetCaster():GetTalentLevel("modifier_luna_2")])
    end
    return self.BaseClass.GetManaCost(self, level)
end

function luna_lucent_beam_custom:GetIntrinsicModifierName()
    return "modifier_luna_lucent_beam_custom_handler"
end

function luna_lucent_beam_custom:OnAbilityPhaseStart()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/luna_lucent_beam_precast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(0.4,0,0) )
	ParticleManager:SetParticleControlEnt(effect_cast,0,self:GetCaster(),PATTACH_POINT_FOLLOW,"attach_attack1",Vector(0,0,0),true)
	ParticleManager:ReleaseParticleIndex( effect_cast )
	return true
end

function luna_lucent_beam_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
    self:CastBeamTarget(target)
    if self:GetCaster():HasModifier("modifier_luna_15") then
        local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, self.modifier_luna_15_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
        local max_counter = self.modifier_luna_15_base + math.floor(self:GetCaster():GetIntellect(false) / self.modifier_luna_15_intellect)
        if max_counter > 0 then
            for _, unit in ipairs(units) do
                if unit ~= target then
                    self:CastBeamTarget(unit)
                    max_counter = max_counter - 1
                    if max_counter <= 0 then
                        break
                    end
                end
            end
        end
    end
end

function luna_lucent_beam_custom:CastBeamTarget(target, is_ultimate, other_damage)
    if not IsServer() then return end
	local duration = self:GetSpecialValueFor("stun_duration")
    
    if self:GetCaster():HasModifier("modifier_luna_6") then
        duration = duration + self.modifier_luna_6[self:GetCaster():GetTalentLevel("modifier_luna_6")]
    end

    duration = duration * (1 - target:GetStatusResistance())

	local damage = self:GetSpecialValueFor("beam_damage")
    if self:GetCaster():HasModifier("modifier_luna_17") then
        damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_luna_17[self:GetCaster():GetTalentLevel("modifier_luna_17")])
    end

	ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self, damage_flags = DOTA_DAMAGE_FLAG_NONE})
	
    if not is_ultimate then
        target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = duration})
        self:GetCaster():EmitSound("Hero_Luna.LucentBeam.Cast")
        target:EmitSound("Hero_Luna.LucentBeam.Target")
    end

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/luna_lucent_beam.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl(effect_cast, 0, target:GetOrigin() )
	ParticleManager:SetParticleControlEnt(effect_cast, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt(effect_cast, 5, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt(effect_cast, 6, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true)
	ParticleManager:ReleaseParticleIndex(effect_cast)

    if self:GetCaster():HasModifier("modifier_luna_5") and not is_ultimate then
        self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)
    end

    if self:GetCaster():HasModifier("modifier_luna_2") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_luna_lucent_beam_custom_damage_boost", {duration = self.modifier_luna_2_duration})
    end
end

modifier_luna_lucent_beam_custom_handler = class({})
function modifier_luna_lucent_beam_custom_handler:IsHidden() return true end
function modifier_luna_lucent_beam_custom_handler:IsPurgable() return false end
function modifier_luna_lucent_beam_custom_handler:IsPurgeException() return false end
function modifier_luna_lucent_beam_custom_handler:RemoveOnDeath() return false end
function modifier_luna_lucent_beam_custom_handler:DeclareFunctions()
    return
    {
         
    }
end
function modifier_luna_lucent_beam_custom_handler:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.attacker == self:GetParent() then return end
    if not params.attacker:IsRealHero() then return end
    if not self:GetParent():HasModifier("modifier_luna_18") then return end
    if self:GetParent():HasModifier("modifier_luna_lucent_beam_custom_cooldown") then return end
    if self:GetParent():HasModifier("modifier_wodarelax") then return end
	if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
	if params.attacker:HasModifier("modifier_wodarelax") then return end
	if params.attacker:HasModifier("modifier_wodawispdeath_wisp") then return end
	if params.attacker:HasModifier("modifier_wodawisp") then return end
    if params.attacker:HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_luna_lucent_beam_custom_cooldown", {duration = self:GetAbility().modifier_luna_18[self:GetCaster():GetTalentLevel("modifier_luna_18")]})
    self:GetAbility():CastBeamTarget(params.attacker)
end

modifier_luna_lucent_beam_custom_damage_boost = class({})

function modifier_luna_lucent_beam_custom_damage_boost:GetTexture() return "luna_2" end

function modifier_luna_lucent_beam_custom_damage_boost:OnCreated(params)
    if not IsServer() then return end
    local current_damage = self:GetAbility().modifier_luna_2[self:GetCaster():GetTalentLevel("modifier_luna_2")]
    self:SetStackCount(self:GetStackCount() + current_damage)
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:SetStackCount(self:GetStackCount() - current_damage)
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_luna_lucent_beam_custom_damage_boost:OnRefresh(params)
    if not IsServer() then return end
    local current_damage = self:GetAbility().modifier_luna_2[self:GetCaster():GetTalentLevel("modifier_luna_2")]
    self:SetStackCount(self:GetStackCount() + current_damage)
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:SetStackCount(self:GetStackCount() - current_damage)
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_luna_lucent_beam_custom_damage_boost:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_luna_lucent_beam_custom_damage_boost:GetModifierPreAttack_BonusDamage()
    return self:GetStackCount()
end

modifier_luna_lucent_beam_custom_cooldown = class({})
function modifier_luna_lucent_beam_custom_cooldown:GetTexture() return "luna_18" end
function modifier_luna_lucent_beam_custom_cooldown:IsDebuff() return true end
function modifier_luna_lucent_beam_custom_cooldown:IsPurgable() return false end
function modifier_luna_lucent_beam_custom_cooldown:IsPurgeException() return false end
function modifier_luna_lucent_beam_custom_cooldown:RemoveOnDeath() return false end