--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bristleback_bristleback_custom", "abilities/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_make_spray", "abilities/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bristleback_bristleback_scepter", "abilities/bristleback_bristleback_custom", LUA_MODIFIER_MOTION_NONE)

bristleback_bristleback_custom = class({})

function bristleback_bristleback_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_defense_matrix_ball_sphere_rings.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_back_dmg.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_bristleback/bristleback_back_lrg_dmg.vpcf", context )
end

function bristleback_bristleback_custom:GetIntrinsicModifierName()
  	return "modifier_bristleback_bristleback_custom"
end

function bristleback_bristleback_custom:GetCooldown(iLevel)
    if self:GetCaster():HasScepter() then
        return self:GetSpecialValueFor("activation_cooldown")
    end  
end
    
function bristleback_bristleback_custom:GetManaCost(iLevel)
    if self:GetCaster():HasScepter() then
        return self:GetSpecialValueFor("activation_manacost")
    end
end 

function bristleback_bristleback_custom:GetBehavior()
    if self:GetCaster():HasScepter() then
        return DOTA_ABILITY_BEHAVIOR_POINT
    end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function bristleback_bristleback_custom:OnSpellStart()
    if not IsServer() then return end
    if not self:GetCaster():HasScepter() then return end
    local caster = self:GetCaster()
    caster:StartGesture(ACT_DOTA_CAST_ABILITY_3)
    caster:EmitSound("Hero_Bristleback.Bristleback.Active")
    local point = self:GetCursorPosition()
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_bristleback_active_conical_quill_spray", {x = point.x, y = point.y, z = point.z})
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_bristleback_bristleback_scepter", {})
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
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_bristleback_bristleback_custom:GetModifierIncomingDamage_Percentage(keys)
	-- Break (Silver Edge / Doom / etc.) -- стандартный Dota-флаг через PassivesDisabled().
	-- Когда брейк активен, пассивка не должна снижать урон (как в ванильной Bristleback).
	if self.parent:PassivesDisabled() then return 0 end

  	local forwardVector = self.caster:GetForwardVector()
  	local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
  	local reverseEnemyVector = (self.caster:GetAbsOrigin() - keys.attacker:GetAbsOrigin()):Normalized()
  	local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))
  	local difference = math.abs(forwardAngle - reverseEnemyAngle)
  	self.side_damage_reduction = self.ability:GetSpecialValueFor("side_damage_reduction")
  	self.back_damage_reduction = self.ability:GetSpecialValueFor("back_damage_reduction")
    if (difference <= (self.back_angle / 1)) or (difference >= (360 - (self.back_angle / 1))) then
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

function modifier_bristleback_bristleback_custom:OnTakeDamage( keys )
	if keys.attacker == nil then return end
	if keys.unit ~= self.parent then return end
	-- Break отключает и автокаст Quill Spray от пороговго урона
	if self.parent:PassivesDisabled() then return end
	if not self.parent:HasAbility("bristleback_quill_spray") or not self.parent:FindAbilityByName("bristleback_quill_spray"):IsTrained() then return end
	self.quill_release_threshold  = self.ability:GetSpecialValueFor("quill_release_threshold")
	local forwardVector = self.caster:GetForwardVector()
	local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
	local reverseEnemyVector = (self.caster:GetAbsOrigin() - keys.attacker:GetAbsOrigin()):Normalized()
	local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))
	local difference = math.abs(forwardAngle - reverseEnemyAngle)
    if (difference <= (self.back_angle / 1)) or (difference >= (360 - (self.back_angle / 1))) then
        local stack = keys.damage
        while stack > 0 do 
            self:SetStackCount(self:GetStackCount() + stack)
            if self:GetStackCount() < self.quill_release_threshold then 
                stack = 0
            else 
                stack =  self:GetStackCount() - self.quill_release_threshold
                if (self:GetStackCount() / self.quill_release_threshold) > 10 then
                    stack = 0
                end
                self:SetStackCount(0)
                self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_bristleback_bristleback_make_spray", {})
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
	local quill_spray_ability = self:GetParent():FindAbilityByName("bristleback_quill_spray")
	if not quill_spray_ability then return end
	if not quill_spray_ability:IsTrained() then return end
	quill_spray_ability:OnSpellStart()
end

function modifier_bristleback_bristleback_make_spray:OnRefresh(table)
	if not IsServer() then return end
	self:IncrementStackCount()
end

function modifier_bristleback_bristleback_make_spray:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_bristleback_bristleback_cooldown") then
		self:Proc()
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_bristleback_bristleback_cooldown", {duration = 1})
		if self:GetStackCount() == 0 then 
			self:Destroy()
		end
	end
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
        self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
        self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_2)
        --self.quill_spray_ability:MakeSpray(self.parent:GetAbsOrigin(), true)
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