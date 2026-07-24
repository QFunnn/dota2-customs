--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_glimmer_cape_custom_active", "items/item_glimmer_cape_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_glimmer_cape_custom_passive", "items/item_glimmer_cape_custom", LUA_MODIFIER_MOTION_NONE)

item_glimmer_cape_custom = class({})

function item_glimmer_cape_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("Item.GlimmerCape.Activate")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_glimmer_cape_custom_active", {duration = self:GetSpecialValueFor("duration")})
end

function item_glimmer_cape_custom:GetIntrinsicModifierName()
	return "modifier_item_glimmer_cape_custom_passive"
end

modifier_item_glimmer_cape_custom_passive = class({})

function modifier_item_glimmer_cape_custom_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_glimmer_cape_custom_passive:IsHidden() return true end

function modifier_item_glimmer_cape_custom_passive:IsPurgable() return false end
function modifier_item_glimmer_cape_custom_passive:IsPurgeException() return false end

function modifier_item_glimmer_cape_custom_passive:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_item_glimmer_cape_custom_passive:GetModifierMagicalResistanceBonus() return self:GetAbility():GetSpecialValueFor("bonus_magical_armor") end

modifier_item_glimmer_cape_custom_active = class({})

function modifier_item_glimmer_cape_custom_active:IsHidden()     return false end

function modifier_item_glimmer_cape_custom_active:OnCreated(table)
    self.barrier = self:GetAbility():GetSpecialValueFor("active_magical_armor")
    self.speed = self:GetAbility():GetSpecialValueFor("bonus_movespeed")
    if not IsServer() then return end
    self.shield = self.barrier
    local particle = ParticleManager:CreateParticle("particles/glimmer_cape5initial.vpcf", PATTACH_RENDERORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(particle, false, false, -1, false, false)
    self:SetHasCustomTransmitterData(true)
end

function modifier_item_glimmer_cape_custom_active:CheckState() 
    return 
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true
    }
end

function modifier_item_glimmer_cape_custom_active:AddCustomTransmitterData() 
    return 
    { 
        shield = self.shield,
    }
end

function modifier_item_glimmer_cape_custom_active:HandleCustomTransmitterData(data)
    self.shield = data.shield
end

function modifier_item_glimmer_cape_custom_active:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
         
    }
end

function modifier_item_glimmer_cape_custom_active:GetModifierMoveSpeedBonus_Constant() return self.speed end

function modifier_item_glimmer_cape_custom_active:GetModifierIncomingSpellDamageConstant(params)
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

function modifier_item_glimmer_cape_custom_active:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	self:Destroy()
end