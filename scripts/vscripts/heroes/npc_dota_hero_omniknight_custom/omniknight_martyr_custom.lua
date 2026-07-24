--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_omniknight_martyr_custom", "heroes/npc_dota_hero_omniknight_custom/omniknight_martyr_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_omniknight_martyr_custom_talent_passive", "heroes/npc_dota_hero_omniknight_custom/omniknight_martyr_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_omniknight_martyr_custom_talent_passive_cooldown", "heroes/npc_dota_hero_omniknight_custom/omniknight_martyr_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_omniknight_martyr_custom_talent_passive_buff", "heroes/npc_dota_hero_omniknight_custom/omniknight_martyr_custom", LUA_MODIFIER_MOTION_NONE )

omniknight_martyr_custom = class({})

function omniknight_martyr_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_repel_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_omniknight/omniknight_heavenly_grace_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", context )
end

omniknight_martyr_custom.modifier_omniknight_5_bonus = {10, 20}
omniknight_martyr_custom.modifier_omniknight_6_cooldown = {25, 21}

function omniknight_martyr_custom:GetCooldown(level)
    if self:GetCaster():HasModifier("modifier_omniknight_5") then
        return 0
    end
    return self.BaseClass.GetCooldown( self, level )
end

function omniknight_martyr_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_omniknight_5") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function omniknight_martyr_custom:GetIntrinsicModifierName()
	return "modifier_omniknight_martyr_custom_talent_passive"
end

function omniknight_martyr_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_omniknight_5") then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function omniknight_martyr_custom:OnSpellStart()
	if not IsServer() then return end
    local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")
    target:RemoveModifierByName("modifier_omniknight_martyr_custom")
	target:AddNewModifier( self:GetCaster(), self, "modifier_omniknight_martyr_custom", { duration = duration } )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_omniknight/omniknight_repel_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetCaster():GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_omniknight_martyr_custom = class({})

function modifier_omniknight_martyr_custom:IsPurgable()
	return false
end

function modifier_omniknight_martyr_custom:RemoveOnDeath()
	return not self:GetCaster():HasModifier("modifier_omniknight_5")
end

function modifier_omniknight_martyr_custom:OnCreated( kv )
    if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Omniknight.Repel")
    self:SetHasCustomTransmitterData( true )
end

function modifier_omniknight_martyr_custom:OnDestroy( kv )
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_Omniknight.Repel")
end

function modifier_omniknight_martyr_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
	}
	return funcs
end

function modifier_omniknight_martyr_custom:GetAbsoluteNoDamagePure(params)
    if not self:GetCaster():HasModifier("modifier_omniknight_martyr_custom_talent_passive_buff") then
        if self:GetCaster():HasModifier("modifier_omniknight_5") then return end
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_omniknight_martyr_custom:GetModifierConstantHealthRegen()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_omniknight_5") then
		bonus = self:GetAbility().modifier_omniknight_5_bonus[self:GetCaster():GetTalentLevel("modifier_omniknight_5")]
	end
	return self:GetAbility():GetSpecialValueFor("base_hpregen") + bonus
end

function modifier_omniknight_martyr_custom:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_heavenly_grace_buff.vpcf"
end

function modifier_omniknight_martyr_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_omniknight_martyr_custom:CheckState()
    if self:GetCaster():HasModifier("modifier_omniknight_5") then return end
    return
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end

function modifier_omniknight_martyr_custom:GetModifierMagicalResistanceBonus()
    if not self:GetCaster():HasModifier("modifier_omniknight_martyr_custom_talent_passive_buff") then
        if self:GetCaster():HasModifier("modifier_omniknight_5") then return end
    end
    return self:GetAbility():GetSpecialValueFor("magic_res")
end

modifier_omniknight_martyr_custom_talent_passive_cooldown = class({})
function modifier_omniknight_martyr_custom_talent_passive_cooldown:IsDebuff() return true end
function modifier_omniknight_martyr_custom_talent_passive_cooldown:IsPurgable() return false end


modifier_omniknight_martyr_custom_talent_passive = class({})
function modifier_omniknight_martyr_custom_talent_passive:IsHidden() return true end
function modifier_omniknight_martyr_custom_talent_passive:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_omniknight_martyr_custom_talent_passive:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetParent():IsAlive() then return end
	if self:GetCaster():HasModifier("modifier_omniknight_martyr_custom_talent_passive_cooldown") then return end
	if not self:GetCaster():HasModifier("modifier_omniknight_6") then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_omniknight_martyr_custom_talent_passive_cooldown", {duration = self:GetAbility().modifier_omniknight_6_cooldown[self:GetCaster():GetTalentLevel("modifier_omniknight_6")]})
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_omniknight_martyr_custom_talent_passive_buff", {duration = self:GetAbility():GetSpecialValueFor("duration")})
	self:GetCaster():EmitSound("Brewmaster_Storm.DispelMagic")
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_dispel_magic.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
end

modifier_omniknight_martyr_custom_talent_passive_buff = class({})
function modifier_omniknight_martyr_custom_talent_passive_buff:IsPurgable() return false end
function modifier_omniknight_martyr_custom_talent_passive_buff:CheckState()
    return
    {
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end

