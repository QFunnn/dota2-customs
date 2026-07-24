--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ancient_apparition_ice_blast_custom", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_blast_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_apparition_ice_blast_custom_debuff", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_blast_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_apparition_ice_blast_custom_talent_cooldown", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_blast_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_apparition_ice_blast_channel_point", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_ice_blast_custom", LUA_MODIFIER_MOTION_NONE )

ancient_apparition_ice_blast_custom = class({})

ancient_apparition_ice_blast_custom.modifier_ancient_apparition_17_duration = 3
ancient_apparition_ice_blast_custom.modifier_ancient_apparition_17_cooldown = 12
ancient_apparition_ice_blast_custom.modifier_ancient_apparition_19 = {2,4,6}

function ancient_apparition_ice_blast_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_ancient_apparition_21") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_CHANNELLED
    end
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end

function ancient_apparition_ice_blast_custom:GetChannelTime()
    if self:GetCaster():HasModifier("modifier_ancient_apparition_21") then
        return 5
    end
	return 0
end

function ancient_apparition_ice_blast_custom:OnUpgrade()
	if not self.release_ability then
		self.release_ability = self:GetCaster():FindAbilityByName("ancient_apparition_ice_blast_release_custom")
	end
	if self.release_ability and not self.release_ability:IsTrained() then
		self.release_ability:SetLevel(1)
	end
end

function ancient_apparition_ice_blast_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_ancient_apparition_21") then
        return "apparat_21"
    end
    return "ancient_apparition_ice_blast"
end

function ancient_apparition_ice_blast_custom:AttackEffect(target)
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_wodawisp") then return end
    if self:GetCaster():HasModifier("modifier_wodarelax") then return end
    if not self:GetCaster():IsAlive() then return end
    if not target:HasModifier("modifier_ancient_apparition_ice_blast_custom_talent_cooldown") then
        target:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_ice_blast_custom_talent_cooldown", {duration = self.modifier_ancient_apparition_17_cooldown})
        target:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_ice_blast_custom_debuff",  { duration = self.modifier_ancient_apparition_17_duration * (1 - target:GetStatusResistance()), dot_damage = self:GetSpecialValueFor("dot_damage"), kill_pct = self:GetSpecialValueFor("kill_pct")})
    end
end

function ancient_apparition_ice_blast_custom:OnSpellStart()
	if not IsServer() then return end
    local point = self:GetCursorPosition()

    if self:GetCaster():HasModifier("modifier_ancient_apparition_21") then
        self.modifier_channel = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_ice_blast_channel_point", {x=point.x,y=point.y,z=point.z})
        return
    end

    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
	EmitSoundOnClient("Hero_Ancient_Apparition.IceBlast.Tracker", self:GetCaster():GetPlayerOwner())
	local velocity	= point - self:GetCaster():GetAbsOrigin()
    velocity.z = 0
    velocity = velocity:Normalized() * self:GetSpecialValueFor("speed")

	self.ice_blast_dummy = CreateModifierThinker(self:GetCaster(), self, "modifier_ancient_apparition_ice_blast_custom", {x = velocity.x, y = velocity.y}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)

	local linear_projectile = 
    {
		Ability				= self,
		vSpawnOrigin		= self:GetCaster():GetAbsOrigin(),
		fDistance			= math.huge,
		fStartRadius		= 0,
		fEndRadius			= 0,
		Source				= self:GetCaster(),
		bDrawsOnMinimap 	= true,
		bVisibleToEnemies 	= false,
		bHasFrontalCone		= false,
		bReplaceExisting	= false,
		iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_NONE,
		iUnitTargetFlags	= DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		fExpireTime 		= GameRules:GetGameTime() + 30.0,
		bDeleteOnHit		= false,
		vVelocity			= Vector(velocity.x, velocity.y, 0),
		bProvidesVision		= true,
		iVisionRadius 		= self:GetSpecialValueFor("target_sight_radius"),
		iVisionTeamNumber 	= self:GetCaster():GetTeamNumber(),
		ExtraData =
		{
			direction_x		= (point - self:GetCaster():GetAbsOrigin()).x,
			direction_y		= (point - self:GetCaster():GetAbsOrigin()).y,
			direction_z		= (point - self:GetCaster():GetAbsOrigin()).z,
			ice_blast_dummy	= self.ice_blast_dummy:entindex(),
		}
	}

	self.initial_projectile = ProjectileManager:CreateLinearProjectile(linear_projectile)
	if not self.release_ability then
		self.release_ability = self:GetCaster():FindAbilityByName("ancient_apparition_ice_blast_release_custom")
	end	
	if self.release_ability then
        self:GetCaster():SwapAbilities("ancient_apparition_ice_blast_custom", "ancient_apparition_ice_blast_release_custom", false, true)
	end
end

function ancient_apparition_ice_blast_custom:OnChannelFinish(bInterrupted)
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_ancient_apparition_21") then
        if self.modifier_channel then
            self.modifier_channel:Destroy()
            self.modifier_channel = nil
        end
    end
end

function ancient_apparition_ice_blast_custom:OnProjectileThink_ExtraData(location, data)
	if data.ice_blast_dummy then
		EntIndexToHScript(data.ice_blast_dummy):SetAbsOrigin(location)
	end
	if not self:GetCaster():IsAlive() and self.release_ability then
		self.release_ability:OnSpellStart()
	end
end

function ancient_apparition_ice_blast_custom:OnProjectileHit_ExtraData(target, location, data)
	if not target and data.ice_blast_dummy then
		local ice_blast_thinker_modifier = EntIndexToHScript(data.ice_blast_dummy):FindModifierByNameAndCaster("modifier_ancient_apparition_ice_blast_custom", self:GetCaster())
		if ice_blast_thinker_modifier then
			ice_blast_thinker_modifier:Destroy()
		end
	end
end

modifier_ancient_apparition_ice_blast_custom = class({})
function modifier_ancient_apparition_ice_blast_custom:IsPurgable()	return false end
function modifier_ancient_apparition_ice_blast_custom:OnCreated(params)
	if not IsServer() then return end
	local ice_blast_particle = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_initial.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), self:GetCaster():GetTeamNumber())
	ParticleManager:SetParticleControl(ice_blast_particle, 1, Vector(params.x, params.y, 0))
	self:AddParticle(ice_blast_particle, false, false, -1, false, false)
end
function modifier_ancient_apparition_ice_blast_custom:OnDestroy()
	if not IsServer() then return end
	self.release_ability = self:GetCaster():FindAbilityByName("ancient_apparition_ice_blast_release_custom")
	if self:GetAbility() and self:GetAbility():IsHidden() and self.release_ability then	
		self:GetCaster():SwapAbilities("ancient_apparition_ice_blast_release_custom", "ancient_apparition_ice_blast_custom", false, true)
	end
	self:GetParent():RemoveSelf()
end

modifier_ancient_apparition_ice_blast_custom_debuff = class({})
function modifier_ancient_apparition_ice_blast_custom_debuff:IsDebuff()		return true end
function modifier_ancient_apparition_ice_blast_custom_debuff:IsPurgable()	return false end
function modifier_ancient_apparition_ice_blast_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_debuff.vpcf"
end
function modifier_ancient_apparition_ice_blast_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end
function modifier_ancient_apparition_ice_blast_custom_debuff:OnCreated(params)
	if not IsServer() then return end
	self.dot_damage		= params.dot_damage
	self.kill_pct		= params.kill_pct
	if params.caster_entindex then
		self.caster = EntIndexToHScript(params.caster_entindex)
	else
		self.caster = self:GetCaster()
	end
	self.damage_table	= {
		victim 			= self:GetParent(),
		damage 			= self.dot_damage,
		damage_type		= DAMAGE_TYPE_MAGICAL,
		damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
		attacker 		= self.caster,
		ability 		= self:GetAbility()
	}
	self:StartIntervalThink(1)
end
function modifier_ancient_apparition_ice_blast_custom_debuff:OnRefresh(params)
	self:OnCreated(params)
end
function modifier_ancient_apparition_ice_blast_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Tick")
	local dmg = ApplyDamage(self.damage_table)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), self.dot_damage, nil)
end
function modifier_ancient_apparition_ice_blast_custom_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_DISABLE_HEALING,
		MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT 
	}
end

function modifier_ancient_apparition_ice_blast_custom_debuff:GetDisableHealing()
	return 1
end

function modifier_ancient_apparition_ice_blast_custom_debuff:OnTakeDamageKillCredit(keys)
	if keys.target == self:GetParent() and (self:GetParent():GetHealth() / self:GetParent():GetMaxHealth()) * 100 <= self.kill_pct and keys.damage > 0 and keys.original_damage > 0 then
		if keys.attacker == self:GetParent() and not self:GetParent():IsInvulnerable() then
			self:GetParent():Kill(self:GetAbility(), self.caster)
		else
			self:GetParent():Kill(self:GetAbility(), keys.attacker)
		end
		if not self:GetParent():IsAlive() then
			local ice_blast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_death.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
			ParticleManager:ReleaseParticleIndex(ice_blast_particle)
		end
	end
end

ancient_apparition_ice_blast_release_custom = class({})
function ancient_apparition_ice_blast_release_custom:IsStealable()	return false end
function ancient_apparition_ice_blast_release_custom:ProcsMagicStick() return false end

function ancient_apparition_ice_blast_release_custom:OnSpellStart()
	if not self.ice_blast_ability then
		self.ice_blast_ability	= self:GetCaster():FindAbilityByName("ancient_apparition_ice_blast_custom")
	end

	if self.ice_blast_ability then
		if self.ice_blast_ability.ice_blast_dummy and self.ice_blast_ability.initial_projectile then
			local vector	= self.ice_blast_ability.ice_blast_dummy:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()
			local velocity	= vector:Normalized() * math.max(vector:Length2D() / 2, 750)
			local final_radius	= math.min(self.ice_blast_ability:GetSpecialValueFor("radius_min") + ((vector:Length2D() / self.ice_blast_ability:GetSpecialValueFor("speed")) * self.ice_blast_ability:GetSpecialValueFor("radius_grow")), self.ice_blast_ability:GetSpecialValueFor("radius_max"))
			self:GetCaster():EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Cast")
			
			local ice_blast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_final.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
			ParticleManager:SetParticleControl(ice_blast_particle, 0, self:GetCaster():GetAbsOrigin())
			ParticleManager:SetParticleControl(ice_blast_particle, 1, velocity)
			ParticleManager:SetParticleControl(ice_blast_particle, 5, Vector(math.min(vector:Length2D() / velocity:Length2D(), 2), 0, 0))
			ParticleManager:ReleaseParticleIndex(ice_blast_particle)

			local marker_particle = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_marker.vpcf", PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber())
			ParticleManager:SetParticleControl(marker_particle, 0, self.ice_blast_ability.ice_blast_dummy:GetAbsOrigin())
			ParticleManager:SetParticleControl(marker_particle, 1, Vector(final_radius, 1, 1))

			AddFOWViewer(self:GetCaster():GetTeamNumber(), self.ice_blast_ability.ice_blast_dummy:GetAbsOrigin(), 650, 4, false)

			local linear_projectile = 
            {
				Ability				= self,
				vSpawnOrigin		= self:GetCaster():GetAbsOrigin(),
				fDistance			= vector:Length2D(),
				fStartRadius		= self.ice_blast_ability:GetSpecialValueFor("path_radius"),
				fEndRadius			= self.ice_blast_ability:GetSpecialValueFor("path_radius"),
				Source				= self:GetCaster(),
				bHasFrontalCone		= false,
				bReplaceExisting	= false,
				iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_NONE,
				iUnitTargetFlags	= DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
				iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				fExpireTime 		= GameRules:GetGameTime() + 10.0,
				bDeleteOnHit		= true,
				vVelocity			= velocity,
				bProvidesVision		= true,
				iVisionRadius 		= self.ice_blast_ability:GetSpecialValueFor("target_sight_radius"),
				iVisionTeamNumber 	= self:GetCaster():GetTeamNumber(),
				ExtraData			=
				{
					marker_particle	= marker_particle,
					final_radius	= final_radius
				}
			}

			self.initial_projectile = ProjectileManager:CreateLinearProjectile(linear_projectile)
			self.ice_blast_ability.ice_blast_dummy:Destroy()
			ProjectileManager:DestroyLinearProjectile(self.ice_blast_ability.initial_projectile)
			self.ice_blast_ability.ice_blast_dummy		= nil
			self.ice_blast_ability.initial_projectile	= nil
		end
        
        --self:GetCaster():SwapAbilities("ancient_apparition_ice_blast_release_custom", "ancient_apparition_ice_blast_custom", false, true)
	end
end

function ancient_apparition_ice_blast_release_custom:OnProjectileThink_ExtraData(location, data)
	if self.ice_blast_ability then
		AddFOWViewer(self:GetCaster():GetTeamNumber(), location, self.ice_blast_ability:GetSpecialValueFor("target_sight_radius"), 3, false)
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), location, nil, self.ice_blast_ability:GetSpecialValueFor("path_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
		local duration = self.ice_blast_ability:GetSpecialValueFor("frostbite_duration")
        if self:GetCaster():HasModifier("modifier_ancient_apparition_19") then
            duration = duration + self.ice_blast_ability.modifier_ancient_apparition_19[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_19")]
        end

		for _, enemy in pairs(enemies) do			
			if enemy:IsInvulnerable() then
				enemy:AddNewModifier(enemy, self.ice_blast_ability, "modifier_ancient_apparition_ice_blast_custom_debuff", 
					{
						duration		= duration * (1 - enemy:GetStatusResistance()),
						dot_damage		= self.ice_blast_ability:GetSpecialValueFor("dot_damage"),
						kill_pct		= self.ice_blast_ability:GetSpecialValueFor("kill_pct"),
						caster_entindex	= self:GetCaster():entindex()
					}
				)
			else
				enemy:AddNewModifier(self:GetCaster(), self.ice_blast_ability, "modifier_ancient_apparition_ice_blast_custom_debuff", 
					{
						duration		= duration * (1 - enemy:GetStatusResistance()),
						dot_damage		= self.ice_blast_ability:GetSpecialValueFor("dot_damage"),
						kill_pct		= self.ice_blast_ability:GetSpecialValueFor("kill_pct")
					}
				)
			end
		end
	end
end

function ancient_apparition_ice_blast_release_custom:OnProjectileHit_ExtraData(target, location, data)
	if not target and self.ice_blast_ability then
		EmitSoundOnLocationWithCaster(location, "Hero_Ancient_Apparition.IceBlast.Target", self:GetCaster())
		if data.marker_particle then
			ParticleManager:DestroyParticle(data.marker_particle, false)
			ParticleManager:ReleaseParticleIndex(data.marker_particle)
		end
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), location, nil, data.final_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
		local damageTable = 
        {
			victim 			= nil,
			damage 			= self.ice_blast_ability:GetAbilityDamage(),
			damage_type		= self.ice_blast_ability:GetAbilityDamageType(),
			damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
			attacker 		= self:GetCaster(),
			ability 		= self
		}
		
		local duration		= self.ice_blast_ability:GetSpecialValueFor("frostbite_duration")
        if self:GetCaster():HasModifier("modifier_ancient_apparition_19") then
            duration = duration + self.ice_blast_ability.modifier_ancient_apparition_19[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_19")]
        end
	
		for _, enemy in pairs(enemies) do
			if enemy:IsInvulnerable() then
				enemy:AddNewModifier(enemy, self.ice_blast_ability, "modifier_ancient_apparition_ice_blast_custom_debuff", 
					{
						duration		= duration * (1 - enemy:GetStatusResistance()),
						dot_damage		= self.ice_blast_ability:GetSpecialValueFor("dot_damage"),
						kill_pct		= self.ice_blast_ability:GetSpecialValueFor("kill_pct"),
						caster_entindex	= self:GetCaster():entindex()
					}
				)
                local ancient_apparition_cold_feet_custom = self:GetCaster():FindAbilityByName("ancient_apparition_cold_feet_custom")
                if ancient_apparition_cold_feet_custom then
                    ancient_apparition_cold_feet_custom:TargetColdFeet(enemy)
                end
			else
				enemy:AddNewModifier(self:GetCaster(), self.ice_blast_ability, "modifier_ancient_apparition_ice_blast_custom_debuff", 
					{
						duration		= duration * (1 - enemy:GetStatusResistance()),
						dot_damage		= self.ice_blast_ability:GetSpecialValueFor("dot_damage"),
						kill_pct		= self.ice_blast_ability:GetSpecialValueFor("kill_pct")
					}
				)
                local ancient_apparition_cold_feet_custom = self:GetCaster():FindAbilityByName("ancient_apparition_cold_feet_custom")
                if ancient_apparition_cold_feet_custom then
                    ancient_apparition_cold_feet_custom:TargetColdFeet(enemy)
                end
			end
		
			if not enemy:IsMagicImmune() then
				damageTable.victim = enemy
				ApplyDamage(damageTable)
			end
		end
	end
end


modifier_ancient_apparition_ice_blast_custom_talent_cooldown = class({})
function modifier_ancient_apparition_ice_blast_custom_talent_cooldown:IsHidden() return true end
function modifier_ancient_apparition_ice_blast_custom_talent_cooldown:IsPurgable() return false end
function modifier_ancient_apparition_ice_blast_custom_talent_cooldown:RemoveOnDeath() return false end


modifier_ancient_apparition_ice_blast_channel_point = class({})
function modifier_ancient_apparition_ice_blast_channel_point:IsPurgable() return false end
function modifier_ancient_apparition_ice_blast_channel_point:IsPurgeException() return false end
function modifier_ancient_apparition_ice_blast_channel_point:IsHidden() return true end
function modifier_ancient_apparition_ice_blast_channel_point:OnCreated(params)
    if not IsServer() then return end
    self.point = Vector(params.x, params.y, params.z)
    self.damage = 0
    self.radius = self:GetAbility():GetSpecialValueFor("radius_min")
    self.radius_tick = (self:GetAbility():GetSpecialValueFor("radius_max") - self:GetAbility():GetSpecialValueFor("radius_min")) / 10
    self.ice_blast_ability = self:GetAbility()
    self.marker_particle = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_marker.vpcf", PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber())
	ParticleManager:SetParticleControl(self.marker_particle, 0, self.point)
	ParticleManager:SetParticleControl(self.marker_particle, 1, Vector(self.radius, 1, 1))
    self:StartIntervalThink(0.49)
end

function modifier_ancient_apparition_ice_blast_channel_point:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_ancient_apparition_ice_blast_channel_point:GetOverrideAnimation()
    return ACT_DOTA_GENERIC_CHANNEL_1
end

function modifier_ancient_apparition_ice_blast_channel_point:OnIntervalThink()
    if not IsServer() then return end
    local mana_cost = (self:GetParent():GetMaxMana() / 100 * 10) * 1
    self:GetParent():SpendMana(mana_cost, self:GetAbility())
    local modifier_ancient_apparition_16 = self:GetCaster():FindModifierByName("modifier_ancient_apparition_16")
    if modifier_ancient_apparition_16 then
        modifier_ancient_apparition_16:ApplyShield(mana_cost)
    end
    self.damage = self.damage + (32 * 1)
    self.radius = self.radius + (self.radius_tick * 1)
    if self.marker_particle then
        ParticleManager:DestroyParticle(self.marker_particle, true)
        ParticleManager:ReleaseParticleIndex(self.marker_particle)
    end

    AddFOWViewer(self:GetCaster():GetTeamNumber(), self.point, self.radius, 1.1, false)

    self.marker_particle = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_marker.vpcf", PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber())
	ParticleManager:SetParticleControl(self.marker_particle, 0, self.point)
	ParticleManager:SetParticleControl(self.marker_particle, 1, Vector(self.radius, 1, 1))

    if self:GetParent():GetMana() <= 0 or self:GetParent():GetMana() < mana_cost then
        self:GetParent():Interrupt()
        self:GetParent():InterruptChannel()
    end
end

function modifier_ancient_apparition_ice_blast_channel_point:OnDestroy()
    if not IsServer() then return end

    local vector = self.point - self:GetCaster():GetAbsOrigin()
	local velocity	= vector:Normalized() * (500)

    self:GetCaster():EmitSound("Hero_Ancient_Apparition.IceBlastRelease.Cast")

    AddFOWViewer(self:GetCaster():GetTeamNumber(), self.point, 650, 4, false)

    local ice_blast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_ice_blast_final.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(ice_blast_particle, 0, self.point)
	ParticleManager:SetParticleControl(ice_blast_particle, 1, velocity)
	ParticleManager:SetParticleControl(ice_blast_particle, 5, Vector(FrameTime(), 0, 0))
	ParticleManager:ReleaseParticleIndex(ice_blast_particle)

    if self.marker_particle then
        ParticleManager:DestroyParticle(self.marker_particle, true)
        ParticleManager:ReleaseParticleIndex(self.marker_particle)
    end

    local location = self.point

    EmitSoundOnLocationWithCaster(location, "Hero_Ancient_Apparition.IceBlast.Target", self:GetCaster())
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), location, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
    local damageTable = 
    {
        victim 			= nil,
        damage 			= self.ice_blast_ability:GetAbilityDamage(),
        damage_type		= self.ice_blast_ability:GetAbilityDamageType(),
        damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
        attacker 		= self:GetCaster(),
        ability 		= self
    }
    
    local duration		= self.ice_blast_ability:GetSpecialValueFor("frostbite_duration")
    if self:GetCaster():HasModifier("modifier_ancient_apparition_19") then
        duration = duration + self.ice_blast_ability.modifier_ancient_apparition_19[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_19")]
    end

    for _, enemy in pairs(enemies) do
        if enemy:IsInvulnerable() then
            enemy:AddNewModifier(enemy, self.ice_blast_ability, "modifier_ancient_apparition_ice_blast_custom_debuff", 
                {
                    duration		= duration * (1 - enemy:GetStatusResistance()),
                    dot_damage		= self.ice_blast_ability:GetSpecialValueFor("dot_damage") + self.damage,
                    kill_pct		= self.ice_blast_ability:GetSpecialValueFor("kill_pct"),
                    caster_entindex	= self:GetCaster():entindex()
                }
            )
            local ancient_apparition_cold_feet_custom = self:GetCaster():FindAbilityByName("ancient_apparition_cold_feet_custom")
            if ancient_apparition_cold_feet_custom then
                ancient_apparition_cold_feet_custom:TargetColdFeet(enemy)
            end
        else
            enemy:AddNewModifier(self:GetCaster(), self.ice_blast_ability, "modifier_ancient_apparition_ice_blast_custom_debuff", 
                {
                    duration		= duration * (1 - enemy:GetStatusResistance()),
                    dot_damage		= self.ice_blast_ability:GetSpecialValueFor("dot_damage") + self.damage,
                    kill_pct		= self.ice_blast_ability:GetSpecialValueFor("kill_pct")
                }
            )
            local ancient_apparition_cold_feet_custom = self:GetCaster():FindAbilityByName("ancient_apparition_cold_feet_custom")
            if ancient_apparition_cold_feet_custom then
                ancient_apparition_cold_feet_custom:TargetColdFeet(enemy)
            end
        end
    
        if not enemy:IsMagicImmune() then
            damageTable.victim = enemy
            ApplyDamage(damageTable)
        end
    end
end