--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_storm_spirit_overload_custom", "abilities/storm_spirit_overload_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_storm_spirit_overload_custom_buff", "abilities/storm_spirit_overload_custom", LUA_MODIFIER_MOTION_NONE)

storm_spirit_overload_custom = class({})

function storm_spirit_overload_custom:GetIntrinsicModifierName()
	return "modifier_storm_spirit_overload_custom"
end

function storm_spirit_overload_custom:OnProjectileHit(target, vLocation)
    if not IsServer() then return end
    self:AttackEffect(self:GetCaster(), target)
end

function storm_spirit_overload_custom:OnSpellStart()
    if not IsServer() then return end
    local radius = self:GetSpecialValueFor("shard_activation_radius")
    local charges = self:GetSpecialValueFor("shard_activation_charges")
    local duration = self:GetSpecialValueFor("shard_activation_duration")
    local storm_spirit_overload_custom = self:GetCaster():FindAbilityByName("storm_spirit_overload_custom")
    local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER , false)
    if storm_spirit_overload_custom and storm_spirit_overload_custom:GetLevel() > 0 then
        for _, hero in pairs(heroes) do
            local modifier_storm_spirit_overload = hero:AddNewModifier(self:GetCaster(), storm_spirit_overload_custom, "modifier_storm_spirit_overload_custom_buff", {duration = duration})
            if modifier_storm_spirit_overload then
                modifier_storm_spirit_overload:SetStackCount(charges)
            end
        end
    end
end

function storm_spirit_overload_custom:AttackEffect(caster, target)
    if not IsServer() then return end
    local overload_aoe = self:GetSpecialValueFor("overload_aoe")
    local overload_damage = self:GetSpecialValueFor("overload_damage")
    local duration = self:GetDuration()
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, overload_aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	for _,enemy in pairs(enemies) do
        local dmg = ApplyDamage({attacker = caster, victim = enemy, damage = overload_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
        enemy:AddNewModifier(self:GetCaster(), self, "modifier_storm_spirit_overload_debuff", {duration = duration})
	end
    target:EmitSound("Hero_StormSpirit.Overload")
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_storm_spirit_overload_custom = class({})
function modifier_storm_spirit_overload_custom:IsPurgable() return false end
function modifier_storm_spirit_overload_custom:IsHidden() return true end
function modifier_storm_spirit_overload_custom:IsPurgeException() return false end

function modifier_storm_spirit_overload_custom:OnCreated()
	if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
	self:StartIntervalThink(0.15)
end

function modifier_storm_spirit_overload_custom:OnIntervalThink()
	if not IsServer() then return end
	if not self.parent:HasModifier("modifier_storm_spirit_overload_custom_buff") and self.ability:IsFullyCastable() then
		local modifier_storm_spirit_overload_custom_buff = self.parent:AddNewModifier(self.parent, self.ability, "modifier_storm_spirit_overload_custom_buff", {})
        if self:GetCaster():HasShard() then
            modifier_storm_spirit_overload_custom_buff:SetStackCount(self:GetAbility():GetSpecialValueFor("shard_activation_charges"))
        end
	end
end

modifier_storm_spirit_overload_custom_buff = class({})

function modifier_storm_spirit_overload_custom_buff:IsPurgable() return false end
function modifier_storm_spirit_overload_custom_buff:IsPurgeException() return false end

function modifier_storm_spirit_overload_custom_buff:OnCreated( kv )
	if not IsServer() then return end
	self.records = {}
    self.parent = self:GetParent()
	self.duration = 1.5
    self.ability = self:GetAbility()
	self.radius = self.ability:GetSpecialValueFor( "overload_aoe" )
	local damage = self.ability:GetSpecialValueFor( "overload_damage" )
	self.damageTable = 
	{
		attacker = self.parent,
		damage = damage,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability,
	}
	self:PlayEffects()
end

function modifier_storm_spirit_overload_custom_buff:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_stormspirit/stormspirit_overload_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false  )
end

function modifier_storm_spirit_overload_custom_buff:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_storm_spirit_overload_custom_buff:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("shard_attack_speed_bonus")
end

function modifier_storm_spirit_overload_custom_buff:AttackModifier( params )
	if not IsServer() then return end
	if params.attacker~=self.parent then return end
	if params.target:GetTeamNumber()==self.parent:GetTeamNumber() then return end
	self.records[params.record] = true
end

function modifier_storm_spirit_overload_custom_buff:OnAttackRecordDestroy( params )
	if not IsServer() then return end
	if not self.records[params.record] then return end
	self.records[params.record] = nil
end

function modifier_storm_spirit_overload_custom_buff:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end
	if not self.records[params.record] then return end

	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), params.target:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
		enemy:AddNewModifier( self.parent, self.ability, "modifier_storm_spirit_overload_debuff", { duration = self.duration } )
	end

	self:PlayEffects2( params.target )

    if self:GetCaster():HasTalent("special_bonus_unique_storm_spirit_7") then
        local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), params.target:GetOrigin(), nil, self:GetAbility():GetSpecialValueFor("overload_aoe"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
        for _,enemy in pairs(enemies) do
            if enemy ~= params.target then
                local projectile = 
                {
                    Target = enemy,
                    Source = params.target,
                    Ability = self:GetAbility(),
                    EffectName = "particles/units/heroes/hero_stormspirit/stormspirit_base_attack.vpcf",
                    iMoveSpeed = self:GetCaster():GetProjectileSpeed(),
                    vSourceLoc = params.target:GetAbsOrigin(),
                    bDrawsOnMinimap = false,
                    bDodgeable = true,
                    bIsAttack = false,
                    bVisibleToEnemies = true,
                }
                ProjectileManager:CreateTrackingProjectile(projectile)
                break
            end
        end
    end

    self:DecrementStackCount()

    if self:GetStackCount() <= 0 then
	    self.ability:UseResources(false, false, false, true)
	    self:Destroy()
    end
end

function modifier_storm_spirit_overload_custom_buff:PlayEffects2( target )
    if target:IsHero() then
	    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	    ParticleManager:ReleaseParticleIndex( effect_cast )
	    self:AddParticle( effect_cast, false, false, -1, false, false  )
    end
    self:GetCaster():EmitSound("Hero_StormSpirit.Overload")
end