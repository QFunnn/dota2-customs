--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_transform", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_metamorphosis_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_transform_aura_applier", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_metamorphosis_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_metamorphosis_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_transform_aura", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_metamorphosis_custom", LUA_MODIFIER_MOTION_NONE)

terrorblade_metamorphosis_custom = class({})
terrorblade_metamorphosis_custom.modifier_terrorblade_3 = {-30,-60,-90}
terrorblade_metamorphosis_custom.modifier_terrorblade_5 = {0.4,0.8}

function terrorblade_metamorphosis_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_scepter.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_terrorblade.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_terrorblade.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_terrorblade.vpcf", context)
end

function terrorblade_metamorphosis_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_terrorblade_3") then
		bonus = self.modifier_terrorblade_3[self:GetCaster():GetTalentLevel("modifier_terrorblade_3")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function terrorblade_metamorphosis_custom:OnSpellStart( duration )
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:UseMetamorphosis(duration)
end


function terrorblade_metamorphosis_custom:UseMetamorphosis(duration)
	local delay = self:GetSpecialValueFor("transformation_time")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_custom_terrorblade_metamorphosis_transform", {duration = delay, meta_duration = duration})
	for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("metamorph_aura_tooltip"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)) do
		if unit ~= self:GetCaster() and unit:IsIllusion() and unit:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() and unit:GetName() == self:GetCaster():GetName() then
			unit:AddNewModifier(self:GetCaster(), self, "modifier_custom_terrorblade_metamorphosis_transform", {duration = delay, meta_duration = -1})
		end
	end
end

modifier_custom_terrorblade_metamorphosis_transform = class({})

function modifier_custom_terrorblade_metamorphosis_transform:IsHidden()	return true end
function modifier_custom_terrorblade_metamorphosis_transform:IsPurgable() return false end

function modifier_custom_terrorblade_metamorphosis_transform:OnCreated(table)
	self.duration	= table.meta_duration
	if not IsServer() then return end
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_3)
	self:GetParent():EmitSound("Hero_Terrorblade.Metamorphosis")

	local transform_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(transform_particle)
	
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_custom_terrorblade_metamorphosis_transform_aura_applier", {})
end

function modifier_custom_terrorblade_metamorphosis_transform:OnDestroy()
	if not IsServer() then return end

	if not self:GetParent():IsAlive() then 
		self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform_aura_applier")
	end

	local meta = self:GetParent():FindModifierByName("modifier_custom_terrorblade_metamorphosis")

	if not meta then 
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_custom_terrorblade_metamorphosis", {duration = self.duration})
	else 
		meta:SetDuration(meta:GetRemainingTime() + self.duration, true)
	end
end

function modifier_custom_terrorblade_metamorphosis_transform:CheckState()
	return {[MODIFIER_STATE_STUNNED] = true}
end

modifier_custom_terrorblade_metamorphosis = class({})

function modifier_custom_terrorblade_metamorphosis:IsPurgable() return false end

function modifier_custom_terrorblade_metamorphosis:OnCreated(table)
	if not self:GetAbility() then self:Destroy() return end

	self.particle_ally_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.particle_ally_fx, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(self.particle_ally_fx, false, false, -1, false, false) 

	self.bonus_range = self:GetAbility():GetSpecialValueFor("bonus_range")
	self.bonus_damage	= self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.base_attack_time = self:GetAbility():GetSpecialValueFor("base_attack_time")
	
	if not IsServer() then return end

	self.previous_attack_cability = self:GetParent():GetAttackCapability()
	
	self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
end

function modifier_custom_terrorblade_metamorphosis:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
	self:GetParent():SetAttackCapability(self.previous_attack_cability)
	self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform_aura_applier")
end

function modifier_custom_terrorblade_metamorphosis:CheckState()
	if not self:GetAbility() then self:Destroy() return end
end

function modifier_custom_terrorblade_metamorphosis:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		 
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
end

function modifier_custom_terrorblade_metamorphosis:GetModifierHealthRegenPercentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_terrorblade_5") then
		bonus = self:GetAbility().modifier_terrorblade_5[self:GetCaster():GetTalentLevel("modifier_terrorblade_5")]
	end
	return bonus
end

function modifier_custom_terrorblade_metamorphosis:GetModelScale() return 10 end

function modifier_custom_terrorblade_metamorphosis:GetModifierModelChange()
	return "models/heroes/terrorblade/demon.vmdl"
end

function modifier_custom_terrorblade_metamorphosis:GetAttackSound()
	return "Hero_Terrorblade_Morphed.Attack"
end

function modifier_custom_terrorblade_metamorphosis:GetModifierProjectileName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf"
end

function modifier_custom_terrorblade_metamorphosis:OnAttackStart(keys)
	if keys.attacker == self:GetParent() then
		--self:GetParent():EmitSound("Hero_Terrorblade_Morphed.preAttack")
	end
end

function modifier_custom_terrorblade_metamorphosis:OnAttack(keys)
	if keys.attacker == self:GetParent() then
		--self:GetParent():EmitSound("Hero_Terrorblade_Morphed.Attack")
	end
end

function modifier_custom_terrorblade_metamorphosis:OnAttackLanded(params)
	if params.attacker ~= self:GetParent() then return end
	self:GetParent():EmitSound("Hero_Terrorblade_Morphed.projectileImpact")
end

function modifier_custom_terrorblade_metamorphosis:GetModifierAttackRangeBonus()
	return self.bonus_range
end

function modifier_custom_terrorblade_metamorphosis:GetModifierBaseAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_custom_terrorblade_metamorphosis:GetModifierBaseAttackTimeConstant()
	return self.base_attack_time
end

function modifier_custom_terrorblade_metamorphosis:GetAttackSound()
	return "Hero_Terrorblade_Morphed.Attack"
end

modifier_custom_terrorblade_metamorphosis_transform_aura_applier = class({})

function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:OnCreated()
	self.metamorph_aura_tooltip	= self:GetAbility():GetSpecialValueFor("metamorph_aura_tooltip")
end

function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:IsAura() return true end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:IsAuraActiveOnDeath() return false end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraDuration()	return 0.5 end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraRadius() return self.metamorph_aura_tooltip end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end

function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetModifierAura()				
	return "modifier_custom_terrorblade_metamorphosis_transform_aura" 
end

function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraEntityReject(hTarget)
	return hTarget == self:GetParent() or self:GetParent():IsIllusion() or not hTarget:IsIllusion() or hTarget:GetPlayerOwnerID() ~= self:GetCaster():GetPlayerOwnerID()  or (hTarget:HasModifier("modifier_terrorblade_reflection_custom") and hTarget:GetName() ~= self:GetParent():GetName())
end

modifier_custom_terrorblade_metamorphosis_transform_aura = class({})

function modifier_custom_terrorblade_metamorphosis_transform_aura:IsHidden() return true end

function modifier_custom_terrorblade_metamorphosis_transform_aura:OnCreated()
	if not self:GetAbility() then self:Destroy() return end
	if not IsServer() then return end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_custom_terrorblade_metamorphosis_transform", {duration = self:GetAbility():GetSpecialValueFor("transformation_time")})
end

function modifier_custom_terrorblade_metamorphosis_transform_aura:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform")
	self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis")
end