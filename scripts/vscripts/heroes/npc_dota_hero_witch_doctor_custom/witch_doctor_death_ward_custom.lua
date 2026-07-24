--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_death_ward_custom", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_death_ward_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_witch_doctor_voodoo_restoration_custom", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_voodoo_restoration_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_witch_doctor_death_ward_custom_kill", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_death_ward_custom", LUA_MODIFIER_MOTION_NONE)

witch_doctor_death_ward_custom = class({})

witch_doctor_death_ward_custom.attacks_proj = {}
-- И в autowodoo
witch_doctor_death_ward_custom.modifier_witch_doctor_9_bounce = {1,2,3}
witch_doctor_death_ward_custom.modifier_witch_doctor_10_duration = {2,3,4}

witch_doctor_death_ward_custom.modifier_witch_doctor_12_cooldown = {-20,-40,-60}

function witch_doctor_death_ward_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_attack.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_skull.vpcf", context )
end

function witch_doctor_death_ward_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_witch_doctor_10") then
		return DOTA_ABILITY_BEHAVIOR_POINT
	end
	return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_CHANNELLED
end

function witch_doctor_death_ward_custom:GetChannelTime()
    if self:GetCaster():HasModifier("modifier_witch_doctor_10") then
        return 0
    end
    return self.BaseClass.GetChannelTime(self)
end

function witch_doctor_death_ward_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_witch_doctor_12") then
    	bonus = self.modifier_witch_doctor_12_cooldown[self:GetCaster():GetTalentLevel("modifier_witch_doctor_12")]
    end
    return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function witch_doctor_death_ward_custom:OnSpellStart()
	if not IsServer() then return end
	local vPosition = self:GetCursorPosition()
	self.death_ward = self:CreateWard(vPosition)
	if self:GetCaster():HasModifier("modifier_witch_doctor_10") then
		if self:GetCaster():HasModifier("modifier_witch_doctor_11") then
			self:GetCaster():SetAbsOrigin(vPosition)
            self:GetCaster():SetOverridehero(self.death_ward)
			self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_witch_doctor_death_ward_custom_switch", {duration = self.modifier_witch_doctor_10_duration[self:GetCaster():GetTalentLevel("modifier_witch_doctor_10")]})
		end
		return
	end
	self.death_ward:EmitSound("Hero_WitchDoctor.Death_WardBuild")
end

function witch_doctor_death_ward_custom:CreateWard(vPosition)

	if self:GetCaster():HasModifier("modifier_witch_doctor_10") then
		local damage = self:GetSpecialValueFor("damage")
		local death_ward = CreateUnitByName("npc_dota_witch_doctor_death_ward_custom", vPosition, true, self:GetCaster(), nil, self:GetCaster():GetTeam())
		Timers:CreateTimer(FrameTime(), function()
			ResolveNPCPositions(vPosition, 128)
		end)
		death_ward:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
		death_ward:SetOwner(self:GetCaster())
		death_ward:AddNewModifier(self:GetCaster(), self, "modifier_witch_doctor_death_ward_custom", {duration = self.modifier_witch_doctor_10_duration[self:GetCaster():GetTalentLevel("modifier_witch_doctor_10")]})
		death_ward:SetBaseDamageMax( damage )
		death_ward:SetBaseDamageMin( damage )
		return death_ward
	end

	local damage = self:GetSpecialValueFor("damage")
	local death_ward = CreateUnitByName("npc_dota_witch_doctor_death_ward_custom", vPosition, true, self:GetCaster(), nil, self:GetCaster():GetTeam())
	Timers:CreateTimer(FrameTime(), function()
		ResolveNPCPositions(vPosition, 128)
	end)
	death_ward:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
	death_ward:SetOwner(self:GetCaster())
	death_ward:AddNewModifier(self:GetCaster(), self, "modifier_witch_doctor_death_ward_custom", {duration = self:GetChannelTime()})
	death_ward:SetBaseDamageMax( damage )
	death_ward:SetBaseDamageMin( damage )
	return death_ward
end

function witch_doctor_death_ward_custom:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_4
end

function witch_doctor_death_ward_custom:OnChannelFinish()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_witch_doctor_10") then
		return
	end
	StopSoundOn("Hero_WitchDoctor.Death_WardBuild", self.death_ward)
	self.death_ward:AddNewModifier(self:GetCaster(), self, "modifier_witch_doctor_death_ward_custom_kill", {duration = 2})
end

function witch_doctor_death_ward_custom:OnProjectileHitHandle(target, vLocation, iProjectileHandle)
	if target then
		self.attacks_proj[iProjectileHandle].targets[target:entindex()] = target

		target:EmitSound("Hero_WitchDoctor.Attack")

		if self:GetCaster():HasModifier("modifier_witch_doctor_14") then
			self:GetCaster():PerformAttack(target, true, true, true, false, false, false, false)
		else
			if RollPercentage(100 - (target:GetEvasion() * 100)) or RollPercentage(50) then
				ApplyDamage({victim = target, attacker = self.death_ward, damage = self:GetSpecialValueFor("damage"), ability = self, damage_type = DAMAGE_TYPE_PURE})
			end
		end

		if self.attacks_proj[iProjectileHandle].bounce > 0 then
			self.attacks_proj[iProjectileHandle].bounce = self.attacks_proj[iProjectileHandle].bounce - 1
			local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, 650, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE, FIND_CLOSEST, false)

			for count = #units, 1, -1 do
		        if units[count] and self.attacks_proj[iProjectileHandle].targets[units[count]:entindex()] ~= nil then
		            table.remove(units, count)
		        end
		    end

			if #units > 0 then
				local projectile =
				{
					Target = units[1],
					Source = target,
					Ability = self,
					EffectName = "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_attack.vpcf",
					bDodgable = true,
					bProvidesVision = false,
					iMoveSpeed = 1000,
					iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
				}
				local proj_id = ProjectileManager:CreateTrackingProjectile(projectile)
				self.attacks_proj[proj_id] = {}
				self.attacks_proj[proj_id].targets = self.attacks_proj[iProjectileHandle].targets
				self.attacks_proj[proj_id].bounce = self.attacks_proj[iProjectileHandle].bounce 
			end
		end
	end
end

modifier_witch_doctor_death_ward_custom = class({})

function modifier_witch_doctor_death_ward_custom:IsDebuff() return false end
function modifier_witch_doctor_death_ward_custom:IsHidden() return true end
function modifier_witch_doctor_death_ward_custom:IsPurgable() return false end
function modifier_witch_doctor_death_ward_custom:IsPurgeException() return false end
function modifier_witch_doctor_death_ward_custom:IsStunDebuff() return false end

function modifier_witch_doctor_death_ward_custom:OnCreated()
	if not IsServer() then return end

	self.wardParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_witchdoctor/witchdoctor_ward_skull.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(self.wardParticle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(self.wardParticle, 2, self:GetParent():GetAbsOrigin())

	self:GetParent():SetBaseDamageMin(self:GetAbility():GetSpecialValueFor("damage"))
	self:GetParent():SetBaseDamageMax(self:GetAbility():GetSpecialValueFor("damage"))
	self:StartIntervalThink( self:GetParent():GetBaseAttackTime(false) )

	if self:GetCaster():HasModifier("modifier_witch_doctor_5") then
		local ability = self:GetCaster():FindAbilityByName("witch_doctor_voodoo_restoration_custom")
		if ability and ability:GetLevel() > 0 then
			self:GetParent():AddNewModifier(self:GetCaster(), ability, "modifier_witch_doctor_voodoo_restoration_custom", {})
		end
	end
end

function modifier_witch_doctor_death_ward_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_WitchDoctor.Death_WardBuild")
	if self:GetParent() and not self:GetParent():IsNull() then
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_witch_doctor_death_ward_custom_kill", {duration = 2})
	end
end

function modifier_witch_doctor_death_ward_custom:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():HasModifier("modifier_witch_doctor_death_ward_custom_kill") then return end
	local range = self:GetParent():Script_GetAttackRange()

	if self.attack_target ~= nil then
		if self.attack_target:IsAttackImmune() or self.attack_target:IsInvulnerable() or ((self:GetParent():GetAbsOrigin() - self.attack_target:GetAbsOrigin()):Length2D() > range) or (not self.attack_target:IsAlive()) or (not self:GetParent():CanEntityBeSeenByMyTeam(self.attack_target)) or self.attack_target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			self.attack_target = nil
		end
	end

	if self.attack_target == nil then
		local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
		local units_targets = {}

		if #units > 0 then
			for _, target_hero in pairs(units) do
				if target_hero:IsHero() then
					table.insert(units_targets, target_hero)
				end
			end

			for _, target_creep in pairs(units) do
				if not target_creep:IsHero() then
					table.insert(units_targets, target_creep)
				end
			end
		end

		if #units_targets > 0 then
			self.attack_target = units_targets[1]
		end
	end

	if self.wardParticle and self.attack_target then
		ParticleManager:SetParticleControlForward(self.wardParticle, 1, -(self:GetParent():GetAbsOrigin() - self.attack_target:GetAbsOrigin()):Normalized())
	end

	local bounce = 0

	if self:GetCaster():HasModifier("modifier_witch_doctor_9") then
		bounce = self:GetAbility().modifier_witch_doctor_9_bounce[self:GetCaster():GetTalentLevel("modifier_witch_doctor_9")]
	end

	if self.attack_target then
		local projectile =
		{
			Target = self.attack_target,
			Source = self:GetParent(),
			Ability = self:GetAbility(),
			EffectName = "particles/units/heroes/hero_witchdoctor/witchdoctor_ward_attack.vpcf",
			bDodgable = true,
			bProvidesVision = false,
			iMoveSpeed = self:GetParent():GetProjectileSpeed(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
		}

		self:GetParent():EmitSound("Hero_WitchDoctor_Ward.Attack")
		local proj_id = ProjectileManager:CreateTrackingProjectile(projectile)
		self:GetAbility().attacks_proj[proj_id] = {}
		self:GetAbility().attacks_proj[proj_id].targets = {}
		self:GetAbility().attacks_proj[proj_id].bounce = bounce 
	end
end

function modifier_witch_doctor_death_ward_custom:CheckState()
	local state = {
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_witch_doctor_death_ward_custom:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_DISABLE_TURNING
	}
end

function modifier_witch_doctor_death_ward_custom:GetModifierDisableTurning()
    return 1
end

function modifier_witch_doctor_death_ward_custom:OnOrder(params)
    if not IsServer() or params.unit ~= self:GetParent() then return end
    if params.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET then
		self.attack_target = params.target
    end
end

witch_doctor_voodoo_switchero_custom = class({})

function witch_doctor_voodoo_switchero_custom:OnSpellStart()
	if not IsServer() then return end

	local ability = self:GetCaster():FindAbilityByName("witch_doctor_death_ward_custom")

	if ability and ability:GetLevel() > 0 then
		local vPosition = self:GetCaster():GetAbsOrigin()
		ability.death_ward = self:CreateWard(vPosition)
		ability.death_ward:EmitSound("Hero_WitchDoctor.Death_WardBuild")
        self:GetCaster():SetOverridehero(ability.death_ward)
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_witch_doctor_death_ward_custom_switch", {duration = self:GetSpecialValueFor("duration")})
	end
end

function witch_doctor_voodoo_switchero_custom:CreateWard(vPosition)
	local ability = self:GetCaster():FindAbilityByName("witch_doctor_death_ward_custom")
	local damage = ability:GetSpecialValueFor("damage")
	local death_ward = CreateUnitByName("npc_dota_witch_doctor_death_ward_custom", vPosition, true, self:GetCaster(), nil, self:GetCaster():GetTeam())
	Timers:CreateTimer(FrameTime(), function()
		ResolveNPCPositions(vPosition, 128)
	end)
	death_ward:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
	death_ward:SetOwner(self:GetCaster())
	death_ward:AddNewModifier(self:GetCaster(), ability, "modifier_witch_doctor_death_ward_custom", {duration = self:GetSpecialValueFor("duration")})
	death_ward:SetBaseDamageMax( damage )
	death_ward:SetBaseDamageMin( damage )
	return death_ward
end

LinkLuaModifier("modifier_witch_doctor_death_ward_custom_switch", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_death_ward_custom", LUA_MODIFIER_MOTION_NONE)

modifier_witch_doctor_death_ward_custom_switch = class({})

function modifier_witch_doctor_death_ward_custom_switch:IsHidden() return true end
function modifier_witch_doctor_death_ward_custom_switch:IsPurgable() return false end

function modifier_witch_doctor_death_ward_custom_switch:OnCreated()
	if not IsServer() then return end
	self:GetParent():AddNoDraw()
end

function modifier_witch_doctor_death_ward_custom_switch:OnDestroy()
	if not IsServer() then return end
	self:GetCaster():SetOverridehero(self:GetCaster())
	FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
	self:GetParent():RemoveNoDraw()
end

function modifier_witch_doctor_death_ward_custom_switch:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true, [MODIFIER_STATE_UNTARGETABLE] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_UNSELECTABLE] = true, [MODIFIER_STATE_ROOTED] = true,
	}
end

modifier_witch_doctor_death_ward_custom_kill = class({})
function modifier_witch_doctor_death_ward_custom_kill:OnCreated()
	if not IsServer() then return end
	self:GetParent():AddNoDraw()
    self:GetParent():AddEffects(EF_NODRAW)
    self:GetParent():SetAbsOrigin(self:GetCaster():GetAbsOrigin() + Vector(0,0,-1000))
end
function modifier_witch_doctor_death_ward_custom_kill:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove(self:GetParent())
end
function modifier_witch_doctor_death_ward_custom_kill:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_MUTED] = true, [MODIFIER_STATE_UNTARGETABLE] = true, [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_UNSELECTABLE] = true, [MODIFIER_STATE_ROOTED] = true,
    }
end