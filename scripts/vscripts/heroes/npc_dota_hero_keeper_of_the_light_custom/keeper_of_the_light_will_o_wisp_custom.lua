--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_keeper_of_the_light_will_o_wisp_custom", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_will_o_wisp_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_will_o_wisp_custom_aura", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_will_o_wisp_custom", LUA_MODIFIER_MOTION_BOTH)

keeper_of_the_light_will_o_wisp_custom = class({})
keeper_of_the_light_will_o_wisp_custom.modifier_keeper_of_the_light_12 = {1,2}
keeper_of_the_light_will_o_wisp_custom.modifier_keeper_of_the_light_13 = {1,2,3}
keeper_of_the_light_will_o_wisp_custom.modifier_keeper_of_the_light_13_cooldown = {-10,-20,-30}

function keeper_of_the_light_will_o_wisp_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_13") then
        bonus = self.modifier_keeper_of_the_light_13_cooldown[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_13")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function keeper_of_the_light_will_o_wisp_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function keeper_of_the_light_will_o_wisp_custom:OnSpellStart()
	self.caster	= self:GetCaster()
	self.position = self:GetCursorPosition()
    self.on_count = self:GetSpecialValueFor("on_count")
    self.radius = self:GetSpecialValueFor("radius")
    self.hit_count = self:GetSpecialValueFor("hit_count")
    self.wisp_damage = self:GetSpecialValueFor("wisp_damage")
    self.off_duration = self:GetSpecialValueFor("off_duration")
    self.on_duration = self:GetSpecialValueFor("on_duration")
    self.off_duration_initial = self:GetSpecialValueFor("off_duration_initial")
    self.fixed_movement_speed = self:GetSpecialValueFor("fixed_movement_speed")
    self.bounty = self:GetSpecialValueFor("bounty")
	self.duration = self.off_duration_initial + (self.on_duration * self.on_count) + (self.off_duration * (self.on_count - 1))
	if not IsServer() then return end
    local npc_dota_ignis_fatuus = CreateUnitByName("npc_dota_ignis_fatuus", self.position, true, self.caster, self.caster, self.caster:GetTeam())
    if npc_dota_ignis_fatuus then
        npc_dota_ignis_fatuus:AddNewModifier(self.caster, self, "modifier_keeper_of_the_light_will_o_wisp_custom", {duration = self.duration})
		npc_dota_ignis_fatuus:SetMaximumGoldBounty(self.bounty)
		npc_dota_ignis_fatuus:SetMinimumGoldBounty(self.bounty)
    end
end

function keeper_of_the_light_will_o_wisp_custom:AttackProjectileTarget(target, parent)
    local info = 
    {
		Target = target,
		Source = parent,
		Ability = self,	
		EffectName = "particles/units/heroes/hero_keeper_of_the_light/keeper_base_attack.vpcf",
		iMoveSpeed = self:GetCaster():GetProjectileSpeed(),
		bDodgeable = true,
	}
    parent:EmitSound("Hero_KeeperOfTheLight.Attack")
	ProjectileManager:CreateTrackingProjectile(info)
end

function keeper_of_the_light_will_o_wisp_custom:OnProjectileHit(hTarget, vLocation)
    if hTarget then
        hTarget:EmitSound("Hero_KeeperOfTheLight.ProjectileImpact")
        self:GetCaster():PerformAttack(hTarget, true, true, true, false, false, false, false)
    end
end

modifier_keeper_of_the_light_will_o_wisp_custom = class({})
function modifier_keeper_of_the_light_will_o_wisp_custom:IsPurgable() return false end
function modifier_keeper_of_the_light_will_o_wisp_custom:OnCreated()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.on_count = self:GetAbility():GetSpecialValueFor("on_count")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.hit_count = self:GetAbility():GetSpecialValueFor("hit_count")
    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_13") then
        self.hit_count = self.hit_count + self:GetAbility().modifier_keeper_of_the_light_13[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_13")]
    end
    self.wisp_damage = self:GetAbility():GetSpecialValueFor("wisp_damage")
    self.off_duration = self:GetAbility():GetSpecialValueFor("off_duration")
    self.on_duration = self:GetAbility():GetSpecialValueFor("on_duration")
    self.off_duration_initial = self:GetAbility():GetSpecialValueFor("off_duration_initial")
    self.fixed_movement_speed = self:GetAbility():GetSpecialValueFor("fixed_movement_speed")
	if not IsServer() then return end
	
    self.health_increments = self.parent:GetMaxHealth() / self.hit_count
	
    self.parent:EmitSound("Hero_KeeperOfTheLight.Wisp.Cast")
	self.parent:EmitSound("Hero_KeeperOfTheLight.Wisp.Spawn")
	self.parent:EmitSound("Hero_KeeperOfTheLight.Wisp.Aura")
	
	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_dazzling.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, 1, 1))
	ParticleManager:SetParticleControl(self.particle, 2, Vector(0, 0, 0))
	self:AddParticle(self.particle, false, false, -1, false, false)
	
	self.particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_dazzling_on.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(self.particle2, 2, Vector(0, 0, 0))
	self:AddParticle(self.particle2, false, false, -1, false, false)
	
	GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.radius, true )
	
	self.timer = 0
	self.pulses = 0
	self.is_on = false
    self.units_pulse = {}
	
	self:StartIntervalThink(FrameTime())
end

function modifier_keeper_of_the_light_will_o_wisp_custom:OnIntervalThink()
	if not IsServer() then return end
	self.timer = self.timer + FrameTime()
	if not self.is_on and (self.pulses == 0 and self.timer >= self.off_duration_initial) or (self.pulses > 0 and self.timer >= self.off_duration) then
		self.is_on 	= true
		self.pulses = self.pulses + 1
		self.parent:EmitSound("Hero_KeeperOfTheLight.Wisp.Active")
		ParticleManager:SetParticleControl(self.particle, 2, Vector(1, 0, 0))
		ParticleManager:SetParticleControl(self.particle2, 2, Vector(1, 0, 0))
		self.timer = 0	
        self.units_pulse = {}	
	elseif self.is_on then
		if self.timer >= self.on_duration then
			self.is_on = false
			ParticleManager:SetParticleControl(self.particle, 2, Vector(0, 0, 0))
			ParticleManager:SetParticleControl(self.particle2, 2, Vector(0, 0, 0))
			self.timer = 0
            self.units_pulse = {}
		else
			local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			for _, enemy in pairs(enemies) do
				if not enemy:HasModifier("modifier_keeper_of_the_light_will_o_wisp_custom_aura") and not self.units_pulse[enemy] then
                    self.units_pulse[enemy] = true
                    ApplyDamage({attacker = self:GetCaster(), victim = enemy, damage = self.wisp_damage, ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL})
					enemy:AddNewModifier(self.parent, self.ability, "modifier_keeper_of_the_light_will_o_wisp_custom_aura", {duration = self.on_duration - self.timer})
                    if self:GetCaster():HasModifier("modifier_keeper_of_the_light_12") then
                        for i=1, self:GetAbility().modifier_keeper_of_the_light_12[self:GetCaster():GetTalentLevel("modifier_keeper_of_the_light_12")] do
                            Timers:CreateTimer(i * 0.1, function()
                                self:GetAbility():AttackProjectileTarget(enemy, self:GetParent())
                            end)
                        end
                    end
				end
			end
		end
	end
end

function modifier_keeper_of_the_light_will_o_wisp_custom:OnRemoved()
	if not IsServer() then return end
	self.parent:EmitSound("Hero_KeeperOfTheLight.Wisp.Destroy")
	self.parent:StopSound("Hero_KeeperOfTheLight.Wisp.Aura")
	local enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		local hypnotize_modifier = enemy:FindModifierByNameAndCaster("modifier_keeper_of_the_light_will_o_wisp_custom_aura", self.parent)
		if hypnotize_modifier then
			hypnotize_modifier:Destroy()
		end
	end
	UTIL_Remove(self.parent)
end

function modifier_keeper_of_the_light_will_o_wisp_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_EVENT_ON_ATTACKED,
        MODIFIER_PROPERTY_HEALTHBAR_PIPS,
    }
end

function modifier_keeper_of_the_light_will_o_wisp_custom:GetModifierHealthBarPips()
    return self.hit_count
end

function modifier_keeper_of_the_light_will_o_wisp_custom:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_keeper_of_the_light_will_o_wisp_custom:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_keeper_of_the_light_will_o_wisp_custom:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_keeper_of_the_light_will_o_wisp_custom:OnAttacked(params)
    if not IsServer() then return end
    if params.target ~= self.parent then return end
	if params.attacker:IsRealHero() or params.attacker:IsClone() or params.attacker:IsTempestDouble() then
        local health = math.floor(self.parent:GetHealth() - self.health_increments)
        if health <= 0 then
            self:OnRemoved()
            self:Destroy()
        else
            self.parent:SetHealth(health)
        end
	end
end

modifier_keeper_of_the_light_will_o_wisp_custom_aura = class({})

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:IsPurgable() return false end

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:GetEffectName()
	return "particles/units/heroes/hero_keeper_of_the_light/keeper_dazzling_debuff.vpcf"
end

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:GetStatusEffectName()
	return "particles/status_fx/status_effect_keeper_dazzle.vpcf"
end

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:OnCreated()
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.fixed_movement_speed = self.ability:GetSpecialValueFor("fixed_movement_speed")
	if not IsServer() then return end
	if self:ApplyHorizontalMotionController() == false then 
		--self:Destroy()
		return
	end
    if not self:GetParent():IsDebuffImmune() then
	    self.parent:Stop()
    end
    self:StartIntervalThink(0.1)
end

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsDebuffImmune() then
        self:ApplyHorizontalMotionController()
    end
end

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:UpdateHorizontalMotion( me, dt )
	if not IsServer() then return end
	local direction = (self.caster:GetOrigin() - me:GetOrigin())
    direction.z = 0
    direction = direction:Normalized()
	me:SetOrigin(me:GetOrigin() + direction * self.fixed_movement_speed * dt )
end

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:OnDestroy()
	if not IsServer() then return end
	self.parent:RemoveHorizontalMotionController( self )
end

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:CheckState()
	return
    {
        [MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_keeper_of_the_light_will_o_wisp_custom_aura:GetOverrideAnimation()
    if self:GetParent():IsDebuffImmune() then return end
    return ACT_DOTA_DISABLED
end