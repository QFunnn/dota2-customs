--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_glimmer_shiled_active", "items/item_glimmer_shield", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_glimmer_shiled_passive", "items/item_glimmer_shield", LUA_MODIFIER_MOTION_NONE)

item_glimmer_shield = class({})

function item_glimmer_shield:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("Item.GlimmerCape.Activate")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_glimmer_shiled_active", {duration = self:GetSpecialValueFor("duration")})
end

function item_glimmer_shield:GetIntrinsicModifierName()
	return "modifier_item_glimmer_shiled_passive"
end

modifier_item_glimmer_shiled_passive = class({})
function modifier_item_glimmer_shiled_passive:IsHidden() return true end
function modifier_item_glimmer_shiled_passive:IsPurgable() return false end
function modifier_item_glimmer_shiled_passive:IsPurgeException() return false end
function modifier_item_glimmer_shiled_passive:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_item_glimmer_shiled_passive:GetModifierPercentageCooldown()
    return self:GetAbility():GetSpecialValueFor("cooldown_reduce") 
end

function modifier_item_glimmer_shiled_passive:GetModifierMagicalResistanceBonus() 
    return self:GetAbility():GetSpecialValueFor("bonus_magical_armor") 
end

function modifier_item_glimmer_shiled_passive:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_armor") 
end

function modifier_item_glimmer_shiled_passive:GetModifierMoveSpeedBonus_Special_Boots()
    return self:GetAbility():GetSpecialValueFor("bonus_movespeed") 
end

function modifier_item_glimmer_shiled_passive:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage") 
end

modifier_item_glimmer_shiled_active = class({})

function modifier_item_glimmer_shiled_active:IsHidden() return false end

function modifier_item_glimmer_shiled_active:OnCreated(table)
    self.speed = self:GetAbility():GetSpecialValueFor("active_movespeed")
    self.barrier = self:GetAbility():GetSpecialValueFor("active_magical_armor")
    if not IsServer() then return end
    self.shield = self.barrier
    local particle = ParticleManager:CreateParticle("particles/glimmer_cape5initial.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
    self:SetHasCustomTransmitterData(true)
    self:StartIntervalThink(FrameTime())
end

function modifier_item_glimmer_shiled_active:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetAbility():GetSpecialValueFor("vision_radius"), FrameTime(), false)
end

function modifier_item_glimmer_shiled_active:AddCustomTransmitterData() 
    return 
    { 
        shield = self.shield,
    }
end

function modifier_item_glimmer_shiled_active:HandleCustomTransmitterData(data)
    self.shield = data.shield
end


function modifier_item_glimmer_shiled_active:CheckState() 
    return 
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_item_glimmer_shiled_active:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
         
    }
end

function modifier_item_glimmer_shiled_active:GetModifierMoveSpeedBonus_Percentage() return self.speed end

function modifier_item_glimmer_shiled_active:GetModifierIncomingSpellDamageConstant(params)
    if IsClient() then 
        if params.report_max then 
            return self.barrier
        else 
            return self.shield
        end 
    end
    if not IsServer() then return end
    local damage = math.min(params.damage, self.shield)
    self.shield = math.max(0, self.shield - damage)
    if self.shield <= 0 then
        self:Destroy()
    end
    self:SendBuffRefreshToClients()
    return -damage
end