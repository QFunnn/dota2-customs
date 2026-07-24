--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_medusa_stone_gaze_custom", "heroes/npc_dota_hero_medusa_custom/medusa_stone_gaze_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_medusa_stone_gaze_custom_debuff", "heroes/npc_dota_hero_medusa_custom/medusa_stone_gaze_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_medusa_stone_gaze_custom_petrified", "heroes/npc_dota_hero_medusa_custom/medusa_stone_gaze_custom", LUA_MODIFIER_MOTION_NONE )

medusa_stone_gaze_custom = class({})

medusa_stone_gaze_custom.modifier_medusa_13 = {-25,-35,-50}

function medusa_stone_gaze_custom:GetCooldown( level )
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_medusa_13") then
		bonus = self.modifier_medusa_13[self:GetCaster():GetTalentLevel("modifier_medusa_13")]
	end	
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function medusa_stone_gaze_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_medusa_13") then return 0 end
    return self.BaseClass.GetManaCost(self, level)
end

function medusa_stone_gaze_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_medusa_stone_gaze_custom", {duration = duration})
end

modifier_medusa_stone_gaze_custom = class({})
function modifier_medusa_stone_gaze_custom:IsPurgable() return false end
function modifier_medusa_stone_gaze_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_medusa_stone_gaze_custom:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.parent = self:GetParent()
	self.modifiers = {}
	if not IsServer() then return end
	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_stone_gaze_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_head", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self:GetParent():EmitSound("Hero_Medusa.StoneGaze.Cast")
end

function modifier_medusa_stone_gaze_custom:OnDestroy()
	if not IsServer() then return end
	for modifier,_ in pairs(self.modifiers) do
		if not modifier:IsNull() then
			modifier:Destroy()
		end
	end
	self:GetParent():StopSound("Hero_Medusa.StoneGaze.Cast")
end

function modifier_medusa_stone_gaze_custom:OnIntervalThink()
	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for _,enemy in pairs(enemies) do
		local modifier1 = enemy:FindModifierByNameAndCaster( "modifier_medusa_stone_gaze_custom_debuff", self.parent )
		local modifier2 = enemy:FindModifierByNameAndCaster( "modifier_medusa_stone_gaze_custom_petrified", self.parent )
		if (not modifier1) and (not modifier2) then
			local modifier = enemy:AddNewModifier( self.parent, self:GetAbility(), "modifier_medusa_stone_gaze_custom_debuff", { center_unit = self.parent:entindex() })
			self.modifiers[modifier] = true
		end
	end
end

function modifier_medusa_stone_gaze_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_medusa_stone_gaze_custom:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor( "speed_boost" )
end

modifier_medusa_stone_gaze_custom_debuff = class({})
function modifier_medusa_stone_gaze_custom_debuff:IsPurgable() return false end

function modifier_medusa_stone_gaze_custom_debuff:OnCreated( kv )
	self.slow = -self:GetAbility():GetSpecialValueFor( "slow" )
	self.stun_duration = self:GetAbility():GetSpecialValueFor( "stone_duration" )
	self.face_duration = self:GetAbility():GetSpecialValueFor( "face_duration" )
	self.physical_bonus = self:GetAbility():GetSpecialValueFor( "bonus_physical_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.stone_angle = self:GetAbility():GetSpecialValueFor( "vision_cone" )
	self.stone_angle = 85
	self.parent = self:GetParent()
	self.facing = false
	self.counter = 0
	self.interval = 0.03
	if not IsServer() then return end
	self.center_unit = EntIndexToHScript( kv.center_unit )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self.center_unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_stone_gaze_facing.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	self:AddParticle( self.effect_cast, false, false, -1, false, false )
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_medusa_stone_gaze_custom_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_medusa_stone_gaze_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	if self.facing then
		return self.slow
	end
end

function modifier_medusa_stone_gaze_custom_debuff:GetModifierAttackSpeedBonus_Constant()
	if self.facing then
		return self.slow
	end
end

function modifier_medusa_stone_gaze_custom_debuff:OnIntervalThink()
	local vector = self.center_unit:GetOrigin()-self.parent:GetOrigin()
	local center_angle = VectorToAngles( vector ).y
	local facing_angle = VectorToAngles( self.parent:GetForwardVector() ).y
	local distance = vector:Length2D()
	local prev_facing = self.facing
	self.facing = ( math.abs( AngleDiff(center_angle,facing_angle) ) < self.stone_angle ) and (distance < self.radius )
	if self.facing~=prev_facing then
		self:ChangeEffects( self.facing )
	end
	if self.facing then
		self.counter = self.counter + self.interval
	end
	if self.counter>=self.face_duration then
		self.parent:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_medusa_stone_gaze_custom_petrified", { duration = self.stun_duration, physical_bonus = self.physical_bonus, center_unit = self.center_unit:entindex() })
		self:Destroy()
	end
end

function modifier_medusa_stone_gaze_custom_debuff:ChangeEffects( IsNowFacing )
	local target = self.parent
	if IsNowFacing then
		target = self.center_unit
		EmitSoundOnClient( "Hero_Medusa.StoneGaze.Target", self:GetParent():GetPlayerOwner() )
	end
	ParticleManager:SetParticleControlEnt( self.effect_cast, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
end

modifier_medusa_stone_gaze_custom_petrified = class({})
function modifier_medusa_stone_gaze_custom_petrified:IsPurgable() return true end

function modifier_medusa_stone_gaze_custom_petrified:OnCreated( kv )
	if not IsServer() then return end
	self.physical_bonus = kv.physical_bonus
	self.center_unit = EntIndexToHScript( kv.center_unit )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff_stoned.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self.center_unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector( 0,0,0 ), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	EmitSoundOnClient( "Hero_Medusa.StoneGaze.Stun", self:GetParent():GetPlayerOwner() )
end

function modifier_medusa_stone_gaze_custom_petrified:OnRefresh( kv )
	if not IsServer() then return end
	self.physical_bonus = kv.physical_bonus
	self.center_unit = EntIndexToHScript( kv.center_unit )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff_stoned.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self.center_unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector( 0,0,0 ), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	EmitSoundOnClient( "Hero_Medusa.StoneGaze.Stun", self:GetParent():GetPlayerOwner() )
end

function modifier_medusa_stone_gaze_custom_petrified:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_medusa_stone_gaze_custom_petrified:GetModifierIncomingDamage_Percentage( params )
	if params.damage_type==DAMAGE_TYPE_PHYSICAL then
		return self.physical_bonus
	end
end

function modifier_medusa_stone_gaze_custom_petrified:CheckState()
	return
    {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end

function modifier_medusa_stone_gaze_custom_petrified:GetStatusEffectName()
	return "particles/status_fx/status_effect_medusa_stone_gaze.vpcf"
end

function modifier_medusa_stone_gaze_custom_petrified:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end