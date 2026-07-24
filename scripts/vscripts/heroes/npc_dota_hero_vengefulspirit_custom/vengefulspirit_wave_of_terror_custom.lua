--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_vengefulspirit_wave_of_terror_custom_debuff", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_wave_of_terror_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengefulspirit_wave_of_terror_custom_spirit", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_wave_of_terror_custom", LUA_MODIFIER_MOTION_NONE)

vengefulspirit_wave_of_terror_custom = class({})

function vengefulspirit_wave_of_terror_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf", context )
end

vengefulspirit_wave_of_terror_custom.modifier_vengefulspirit_1 = {-10,-20}
vengefulspirit_wave_of_terror_custom.modifier_vengefulspirit_8 = {-1,-2,-3}
vengefulspirit_wave_of_terror_custom.modifier_vengefulspirit_9 = {-5,-10,-15}
vengefulspirit_wave_of_terror_custom.modifier_vengefulspirit_16 = {-8,-16,-24}
vengefulspirit_wave_of_terror_custom.modifier_vengefulspirit_18 = {6,12}
vengefulspirit_wave_of_terror_custom.modifier_vengefulspirit_20 = {-10,-20,-30}

function vengefulspirit_wave_of_terror_custom:OnSpellStart()
	if not IsServer() then return end	

	local point = self:GetCursorPosition()

	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end

	local distance = self:GetCastRange(self:GetCaster():GetAbsOrigin(),self:GetCaster()) + self:GetCaster():GetCastRangeBonus()

	local dummy = CreateModifierThinker(self:GetCaster(), self,	"modifier_invulnerable", {}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(),	false)
	dummy:EmitSound("Hero_VengefulSpirit.WaveOfTerror")

	local direction = point - self:GetCaster():GetAbsOrigin()
	direction.z = 0
	direction = direction:Normalized()

	local velocity = direction * 2000

	local vision_aoe = self:GetSpecialValueFor("vision_aoe")

	local vision_duration = self:GetSpecialValueFor("vision_duration")

	local projectile =
	{
		Ability				= self,
		EffectName			= "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror.vpcf",
		vSpawnOrigin		= self:GetCaster():GetAbsOrigin(),
		fDistance			= distance,
		fStartRadius		= 325,
		fEndRadius			= 325,
		Source				= self:GetCaster(),
		bHasFrontalCone		= false,
		bReplaceExisting	= false,
		iUnitTargetTeam		= self:GetAbilityTargetTeam(),
		iUnitTargetFlags	= self:GetAbilityTargetFlags(),
		iUnitTargetType		= self:GetAbilityTargetType(),
		fExpireTime 		= GameRules:GetGameTime() + 10.0,
		bDeleteOnHit		= false,
		vVelocity			= Vector(velocity.x,velocity.y,0),
		bProvidesVision		= true,
		iVisionRadius 		= vision_aoe,
		iVisionTeamNumber 	= self:GetCaster():GetTeamNumber(),
		ExtraData			= {damage = damage, duration = duration, dummy_entindex = dummy:entindex()}
	}

	ProjectileManager:CreateLinearProjectile(projectile)

	if self:GetCaster():HasModifier("modifier_vengefulspirit_13") then

		local distance_teleport = (point - self:GetCaster():GetAbsOrigin()):Length2D()

		local projectile =
		{
			Ability				= self,
			vSpawnOrigin		= self:GetCaster():GetAbsOrigin(),
			fDistance			= distance_teleport,
			fStartRadius		= 325,
			fEndRadius			= 325,
			Source				= self:GetCaster(),
			bHasFrontalCone		= false,
			bReplaceExisting	= false,
			iUnitTargetTeam		= self:GetAbilityTargetTeam(),
			iUnitTargetFlags	= self:GetAbilityTargetFlags(),
			iUnitTargetType		= self:GetAbilityTargetType(),
			fExpireTime 		= GameRules:GetGameTime() + 10.0,
			bDeleteOnHit		= false,
			vVelocity			= Vector(velocity.x,velocity.y,0),
			bProvidesVision		= true,
			iVisionRadius 		= vision_aoe,
			iVisionTeamNumber 	= self:GetCaster():GetTeamNumber(),
			ExtraData			= {teleport = 1}
		}

		ProjectileManager:CreateLinearProjectile(projectile)
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_vengefulspirit_wave_of_terror_custom_spirit", {projectile = projectile})
	end
end

function vengefulspirit_wave_of_terror_custom:OnProjectileThink_ExtraData(location, ExtraData)
	if ExtraData.dummy_entindex then
		AddFOWViewer(self:GetCaster():GetTeamNumber(), location, self:GetSpecialValueFor("vision_aoe"), self:GetSpecialValueFor("vision_duration"), false)
		EntIndexToHScript(ExtraData.dummy_entindex):SetAbsOrigin(location)
	end
end

function vengefulspirit_wave_of_terror_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
	if target then
        if not ExtraData.teleport then
            local damage = self:GetSpecialValueFor("damage")
            if self:GetCaster():HasModifier("modifier_vengefulspirit_18") then
                damage = damage + (self:GetCaster():GetMana() / 100 * self.modifier_vengefulspirit_18[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_18")])
            end
            local duration = self:GetSpecialValueFor("duration")
            ApplyDamage({victim = target, attacker = self:GetCaster(), ability = self, damage = damage, damage_type = self:GetAbilityDamageType()})
            target:AddNewModifier(self:GetCaster(), self, "modifier_vengefulspirit_wave_of_terror_custom_debuff", {duration = duration * (1 - target:GetStatusResistance())})
        end
	else
		if ExtraData.dummy_entindex then
			EntIndexToHScript(ExtraData.dummy_entindex):ForceKill(false)
		end
		if self:GetCaster():HasModifier("modifier_vengefulspirit_13") and ExtraData.teleport ~= nil and ExtraData.teleport == 1 then
            if not self:GetCaster():HasModifier("modifier_wodarelax_invul") then
			    FindClearSpaceForUnit(self:GetCaster(), location, true)
            end
			self:GetCaster():RemoveModifierByName("modifier_vengefulspirit_wave_of_terror_custom_spirit")
		end
	end
	return false
end

modifier_vengefulspirit_wave_of_terror_custom_debuff = class({})

function modifier_vengefulspirit_wave_of_terror_custom_debuff:IsDebuff() return true end
function modifier_vengefulspirit_wave_of_terror_custom_debuff:IsHidden() return false end
function modifier_vengefulspirit_wave_of_terror_custom_debuff:IsPurgable() return true end
function modifier_vengefulspirit_wave_of_terror_custom_debuff:IsStunDebuff() return false end
function modifier_vengefulspirit_wave_of_terror_custom_debuff:RemoveOnDeath() return true end

function modifier_vengefulspirit_wave_of_terror_custom_debuff:OnCreated( params )
	local ability = self:GetAbility()
	if not ability then self:Destroy() return end
    self.attack_reduction = ability:GetSpecialValueFor("attack_reduction")
	self.armor_reduction = ability:GetSpecialValueFor("armor_reduction")
end

function modifier_vengefulspirit_wave_of_terror_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_vengefulspirit_wave_of_terror_custom_debuff:GetModifierDamageOutgoing_Percentage()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_vengefulspirit_9") then
        bonus = self:GetAbility().modifier_vengefulspirit_9[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_9")]
    end
    return self.attack_reduction + bonus
end

function modifier_vengefulspirit_wave_of_terror_custom_debuff:GetModifierPhysicalArmorBonus()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_vengefulspirit_8") then
		bonus = self:GetAbility().modifier_vengefulspirit_8[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_8")]
	end
	return self.armor_reduction + bonus
end

function modifier_vengefulspirit_wave_of_terror_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_vengeful/vengeful_wave_of_terror_recipient.vpcf"
end

function modifier_vengefulspirit_wave_of_terror_custom_debuff:GetEffectAttachType()
	return PATTACH_POINT_FOLLOW
end

function modifier_vengefulspirit_wave_of_terror_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_vengefulspirit_1") then
		bonus = self:GetAbility().modifier_vengefulspirit_1[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_1")]
	end
	return bonus
end

function modifier_vengefulspirit_wave_of_terror_custom_debuff:GetModifierMagicalResistanceBonus()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_vengefulspirit_16") then
		bonus = self:GetAbility().modifier_vengefulspirit_16[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_16")]
	end
	return bonus
end

function modifier_vengefulspirit_wave_of_terror_custom_debuff:GetModifierPropertyRestorationAmplification()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_vengefulspirit_20") then
		bonus = self:GetAbility().modifier_vengefulspirit_20[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_20")]
	end
	return bonus
end

modifier_vengefulspirit_wave_of_terror_custom_spirit = class({})

function modifier_vengefulspirit_wave_of_terror_custom_spirit:IsHidden() return true end
function modifier_vengefulspirit_wave_of_terror_custom_spirit:IsPurgable() return false end

function modifier_vengefulspirit_wave_of_terror_custom_spirit:OnCreated(data)
	if not IsServer() then return end
    self.projectile = data.projectile
	ProjectileManager:ProjectileDodge(self:GetParent())
	self:GetParent():AddEffects(EF_NODRAW)
end

function modifier_vengefulspirit_wave_of_terror_custom_spirit:OnDestroy()
	if not IsServer() then return end
    if self.projectile and ProjectileManager:IsValidProjectile(self.projectile) then
        ProjectileManager:DestroyLinearProjectile(self.projectile)
    end
	self:GetParent():RemoveEffects(EF_NODRAW)
end

function modifier_vengefulspirit_wave_of_terror_custom_spirit:CheckState()
	local state =
	{
		[MODIFIER_STATE_INVULNERABLE] 	= true,
		[MODIFIER_STATE_OUT_OF_GAME]	= true,
		[MODIFIER_STATE_UNSELECTABLE]	= true,
		[MODIFIER_STATE_DISARMED]	= true,
		[MODIFIER_STATE_ROOTED]	= true,
		[MODIFIER_STATE_NO_HEALTH_BAR]  = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
	}
	return state
end