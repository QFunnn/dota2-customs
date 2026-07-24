--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_morphling_waterraze_custom_debuff", "heroes/npc_dota_hero_morphling_custom/morphling_waterraze_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_waterraze_custom_mana_buff", "heroes/npc_dota_hero_morphling_custom/morphling_waterraze_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_waterraze_custom_mana_stack", "heroes/npc_dota_hero_morphling_custom/morphling_waterraze_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_waterraze_custom_talent_handler", "heroes/npc_dota_hero_morphling_custom/morphling_waterraze_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_morphling_waterraze_custom_talent_handler_cooldown", "heroes/npc_dota_hero_morphling_custom/morphling_waterraze_custom", LUA_MODIFIER_MOTION_NONE)

morphling_waterraze1_custom =  class({})
morphling_waterraze2_custom = class({})
morphling_waterraze3_custom = class({})

function morphling_waterraze1_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf", context )
end

function morphling_waterraze2_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf", context )
end

function morphling_waterraze3_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf", context )
end

morphling_waterraze1_custom.modifier_morphling_17 = {-2.5,-5,-7.5}
morphling_waterraze2_custom.modifier_morphling_17 = {-2.5,-5,-7.5}
morphling_waterraze3_custom.modifier_morphling_17 = {-2.5,-5,-7.5}
morphling_waterraze1_custom.modifier_morphling_20 = {3,4.5,6}
morphling_waterraze2_custom.modifier_morphling_20 = {3,4.5,6}
morphling_waterraze3_custom.modifier_morphling_20 = {3,4.5,6}
morphling_waterraze1_custom.modifier_morphling_20_duration = 15
morphling_waterraze2_custom.modifier_morphling_20_duration = 15
morphling_waterraze3_custom.modifier_morphling_20_duration = 15

function morphling_waterraze1_custom:GetIntrinsicModifierName()
	return "modifier_morphling_waterraze_custom_talent_handler"
end

function morphling_waterraze1_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_morphling_17") then
		bonus = self.modifier_morphling_17[self:GetCaster():GetTalentLevel("modifier_morphling_17")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function morphling_waterraze2_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_morphling_17") then
		bonus = self.modifier_morphling_17[self:GetCaster():GetTalentLevel("modifier_morphling_17")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function morphling_waterraze3_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_morphling_17") then
		bonus = self.modifier_morphling_17[self:GetCaster():GetTalentLevel("modifier_morphling_17")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function morphling_waterraze1_custom:OnSpellStart()
	if not IsServer() then return end
	local raze_radius = self:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = self:GetSpecialValueFor("shadowraze_range")
	local raze_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * raze_distance
	CastShadowRazeOnPoint(self:GetCaster(), self, raze_point, raze_radius)
end

function morphling_waterraze2_custom:OnSpellStart()
	if not IsServer() then return end
	local raze_radius = self:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = self:GetSpecialValueFor("shadowraze_range")
	local raze_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * raze_distance
	CastShadowRazeOnPoint(self:GetCaster(), self, raze_point, raze_radius)
end

function morphling_waterraze3_custom:OnSpellStart()
	if not IsServer() then return end
	local raze_radius = self:GetSpecialValueFor("shadowraze_radius")
	local raze_distance = self:GetSpecialValueFor("shadowraze_range")
	local raze_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * raze_distance
	CastShadowRazeOnPoint(self:GetCaster(), self, raze_point, raze_radius)
end

function CastShadowRazeOnPoint(caster, ability, point, radius, passive)

	if caster:HasModifier("modifier_morphling_20") then
		caster:AddNewModifier(caster, ability, "modifier_morphling_waterraze_custom_mana_stack", {duration = ability.modifier_morphling_20_duration})
		caster:AddNewModifier(caster, ability, "modifier_morphling_waterraze_custom_mana_buff", {duration = ability.modifier_morphling_20_duration})
	end

	EmitSoundOnLocationWithCaster(point, "Hero_Morphling.AdaptiveStrikeAgi.Target", caster)

	local particle_raze_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle_raze_fx, 0, point)
	ParticleManager:SetParticleControl(particle_raze_fx, 1, point)
	ParticleManager:ReleaseParticleIndex(particle_raze_fx)

	local enemies = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

	for _,enemy in pairs(enemies) do
		if not enemy:IsMagicImmune()  then
			ApplyShadowRazeDamage(caster, ability, enemy, passive)
		end
	end
end

function ApplyShadowRazeDamage(caster, ability, enemy, passive)
	local damage = ability:GetSpecialValueFor("shadowraze_damage")

	if passive ~= nil then
		damage = damage * 0.5
	end

	local stack_bonus_damage = ability:GetSpecialValueFor("bonus_damage_mana")

	local duration = ability:GetSpecialValueFor("duration")

	local modifier = enemy:FindModifierByName("modifier_morphling_waterraze_custom_debuff")

	if modifier then
		damage = damage + ( (stack_bonus_damage * modifier:GetStackCount()) / 100 * caster:GetMana() )
	end

	ApplyDamage({victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, attacker = caster, ability = ability})    
	enemy:AddNewModifier(caster, ability, "modifier_morphling_waterraze_custom_debuff", {duration = duration * (1-enemy:GetStatusResistance())})
end

modifier_morphling_waterraze_custom_debuff = class ({})

function modifier_morphling_waterraze_custom_debuff:IsDebuff() return true end

function modifier_morphling_waterraze_custom_debuff:IsPurgable() return not self:GetCaster():HasModifier("modifier_morphling_19") end

function modifier_morphling_waterraze_custom_debuff:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_morphling_waterraze_custom_debuff:OnRefresh()
	if not IsServer() then return end
    if self:GetStackCount() < 9 then
	    self:IncrementStackCount()
    end
end

function modifier_morphling_waterraze_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE
	}
end

function modifier_morphling_waterraze_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movement_speed_pct") * self:GetStackCount()
end

function modifier_morphling_waterraze_custom_debuff:GetModifierTurnRate_Percentage()
	return self:GetAbility():GetSpecialValueFor("turn_rate_pct")
end

modifier_morphling_waterraze_custom_mana_stack = class({})

function modifier_morphling_waterraze_custom_mana_stack:IsHidden() return true end
function modifier_morphling_waterraze_custom_mana_stack:IsPurgable() return false end
function modifier_morphling_waterraze_custom_mana_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_morphling_waterraze_custom_mana_buff = class({})

function modifier_morphling_waterraze_custom_mana_buff:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(0)
    self:StartIntervalThink(FrameTime())
end

function modifier_morphling_waterraze_custom_mana_buff:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_morphling_waterraze_custom_mana_stack")
    self:SetStackCount(#stack)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_morphling_waterraze_custom_mana_buff:IsPurgable() return false end

function modifier_morphling_waterraze_custom_mana_buff:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE
	}
end

function modifier_morphling_waterraze_custom_mana_buff:GetModifierExtraManaPercentage()
	return self:GetStackCount() * self:GetAbility().modifier_morphling_20[self:GetCaster():GetTalentLevel("modifier_morphling_20")]
end

function modifier_morphling_waterraze_custom_mana_buff:GetTexture() return "morphling_20" end

modifier_morphling_waterraze_custom_talent_handler = class({})

function modifier_morphling_waterraze_custom_talent_handler:IsHidden() return true end
function modifier_morphling_waterraze_custom_talent_handler:IsPurgable() return false end
function modifier_morphling_waterraze_custom_talent_handler:RemoveOnDeath() return false end
function modifier_morphling_waterraze_custom_talent_handler:IsPurgeException() return false end

function modifier_morphling_waterraze_custom_talent_handler:DeclareFunctions()
	return
	{
		 
	}
end

function modifier_morphling_waterraze_custom_talent_handler:OnAbilityFullyCast( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end
	if not params.ability then return end
	if params.ability:IsItem() or params.ability:IsToggle() then return end
	if not self:GetCaster():HasModifier("modifier_morphling_replicate_custom") then return end
	if params.ability:GetAbilityName() == "morphling_replicate_custom" then return end
    if params.ability:GetAbilityName() == "nevermore_frenzy_custom" then return end
	if params.ability:GetAbilityName() == "morphling_morph_replicate_custom" then return end
	if params.ability:GetAbilityName() == "invoker_quas_custom" then return end
	if params.ability:GetAbilityName() == "invoker_wex_custom" then return end
	if params.ability:GetAbilityName() == "invoker_exort_custom" then return end
	if not self:GetCaster():HasModifier("modifier_morphling_18") then return end
    if self:GetParent():HasModifier("modifier_morphling_waterraze_custom_talent_handler_cooldown") then return end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, 900, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )
	local creeps = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, 900, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false )
	local morphling_waterraze1_custom = self:GetCaster():FindAbilityByName("morphling_waterraze1_custom")
	if morphling_waterraze1_custom and morphling_waterraze1_custom:GetLevel() > 0 then
		if #enemies > 0 then
			CastShadowRazeOnPoint(self:GetCaster(), morphling_waterraze1_custom, enemies[1]:GetAbsOrigin(), morphling_waterraze1_custom:GetSpecialValueFor("shadowraze_radius"), true)
            self:IncrementStackCount()
            if self:GetStackCount() >= 3 then
                self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_morphling_waterraze_custom_talent_handler_cooldown", {duration = 3})
                self:SetStackCount(0)
            end
			return
		end
		if #creeps > 0 then
			CastShadowRazeOnPoint(self:GetCaster(), morphling_waterraze1_custom, creeps[1]:GetAbsOrigin(), morphling_waterraze1_custom:GetSpecialValueFor("shadowraze_radius"), true)
            self:IncrementStackCount()
            if self:GetStackCount() >= 3 then
                self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_morphling_waterraze_custom_talent_handler_cooldown", {duration = 3})
                self:SetStackCount(0)
            end
			return
		end
	end
end


modifier_morphling_waterraze_custom_talent_handler_cooldown = class({})
function modifier_morphling_waterraze_custom_talent_handler_cooldown:IsPurgable() return false end
function modifier_morphling_waterraze_custom_talent_handler_cooldown:IsPurgeException() return false end
function modifier_morphling_waterraze_custom_talent_handler_cooldown:RemoveOnDeath() return false end
function modifier_morphling_waterraze_custom_talent_handler_cooldown:IsDebuff() return true end