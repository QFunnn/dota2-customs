--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_puck_dream_coil_custom", "abilities/puck_dream_coil_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_dream_coil_custom_thinker", "abilities/puck_dream_coil_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_dream_coil_custom_tether", "abilities/puck_dream_coil_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_dream_coil_custom_thinker_scepter", "abilities/puck_dream_coil_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_puck_dream_coil_custom_stun", "abilities/puck_dream_coil_custom", LUA_MODIFIER_MOTION_NONE)

puck_dream_coil_custom = class({})

function puck_dream_coil_custom:GetBreakDamage()
    local damage = self:GetSpecialValueFor("coil_break_damage")
    return damage
end 

function puck_dream_coil_custom:GetCoilDuration()
    local latch_duration = self:GetSpecialValueFor("coil_duration")
    return latch_duration
end 

function puck_dream_coil_custom:GetAOERadius()
	return self:GetSpecialValueFor("coil_radius")
end

function puck_dream_coil_custom:OnSpellStart()
    if not IsServer() then return end
    if self:GetCaster():GetName() == "npc_dota_hero_puck" then
        self:GetCaster():EmitSound("puck_puck_ability_dreamcoil_0"..RandomInt(1, 2))
    end
    local damage = self:GetSpecialValueFor("coil_initial_damage")
    local latch_duration = self:GetCoilDuration() 
    local coil_stun_duration = self:GetSpecialValueFor("coil_stun_duration")
    local coil_thinker = CreateModifierThinker(self:GetCaster(), self, "modifier_puck_dream_coil_custom_thinker", {duration = latch_duration}, self:GetCursorPosition(), self:GetCaster():GetTeamNumber(), false )
    if self:GetCaster():HasScepter() then 
        CreateModifierThinker(self:GetCaster(), self, "modifier_puck_dream_coil_custom_thinker_scepter", {duration = latch_duration + coil_stun_duration + 1}, self:GetCursorPosition(), self:GetCaster():GetTeamNumber(), false )
    end 
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCursorPosition(), nil, self:GetSpecialValueFor("coil_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _, enemy in pairs(enemies) do
	    ApplyDamage({ victim = enemy, damage = damage, damage_type = self:GetAbilityDamageType(), attacker= self:GetCaster(), ability = self })
        if not enemy:HasModifier("modifier_puck_dream_coil_custom") then
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_puck_dream_coil_custom",  {duration= latch_duration*(1 - enemy:GetStatusResistance()), coil_thinker	= coil_thinker:entindex() })
        end
    end
end

function puck_dream_coil_custom:OnProjectileHit(hTarget, vLocation)
    if not hTarget then return end
    if not IsServer() then return end
    hTarget:EmitSound("Puck.Coil_Attack_impact")
    self:GetCaster():PerformAttack(hTarget, true, true, true, false, false, false, true)
end

modifier_puck_dream_coil_custom = class({})
function modifier_puck_dream_coil_custom:IsPurgable() return false end
function modifier_puck_dream_coil_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_puck_dream_coil_custom:OnCreated(params)
    self.coil_break_radius = self:GetAbility():GetSpecialValueFor("coil_break_radius")
    self.coil_stun_duration	= self:GetAbility():GetSpecialValueFor("coil_stun_duration")
    self.coil_break_damage = self:GetAbility():GetBreakDamage() 
    if not IsServer() then return end
    self.leash = self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_puck_dream_coil_custom_tether", {duration = self:GetRemainingTime()})
    self.ability_damage_type = self:GetAbility():GetAbilityDamageType()
    self.coil_thinker = EntIndexToHScript(params.coil_thinker)
    self.coil_thinker_location = self.coil_thinker:GetAbsOrigin()
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf", PATTACH_ABSORIGIN, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 0, self.coil_thinker_location )
    ParticleManager:SetParticleControlEnt(effect_cast,1,self:GetParent(),PATTACH_POINT_FOLLOW,"attach_hitloc",self:GetParent():GetOrigin(),true)
    self:AddParticle(effect_cast,false,false,-1,false,false)
    self.bBroken = false
    self.interval = 0.05
    self:OnIntervalThink()
    self:StartIntervalThink(self.interval)
end

function modifier_puck_dream_coil_custom:OnIntervalThink()
    if not IsServer() then return end
    if self.bBroken then return end
    if (self:GetParent():GetAbsOrigin() - self.coil_thinker_location):Length2D() >= self.coil_break_radius then
        self.bBroken = true
        self:StartIntervalThink(-1)
        local stun_duration	= self.coil_stun_duration
        local break_damage	= self.coil_break_damage
        local damageTable =
        {
            victim 			= self:GetParent(),
            damage 			= break_damage,
            damage_type		= self.ability_damage_type,
            damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
            attacker 		= self:GetCaster(),
            ability 		= self:GetAbility()
        }
        ApplyDamage(damageTable)
        self:GetParent():EmitSound("Hero_Puck.Dream_Coil_Snap")
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {duration = stun_duration})
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_puck_dream_coil_custom_stun", {duration = (1 - self:GetParent():GetStatusResistance())*stun_duration})
        if self.leash and not self.leash:IsNull() then
            self.leash:Destroy()
        end
        self:Destroy()
    end
end

modifier_puck_dream_coil_custom_thinker = class({})
function modifier_puck_dream_coil_custom_thinker:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("Puck.Coil")
    self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_puck/puck_dreamcoil.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(self.pfx, false, false, -1, false, true)		
end
function modifier_puck_dream_coil_custom_thinker:OnDestroy()
    if not IsServer() then return end
    self:GetParent():StopSound("Puck.Coil")
    self:GetParent():RemoveSelf()
end

modifier_puck_dream_coil_custom_tether = class({})
function modifier_puck_dream_coil_custom_tether:IsHidden() return true end
function modifier_puck_dream_coil_custom_tether:IsPurgable() return false end
function modifier_puck_dream_coil_custom_tether:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_puck_dream_coil_custom_tether:CheckState()
    return
    {
        [MODIFIER_STATE_TETHERED] = true
    }
end

modifier_puck_dream_coil_custom_thinker_scepter = class({})
function modifier_puck_dream_coil_custom_thinker_scepter:IsHidden() return true end
function modifier_puck_dream_coil_custom_thinker_scepter:IsPurgable() return false end
function modifier_puck_dream_coil_custom_thinker_scepter:OnCreated()
    if not IsServer() then return end
    self.targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("coil_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    self.rapid_fire_interval = self:GetAbility():GetSpecialValueFor("coil_rapid_fire_rate") - FrameTime()*2
    self:StartIntervalThink(self.rapid_fire_interval)
end 

function modifier_puck_dream_coil_custom_thinker_scepter:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():IsAlive() then return end 
    for _,target in pairs(self.targets) do 
        if target and not target:IsNull() and (target:HasModifier("modifier_puck_dream_coil_custom") or target:HasModifier("modifier_puck_dream_coil_custom_stun")) and not target:IsAttackImmune() then 
            local projectile =
            {
                Target = target,
                Source = self:GetParent(),
                Ability = self:GetAbility(),
                EffectName = "particles/units/heroes/hero_puck/puck_base_attack.vpcf",
                iMoveSpeed = self:GetCaster():GetProjectileSpeed(),
                vSourceLoc = self:GetParent():GetAbsOrigin(),
                bDodgeable = true,
                bProvidesVision = false,
            }
            self:GetParent():EmitSound("Puck.Coil_Attack")
            local hProjectile = ProjectileManager:CreateTrackingProjectile( projectile )	
        end
    end 
end

modifier_puck_dream_coil_custom_stun = class({})
function modifier_puck_dream_coil_custom_stun:IsHidden() return true end
function modifier_puck_dream_coil_custom_stun:IsPurgable() return false end
function modifier_puck_dream_coil_custom_stun:IsPurgeException() return true end
function modifier_puck_dream_coil_custom_stun:IsStunDebuff() return true end