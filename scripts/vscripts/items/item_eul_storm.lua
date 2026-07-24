--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_eul_storm", "items/item_eul_storm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_eul_storm_thinker", "items/item_eul_storm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_eul_storm_pull", "items/item_eul_storm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_eul_storm_tornado", "items/item_eul_storm", LUA_MODIFIER_MOTION_NONE)

item_eul_storm = class({})

function item_eul_storm:GetIntrinsicModifierName()
	return "modifier_item_eul_storm"
end

function item_eul_storm:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function item_eul_storm:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    point = GetGroundPosition(point, nil)

    local target = CreateModifierThinker(self:GetCaster(), self, "modifier_item_eul_storm_thinker", nil, point, self:GetCaster():GetTeamNumber(), false)

    local info = 
    {
        EffectName = "particles/items2_fx/rod_of_atos_attack.vpcf",
        Ability = self,
        iMoveSpeed = 1400,
        Source = self:GetCaster(),
        Target = target,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
    }

    local point_start = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack1"))
    local vDirection = target:GetAbsOrigin() - self:GetCaster():GetOrigin()
    local range = vDirection:Length2D()
    vDirection.z = 0.0
    vDirection = vDirection:Normalized()
    --local particle = ParticleManager:CreateParticle( "particles/eul_storm_proj.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
    --ParticleManager:SetParticleControl( particle, 0, point_start )
    --ParticleManager:SetParticleControl( particle, 1, Vector(1400,1400,1400) )
    --ParticleManager:SetParticleControl( particle, 5,  target:GetAbsOrigin() )
    ProjectileManager:CreateTrackingProjectile( info )
end

function item_eul_storm:OnProjectileHit( target, vLocation )
    if not IsServer() then return end

    if target == nil then return end

    local tornado = CreateUnitByName("npc_dota_enraged_wildkin_tornado", target:GetAbsOrigin(), true, nil, nil, self:GetCaster():GetTeamNumber())
	tornado:SetOwner(self:GetCaster())
	tornado:AddNewModifier(self:GetCaster(), self, "modifier_item_eul_storm_tornado", { duration = self:GetSpecialValueFor("cyclone_duration") })

    UTIL_Remove(target)

    return true
end

modifier_item_eul_storm_thinker = class({})
function modifier_item_eul_storm_thinker:IsHidden() return true end

modifier_item_eul_storm = class({})

function modifier_item_eul_storm:IsHidden() return true end
function modifier_item_eul_storm:IsPurgable() return false end
function modifier_item_eul_storm:IsPurgeException() return false end
function modifier_item_eul_storm:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_eul_storm:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_BONUS
	}
end

function modifier_item_eul_storm:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_strength")
end
function modifier_item_eul_storm:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end
function modifier_item_eul_storm:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end
function modifier_item_eul_storm:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end
function modifier_item_eul_storm:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end

modifier_item_eul_storm_tornado = class({})

function modifier_item_eul_storm_tornado:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	local particle = ParticleManager:CreateParticle("particles/neutral_fx/tornado_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
	self:GetParent():EmitSound("n_creep_Wildkin.Tornado")
	self:StartIntervalThink(0.5)
end

function modifier_item_eul_storm_tornado:OnIntervalThink()
	if not IsServer() then return end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _, enemy in pairs(enemies) do
		ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = self.damage / 2, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
	end
end

function modifier_item_eul_storm_tornado:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_item_eul_storm_tornado:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("n_creep_Wildkin.Tornado")
    self:GetParent():Destroy()
end

function modifier_item_eul_storm_tornado:GetModifierAura()
	return "modifier_item_eul_storm_pull"
end

function modifier_item_eul_storm_tornado:GetAuraRadius()
	return self.radius
end

function modifier_item_eul_storm_tornado:GetAuraDuration()
	return 0.1
end

function modifier_item_eul_storm_tornado:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_item_eul_storm_tornado:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_eul_storm_tornado:IsAura()
	return true
end

modifier_item_eul_storm_pull = class({})

function modifier_item_eul_storm_pull:IsPurgable() return false end

function modifier_item_eul_storm_pull:IsHidden() return true end

function modifier_item_eul_storm_pull:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_eul_storm_pull:OnCreated()
	if not IsServer() then return end
	self.effect_cast = ParticleManager:CreateParticle( "particles/windrunner_pull.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( self.effect_cast, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( self.effect_cast, 1, self:GetAuraOwner():GetAbsOrigin() )
	self:AddParticle(self.effect_cast, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end

function modifier_item_eul_storm_pull:CheckState()
    return
    {
        [MODIFIER_STATE_PASSIVES_DISABLED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_item_eul_storm_pull:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():IsDebuffImmune() then return end
	if not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():IsCurrentlyVerticalMotionControlled() then
		if not self:GetParent():HasModifier("modifier_slark_pounce_arc") and not self:GetParent():HasModifier("modifier_slark_pounce_custom") and not self:GetParent():HasModifier("modifier_pudge_chain_binding") then
			if self:GetAuraOwner() and not self:GetAuraOwner():IsNull() then
				local speed = self:GetAbility():GetSpecialValueFor("speed")
				local vect = (self:GetParent():GetAbsOrigin() - self:GetAuraOwner():GetAbsOrigin()):Normalized()
                local point = self:GetParent():GetAbsOrigin() - vect * (speed * FrameTime())
                point = GetGroundPosition(point, self:GetParent())
                if GridNav:CanFindPath( self:GetParent():GetAbsOrigin(), point ) then
                    self:GetParent():SetAbsOrigin(point)
                else
                    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
                end
			end
		end
	end
end

function modifier_item_eul_storm_pull:OnDestroy()
	if not IsServer() then return end
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, true)
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end
	if not self:GetParent():IsCurrentlyHorizontalMotionControlled() and not self:GetParent():IsCurrentlyVerticalMotionControlled() then
		if not self:GetParent():HasModifier("modifier_slark_pounce_arc") and not self:GetParent():HasModifier("modifier_slark_pounce_custom") and not self:GetParent():HasModifier("modifier_pudge_chain_binding") then
			FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
		end
	end
end