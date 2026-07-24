--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_medusa_mana_shield_custom", "heroes/npc_dota_hero_medusa_custom/medusa_mana_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_medusa_mana_shield_custom_active", "heroes/npc_dota_hero_medusa_custom/medusa_mana_shield_custom", LUA_MODIFIER_MOTION_NONE)

medusa_mana_shield_custom = class({})

medusa_mana_shield_custom.modifier_medusa_20_manacost = 4
medusa_mana_shield_custom.modifier_medusa_20_cooldown = 35
medusa_mana_shield_custom.modifier_medusa_20_maximum = 30
medusa_mana_shield_custom.modifier_medusa_20_duration = 15
medusa_mana_shield_custom.modifier_medusa_20_attackspeed = 3

function medusa_mana_shield_custom:GetIntrinsicModifierName()
    return "modifier_medusa_mana_shield_custom"
end

function medusa_mana_shield_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_medusa.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_medusa.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_medusa.vpcf", context)
end

function medusa_mana_shield_custom:GetBehavior()
    -- if self:GetCaster():HasModifier("modifier_medusa_20") then
    --     return DOTA_ABILITY_BEHAVIOR_TOGGLE
    -- end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function medusa_mana_shield_custom:OnToggle()
    if not IsServer() then return end
    if self:GetToggleState() then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_medusa_mana_shield_custom_active", {duration = self.modifier_medusa_20_duration})
        self:StartCooldown(3)
    else
        local modifier_medusa_mana_shield_custom_active = self:GetCaster():FindModifierByName("modifier_medusa_mana_shield_custom_active")
        if modifier_medusa_mana_shield_custom_active then
            modifier_medusa_mana_shield_custom_active:StartIntervalThink(-1)
        end
        self:StartCooldown(self.modifier_medusa_20_cooldown)
    end
end

function medusa_mana_shield_custom:Spawn()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("medusa_mana_shield_custom") then return end
    if not self:IsTrained() then
        self:SetLevel(1)
    end
end

modifier_medusa_mana_shield_custom = class({})
function modifier_medusa_mana_shield_custom:IsPurgable() return false end
function modifier_medusa_mana_shield_custom:IsPurgeException() return false end
function modifier_medusa_mana_shield_custom:RemoveOnDeath() return false end
function modifier_medusa_mana_shield_custom:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_medusa_mana_shield_custom:OnCreated( kv )
    self.damage_per_mana = self:GetAbility():GetSpecialValueFor("damage_per_mana")
    self.illusion_damage_per_mana = self:GetAbility():GetSpecialValueFor("illusion_damage_per_mana")
    self.absorption_pct = self:GetAbility():GetSpecialValueFor("absorption_pct")
    self.bonus_mana = self:GetAbility():GetSpecialValueFor("bonus_mana")
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Medusa.ManaShield.On")
end

function modifier_medusa_mana_shield_custom:OnRefresh( kv )
    self.damage_per_mana = self:GetAbility():GetSpecialValueFor("damage_per_mana")
    self.illusion_damage_per_mana = self:GetAbility():GetSpecialValueFor("illusion_damage_per_mana")
    self.absorption_pct = self:GetAbility():GetSpecialValueFor("absorption_pct")
    self.bonus_mana = self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_medusa_mana_shield_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Medusa.ManaShield.Off")
end

function modifier_medusa_mana_shield_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_MANA_BONUS
	}
end

function modifier_medusa_mana_shield_custom:GetModifierManaBonus()
    return self.bonus_mana
end

function modifier_medusa_mana_shield_custom:GetModifierTotal_ConstantBlock( params )
    if IsClient() then return 0 end
	local incoming_damage = params.damage
    local block_damage = params.damage / 100 * self.absorption_pct
    local damage_per_mana = self.damage_per_mana
    if self:GetParent():IsIllusion() then
        block_damage = params.damage
    end
    if self:GetParent():GetMana() <= 0 then
        block_damage = 0
    end
    local maximum_block_damage = self:GetParent():GetMana() * damage_per_mana
    if self:GetParent():IsIllusion() then
        maximum_block_damage = self:GetParent():GetMana() * self.illusion_damage_per_mana
    end
    if block_damage > maximum_block_damage then
        block_damage = maximum_block_damage
    end
    local spend_mana = block_damage / damage_per_mana
    if self:GetParent():IsIllusion() then
        spend_mana = block_damage / self.illusion_damage_per_mana
    end
    if block_damage > 0 then
	    self:GetParent():SpendMana( spend_mana, self:GetAbility() )
	    self:PlayEffects( block_damage )
    end
	return block_damage
end

function modifier_medusa_mana_shield_custom:GetEffectName()
	return "particles/units/heroes/hero_medusa/medusa_mana_shield.vpcf"
end

function modifier_medusa_mana_shield_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_medusa_mana_shield_custom:PlayEffects( damage )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_mana_shield_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( damage, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetParent():EmitSound("Hero_Medusa.ManaShield.Proc")
end

modifier_medusa_mana_shield_custom_active = class({})
function modifier_medusa_mana_shield_custom_active:IsPurgable() return false end

function modifier_medusa_mana_shield_custom_active:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Medusa.ManaShield.On")
    self:StartIntervalThink(1)
end

function modifier_medusa_mana_shield_custom_active:OnIntervalThink()
    if not IsServer() then return end
    if self:GetStackCount() < self:GetAbility().modifier_medusa_20_maximum then
        local manacost = self:GetParent():GetMaxMana() / 100 * self:GetAbility().modifier_medusa_20_manacost
        if manacost >= self:GetParent():GetMana() then
            self:GetAbility():ToggleAbility()
            return
        end
        self:GetParent():SpendMana(manacost, self:GetAbility())
        self:SetStackCount(self:GetStackCount() + self:GetAbility().modifier_medusa_20_attackspeed)
    else
        self:GetAbility():ToggleAbility()
    end
end

function modifier_medusa_mana_shield_custom_active:GetEffectName()
	return "particles/units/heroes/hero_medusa/medusa_mana_shield_buff.vpcf"
end

function modifier_medusa_mana_shield_custom_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_medusa_mana_shield_custom_active:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE
    }
end

function modifier_medusa_mana_shield_custom_active:GetModifierAttackSpeedPercentage()
    return self:GetStackCount()
end