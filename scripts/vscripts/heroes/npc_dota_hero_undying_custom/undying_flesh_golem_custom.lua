--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undying_flesh_golem_custom", "heroes/npc_dota_hero_undying_custom/undying_flesh_golem_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_flesh_golem_custom_debuff", "heroes/npc_dota_hero_undying_custom/undying_flesh_golem_custom", LUA_MODIFIER_MOTION_NONE)

undying_flesh_golem_custom = class({})

function undying_flesh_golem_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_fg_transform.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_fg_transform_reverse.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_fg_aura.vpcf", context )
end

undying_flesh_golem_custom.modifier_undying_20 = {0.5,1,1.5}

function undying_flesh_golem_custom:GetIntrinsicModifierName()
	if self:GetCaster():HasModifier("modifier_undying_7") then
		return "modifier_undying_flesh_golem_custom"
	end
end

function undying_flesh_golem_custom:GetCooldown(level)
	if self:GetCaster():HasModifier("modifier_undying_7") then return 0 end
    return self.BaseClass.GetCooldown( self, level )
end

function undying_flesh_golem_custom:GetManaCost(level)
	if self:GetCaster():HasModifier("modifier_undying_7") then return 0 end
    return self.BaseClass.GetManaCost(self, level)
end

function undying_flesh_golem_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_undying_7") then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function undying_flesh_golem_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():StartGesture(ACT_DOTA_SPAWN)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_undying_flesh_golem_custom", {duration = duration})
end

modifier_undying_flesh_golem_custom = class({})
function modifier_undying_flesh_golem_custom:IsPurgable() return false end
function modifier_undying_flesh_golem_custom:IsPurgeException() return false end
function modifier_undying_flesh_golem_custom:RemoveOnDeath() return not self:GetCaster():HasModifier("modifier_undying_7") end

function modifier_undying_flesh_golem_custom:OnCreated()
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.str_percentage = self:GetAbility():GetSpecialValueFor("str_percentage")
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.movement_bonus = self:GetAbility():GetSpecialValueFor("movement_bonus")
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Undying.FleshGolem.Cast")
	self.strength = self:GetParent():GetStrength() * self.str_percentage * 0.01
	self:StartIntervalThink(0.1)

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_undying/undying_fg_transform.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetAbsOrigin() )	
	ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_undying_flesh_golem_custom:OnIntervalThink()
	if not IsServer() then return end
	self.strength = 0
	self.strength = self:GetParent():GetStrength() * self.str_percentage * 0.01
	self:GetParent():CalculateStatBonus(true)
end

function modifier_undying_flesh_golem_custom:OnDestroy()
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_undying/undying_fg_transform_reverse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetAbsOrigin() )	
	ParticleManager:ReleaseParticleIndex(particle)
	self:GetParent():EmitSound("Hero_Undying.FleshGolem.End")
end

function modifier_undying_flesh_golem_custom:GetEffectName()
    return "particles/units/heroes/hero_undying/undying_fg_aura.vpcf"
end

function modifier_undying_flesh_golem_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MODEL_CHANGE,        
		 
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
	}
end

function modifier_undying_flesh_golem_custom:GetModifierTotalPercentageManaRegen()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_undying_20") then
		bonus = self:GetAbility().modifier_undying_20[self:GetCaster():GetTalentLevel("modifier_undying_20")]
	end
	return bonus
end

function modifier_undying_flesh_golem_custom:OnTooltip()
	return self.str_percentage
end

function modifier_undying_flesh_golem_custom:GetModifierMoveSpeedBonus_Constant()
	return self.movement_bonus
end

function modifier_undying_flesh_golem_custom:GetModifierBonusStats_Strength()
	return self.strength
end

function modifier_undying_flesh_golem_custom:GetModifierModelChange()
	return "models/heroes/undying/undying_flesh_golem.vmdl"
end

function modifier_undying_flesh_golem_custom:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if self:GetParent():IsIllusion() then return end
	if params.target:IsWard() then return end
	params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_undying_flesh_golem_custom_debuff", {duration = self.slow_duration})

    local spawn_zombie_on_attack = self:GetAbility():GetSpecialValueFor("spawn_zombie_on_attack")
    local zombie_duration = self:GetAbility():GetSpecialValueFor("zombie_duration")
    local zombie_spawn_padding = self:GetAbility():GetSpecialValueFor("zombie_spawn_padding")
    if self:GetCaster():HasModifier("modifier_undying_10") then return end
    local undying_tombstone_custom = self:GetCaster():FindAbilityByName("undying_tombstone_custom")
    if undying_tombstone_custom and undying_tombstone_custom:GetLevel() > 0 then
        undying_tombstone_custom:CreateZombieDecay(params.target:GetAbsOrigin() + RandomVector(zombie_spawn_padding), zombie_duration, true)
    end
end

modifier_undying_flesh_golem_custom_debuff = class({})

function modifier_undying_flesh_golem_custom_debuff:OnCreated()
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	self.damage_amp = self:GetAbility():GetSpecialValueFor("damage_amp")
end

function modifier_undying_flesh_golem_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_undying_flesh_golem_custom_debuff:GetModifierIncomingDamage_Percentage()
	return self.damage_amp
end

function modifier_undying_flesh_golem_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end