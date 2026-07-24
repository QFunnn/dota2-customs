--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wodacreepchampion=class({})

function modifier_wodacreepchampion:IsPurgable()
	return false 
end

function modifier_wodacreepchampion:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/champion_effect_blue.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	--ParticleManager:SetParticleControl( particle, 15, Vector( 0, 0, 0 ) )
    --ParticleManager:SetParticleControl( particle, 16, Vector( 0, 0, 0 ) )
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():SetBaseDamageMin(self:GetParent():GetBaseDamageMin() * 1.2)
    self:GetParent():SetBaseDamageMax(self:GetParent():GetBaseDamageMax() * 1.2)
    self:GetParent():SetBaseMaxHealth(self:GetParent():GetMaxHealth() * 2)
    self:GetParent():SetBaseHealthRegen(self:GetParent():GetBaseHealthRegen() * 2)
    self:GetParent():SetPhysicalArmorBaseValue(self:GetParent():GetPhysicalArmorBaseValue() * 1)
    self:GetParent():SetBaseMagicalResistanceValue(self:GetParent():GetBaseMagicalResistanceValue() * 1)
    self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
end

function modifier_wodacreepchampion:GetEffectName()
	return "particles/woda_rune_doubledamage1.vpcf"
end

function modifier_wodacreepchampion:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_wodacreepchampion:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE, MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE 
    }
    return funcs
end

function modifier_wodacreepchampion:GetModifierAttackSpeedPercentage()
    return 115
end

function modifier_wodacreepchampion:GetModifierTotalDamageOutgoing_Percentage(params)
    if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then 
    	return 20
    end
end

function modifier_wodacreepchampion:GetTexture()
	return "championblue"
end

modifier_wodacreepchampionred=class({})

function modifier_wodacreepchampionred:IsPurgable()
	return false 
end

function modifier_wodacreepchampionred:OnCreated()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/champion_effect_red.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	--ParticleManager:SetParticleControl( particle, 15, Vector( 0, 0, 0 ) )
    --ParticleManager:SetParticleControl( particle, 16, Vector( 0, 0, 0 ) )
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():SetBaseDamageMin(self:GetParent():GetBaseDamageMin() * 2)
    self:GetParent():SetBaseDamageMax(self:GetParent():GetBaseDamageMax() * 2)
    self:GetParent():SetBaseMaxHealth(self:GetParent():GetMaxHealth() * 5)
    self:GetParent():SetBaseHealthRegen(self:GetParent():GetBaseHealthRegen() * 5)
    self:GetParent():SetPhysicalArmorBaseValue(self:GetParent():GetPhysicalArmorBaseValue() * 1)
    self:GetParent():SetBaseMagicalResistanceValue(self:GetParent():GetBaseMagicalResistanceValue() * 1)
    self:GetParent():SetHealth(self:GetParent():GetMaxHealth())
end

function modifier_wodacreepchampionred:GetEffectName()
	return "particles/woda_rube_doubledamage2woda_rune_doubledamage1.vpcf"
end

function modifier_wodacreepchampionred:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_wodacreepchampionred:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE, MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE 
    }
    return funcs
end

function modifier_wodacreepchampionred:GetModifierAttackSpeedPercentage()
    return 115
end

function modifier_wodacreepchampionred:GetModifierTotalDamageOutgoing_Percentage(params)
    if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then 
    	return 100
    end
end

function modifier_wodacreepchampionred:GetTexture()
	return "championred"
end