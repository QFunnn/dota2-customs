--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ancient_apparition_ice_vortex_custom", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_vortex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_apparition_ice_vortex_custom_aura", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_vortex_custom", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_ancient_apparition_ice_vortex_custom_buff", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_vortex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_apparition_ice_vortex_custom_aura_buff", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_vortex_custom", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_vortex_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_vortex_custom", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_ancient_apparition_ice_vortex_custom_stack_debuff", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_vortex_custom", LUA_MODIFIER_MOTION_NONE )

ancient_apparition_ice_vortex_custom = class({})

ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_1 = {12,24,36}
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_2 = {-20,-40}
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_3 = 70
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_4 = {300,450,600}
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_delay = 5
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_10_attackspeed = {30,60}
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_10_lifesteal = {8,16}
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_13 = {10,20,30}
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_6_duration = 3
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_6_max_stacks = 16
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_6_slow = -1
ancient_apparition_ice_vortex_custom.modifier_ancient_apparition_6_damage = 5

function ancient_apparition_ice_vortex_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_ancient_apparition_4") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function ancient_apparition_ice_vortex_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function ancient_apparition_ice_vortex_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_ancient_apparition_4") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function ancient_apparition_ice_vortex_custom:GetCooldown(level)
    if self:GetCaster():HasModifier("modifier_ancient_apparition_4") then
        return 0
    end
	return self.BaseClass.GetCooldown(self, level)
end

function ancient_apparition_ice_vortex_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local vortex_duration = self:GetSpecialValueFor("vortex_duration")
	self:GetCaster():EmitSound("Hero_Ancient_Apparition.IceVortexCast")
	CreateModifierThinker(self:GetCaster(), self, "modifier_ancient_apparition_ice_vortex_custom", {duration = vortex_duration}, point, self:GetCaster():GetTeamNumber(), false)
    if self:GetCaster():HasModifier("modifier_ancient_apparition_10") or self:GetCaster():HasModifier("modifier_ancient_apparition_13") then
        CreateModifierThinker(self:GetCaster(), self, "modifier_ancient_apparition_ice_vortex_custom_buff", {duration = vortex_duration}, point, self:GetCaster():GetTeamNumber(), false)
    end
end

modifier_ancient_apparition_ice_vortex_custom = class({})

function modifier_ancient_apparition_ice_vortex_custom:OnCreated()
	self.radius				= self:GetAbility():GetSpecialValueFor("radius")
	self.vision_aoe			= self:GetAbility():GetSpecialValueFor("vision_aoe")
	self.vortex_duration	= self:GetAbility():GetSpecialValueFor("vortex_duration")
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Ancient_Apparition.IceVortex")
	self:GetParent():EmitSound("Hero_Ancient_Apparition.IceVortex.lp")
	local vortex_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(vortex_particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(vortex_particle, 5, Vector(self.radius, 0, 0))
	self:AddParticle(vortex_particle, false, false, -1, false, false)
	AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self.vision_aoe, self.vortex_duration, false)
    self:StartIntervalThink(self:GetAbility().modifier_ancient_apparition_delay)
end

function modifier_ancient_apparition_ice_vortex_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_Ancient_Apparition.IceVortex.lp")
	self:GetParent():RemoveSelf()
end

function modifier_ancient_apparition_ice_vortex_custom:IsHidden()				return true end
function modifier_ancient_apparition_ice_vortex_custom:IsAura() 				return true end
function modifier_ancient_apparition_ice_vortex_custom:IsAuraActiveOnDeath() 	return false end
function modifier_ancient_apparition_ice_vortex_custom:GetAuraRadius()		return self.radius end
function modifier_ancient_apparition_ice_vortex_custom:GetAuraSearchFlags()	return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_ancient_apparition_ice_vortex_custom:GetAuraSearchTeam()	return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_ancient_apparition_ice_vortex_custom:GetAuraSearchType()	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_ancient_apparition_ice_vortex_custom:GetModifierAura()		return "modifier_ancient_apparition_ice_vortex_custom_aura" end


----------------------------------------------------------

modifier_ancient_apparition_ice_vortex_custom_buff = class({})

function modifier_ancient_apparition_ice_vortex_custom_buff:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_ancient_apparition_ice_vortex_custom_buff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveSelf()
end

function modifier_ancient_apparition_ice_vortex_custom_buff:IsHidden()				return true end
function modifier_ancient_apparition_ice_vortex_custom_buff:IsAura() 				return true end
function modifier_ancient_apparition_ice_vortex_custom_buff:IsAuraActiveOnDeath() 	return false end
function modifier_ancient_apparition_ice_vortex_custom_buff:GetAuraRadius()		return self.radius end
function modifier_ancient_apparition_ice_vortex_custom_buff:GetAuraSearchFlags()	return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_ancient_apparition_ice_vortex_custom_buff:GetAuraSearchTeam()	return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_ancient_apparition_ice_vortex_custom_buff:GetAuraSearchType()	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_ancient_apparition_ice_vortex_custom_buff:GetModifierAura()		return "modifier_ancient_apparition_ice_vortex_custom_aura_buff" end

modifier_ancient_apparition_ice_vortex_custom_aura_buff = class({})

function modifier_ancient_apparition_ice_vortex_custom_aura_buff:IsHidden() return not self:GetCaster():HasModifier("modifier_ancient_apparition_10") end

function modifier_ancient_apparition_ice_vortex_custom_aura_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_ancient_apparition_ice_vortex_custom_aura_buff:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_MAGICAL_LIFESTEAL,
	}	
end

function modifier_ancient_apparition_ice_vortex_custom_aura_buff:GetModifierMagicalResistanceBonus()
	if self:GetCaster():HasModifier("modifier_ancient_apparition_13") then
        return self:GetAbility().modifier_ancient_apparition_13[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_13")]
    end
end

function modifier_ancient_apparition_ice_vortex_custom_aura_buff:GetModifierAttackSpeedBonus_Constant()
	if self:GetCaster():HasModifier("modifier_ancient_apparition_10") then
        return self:GetAbility().modifier_ancient_apparition_10_attackspeed[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_10")]
    end
end

function modifier_ancient_apparition_ice_vortex_custom_aura_buff:GetModifierProperty_MagicalLifesteal()
    if not self:GetCaster():HasModifier("modifier_ancient_apparition_10") then return end
    return self:GetAbility().modifier_ancient_apparition_10_lifesteal[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_10")]
end

----------------------------------------------------------


modifier_ancient_apparition_ice_vortex_custom_aura = class({})

function modifier_ancient_apparition_ice_vortex_custom_aura:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end

function modifier_ancient_apparition_ice_vortex_custom_aura:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.movement_speed_pct	= self:GetAbility():GetSpecialValueFor("movement_speed_pct")
	self.spell_resist_pct = self:GetAbility():GetSpecialValueFor("spell_resist_pct")
    self.damage = self:GetAbility():GetSpecialValueFor("shard_dps")
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_ancient_apparition_ice_vortex_custom_aura:OnIntervalThink()
    if not IsServer() then return end
    local damage = self.damage
    if self:GetCaster():HasModifier("modifier_ancient_apparition_1") then
        damage = damage + self:GetAbility().modifier_ancient_apparition_1[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_1")]
    end
    if self:GetCaster():HasModifier("modifier_ancient_apparition_3") then
        damage = damage + (self:GetCaster():GetPhysicalArmorValue(false) / 100 * self:GetAbility().modifier_ancient_apparition_3)
    end
    local damageTable = 
    {
		victim = self:GetParent(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility()
	}
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), damage, nil)
    ApplyDamage(damageTable)

    if self:GetCaster():HasModifier("modifier_ancient_apparition_6") then
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ancient_apparition_ice_vortex_custom_stack_debuff", {duration = self:GetAbility().modifier_ancient_apparition_6_duration})
    end
end

function modifier_ancient_apparition_ice_vortex_custom_aura:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}	
end

function modifier_ancient_apparition_ice_vortex_custom_aura:GetModifierMoveSpeedBonus_Percentage()
	return self.movement_speed_pct
end

function modifier_ancient_apparition_ice_vortex_custom_aura:GetModifierMagicalResistanceBonus()
	return self.spell_resist_pct
end

function modifier_ancient_apparition_ice_vortex_custom_aura:GetModifierAttackSpeedBonus_Constant()
	if self:GetCaster():HasModifier("modifier_ancient_apparition_2") then
        return self:GetAbility().modifier_ancient_apparition_2[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_2")]
    end
end

------------------------------------------------------------------------------------------------------------------------------------------

modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent = class({})
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:IsHidden() return true end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:IsPurgable() return false end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:RemoveOnDeath() return false end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:IsPurgeException() return false end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:OnCreated()
	if not IsServer() then return end
    self.radius = self:GetCaster():GetAoeBonus(self:GetAbility().modifier_ancient_apparition_4[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_4")])
	self.vortex_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt( self.vortex_particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true )
	ParticleManager:SetParticleControl(self.vortex_particle, 5, Vector(self.radius, 0, 0))
	self:AddParticle(self.vortex_particle, false, false, -1, false, false)

    self.particle = ParticleManager:CreateParticle("particles/apparat_lich_radius.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(self.particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(self.particle, 2, Vector(self.radius,self.radius,self.radius))
    self:AddParticle(self.particle, false, false, -1, false, false)
    self.current_radius = self.radius

    self.damage_tick = 0
    self:StartIntervalThink(0.1)
end

function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:OnIntervalThink()
    if not IsServer() then return end
    self.radius = self:GetCaster():GetAoeBonus(self:GetAbility().modifier_ancient_apparition_4[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_4")])

    if self.radius ~= self.current_radius then
        if self.particle then
            ParticleManager:DestroyParticle(self.particle, true)
        end
        self.particle = ParticleManager:CreateParticle("particles/apparat_lich_radius.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControlEnt(self.particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetAbsOrigin(), true)
        ParticleManager:SetParticleControl(self.particle, 2, Vector(self.radius,self.radius,self.radius))
        self:AddParticle(self.particle, false, false, -1, false, false)
        self.current_radius = self.radius
    end

    if self.vortex_particle then
        ParticleManager:SetParticleControl(self.vortex_particle, 5, Vector(self.radius, 0, 0))
    end
end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:IsAura() 				return true end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:IsAuraActiveOnDeath() 	return false end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:GetAuraRadius()		return self.radius end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:GetAuraSearchFlags()	return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:GetAuraSearchTeam()	return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:GetAuraSearchType()	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_ancient_apparition_ice_vortex_custom_debuff_aura_talent:GetModifierAura()		return "modifier_ancient_apparition_ice_vortex_custom_aura" end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent = class({})
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:IsHidden() return true end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:IsPurgable() return false end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:RemoveOnDeath() return false end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:IsPurgeException() return false end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:OnCreated()
	if not IsServer() then return end
    self.radius = self:GetCaster():GetAoeBonus(self:GetAbility().modifier_ancient_apparition_4[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_4")])
    self:StartIntervalThink(0.1)
end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:OnIntervalThink()
    if not IsServer() then return end
    self.radius = self:GetCaster():GetAoeBonus(self:GetAbility().modifier_ancient_apparition_4[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_4")])
end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:IsAura() 				return true end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:IsAuraActiveOnDeath() 	return false end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:GetAuraRadius()		return self.radius end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:GetAuraSearchFlags()	return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:GetAuraSearchTeam()	return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:GetAuraSearchType()	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_ancient_apparition_ice_vortex_custom_buff_aura_talent:GetModifierAura()		return "modifier_ancient_apparition_ice_vortex_custom_aura_buff" end

modifier_ancient_apparition_ice_vortex_custom_stack_debuff = class({})

function modifier_ancient_apparition_ice_vortex_custom_stack_debuff:GetTexture() return "ancient_apparation_3" end

function modifier_ancient_apparition_ice_vortex_custom_stack_debuff:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(1)
end

function modifier_ancient_apparition_ice_vortex_custom_stack_debuff:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() >= self:GetAbility().modifier_ancient_apparition_6_max_stacks then return end
    self:IncrementStackCount()
end

function modifier_ancient_apparition_ice_vortex_custom_stack_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damageTable = 
    {
		victim = self:GetParent(),
		damage = self:GetAbility().modifier_ancient_apparition_6_damage * self:GetStackCount(),
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility()
	}
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), self:GetAbility().modifier_ancient_apparition_6_damage * self:GetStackCount(), nil)
    ApplyDamage(damageTable)
end

function modifier_ancient_apparition_ice_vortex_custom_stack_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_ancient_apparition_ice_vortex_custom_stack_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility().modifier_ancient_apparition_6_slow * self:GetStackCount()
end

function modifier_ancient_apparition_ice_vortex_custom_stack_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end