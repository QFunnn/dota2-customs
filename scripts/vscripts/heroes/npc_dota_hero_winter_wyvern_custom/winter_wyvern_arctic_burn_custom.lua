--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_winter_wyvern_arctic_burn_custom", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_arctic_burn_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_winter_wyvern_arctic_burn_custom_debuff", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_arctic_burn_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_winter_wyvern_arctic_burn_custom_handler", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_arctic_burn_custom", LUA_MODIFIER_MOTION_NONE)

winter_wyvern_arctic_burn_custom = class({})
winter_wyvern_arctic_burn_custom.modifier_winter_wyvern_8 = {25,50}
winter_wyvern_arctic_burn_custom.modifier_winter_wyvern_12 = {200,400}
winter_wyvern_arctic_burn_custom.modifier_winter_wyvern_13 = {-10,-20}
winter_wyvern_arctic_burn_custom.modifier_winter_wyvern_14 = 160

function winter_wyvern_arctic_burn_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_start.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_buff.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_flying.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/winter_wyvern_arctic_attack.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_wyvern_arctic_burn.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_winter_wyvern.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_winter_wyvern.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_winter_wyvern.vpcf", context)
    -- particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_hero_effect.vpcf
end

function winter_wyvern_arctic_burn_custom:GetIntrinsicModifierName()
    return "modifier_winter_wyvern_arctic_burn_custom_handler"
end

function winter_wyvern_arctic_burn_custom:GetCooldown( level )
	if self:GetCaster():HasModifier("modifier_winter_wyvern_14") then
		return 0
    end
    self.BaseClass.GetCooldown( self, level )
end

function winter_wyvern_arctic_burn_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_winter_wyvern_14") then
        return self.modifier_winter_wyvern_14
    end
    return self.BaseClass.GetManaCost(self, level)
end

function winter_wyvern_arctic_burn_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_winter_wyvern_14") then
        return DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function winter_wyvern_arctic_burn_custom:OnToggle()
	if not IsServer() then return end 
	local toggle = self:GetToggleState();
    local modifier_winter_wyvern_arctic_burn_custom = self:GetCaster():FindModifierByName("modifier_winter_wyvern_arctic_burn_custom")
    if toggle then 
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_winter_wyvern_arctic_burn_custom", {})
    else 
        if modifier_winter_wyvern_arctic_burn_custom then
            modifier_winter_wyvern_arctic_burn_custom:Destroy()
        end
    end
end

function winter_wyvern_arctic_burn_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_winter_wyvern_14") then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_winter_wyvern_arctic_burn_custom", {duration = duration})
end

modifier_winter_wyvern_arctic_burn_custom = class({})
function modifier_winter_wyvern_arctic_burn_custom:IsPurgable() return false end

function modifier_winter_wyvern_arctic_burn_custom:OnCreated()
    if not IsServer() then return end
    --self.target_indexs = {}
    self:GetCaster():EmitSound("Hero_Winter_Wyvern.ArcticBurn.Cast")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_start.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
    self:GetParent():StartGesture( ACT_DOTA_CAST_ABILITY_1 )
    local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_buff.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent() );
    ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetOrigin(), true );
    ParticleManager:SetParticleControlEnt( nFXIndex, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true );
    ParticleManager:SetParticleControlEnt( nFXIndex, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetOrigin(), true );
    ParticleManager:SetParticleControlEnt( nFXIndex, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_eye_l", self:GetParent():GetOrigin(), true );
    ParticleManager:SetParticleControlEnt( nFXIndex, 4, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_eye_r", self:GetParent():GetOrigin(), true );
    self:AddParticle( nFXIndex, false, false, -1, false, false );
    if self:GetCaster() == self:GetParent() then
        local nFXIndexB = ParticleManager:CreateParticle( "particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_flying.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent() );
        ParticleManager:SetParticleControlEnt( nFXIndexB, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetOrigin(), true );
        ParticleManager:SetParticleControlEnt( nFXIndexB, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_spine_1", self:GetParent():GetOrigin(), true );
        ParticleManager:SetParticleControlEnt( nFXIndexB, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_spine_2", self:GetParent():GetOrigin(), true );
        ParticleManager:SetParticleControlEnt( nFXIndexB, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_spine_3", self:GetParent():GetOrigin(), true );
        ParticleManager:SetParticleControlEnt( nFXIndexB, 4, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_spine_4", self:GetParent():GetOrigin(), true );
        ParticleManager:SetParticleControlEnt( nFXIndexB, 5, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_spine_5", self:GetParent():GetOrigin(), true );
        self:AddParticle( nFXIndexB, false, false, -1, false, false );
    end
    if self:GetParent():IsRangedAttacker() then
        self.szRangedProjectileName = self:GetParent():GetRangedProjectileName();
        self:GetParent():SetRangedProjectileName( "particles/units/heroes/hero_winter_wyvern/winter_wyvern_arctic_attack.vpcf" )
    end
    if self:GetCaster():HasModifier("modifier_winter_wyvern_14") then
        self:StartIntervalThink(1)
    end
end

function modifier_winter_wyvern_arctic_burn_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetParent():GetMana() < self:GetAbility().modifier_winter_wyvern_14 then
        self:GetAbility():ToggleAbility()
    else
        self:GetParent():Script_ReduceMana(self:GetAbility().modifier_winter_wyvern_14, self:GetAbility())
    end
end

function modifier_winter_wyvern_arctic_burn_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():StartGesture( ACT_DOTA_ARCTIC_BURN_END )
	StopSoundOn( "Hero_Winter_Wyvern.ArcticBurn.Cast", self:GetParent() )
    GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self:GetAbility():GetSpecialValueFor( "tree_destruction_radius" ), false )
    if self:GetParent():IsRangedAttacker() then
        self:GetParent():SetRangedProjectileName( self.szRangedProjectileName );
    end
end

function modifier_winter_wyvern_arctic_burn_custom:DeclareFunctions()
	return
    {
		 
		MODIFIER_PROPERTY_ATTACK_POINT_CONSTANT,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
        MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_winter_wyvern_arctic_burn_custom:OnAttackLanded( params )
	if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    --if not self:GetCaster():HasModifier("modifier_winter_wyvern_14") then
    --    if self.target_indexs[params.target:entindex()] then return end
    --    self.target_indexs[params.target:entindex()] = true
    --end
    local damage_duration = self:GetAbility():GetSpecialValueFor("damage_duration")
	params.target:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_winter_wyvern_arctic_burn_custom_debuff", {duration = damage_duration * (1 - params.target:GetStatusResistance())} )
    EmitSoundOn("Hero_Winter_Wyvern.ArcticBurn.projectileImpact", params.target);
end

function modifier_winter_wyvern_arctic_burn_custom:OnAttack( params )
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    --if not self:GetCaster():HasModifier("modifier_winter_wyvern_14") then
    --    if self.target_indexs[params.target:entindex()] then return end
    --end
    local modifier_winter_wyvern_arctic_burn_custom_handler = self:GetParent():FindModifierByName("modifier_winter_wyvern_arctic_burn_custom_handler")
    if modifier_winter_wyvern_arctic_burn_custom_handler then
        modifier_winter_wyvern_arctic_burn_custom_handler.records[params.record] = true
    end
end

function modifier_winter_wyvern_arctic_burn_custom:GetModifierAttackPointConstant( params )
	return self:GetAbility():GetSpecialValueFor( "attack_point" )
end

function modifier_winter_wyvern_arctic_burn_custom:GetActivityTranslationModifiers( params )
	return "flying"
end

function modifier_winter_wyvern_arctic_burn_custom:GetModifierAttackRangeBonus( params )
	return self:GetAbility():GetSpecialValueFor( "attack_range_bonus" )
end

function modifier_winter_wyvern_arctic_burn_custom:GetModifierProjectileSpeedBonus( params )
	return self:GetAbility():GetSpecialValueFor( "projectile_speed_bonus" )
end

function modifier_winter_wyvern_arctic_burn_custom:CheckState()
	return
    {
        [MODIFIER_STATE_FLYING] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

modifier_winter_wyvern_arctic_burn_custom_debuff = class({})

function modifier_winter_wyvern_arctic_burn_custom_debuff:DeclareFunctions() 
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_winter_wyvern_arctic_burn_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("move_slow")
end

function modifier_winter_wyvern_arctic_burn_custom_debuff:OnCreated() 
	if not IsServer() then return end
    local tick_rate = self:GetAbility():GetSpecialValueFor("tick_rate")
    self.tick_rate = tick_rate
	self.health_dmg_conversion = (self:GetAbility():GetSpecialValueFor("percent_damage") / 100) * tick_rate
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_arctic_burn_slow.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
    self.current_frame = 0
	self:StartIntervalThink(FrameTime())
end

function modifier_winter_wyvern_arctic_burn_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    self.current_frame = self.current_frame + FrameTime()
    if self.current_frame >= self.tick_rate then
        local damage = self:GetParent():GetHealth() * self.health_dmg_conversion
        if self:GetCaster():HasModifier("modifier_winter_wyvern_8") then
            damage = damage + (self:GetAbility().modifier_winter_wyvern_8[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_8")] * self.tick_rate)
        end
        ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), damage, nil)
        self.current_frame = 0
    end
    if self:GetCaster():HasModifier("modifier_winter_wyvern_12") then
        AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetAbility().modifier_winter_wyvern_12[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_12")], 0.1, false)
    end
end

function modifier_winter_wyvern_arctic_burn_custom_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_wyvern_arctic_burn.vpcf"
end

function modifier_winter_wyvern_arctic_burn_custom_debuff:GetModifierSpellAmplify_Percentage()
    if self:GetCaster():HasModifier("modifier_winter_wyvern_13") then
	    return self:GetAbility().modifier_winter_wyvern_13[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_13")]
    end
end

modifier_winter_wyvern_arctic_burn_custom_handler = class({})
function modifier_winter_wyvern_arctic_burn_custom_handler:IsHidden() return true end
function modifier_winter_wyvern_arctic_burn_custom_handler:IsPurgable() return false end
function modifier_winter_wyvern_arctic_burn_custom_handler:IsPurgeException() return false end
function modifier_winter_wyvern_arctic_burn_custom_handler:RemoveOnDeath() return false end
function modifier_winter_wyvern_arctic_burn_custom_handler:OnCreated()
    if not IsServer() then return end
    self.records = {}
end
function modifier_winter_wyvern_arctic_burn_custom_handler:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    if self:GetParent():HasModifier("modifier_winter_wyvern_arctic_burn_custom") then return end
    if params.record and self.records[params.record] then
        local damage_duration = self:GetAbility():GetSpecialValueFor("damage_duration")
	    params.target:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_winter_wyvern_arctic_burn_custom_debuff", {duration = damage_duration * (1 - params.target:GetStatusResistance())} )
        EmitSoundOn("Hero_Winter_Wyvern.ArcticBurn.projectileImpact", params.target);
    end
end