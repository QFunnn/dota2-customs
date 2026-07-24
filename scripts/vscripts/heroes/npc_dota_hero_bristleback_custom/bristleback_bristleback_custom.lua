--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bristleback_bristleback_custom", "heroes/npc_dota_hero_bristleback_custom/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_make_spray", "heroes/npc_dota_hero_bristleback_custom/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_custom_hp_bonus", "heroes/npc_dota_hero_bristleback_custom/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_custom_hp_bonus_count", "heroes/npc_dota_hero_bristleback_custom/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_shield_active", "heroes/npc_dota_hero_bristleback_custom/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_cooldown", "heroes/npc_dota_hero_bristleback_custom/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_scepter", "heroes/npc_dota_hero_bristleback_custom/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)

bristleback_bristleback_custom = class({})

bristleback_bristleback_custom.modifier_bristleback_5 = {3,6}
bristleback_bristleback_custom.modifier_bristleback_4 = 50
bristleback_bristleback_custom.modifier_bristleback_4_duration = {10,20}
bristleback_bristleback_custom.modifier_bristleback_7 = -70
bristleback_bristleback_custom.modifier_bristleback_10 = {350,700}

function bristleback_bristleback_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_defense_matrix_ball_sphere_rings.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_back_lrg_dmg.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_bristleback.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_bristleback.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_bristleback.vpcf", context)
end

function bristleback_bristleback_custom:GetIntrinsicModifierName()
  	return "modifier_bristleback_bristleback_custom"
end

function bristleback_bristleback_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_bristleback_21") then
        return self:GetSpecialValueFor("activation_cooldown")
    end  
end
    
function bristleback_bristleback_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_bristleback_21") then
        return self:GetSpecialValueFor("activation_manacost")
    end
end 

function bristleback_bristleback_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_bristleback_14") then
		return "bristleback_14"
	end
	if self:GetCaster():HasModifier("modifier_bristleback_7") then
		return "bristleback_7"
	end
	return "bristleback_bristleback"
end

function bristleback_bristleback_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_bristleback_7") then
		return DOTA_ABILITY_BEHAVIOR_TOGGLE
	end
    if self:GetCaster():HasModifier("modifier_bristleback_21") then
        return DOTA_ABILITY_BEHAVIOR_POINT
    end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function bristleback_bristleback_custom:OnSpellStart()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_bristleback_21") then return end
    local caster = self:GetCaster()
    caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
    caster:EmitSound("Hero_Bristleback.Bristleback.Active")
    local point = self:GetCursorPosition()
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_bristleback_active_conical_quill_spray", {x = point.x, y = point.y, z = point.z})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_bristleback_bristleback_scepter", {})
end

function bristleback_bristleback_custom:OnToggle()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_bristleback_7") then return end
	local caster = self:GetCaster()
	local toggle = self:GetToggleState()
	if toggle then
		self.modifier = caster:AddNewModifier( caster, self, "modifier_bristleback_bristleback_shield_active", {} )
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end
	self:StartCooldown(1)
end

modifier_bristleback_bristleback_shield_active = class({})
function modifier_bristleback_bristleback_shield_active:IsPurgable() return false end
function modifier_bristleback_bristleback_shield_active:IsPurgeException() return false end
function modifier_bristleback_bristleback_shield_active:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end
function modifier_bristleback_bristleback_shield_active:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility().modifier_bristleback_7
end

modifier_bristleback_bristleback_custom = class({})

function modifier_bristleback_bristleback_custom:IsPurgable() return false end
function modifier_bristleback_bristleback_custom:IsHidden() return true end


function modifier_bristleback_bristleback_custom:OnCreated()
  	self.ability = self:GetAbility()
  	self.caster = self:GetCaster()
  	self.parent = self:GetParent()
  	self.front_damage_reduction = 0
  	self.side_angle = self.ability:GetSpecialValueFor("side_angle")
  	self.back_angle = self.ability:GetSpecialValueFor("back_angle")
end

function modifier_bristleback_bristleback_custom:OnRefresh()
  	self:OnCreated()
end

function modifier_bristleback_bristleback_custom:DeclareFunctions()
    return 
	{
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_bristleback_bristleback_custom:GetModifierIncomingDamage_Percentage(keys)
  	if self.parent:PassivesDisabled() or bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION or bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return 0 end
  	local forwardVector = self.caster:GetForwardVector()
  	local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
  	local reverseEnemyVector = (self.caster:GetAbsOrigin() - keys.attacker:GetAbsOrigin()):Normalized()
  	local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))
  	local difference = math.abs(forwardAngle - reverseEnemyAngle)
  	self.side_damage_reduction = self.ability:GetSpecialValueFor("side_damage_reduction")
  	self.back_damage_reduction = self.ability:GetSpecialValueFor("back_damage_reduction")
	if self:GetCaster():HasModifier("modifier_bristleback_5") then
		self.back_damage_reduction = self.back_damage_reduction + self:GetAbility().modifier_bristleback_5[self:GetCaster():GetTalentLevel("modifier_bristleback_5")]
		self.side_damage_reduction = self.side_damage_reduction + self:GetAbility().modifier_bristleback_5[self:GetCaster():GetTalentLevel("modifier_bristleback_5")]
	end
	if self:GetCaster():HasModifier("modifier_bristleback_14") then
		local vector = self:GetCaster():GetOrigin()-self:GetParent():GetOrigin()
		local center_angle = VectorToAngles( vector ).y
		local facing_angle = VectorToAngles( self:GetParent():GetForwardVector() ).y
		if (difference >= 149) and (difference <= 260) or self:GetParent():HasModifier("modifier_bristleback_bristleback_shield_active") then
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
			ParticleManager:SetParticleControl(particle, 1, self.parent:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)
			local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_back_lrg_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
			ParticleManager:SetParticleControlEnt(particle2, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle2)
			self.parent:EmitSound("Hero_Bristleback.Bristleback")
            print("front")
			return self.back_damage_reduction * (-1)
		elseif (difference <= (self.side_angle)) or (difference >= (360 - (self.side_angle))) then 
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
			ParticleManager:SetParticleControl(particle, 1, self.parent:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)
			return self.side_damage_reduction * (-1)
		end
	else
		if (difference <= (self.back_angle / 1)) or (difference >= (360 - (self.back_angle / 1))) or self:GetParent():HasModifier("modifier_bristleback_bristleback_shield_active") then
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
			ParticleManager:SetParticleControl(particle, 1, self.parent:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)
			local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_back_lrg_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
			ParticleManager:SetParticleControlEnt(particle2, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle2)
			self.parent:EmitSound("Hero_Bristleback.Bristleback")
			return self.back_damage_reduction * (-1)
		elseif (difference <= (self.side_angle)) or (difference >= (360 - (self.side_angle))) then 
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
			ParticleManager:SetParticleControl(particle, 1, self.parent:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(particle, 1, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(particle)
			return self.side_damage_reduction * (-1)
		end
	end
end

function modifier_bristleback_bristleback_custom:OnTakeDamage( keys )
	if keys.attacker == nil then return end
	if keys.unit ~= self.parent then return end
	if self.parent:PassivesDisabled() or bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION or bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end
    local bristleback_quill_spray_custom = self.parent:FindAbilityByName("bristleback_quill_spray_custom")
    if self:GetCaster():HasModifier("modifier_bristleback_10") then
        bristleback_quill_spray_custom = self.parent:FindAbilityByName("bristleback_viscous_nasal_goo_custom")
    end
    if not bristleback_quill_spray_custom then return end
    if not bristleback_quill_spray_custom:IsTrained() then return end
	self.quill_release_threshold  = self.ability:GetSpecialValueFor("quill_release_threshold")
	local forwardVector = self.caster:GetForwardVector()
	local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
	local reverseEnemyVector = (self.caster:GetAbsOrigin() - keys.attacker:GetAbsOrigin()):Normalized()
	local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))
	local difference = math.abs(forwardAngle - reverseEnemyAngle)
    local modifier_bristleback_warpath_custom = self:GetParent():FindModifierByName("modifier_bristleback_warpath_custom")
	if self:GetCaster():HasModifier("modifier_bristleback_14") then
		local vector = self:GetCaster():GetOrigin()-self:GetParent():GetOrigin()
		local center_angle = VectorToAngles( vector ).y
		local facing_angle = VectorToAngles( self:GetParent():GetForwardVector() ).y
		if (difference >= 149) and (difference <= 260) or self:GetParent():HasModifier("modifier_bristleback_bristleback_shield_active") then
			local stack = keys.damage
			while stack > 0 do 
				self:SetStackCount(self:GetStackCount() + stack)
				if self:GetStackCount() < self.quill_release_threshold then 
					stack = 0
				else 
					stack =  self:GetStackCount() - self.quill_release_threshold
					self:SetStackCount(0)
                     print("2")
					self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bristleback_bristleback_make_spray", {})
                    if modifier_bristleback_warpath_custom then 
                        modifier_bristleback_warpath_custom:IncStacks()
                    end
					if self:GetCaster():HasModifier("modifier_bristleback_4") then
						self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_bristleback_bristleback_custom_hp_bonus", {duration = self:GetAbility().modifier_bristleback_4_duration[self:GetCaster():GetTalentLevel("modifier_bristleback_4")]})
						self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_bristleback_bristleback_custom_hp_bonus_count", {duration = self:GetAbility().modifier_bristleback_4_duration[self:GetCaster():GetTalentLevel("modifier_bristleback_4")]})
					end
				end
			end
		end
	else
        print("1")
		if (difference <= (self.back_angle / 1)) or (difference >= (360 - (self.back_angle / 1))) or self:GetParent():HasModifier("modifier_bristleback_bristleback_shield_active") then
			local stack = keys.damage
            print("2")
			while stack > 0 do 
				self:SetStackCount(self:GetStackCount() + stack)
				if self:GetStackCount() < self.quill_release_threshold then
                    print("3")
					stack = 0
				else 
                    print("4")
					stack =  self:GetStackCount() - self.quill_release_threshold
					self:SetStackCount(0)
					self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bristleback_bristleback_make_spray", {})
                    if modifier_bristleback_warpath_custom then 
                        modifier_bristleback_warpath_custom:IncStacks()
                    end
					if self:GetCaster():HasModifier("modifier_bristleback_4") then
						self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_bristleback_bristleback_custom_hp_bonus", {duration = self:GetAbility().modifier_bristleback_4_duration[self:GetCaster():GetTalentLevel("modifier_bristleback_4")]})
						self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_bristleback_bristleback_custom_hp_bonus_count", {duration = self:GetAbility().modifier_bristleback_4_duration[self:GetCaster():GetTalentLevel("modifier_bristleback_4")]})
					end
				end
			end
		end
	end
end

modifier_bristleback_bristleback_make_spray = class({})
function modifier_bristleback_bristleback_make_spray:IsHidden() return true end
function modifier_bristleback_bristleback_make_spray:IsPurgable() return false end
function modifier_bristleback_bristleback_make_spray:OnCreated(table)
	if not IsServer() then return end
	self:SetStackCount(1)
	self:Proc()
	self:StartIntervalThink(0.1)
end

function modifier_bristleback_bristleback_make_spray:Proc()
	if not IsServer() then return end
	if self:GetStackCount() == 0 then return end
	self:DecrementStackCount()
	if self:GetCaster():HasModifier("modifier_bristleback_10") then
		local bristleback_viscous_nasal_goo_custom = self:GetCaster():FindAbilityByName("bristleback_viscous_nasal_goo_custom")
		if bristleback_viscous_nasal_goo_custom and bristleback_viscous_nasal_goo_custom:GetLevel() > 0 then
			if self:GetCaster():HasModifier("modifier_bristleback_10") then
				local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetAbility().modifier_bristleback_10[self:GetCaster():GetTalentLevel("modifier_bristleback_10")], DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
				for _, enemy in pairs(enemies) do
					bristleback_viscous_nasal_goo_custom:TalentRadius(enemy)
				end
			end
		end
		return
	end
    if self:GetCaster():HasModifier("modifier_bristleback_8") then return end
	local quill_spray_ability = self:GetParent():FindAbilityByName("bristleback_quill_spray_custom")
	if not quill_spray_ability then return end
	if not quill_spray_ability:IsTrained() then return end
    if self:GetParent():IsRealHero() then
	    quill_spray_ability:MakeSpray(self:GetParent():GetAbsOrigin())
    end
end

function modifier_bristleback_bristleback_make_spray:OnRefresh(table)
	if not IsServer() then return end
	self:IncrementStackCount()
end

function modifier_bristleback_bristleback_make_spray:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_bristleback_bristleback_cooldown") then
		self:Proc()
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_bristleback_bristleback_cooldown", {duration = 0.5})
		if self:GetStackCount() == 0 then 
			self:Destroy()
		end
	end
end

modifier_bristleback_bristleback_custom_hp_bonus = class({})
function modifier_bristleback_bristleback_custom_hp_bonus:IsPurgable() return false end
function modifier_bristleback_bristleback_custom_hp_bonus:IsPurgeException() return false end
function modifier_bristleback_bristleback_custom_hp_bonus:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_bristleback_bristleback_custom_hp_bonus:IsHidden() return true end
function modifier_bristleback_bristleback_custom_hp_bonus:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
end
function modifier_bristleback_bristleback_custom_hp_bonus:GetModifierHealthBonus()
	return self:GetAbility().modifier_bristleback_4
end
function modifier_bristleback_bristleback_custom_hp_bonus:OnCreated()
	if not IsServer() then return end
	self:GetParent():CalculateStatBonus(true)
end

modifier_bristleback_bristleback_custom_hp_bonus_count = class({})
function modifier_bristleback_bristleback_custom_hp_bonus_count:IsPurgable() return false end
function modifier_bristleback_bristleback_custom_hp_bonus_count:IsPurgeException() return false end
function modifier_bristleback_bristleback_custom_hp_bonus_count:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end
function modifier_bristleback_bristleback_custom_hp_bonus_count:OnIntervalThink()
	if not IsServer() then return end
	local modifier_bristleback_bristleback_custom_hp_bonus = self:GetParent():FindAllModifiersByName("modifier_bristleback_bristleback_custom_hp_bonus")
	self:SetStackCount(#modifier_bristleback_bristleback_custom_hp_bonus)
end



modifier_bristleback_bristleback_cooldown = class({})
function modifier_bristleback_bristleback_cooldown:IsHidden() return true end
function modifier_bristleback_bristleback_cooldown:IsPurgable() return false end
function modifier_bristleback_bristleback_cooldown:IsPurgeException() return false end
function modifier_bristleback_bristleback_cooldown:RemoveOnDeath() return false end

modifier_bristleback_bristleback_scepter = class({})

function modifier_bristleback_bristleback_scepter:IsHidden() return true end
function modifier_bristleback_bristleback_scepter:IsPurgable() return false end
function modifier_bristleback_bristleback_scepter:OnCreated()
    if not IsServer() then return end 
    self.parent = self:GetParent()
    self.count = 0
    self.max = self:GetAbility():GetSpecialValueFor("activation_num_quill_sprays")
    self.interval = self:GetAbility():GetSpecialValueFor("activation_spray_interval")
    self.quill_spray_ability = self.parent:FindAbilityByName("bristleback_quill_spray_custom")
    self.ulti_mod = self.parent:FindModifierByName("modifier_bristleback_warpath_custom")
    self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("activation_delay"))
end 

function modifier_bristleback_bristleback_scepter:OnIntervalThink()
    if not IsServer() then return end 
    if self.quill_spray_ability and self.quill_spray_ability:IsTrained() then 
        if self.parent:IsRealHero() then
            self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
            self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_2)
            self.quill_spray_ability:MakeSpray(self.parent:GetAbsOrigin(), true)
            if self.ulti_mod then 
                self.ulti_mod:IncStacks()
            end
        end
    end
    self.count = self.count + 1
    if self.count >= self.max then 
        self:Destroy()
    end 
    self:StartIntervalThink(self.interval)
end 

function modifier_bristleback_bristleback_scepter:OnDestroy()
    if not IsServer() then return end 
    self.parent:RemoveModifierByName("modifier_bristleback_active_conical_quill_spray")
end 