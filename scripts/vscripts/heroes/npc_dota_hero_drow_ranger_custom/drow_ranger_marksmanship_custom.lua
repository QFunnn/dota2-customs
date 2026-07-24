--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_drow_ranger_marksmanship_custom", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_marksmanship_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_marksmanship_custom_debuff", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_marksmanship_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_marksmanship_custom_talent", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_marksmanship_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_marksmanship_custom_cannot_miss", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_marksmanship_custom", LUA_MODIFIER_MOTION_NONE )

drow_ranger_marksmanship_custom = class({})

function drow_ranger_marksmanship_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_base_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_marksmanship_frost_arrow.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_marksmanship.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_drow/drow_marksmanship_start.vpcf", context )
end

function drow_ranger_marksmanship_custom:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function drow_ranger_marksmanship_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_drow_ranger_7") then
		return "drow_ranger_7"
	end
	return "drow_ranger_marksmanship"
end

function drow_ranger_marksmanship_custom:GetCastRange(vLocation, hTarget)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_woda_talent_octar") then
		local bonus_2 = {150,300}
		bonus = bonus_2[self:GetCaster():GetTalentLevel("modifier_woda_talent_octar")]
	end
	return 0
end

function drow_ranger_marksmanship_custom:OnSpellStart()
	if not IsServer() then return end
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, self:GetCaster():GetAttackSpeed(true))
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetCaster():Script_GetAttackRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
	for _, enemy in pairs(enemies) do
		local projectile = "particles/units/heroes/hero_drow/drow_base_attack.vpcf"
		local drow_ranger_frost_arrows_custom = self:GetCaster():FindAbilityByName("drow_ranger_frost_arrows_custom")
		local ultimate = false
		if drow_ranger_frost_arrows_custom then
			if drow_ranger_frost_arrows_custom:GetAutoCastState() and drow_ranger_frost_arrows_custom:IsFullyCastable() then
				projectile = "particles/units/heroes/hero_drow/drow_frost_arrow.vpcf"
				if RollPercentage(self:GetSpecialValueFor( "chance" )) then
					projectile = "particles/units/heroes/hero_drow/drow_marksmanship_frost_arrow.vpcf"
					ultimate = true
				end
			else
				if RollPercentage(self:GetSpecialValueFor( "chance" )) then
					projectile = "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
					ultimate = true
				end
			end
		end
		local projectile_info = {
			Ability = self,	
			EffectName = projectile,
			iMoveSpeed = self:GetCaster():GetProjectileSpeed(),
			iSourceAttachment = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_bow_eyes")),	
			bDodgeable = true,
			bIsAttack = true,
			Source = self:GetCaster(),
			Target = enemy,
			ExtraData = {ultimate = ultimate},
		}
		ProjectileManager:CreateTrackingProjectile( projectile_info )
	end
end

function drow_ranger_marksmanship_custom:GetIntrinsicModifierName()
	if self:GetCaster():IsIllusion() then return end
	return "modifier_drow_ranger_marksmanship_custom"
end

function drow_ranger_marksmanship_custom:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end
	if data.ultimate == 1 or data.ultimate == true then
		local modifier = target:AddNewModifier( self:GetCaster(), self, "modifier_drow_ranger_marksmanship_custom_debuff", { duration = 0.5 } )
	end
	if data.talent == 1 or data.talent == true then
		local modifier = self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_drow_ranger_marksmanship_custom_talent", { duration = 0.5 } )
		self:GetCaster():PerformAttack(target, true, true, true, false, false, false, false)
		if modifier then
			modifier:Destroy()
		end
		return
	end
	self:GetCaster():PerformAttack(target, true, true, true, false, false, false, false)
end

modifier_drow_ranger_marksmanship_custom = class({})

function modifier_drow_ranger_marksmanship_custom:IsHidden()
	return true
end

function modifier_drow_ranger_marksmanship_custom:IsDebuff()
	return false
end

function modifier_drow_ranger_marksmanship_custom:IsPurgable()
	return false
end

function modifier_drow_ranger_marksmanship_custom:GetPriority()
	return MODIFIER_PRIORITY_LOW
end

function modifier_drow_ranger_marksmanship_custom:OnCreated( kv )
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.disable = self:GetAbility():GetSpecialValueFor( "disable_range" )
	self.radius = self:GetAbility():GetSpecialValueFor( "agility_range" )
	self.split_range = self:GetAbility():GetSpecialValueFor( "scepter_range" )
	self.split_count = self:GetAbility():GetSpecialValueFor( "split_count_scepter" )
	self.split_damage = self:GetAbility():GetSpecialValueFor( "damage_reduction_scepter" )
	self.active = true

	if not IsServer() then return end
	self.records = {}
	self.procs = false

	self.info = {
		Ability = self:GetAbility(),	
		EffectName = self:GetParent():GetRangedProjectileName(),
		iMoveSpeed = self:GetParent():GetProjectileSpeed(),
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,		
		bDodgeable = true,
		bIsAttack = true,
		ExtraData = {},
	}

	self:StartIntervalThink( 0.1 )
end

function modifier_drow_ranger_marksmanship_custom:OnIntervalThink()
	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.disable, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 0, false )
	local no_enemies = #enemies==0
	if self:GetCaster():HasModifier("modifier_drow_ranger_16") then
		no_enemies = true
	end
	if self.active ~= no_enemies then
		self:PlayEffects2( no_enemies )
		self.active = no_enemies
	end
end

function modifier_drow_ranger_marksmanship_custom:PlayEffects1()
	self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_drow/drow_marksmanship.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(2,0,0) )
	self:AddParticle( self.effect_cast, false,  false,  -1, false,  false  )
	self:PlayEffects2( true )
end

function modifier_drow_ranger_marksmanship_custom:PlayEffects2( start )
	local state = 1
	if start then state = 2 end
	if not start then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_drow/drow_marksmanship_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_drow_ranger_marksmanship_custom:OnRefresh( kv )
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.disable = self:GetAbility():GetSpecialValueFor( "disable_range" )
	self.radius = self:GetAbility():GetSpecialValueFor( "agility_range" )	
end

function modifier_drow_ranger_marksmanship_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}
	return funcs
end

function modifier_drow_ranger_marksmanship_custom:OnAttackRecord( params )
    if not IsServer() then return end
    if self:GetParent():PassivesDisabled() then return end
    if params.attacker ~= self:GetParent() then return end

end

function modifier_drow_ranger_marksmanship_custom:OnAttackStart( params )
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
	if params.attacker~=self:GetParent() then return end
    self:GetParent():RemoveModifierByName("modifier_drow_ranger_marksmanship_custom_cannot_miss")
	if not self.active then return end
	local rand = RandomInt( 0, 100 )
	if rand>self.chance then return end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_drow_ranger_marksmanship_custom_cannot_miss", {})
    self.procs = true
end

function modifier_drow_ranger_marksmanship_custom:OnAttack( params )
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
	if params.attacker~=self:GetParent() then return end
	if self:GetAbility().split and self:GetAbility().split_procs then
		self.procs = true
	end
	if not self.procs then return end
	self.procs = false
	self.records[params.record] = true
    self:GetParent():RemoveModifierByName("modifier_drow_ranger_marksmanship_custom_cannot_miss")
end

function modifier_drow_ranger_marksmanship_custom:OnAttackLanded( params )
	if self:GetParent():PassivesDisabled() then return end
	if not self.records[params.record] then return end
	local modifier = params.target:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_drow_ranger_marksmanship_custom_debuff", { duration = FrameTime() } )
	self.records[params.record] = modifier
end

function modifier_drow_ranger_marksmanship_custom:GetModifierProcAttack_BonusDamage_Physical( params )
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
	if not self.records[params.record] then return end
    params.target:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_drow_ranger_marksmanship_custom_debuff", { duration = FrameTime() } )
	return self.damage
end

function modifier_drow_ranger_marksmanship_custom:OnAttackRecordDestroy( params )
	if not self.records[params.record] then return end
	if self:GetParent():PassivesDisabled() then return end
	local modifier = self.records[params.record]
	if type(modifier)=='table' and not modifier:IsNull() then modifier:Destroy() end
	self.records[params.record] = nil
end

function modifier_drow_ranger_marksmanship_custom:GetModifierProjectileName( params )
	if not IsServer() then return end
	if not self.procs then return end
	if self:GetParent():PassivesDisabled() then return end
	local drow_ranger_frost_arrows_custom = self:GetCaster():FindAbilityByName('drow_ranger_frost_arrows_custom')
	if drow_ranger_frost_arrows_custom and drow_ranger_frost_arrows_custom:GetLevel() <= 0 then
		return "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
	end
end

function modifier_drow_ranger_marksmanship_custom:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
	if not self:GetParent():HasScepter() then return end
	if self:GetAbility().split then return end

	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), params.target:GetOrigin(), nil, self.split_range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )

	local count = 0
	for _,enemy in pairs(enemies) do
		if enemy~=params.target and count<self.split_count then
			local procs = false
			local rand = RandomInt( 0, 100 )
			if self.active and rand<=self.chance then
				procs = true
			end

			self.info.Target = enemy
			self.info.Source = params.target
			if procs then
				self.info.EffectName = "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
				self.info.ExtraData = { procs = true }
			else
				self.info.EffectName = self:GetParent():GetRangedProjectileName()
				self.info.ExtraData = { procs = false }
			end
			ProjectileManager:CreateTrackingProjectile( self.info )
			count = count+1
		end
	end
end

function modifier_drow_ranger_marksmanship_custom:GetModifierDamageOutgoing_Percentage()
	if not IsServer() then return end
	if self:GetParent():PassivesDisabled() then return end
	if self:GetAbility().split then
		return -self.split_damage
	end
end

modifier_drow_ranger_marksmanship_custom_debuff = class({})

function modifier_drow_ranger_marksmanship_custom_debuff:IsHidden()
	return true
end

function modifier_drow_ranger_marksmanship_custom_debuff:IsDebuff()
	return true
end

function modifier_drow_ranger_marksmanship_custom_debuff:IsStunDebuff()
	return false
end

function modifier_drow_ranger_marksmanship_custom_debuff:IsPurgable()
	return false
end

function modifier_drow_ranger_marksmanship_custom_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function modifier_drow_ranger_marksmanship_custom_debuff:OnCreated()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.armor = self.parent:GetPhysicalArmorBaseValue()*-1
end

function modifier_drow_ranger_marksmanship_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_drow_ranger_marksmanship_custom_debuff:GetModifierPhysicalArmorBonus()
    if not IsServer() then return end
    return self.armor
end


modifier_drow_ranger_marksmanship_custom_talent = class({})

function modifier_drow_ranger_marksmanship_custom_talent:IsHidden() return true end
function modifier_drow_ranger_marksmanship_custom_talent:IsPurgable() return false end

function modifier_drow_ranger_marksmanship_custom_talent:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
	return funcs
end

function modifier_drow_ranger_marksmanship_custom_talent:GetModifierDamageOutgoing_Percentage()
	if IsServer() then
		return -50
	end
end

modifier_drow_ranger_marksmanship_custom_cannot_miss = class({})
function modifier_drow_ranger_marksmanship_custom_cannot_miss:IsHidden() return true end
function modifier_drow_ranger_marksmanship_custom_cannot_miss:IsPurgable() return false end
function modifier_drow_ranger_marksmanship_custom_cannot_miss:IsPurgeException() return false end
function modifier_drow_ranger_marksmanship_custom_cannot_miss:OnCreated()
    if not IsServer() then return end
    print("cannot miss")
end
function modifier_drow_ranger_marksmanship_custom_cannot_miss:CheckState()
    return
    {
        [MODIFIER_STATE_CANNOT_MISS] = true
    }
end