--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_winter_wyvern_splinter_blast_custom_slow", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_splinter_blast_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_winter_wyvern_splinter_blast_custom_talent_debuff", "heroes/npc_dota_hero_winter_wyvern_custom/winter_wyvern_splinter_blast_custom", LUA_MODIFIER_MOTION_NONE)

winter_wyvern_splinter_blast_custom = class({})
winter_wyvern_splinter_blast_custom.modifier_winter_wyvern_16 = {100,200,300}
winter_wyvern_splinter_blast_custom.modifier_winter_wyvern_20 = {0.3,0.6,0.9}
winter_wyvern_splinter_blast_custom.modifier_winter_wyvern_18 = {-4,-6,-8}
winter_wyvern_splinter_blast_custom.modifier_winter_wyvern_18_duration = 12

function winter_wyvern_splinter_blast_custom:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end

function winter_wyvern_splinter_blast_custom:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end
end

function winter_wyvern_splinter_blast_custom:GetAOERadius()
    return self:GetSpecialValueFor("split_radius")
end

function winter_wyvern_splinter_blast_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_splinter.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast_slow.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf", context)
end

function winter_wyvern_splinter_blast_custom:OnSpellStart(new_target, new_radius) 
	if not IsServer() then return end
	local target = self:GetCursorTarget()
    if new_target then
        target = new_target
    end
    if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if target:TriggerSpellAbsorb(self) then return end
    end
	local secondary_projectile_speed = self:GetSpecialValueFor("secondary_projectile_speed")
	local split_radius = self:GetSpecialValueFor("split_radius")
    if new_radius then
        split_radius = new_radius
    end
	local slow_duration = self:GetSpecialValueFor("slow_duration")
	local slow = self:GetSpecialValueFor("bonus_movespeed")
	local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_winter_wyvern_16") then
        damage = damage + (self:GetCaster():Script_GetMagicalArmorValue(nil) * self.modifier_winter_wyvern_16[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_16")])
    end
	local speed = self:GetSpecialValueFor("projectile_speed")
    local projectile_max_time = self:GetSpecialValueFor("projectile_max_time")
	self:GetCaster():EmitSound("Hero_Winter_Wyvern.SplinterBlast.Cast")
    self:CreateTrackingProjectile(
    {
        target = target,
        caster = self:GetCaster(),
        ability = self,
        iMoveSpeed = speed,
        iSourceAttachment = self:GetCaster():ScriptLookupAttachment("attach_attack1"),
        EffectName = "particles/units/heroes/hero_winter_wyvern/wyvern_splinter.vpcf",
        secondary_projectile_speed = secondary_projectile_speed,
        split_radius = split_radius,
        slow_duration = slow_duration,
        projectile_max_time = projectile_max_time,
        slow = slow,
        damage = damage,
        splinter_proc = 0
    })	
end

function winter_wyvern_splinter_blast_custom:CreateTrackingProjectile(params)
    local target = params.target
    local caster = params.caster
    local speed = params.iMoveSpeed
    params.creation_time = GameRules:GetGameTime()
    local projectile = caster:GetAttachmentOrigin(params.iSourceAttachment)
    local particle = ParticleManager:CreateParticle(params.EffectName, PATTACH_POINT, caster)
    caster:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Projectile")
    local arctic_flight_offset = Vector(0,0,0)
    if caster:HasModifier("modifier_winter_wyvern_arctic_burn_custom") then 
        arctic_flight_offset = Vector(0,0, 150)
    end
    ParticleManager:SetParticleControl(particle, 0, caster:GetAttachmentOrigin(params.iSourceAttachment) + arctic_flight_offset)
    ParticleManager:SetParticleControlEnt(particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle, 2, Vector(speed, 0, 0))
    Timers:CreateTimer(function()
        local target_location = target:GetAbsOrigin()
        projectile = projectile + (target_location - projectile):Normalized() * speed * FrameTime()
        if (target_location - projectile):Length2D() < speed * FrameTime() then
            caster:StopSound("Hero_Winter_Wyvern.SplinterBlast.Projectile")
            ParticleManager:DestroyParticle(particle, false)
            ParticleManager:ReleaseParticleIndex(particle)
            self:OnTrackingProjectileHit(params)
            return nil
        else
            speed = speed + 25
			ParticleManager:SetParticleControl(particle, 2, Vector(speed, 0, 0))
            return 0
        end
    end)
end

function winter_wyvern_splinter_blast_custom:OnTrackingProjectileHit(params)
	local nearby_enemy_units = FindUnitsInRadius(params.caster:GetTeam(), params.target:GetAbsOrigin(), nil, params.split_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false )
	params.caster:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Target")
	for _,enemy in pairs(nearby_enemy_units) do 
		if (enemy ~= params.target or self:GetCaster():HasModifier("modifier_winter_wyvern_15")) and enemy:IsAlive() then
			local extra_data = 
            {
                damage = params.damage, 
                slow_duration = params.slow_duration, 
                slow = params.slow, 
                split_radius = params.split_radius, 
                secondary_projectile_speed = params.secondary_projectile_speed,
                splinter_proc = params.splinter_proc
			}
			local projectile =
			{
                Target = enemy,
                Source = params.target,
                Ability = params.ability,
                EffectName = "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf",
                iMoveSpeed = params.secondary_projectile_speed,
                vSourceLoc = params.target:GetAbsOrigin(),
                bDrawsOnMinimap = false,
                bDodgeable = true,
                bIsAttack = false,
                iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
                bVisibleToEnemies = true,
                bReplaceExisting = false,
                flExpireTime = GameRules:GetGameTime() + 10,
                bProvidesVision = true,
                iVisionRadius = 400,
                iVisionTeamNumber = params.caster:GetTeamNumber(),
                ExtraData = extra_data
			}
			ProjectileManager:CreateTrackingProjectile(projectile)
		end
	end
end

function winter_wyvern_splinter_blast_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
    print("www")
	if target and target:IsAlive() then 
		local caster = self:GetCaster()
		target:AddNewModifier(caster, self, "modifier_winter_wyvern_splinter_blast_custom_slow", {duration = ExtraData.slow_duration * (1 - target:GetStatusResistance()), slow = ExtraData.slow, attack_slow = ExtraData.attack_slow})
		caster:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Splinter")
		local damage_table = {}
		damage_table.attacker = caster
		damage_table.ability = self
		damage_table.damage_type = self:GetAbilityDamageType()
		damage_table.damage = ExtraData.damage
		damage_table.victim = target
		ApplyDamage(damage_table)
        if self:GetCaster():HasModifier("modifier_winter_wyvern_20") then
            target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = self.modifier_winter_wyvern_20[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_20")] * (1-target:GetStatusResistance())})
        end
        if self:GetCaster():HasModifier('modifier_winter_wyvern_18') then
            target:AddNewModifier(self:GetCaster(), self, "modifier_winter_wyvern_splinter_blast_custom_talent_debuff", {duration = self.modifier_winter_wyvern_18_duration * (1-target:GetStatusResistance())})
        end
	end
end

modifier_winter_wyvern_splinter_blast_custom_slow = class({})
function modifier_winter_wyvern_splinter_blast_custom_slow:IsDebuff() return true end

function modifier_winter_wyvern_splinter_blast_custom_slow:OnCreated(params)
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast_slow.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_winter_wyvern_splinter_blast_custom_slow:DeclareFunctions() 
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_winter_wyvern_splinter_blast_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_movespeed")
end

modifier_winter_wyvern_splinter_blast_custom_talent_debuff = class({})

function modifier_winter_wyvern_splinter_blast_custom_talent_debuff:GetTexture() return "winter_wyvern_18" end

function modifier_winter_wyvern_splinter_blast_custom_talent_debuff:OnCreated(params)
    if not IsServer() then return end
    self:IncrementStackCount()
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_winter_wyvern_splinter_blast_custom_talent_debuff:OnRefresh(params)
    if not IsServer() then return end
    self:IncrementStackCount()
    Timers:CreateTimer(self:GetDuration(), function()
        if self and not self:IsNull() then
            self:DecrementStackCount()
            if self:GetStackCount() <= 0 then
                self:Destroy()
            end
        end
    end)
end

function modifier_winter_wyvern_splinter_blast_custom_talent_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    }
end

function modifier_winter_wyvern_splinter_blast_custom_talent_debuff:GetModifierMagicalResistanceBonus()
    return self:GetStackCount() * self:GetAbility().modifier_winter_wyvern_18[self:GetCaster():GetTalentLevel("modifier_winter_wyvern_18")]
end