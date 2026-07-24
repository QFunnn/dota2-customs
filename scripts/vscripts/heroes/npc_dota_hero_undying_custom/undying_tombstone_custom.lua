--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GenerateZombieType()
	local zombie_types = {"npc_dota_unit_undying_zombie_torso", "npc_dota_unit_undying_zombie"}

	local chosen_zombie = zombie_types[RandomInt(1, #zombie_types)]    
	return chosen_zombie
end

function IsUndyingZombie(unit)
	if unit.GetClassname then
		if unit:GetClassname() == "npc_dota_unit_undying_zombie" then
			return true
		end
	end

	return false
end

function IsUndyingTombstone(unit)
	if unit.GetClassname then
		if unit:GetClassname() == "npc_dota_unit_undying_tombstone" then
			return true
		end
	end

	return false
end

LinkLuaModifier("modifier_undying_tombstone_custom", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_tombstone_custom_zombie", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_zombie_ai_no_tombstone", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tombstone_movespeed_aura", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tombstone_damage_aura", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tombstone_movespeed", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tombstone_damage", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_tombstone_custom_invul", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_tombstone_body_bonuses_damage", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)

undying_tombstone_custom = class({})

function undying_tombstone_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_tombstone.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_tombstone_ambient.vpcf", context )
    PrecacheResource( "particle", "particles/undying_debuff_tomb_mana.vpcf", context )
    PrecacheResource( "particle", "particles/items2_fx/necronomicon_archer_manaburn_explosion.vpcf", context )
end

function undying_tombstone_custom:OnAbilityPhaseStart()
    self.vTargetPosition = self:GetCursorPosition()

    if self:GetCursorTarget() == nil and Entities:FindByModelWithin(nil, "models/props_structures/radiant_statue001.vmdl", self.vTargetPosition, 800) ~= nil and GetMapName() == "overthrow" then
        return false
    end

    return true;
end

undying_tombstone_custom.modifier_undying_14 = {10,20}
undying_tombstone_custom.modifier_undying_11 = {100,150,200}
undying_tombstone_custom.modifier_undying_17_radius = 600
undying_tombstone_custom.modifier_undying_17_damage = {150,225,300}

function undying_tombstone_custom:GetCooldown(level)
    return self.BaseClass.GetCooldown( self, level )
end

function undying_tombstone_custom:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()    
	self:SpawnTombstone(point)
end

function undying_tombstone_custom:SpawnTombstone(point)
	if not IsServer() then return end
	local tombstone_health = self:GetSpecialValueFor("tombstone_health")
	local duration = self:GetSpecialValueFor("duration")
	local trees_destroy_radius = self:GetSpecialValueFor("trees_destroy_radius")

	for k, v in pairs(Entities:FindAllInSphere(self:GetCaster():GetAbsOrigin(), 99999)) do
        if v:GetName() == "npc_dota_unit_undying_tombstone" and (v:FindModifierByName("modifier_undying_tombstone_custom") and v:FindModifierByName("modifier_undying_tombstone_custom"):GetCaster() == self:GetCaster()) then
            v:ForceKill(false)
        end
    end

	EmitSoundOnLocationWithCaster(point, "Hero_Undying.Tombstone", self:GetCaster())

	local tombstone = CreateUnitByName("npc_dota_unit_tombstone"..self:GetLevel(), point, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
	tombstone:SetOwner(self:GetCaster())
	tombstone:SetBaseMaxHealth(tombstone_health)
	tombstone:SetMaxHealth(tombstone_health)
	tombstone:SetHealth(tombstone_health)   
	tombstone:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = duration})    
	tombstone:AddNewModifier(self:GetCaster(), self, "modifier_undying_tombstone_custom", {duration = duration})

	local nTombstoneFX = ParticleManager:CreateParticle( "particles/units/heroes/hero_undying/undying_tombstone.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControl( nTombstoneFX, 0, tombstone:GetAbsOrigin() )	
	ParticleManager:SetParticleControlEnt( nTombstoneFX, 1, self:GetCaster(), duration, "attach_attack1", self:GetCaster():GetOrigin(), true )
	ParticleManager:SetParticleControl( nTombstoneFX, 2, Vector( duration, duration, duration ) )
	ParticleManager:ReleaseParticleIndex( nTombstoneFX )

	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_tombstone_ambient.vpcf", PATTACH_CUSTOMORIGIN, tombstone)
    ParticleManager:SetParticleControlEnt(particle, 0, tombstone, PATTACH_POINT_FOLLOW, "attach_origin", tombstone:GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 1, tombstone, PATTACH_POINT_FOLLOW, "attach_origin", tombstone:GetAbsOrigin(), true)

	local neutral_spell_immunity = tombstone:FindAbilityByName(neutral_spell_immunity)

	if neutral_spell_immunity then
		neutral_spell_immunity:SetLevel(1)
	end

	GridNav:DestroyTreesAroundPoint(point, trees_destroy_radius, true)
end

function undying_tombstone_custom:CreateZombieDecay(point, duration, is_ultimate)
	local zombie = CreateUnitByName(GenerateZombieType(), point+RandomVector(150), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
	zombie:EmitSound("Undying_Zombie.Spawn")
    if not is_ultimate then
	    zombie:AddNewModifier(self:GetCaster(), self, "modifier_undying_tombstone_custom_invul", {})
    end
	ResolveNPCPositions(zombie:GetAbsOrigin(), zombie:GetHullRadius()) 
	local undying_tombstone_zombie_deathstrike = zombie:FindAbilityByName("undying_tombstone_zombie_deathstrike")
	if undying_tombstone_zombie_deathstrike then
		undying_tombstone_zombie_deathstrike:SetLevel(1)
	end
	local neutral_spell_immunity = zombie:FindAbilityByName("neutral_spell_immunity")
	if neutral_spell_immunity then
		neutral_spell_immunity:SetLevel(1)
	end
	zombie:AddNewModifier(self:GetCaster(), self, "modifier_zombie_ai_no_tombstone", {})
	zombie:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = duration})
end

modifier_undying_tombstone_custom = class({})

function modifier_undying_tombstone_custom:IsHidden() return true end
function modifier_undying_tombstone_custom:IsPurgable() return false end 
function modifier_undying_tombstone_custom:IsDebuff() return false end

function modifier_undying_tombstone_custom:OnCreated()
	if IsServer() then
		if not self:GetAbility() then self:Destroy() end
		local zombie_interval = self:GetAbility():GetSpecialValueFor("zombie_interval")

		self.interval = zombie_interval
		self.interval_cur = zombie_interval

		if self:GetCaster():HasModifier("modifier_undying_17") then
			self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_tombstone_damage_aura", {})
		end

		if self:GetCaster():HasModifier("modifier_undying_17") then return end
		self:OnIntervalThink()
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_undying_tombstone_custom:OnIntervalThink()
	if not IsServer() then return end

	if self:GetCaster():HasModifier("modifier_undying_17") and not self:GetParent():HasModifier("modifier_tombstone_damage_aura") then
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_tombstone_damage_aura", {})
	end

	if self:GetCaster():HasModifier("modifier_undying_17") then return end

	self.interval_cur = self.interval_cur + FrameTime()

	if self.interval_cur >= self.interval then
		self.interval_cur = 0
		local radius = self:GetAbility():GetSpecialValueFor("radius")
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)

		for _, enemy in pairs(enemies) do
			if not enemy:IsCourier() and not IsUndyingZombie(enemy) then
				local zombie = CreateUnitByName(GenerateZombieType(), enemy:GetAbsOrigin(), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
				zombie:EmitSound("Undying_Zombie.Spawn")
				FindClearSpaceForUnit(zombie, enemy:GetAbsOrigin() + RandomVector(enemy:GetHullRadius() + zombie:GetHullRadius()), true)
				ResolveNPCPositions(zombie:GetAbsOrigin(), enemy:GetHullRadius())
				zombie:SetAggroTarget(enemy)
				zombie:SetForceAttackTarget(enemy)   
				local mod = zombie:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_undying_tombstone_custom_zombie", {enemy_entindex = enemy:entindex(), tombstone = self:GetParent():entindex()})  
				zombie:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_undying_tombstone_custom_invul", {})
				local undying_tombstone_zombie_deathstrike = zombie:FindAbilityByName("undying_tombstone_zombie_deathstrike")
				if undying_tombstone_zombie_deathstrike then
					undying_tombstone_zombie_deathstrike:SetLevel(1)
				end
				local neutral_spell_immunity = zombie:FindAbilityByName("neutral_spell_immunity")
				if neutral_spell_immunity then
					neutral_spell_immunity:SetLevel(1)
				end
			end
		end
	end
end

function modifier_undying_tombstone_custom:DeclareFunctions()
	return
	 {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		 
	}
end

function modifier_undying_tombstone_custom:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_undying_tombstone_custom:CheckState()
	if self:GetCaster():HasModifier("modifier_undying_21") then
		return {[MODIFIER_STATE_INVULNERABLE] = true}
	end
	return {}
end

function modifier_undying_tombstone_custom:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_undying_tombstone_custom:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_undying_tombstone_custom:OnAttackLanded(params)  
	if not IsServer() then return end
	if params.target ~= self:GetParent() then return end

	if params.attacker:IsRealHero() or params.attacker:IsClone() or params.attacker:IsTempestDouble() then
		damage_to_tombstone = self:GetAbility():GetSpecialValueFor("attack_hero")
	else
		damage_to_tombstone = self:GetAbility():GetSpecialValueFor("attack_unit")
	end        
		
	if (self:GetParent():GetHealth() - damage_to_tombstone) <= 0 then
		self:GetParent():Kill(nil, params.attacker)
		self:Destroy()
	else
		self:GetParent():SetHealth(self:GetParent():GetHealth() - damage_to_tombstone)
	end                           
end

modifier_undying_tombstone_custom_zombie = class({})

function modifier_undying_tombstone_custom_zombie:IsPurgable()   return false end
function modifier_undying_tombstone_custom_zombie:IsHidden()   return true end

function modifier_undying_tombstone_custom_zombie:OnCreated(params)
    if not IsServer() then return end
    self.aggro_target = EntIndexToHScript(params.enemy_entindex)
    self.tombstone = EntIndexToHScript(params.tombstone)
    self:StartIntervalThink(FrameTime())
end

function modifier_undying_tombstone_custom_zombie:OnIntervalThink()
    if IsServer() then
    	if self.tombstone == nil then
    		self:GetParent():ForceKill(false)
    		return
    	end
    	if self.tombstone and not self.tombstone:IsAlive() then
    		self:GetParent():ForceKill(false)
    		return
    	end
        if not self.aggro_target:IsAlive() or self.aggro_target == nil or self.aggro_target:IsReincarnating() then
            self:GetParent():ForceKill(false)
            return
        end
        if not self:GetParent():CanEntityBeSeenByMyTeam(self.aggro_target) and self.aggro_target:IsInvisible() then
        	self:GetParent():ForceKill(false)
            return
        end
        if not self:GetParent():CanEntityBeSeenByMyTeam(self.aggro_target) then
            ExecuteOrderFromTable({
                UnitIndex   = self:GetParent():entindex(),
                OrderType   = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position    = self.aggro_target:GetAbsOrigin()
            })
        elseif self:GetParent():GetAggroTarget() ~= self.aggro_target then
            ExecuteOrderFromTable({
                UnitIndex   = self:GetParent():entindex(),
                OrderType   = DOTA_UNIT_ORDER_ATTACK_TARGET,
                TargetIndex = self.aggro_target
            })
        end
    end
end

function modifier_undying_tombstone_custom_zombie:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
	}
end

function modifier_undying_tombstone_custom_zombie:GetModifierProcAttack_BonusDamage_Physical(params)
	if self:GetCaster():HasModifier("modifier_undying_14") then
        if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then
            return
        end
	    local damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_undying_14[self:GetCaster():GetTalentLevel("modifier_undying_14")]
	    self:GetCaster():PerformAttack(params.target, true, true, true, false, false, true, true)
	    return damage
    else
        local damageTable = 
		{
			attacker = self:GetCaster(),
			ability = nil,
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
			victim = params.target,
			damage = 1,
			damage_type = DAMAGE_TYPE_PURE,
		}
        ApplyDamage(damageTable)
    end
end

function modifier_undying_tombstone_custom_zombie:GetModifierAttackRangeBonus()
	if not self:GetCaster():HasModifier("modifier_undying_11") then return end
	return self:GetAbility().modifier_undying_11[self:GetCaster():GetTalentLevel("modifier_undying_11")]
end

modifier_zombie_ai_no_tombstone = class({})

function modifier_zombie_ai_no_tombstone:IsHidden() return true end
function modifier_zombie_ai_no_tombstone:IsPurgable() return false end 
function modifier_zombie_ai_no_tombstone:IsDebuff() return false end

function modifier_zombie_ai_no_tombstone:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1)
	self:OnIntervalThink()
end

function modifier_zombie_ai_no_tombstone:OnIntervalThink()
	if not IsServer() then return end
	if self:GetParent():GetAggroTarget() == nil and self:GetParent().target == nil then
		for _, enemy in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, -1, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)) do
			ExecuteOrderFromTable({UnitIndex = self:GetParent():entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = enemy:GetOrigin()})
			self:GetParent().target = enemy
			break
		end
	end
	if self:GetParent().target and self:GetParent():GetAggroTarget() == nil then
		ExecuteOrderFromTable({UnitIndex = self:GetParent():entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = self:GetParent().target:GetOrigin()})
	end
	if self:GetParent().target and self:GetParent().target:IsNull() or not self:GetParent().target:IsAlive() then
		self:GetParent().target = nil
	end
end

function modifier_zombie_ai_no_tombstone:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
	}
end

function modifier_zombie_ai_no_tombstone:GetModifierProcAttack_BonusDamage_Physical(params)
	if self:GetCaster():HasModifier("modifier_undying_14") then
        if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then
            return
        end
	    local damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_undying_14[self:GetCaster():GetTalentLevel("modifier_undying_14")]
	    self:GetCaster():PerformAttack(params.target, true, true, true, false, false, true, true)
	    return damage
    else
        local damageTable = 
		{
			attacker = self:GetCaster(),
			ability = nil,
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
			victim = params.target,
			damage = 1,
			damage_type = DAMAGE_TYPE_PURE,
		}
        ApplyDamage(damageTable)
    end
end

modifier_tombstone_movespeed_aura = class({})

function modifier_tombstone_movespeed_aura:IsAura() return true end
function modifier_tombstone_movespeed_aura:IsAuraActiveOnDeath() return false end
function modifier_tombstone_movespeed_aura:GetAuraDuration() return 0 end

function modifier_tombstone_movespeed_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_tombstone_movespeed_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_tombstone_movespeed_aura:GetModifierAura()
    return "modifier_tombstone_movespeed"
end

modifier_tombstone_movespeed = class({})

function modifier_tombstone_movespeed:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

modifier_tombstone_damage_aura = class({})

function modifier_tombstone_damage_aura:IsAura() return true end
function modifier_tombstone_damage_aura:IsAuraActiveOnDeath() return false end
function modifier_tombstone_damage_aura:GetAuraDuration() return 0 end

function modifier_tombstone_damage_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_tombstone_damage_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_tombstone_damage_aura:GetModifierAura()
    return "modifier_tombstone_damage"
end

function modifier_tombstone_damage_aura:GetAuraRadius()
    return self:GetAbility().modifier_undying_17_radius
end

modifier_tombstone_damage = class({})

function modifier_tombstone_damage:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
	local particle = ParticleManager:CreateParticle("particles/undying_debuff_tomb_mana.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    ParticleManager:SetParticleControlEnt( particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_tombstone_damage:OnIntervalThink()
	if not IsServer() then return end
    
	local particle = ParticleManager:CreateParticle("particles/items2_fx/necronomicon_archer_manaburn_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    ParticleManager:SetParticleControlEnt( particle, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )

	local damage = self:GetCaster():GetManaRegen() / 100 * self:GetAbility().modifier_undying_17_damage[self:GetCaster():GetTalentLevel("modifier_undying_17")]
	ApplyDamage({ victim = self:GetParent(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self:GetAbility()})
end

LinkLuaModifier("modifier_undying_tombstone_body", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_tombstone_body_bonuses", "heroes/npc_dota_hero_undying_custom/undying_tombstone_custom", LUA_MODIFIER_MOTION_NONE)

undying_tombstone_body = class({})

undying_tombstone_body.zombies = {}

undying_tombstone_body.modifier_undying_14 = {11,22}
undying_tombstone_body.modifier_undying_11 = {80,160,240}

function undying_tombstone_body:GetIntrinsicModifierName()
	return "modifier_undying_tombstone_body"
end

modifier_undying_tombstone_body = class({})

function modifier_undying_tombstone_body:OnCreated()
	if not IsServer() then return end
	if self:GetParent():IsIllusion() then return end
	self.zombies = {}
	self:StartIntervalThink(0.25)
end

function modifier_undying_tombstone_body:OnIntervalThink()
	if not IsServer() then return end

	if player_system:IsLose(self:GetParent():GetPlayerOwnerID()) then
		for _, zombie in pairs(self.zombies) do
			if zombie and not zombie:IsNull() and zombie:IsAlive() then
				zombie:ForceKill(false)
			end
		end
		return
	end

	if #self.zombies < self:GetAbility():GetSpecialValueFor("max_zombie") then
		self:SpawnZombie()
	end
end

function modifier_undying_tombstone_body:SpawnZombie()
	if not IsServer() then return end

	local zombie = CreateUnitByName("npc_dota_unit_undying_zombie_tombstone_body", self:GetParent():GetAbsOrigin(), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
	table.insert(self.zombies, zombie)
	zombie:EmitSound("Undying_Zombie.Spawn")
	FindClearSpaceForUnit(zombie, self:GetParent():GetAbsOrigin() + RandomVector(self:GetParent():GetHullRadius() + zombie:GetHullRadius()), true)
	ResolveNPCPositions(zombie:GetAbsOrigin(), self:GetParent():GetHullRadius())

	if zombie.AI ~= nil then
		zombie.AI.hBucket = self:GetCaster()
	end

	local mod = zombie:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_undying_tombstone_body_bonuses", {})  

	zombie:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_undying_tombstone_custom_invul", {})

	local undying_tombstone_zombie_deathstrike = zombie:FindAbilityByName("undying_tombstone_zombie_deathstrike")
	if undying_tombstone_zombie_deathstrike then
		undying_tombstone_zombie_deathstrike:SetLevel(1)
	end

	local neutral_spell_immunity = zombie:FindAbilityByName("neutral_spell_immunity")
	if neutral_spell_immunity then
		neutral_spell_immunity:SetLevel(1)
	end
end

modifier_undying_tombstone_body_bonuses_damage = class({})
function modifier_undying_tombstone_body_bonuses_damage:IsHidden() return true end
function modifier_undying_tombstone_body_bonuses_damage:IsPurgable() return false end
function modifier_undying_tombstone_body_bonuses_damage:IsPurgeException() return false end
function modifier_undying_tombstone_body_bonuses_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    }
end
function modifier_undying_tombstone_body_bonuses_damage:GetModifierDamageOutgoing_Percentage()
    return -100 + self:GetAbility().modifier_undying_14[self:GetCaster():GetTalentLevel("modifier_undying_14")]
end

modifier_undying_tombstone_body_bonuses = class({})

function modifier_undying_tombstone_body_bonuses:IsPurgable()   return false end
function modifier_undying_tombstone_body_bonuses:IsHidden()   return true end
function modifier_undying_tombstone_body_bonuses:IsPurgable() return false end

function modifier_undying_tombstone_body_bonuses:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}
end

function modifier_undying_tombstone_body_bonuses:GetModifierProcAttack_BonusDamage_Physical(params)
	if not self:GetCaster():HasModifier("modifier_undying_14") then return end
    if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then
        return
    end
    local modifier_undying_tombstone_body_bonuses_damage = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_undying_tombstone_body_bonuses_damage", {})
    if modifier_undying_tombstone_body_bonuses_damage then
	    self:GetCaster():PerformAttack(params.target, true, true, true, false, false, false, true)
        modifier_undying_tombstone_body_bonuses_damage:Destroy()
    end
	return 0
end

function modifier_undying_tombstone_body_bonuses:GetModifierAttackRangeBonus()
	if not self:GetCaster():HasModifier("modifier_undying_11") then return end
	return self:GetAbility().modifier_undying_11[self:GetCaster():GetTalentLevel("modifier_undying_11")]
end

function modifier_undying_tombstone_body_bonuses:CheckState()
	return 
	{
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_DISARMED] = not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawisp") or self:GetCaster():HasModifier("modifier_smoke_of_deceit"),
		[MODIFIER_STATE_STUNNED] = not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawisp") or self:GetCaster():HasModifier("modifier_smoke_of_deceit"),
	}
end

function modifier_undying_tombstone_body_bonuses:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.1)
end

function modifier_undying_tombstone_body_bonuses:OnIntervalThink()
	if not IsServer() then return end

	local length = (self:GetCaster():GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()

	if length >= 750 then
		FindClearSpaceForUnit(self:GetParent(), self:GetCaster():GetAbsOrigin() + RandomVector(200), true)
	end

	if not self:GetCaster():IsAlive() or self:GetCaster():HasModifier("modifier_wodawisp") or self:GetCaster():HasModifier("modifier_smoke_of_deceit") then
		self:GetParent():AddEffects( EF_NODRAW )
	else
		self:GetParent():RemoveEffects( EF_NODRAW )
	end
end

function modifier_undying_tombstone_body_bonuses:GetModifierMoveSpeed_Absolute()
	return self:GetCaster():GetMoveSpeedModifier(self:GetCaster():GetBaseMoveSpeed(), true) + 75
end

modifier_undying_tombstone_custom_invul = class({})

function modifier_undying_tombstone_custom_invul:IsPurgable() return false end

function modifier_undying_tombstone_custom_invul:IsHidden() return true end

function modifier_undying_tombstone_custom_invul:RemoveOnDeath() return false end

function modifier_undying_tombstone_custom_invul:OnCreated()
	if not IsServer() then return end
	self:GetParent():SetBaseMaxHealth(1)
	self:GetParent():SetMaxHealth(1)
	self:GetParent():SetHealth(1)
end

function modifier_undying_tombstone_custom_invul:DeclareFunctions()
	local decFuncs = {
		 
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
	return decFuncs
end

function modifier_undying_tombstone_custom_invul:CheckState()
	return {[MODIFIER_STATE_MAGIC_IMMUNE] = true}
end

function modifier_undying_tombstone_custom_invul:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_undying_tombstone_custom_invul:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_undying_tombstone_custom_invul:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_undying_tombstone_custom_invul:OnAttackLanded(keys)
    if not IsServer() then return end
    if keys.target == self:GetParent() then
        if self:GetParent():GetHealth() - 1 <= 0 then
            self:GetParent():Kill(nil, keys.attacker)
        else
            self:GetParent():SetHealth(self:GetParent():GetHealth() - 1)
        end
    end
end