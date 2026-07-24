--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier("modifier_winter_wyvern_cold_embrace_custom", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_cold_embrace_custom", LUA_MODIFIER_MOTION_NONE)

winter_wyvern_cold_embrace_custom = class({})

winter_wyvern_cold_embrace_custom.modifier_winter_wyvern_5 = {50,75,100}
winter_wyvern_cold_embrace_custom.modifier_winter_wyvern_6 = {0,-2}
winter_wyvern_cold_embrace_custom.modifier_winter_wyvern_17 = {600,1200}

function winter_wyvern_cold_embrace_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_winter_wyvern_6") then
        bonus = self.modifier_winter_wyvern_6[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_6")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function winter_wyvern_cold_embrace_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_buff.vpcf", context)
end

function winter_wyvern_cold_embrace_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    local target = self:GetCursorTarget()
    self:GetCaster():EmitSound("Hero_Winter_Wyvern.ColdEmbrace.Cast")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_start.vpcf", PATTACH_POINT, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    target:AddNewModifier(self:GetCaster(), self, "modifier_winter_wyvern_cold_embrace_custom", {duration = duration})
end

modifier_winter_wyvern_cold_embrace_custom = class({})
function modifier_winter_wyvern_cold_embrace_custom:IsPurgable() return false end
function modifier_winter_wyvern_cold_embrace_custom:IsPurgeException() return false end
function modifier_winter_wyvern_cold_embrace_custom:IsHidden() return false end
function modifier_winter_wyvern_cold_embrace_custom:CheckState()
    if self:GetCaster():HasModifier("modifier_winter_wyvern_6") then
        return
        {
            [MODIFIER_STATE_ROOTED] = true,
        }
    end
	return 
    {
		[MODIFIER_STATE_FROZEN] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_winter_wyvern_cold_embrace_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
         
    }
end

function modifier_winter_wyvern_cold_embrace_custom:OnTakeDamage(params)
	if not IsServer() then return end
	local attacker = params.attacker
	local target = params.unit
	local original_damage = params.original_damage
	local damage_type = params.damage_type
	local damage_flags = params.damage_flags
	if params.unit == self:GetParent() and not params.attacker:IsBuilding() and params.attacker:GetTeamNumber() ~= self:GetParent():GetTeamNumber() and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= DOTA_DAMAGE_FLAG_REFLECTION then	
		if not params.unit:IsOther() and self:GetParent():HasModifier("modifier_winter_wyvern_5") then
			local damageTable = 
            {
				victim			= params.attacker,
				damage			= params.original_damage / 100 * self:GetAbility().modifier_winter_wyvern_5[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_5")],
				damage_type		= params.damage_type,
				damage_flags 	= DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
				attacker		= self:GetParent(),
				ability			= self:GetAbility()
			}
			ApplyDamage(damageTable)
		end
	end
end

function modifier_winter_wyvern_cold_embrace_custom:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_winter_wyvern_cold_embrace_custom:GetEffectName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_frozen.vpcf"
end

function modifier_winter_wyvern_cold_embrace_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_winter_wyvern_cold_embrace_custom:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Winter_Wyvern.ColdEmbrace") 
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetOrigin() ) 
    ParticleManager:SetParticleControl( particle, 1, self:GetParent():GetOrigin() ) 
    ParticleManager:SetParticleControl( particle, 2, self:GetParent():GetOrigin() )
    self:AddParticle(particle, false, false, -1, false, false)
    self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
    self:StartIntervalThink(self.tick_interval)
end

function modifier_winter_wyvern_cold_embrace_custom:OnIntervalThink()
    if not IsServer() then return end
    local heal_additive = self:GetAbility():GetSpecialValueFor("heal_additive")
    local heal_percentage = self:GetAbility():GetSpecialValueFor("heal_percentage")
    local heal = (heal_additive + (self:GetParent():GetMaxHealth() / 100 * heal_percentage)) * self.tick_interval
    if self:GetParent():GetHealthPercent() < 100 then
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), heal, nil)
    end
    self:GetParent():HealWithParams(heal, self:GetAbility(), false, true, self:GetCaster(), false)
end

function modifier_winter_wyvern_cold_embrace_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_wyvern_cold_embrace.vpcf"
end

function modifier_winter_wyvern_cold_embrace_custom:OnDestroy()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_winter_wyvern_17") then
        local winter_wyvern_splinter_blast_custom = self:GetCaster():FindAbilityByName("winter_wyvern_splinter_blast_custom")
        if winter_wyvern_splinter_blast_custom then
            winter_wyvern_splinter_blast_custom:OnSpellStart(self:GetParent(), self:GetAbility().modifier_winter_wyvern_17[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_17")])
        end
    end
end