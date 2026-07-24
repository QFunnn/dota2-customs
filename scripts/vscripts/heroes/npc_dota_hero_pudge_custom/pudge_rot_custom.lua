--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pudge_rot_custom","heroes/npc_dota_hero_pudge_custom/pudge_rot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pudge_rot_custom_slow","heroes/npc_dota_hero_pudge_custom/pudge_rot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pudge_rot_custom_dummy","heroes/npc_dota_hero_pudge_custom/pudge_rot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pudge_rot_custom_cooldown","heroes/npc_dota_hero_pudge_custom/pudge_rot_custom", LUA_MODIFIER_MOTION_NONE)

pudge_rot_custom = class({})

function pudge_rot_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_pudge/pudge_rot.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_proj.vpcf", context )
end

pudge_rot_custom.modifier_pudge_1 = {-5,-10,-15}
pudge_rot_custom.modifier_pudge_2 = {50,100}
pudge_rot_custom.modifier_pudge_4 = {0.25,0.5,0.75}
pudge_rot_custom.modifier_pudge_5 = {2.5,5}
pudge_rot_custom.modifier_pudge_5_duration = 5
pudge_rot_custom.modifier_pudge_6 = {-10,-20}
pudge_rot_custom.modifier_pudge_15 = {-10,-20}
pudge_rot_custom.modifier_pudge_16 = {10,20}

function pudge_rot_custom:ResetToggleOnRespawn() return true end

function pudge_rot_custom:OnToggle()
 	if not IsServer() then return end
    if self:GetToggleState() then
    	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_pudge_rot_custom", {} )
    else
        self:GetCaster():RemoveModifierByName("modifier_pudge_rot_custom")
    end
end

modifier_pudge_rot_custom = class({})

function modifier_pudge_rot_custom:IsPurgable() return false end
function modifier_pudge_rot_custom:IsDebuff() return true end

function modifier_pudge_rot_custom:OnCreated(params)
	if not IsServer() then return end

	self.original_modifier = true
	self.damage_incrisies = false
	if params.talent ~= nil then
		self.original_modifier = false
	end
	if params.talent_incisisies ~= nil then
		self.damage_incrisies = true
	end
	self.rot_radius = self:GetAbility():GetSpecialValueFor("rot_radius")
	self.rot_tick = self:GetAbility():GetSpecialValueFor("rot_tick")

	if self:GetCaster():HasModifier("modifier_pudge_2") then
		self.rot_radius = self.rot_radius + self:GetAbility().modifier_pudge_2[self:GetCaster():GetTalentLevel("modifier_pudge_2")]
	end

	self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_rot.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.pfx, 1, Vector(self.rot_radius, 1, self.rot_radius))
    self:AddParticle(self.pfx, false, false, -1, false, false)  

	self:StartIntervalThink(0)
	if self.original_modifier then
		self:GetParent():EmitSound("Hero_Pudge.Rot")
		self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_ROT)
	end
end

function modifier_pudge_rot_custom:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetParent():IsAlive() then
		if not self.original_modifier then
			self:Destroy()
		end
		return 
	end

	self.rot_radius = self:GetAbility():GetSpecialValueFor("rot_radius")
	self.rot_tick = self:GetAbility():GetSpecialValueFor("rot_tick")
	self.rot_damage = self:GetAbility():GetSpecialValueFor("rot_damage")

	if self:GetCaster():HasModifier("modifier_pudge_4") then
		self.rot_damage = self.rot_damage + ( self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_pudge_4[self:GetCaster():GetTalentLevel("modifier_pudge_4")] )
	end

    if self:GetCaster():HasModifier("modifier_pudge_16") then
        self.rot_damage = self.rot_damage + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_pudge_16[self:GetCaster():GetTalentLevel("modifier_pudge_16")])
    end

	if self:GetCaster():HasModifier("modifier_pudge_2") then
		self.rot_radius = self.rot_radius + self:GetAbility().modifier_pudge_2[self:GetCaster():GetTalentLevel("modifier_pudge_2")]
	end

	if self.pfx then
		ParticleManager:SetParticleControl(self.pfx, 1, Vector(self.rot_radius, 1, self.rot_radius))
	end

	if self.original_modifier then
		local cur_time = GameRules:GetGameTime()
		if self:GetAbility().last_rot_time ~= nil and (cur_time - self:GetAbility().last_rot_time) < self.rot_tick then
			return
		end
		self:GetAbility().last_rot_time = cur_time
	else
		local cur_time = GameRules:GetGameTime()
		if self.last_rot_time ~= nil and (cur_time - self.last_rot_time) < self.rot_tick then
			return
		end
		self.last_rot_time = cur_time
	end
	
	local self_damage = self.rot_damage * self.rot_tick
    if self:GetParent():HasModifier("modifier_pudge_16") then
        self_damage = 0
    end

	if self_damage ~= 0 then 
		if not self:GetParent():IsMagicImmune() then 
			ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self_damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL, ability = self:GetAbility() })
		end
	end

	local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.rot_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

	for _, enemy in pairs(units) do
		if enemy ~= self:GetParent() then
			local damage = self.rot_damage
			damage = damage * self.rot_tick
			local damage_next = true

			if self.damage_incrisies then
				if enemy:HasModifier("modifier_pudge_rot_custom") then
					damage_next = false
				end
			end

			if damage_next then
				ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self:GetAbility() })
			end
		end
	end
end

function modifier_pudge_rot_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_Pudge.Rot")
	self:GetParent():StopSound("Hero_Pudge.Rot.Persona")
end

function modifier_pudge_rot_custom:IsAura()	
	return true 
end

function modifier_pudge_rot_custom:IsAuraActiveOnDeath() 
	return false 
end

function modifier_pudge_rot_custom:GetAuraRadius() 
	if self.rot_radius then 
		return self.rot_radius 
	end 
end

function modifier_pudge_rot_custom:GetAuraSearchFlags() 
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_pudge_rot_custom:GetAuraSearchTeam() 
	return DOTA_UNIT_TARGET_TEAM_BOTH 
end

function modifier_pudge_rot_custom:GetAuraSearchType() 
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC 
end

function modifier_pudge_rot_custom:GetAuraEntityReject(hTarget)
    if not IsServer() then return end

    if hTarget == self:GetCaster() or hTarget:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        return true
    end

    return false
end

function modifier_pudge_rot_custom:GetModifierAura() 
	return "modifier_pudge_rot_custom_slow" 
end

modifier_pudge_rot_custom_slow = class({})

function modifier_pudge_rot_custom_slow:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end

function modifier_pudge_rot_custom_slow:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
	self.time_rot = 0
end

function modifier_pudge_rot_custom_slow:OnIntervalThink()
	if not IsServer() then return end
    if self:GetAuraOwner() == nil or self:GetAuraOwner():IsNull() then return end
	if self:GetCaster():HasModifier("modifier_pudge_5") then
		if not self:GetParent():HasModifier("modifier_pudge_rot_custom") then
			local original_mod = self:GetAuraOwner():FindModifierByName("modifier_pudge_rot_custom")
			if original_mod then
				if original_mod:GetCaster() == self:GetAuraOwner() or self:GetAuraOwner():GetUnitName() == "npc_dota_companion" then
					self.time_rot = self.time_rot + FrameTime()
					if self.time_rot >= self:GetAbility().modifier_pudge_5_duration then
						self.time_rot = 0
						if self:GetCaster():HasModifier("modifier_pudge_rot_custom_cooldown") then return end
						self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pudge_rot_custom", {duration = self:GetAbility().modifier_pudge_5[self:GetCaster():GetTalentLevel("modifier_pudge_5")], talent = true, talent_incisisies = true})
						self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pudge_rot_custom_cooldown", {duration = self:GetAbility().modifier_pudge_5[self:GetCaster():GetTalentLevel("modifier_pudge_5")]})
					end
				end
			end
		end
	end
end

function modifier_pudge_rot_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_pudge_15") then
		bonus = self:GetAbility().modifier_pudge_15[self:GetCaster():GetTalentLevel("modifier_pudge_15")]
	end
	return self:GetAbility():GetSpecialValueFor("rot_slow") + bonus
end

function modifier_pudge_rot_custom_slow:GetModifierMagicalResistanceBonus()
	if self:GetCaster():HasModifier("modifier_pudge_1") then
		return self:GetAbility().modifier_pudge_1[self:GetCaster():GetTalentLevel("modifier_pudge_1")]
	end
	return 0
end

function modifier_pudge_rot_custom_slow:GetModifierPropertyRestorationAmplification()
	if self:GetCaster():HasModifier("modifier_pudge_6") then
		return self:GetAbility().modifier_pudge_6[self:GetCaster():GetTalentLevel("modifier_pudge_6")]
	end
	return 0
end

pudge_rot_bomb = class({})

function pudge_rot_bomb:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()

	local dummy = CreateUnitByName("npc_dota_companion", point, false, nil, nil, self:GetCaster():GetTeamNumber())
    dummy:AddNewModifier(self, nil, "modifier_pudge_rot_custom_dummy", {})

	local info = 
	{
        EffectName = "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_proj.vpcf",
        Ability = self,
        iMoveSpeed = 1200,
        Source = self:GetCaster(),
        Target = dummy,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
    }

    ProjectileManager:CreateTrackingProjectile( info )

    self:GetCaster():EmitSound("Hero_Pudge.Eject")
end

function pudge_rot_bomb:OnProjectileHit( target, vLocation )
    if not IsServer() then return end
    if target ~= nil then
    	local pudge_rot_custom = self:GetCaster():FindAbilityByName("pudge_rot_custom")
    	if pudge_rot_custom and pudge_rot_custom:GetLevel() > 0 then
    		target:AddNewModifier(self:GetCaster(), pudge_rot_custom, "modifier_pudge_rot_custom", {duration = self:GetSpecialValueFor("duration"), talent = true})
    	end
    	target:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = self:GetSpecialValueFor("duration")})
    end
    return true
end

modifier_pudge_rot_custom_dummy = class({})

function modifier_pudge_rot_custom_dummy:IsHidden() return true end
function modifier_pudge_rot_custom_dummy:IsPurgable() return false end

function modifier_pudge_rot_custom_dummy:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end

modifier_pudge_rot_custom_cooldown = class({})
function modifier_pudge_rot_custom_cooldown:IsHidden() return true end
function modifier_pudge_rot_custom_cooldown:IsPurgable() return false end
function modifier_pudge_rot_custom_cooldown:RemoveOnDeath() return false end
function modifier_pudge_rot_custom_cooldown:IsPurgeException() return false end