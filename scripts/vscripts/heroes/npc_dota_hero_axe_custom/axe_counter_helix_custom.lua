--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_axe_counter_helix_custom", "heroes/npc_dota_hero_axe_custom/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_cooldown", "heroes/npc_dota_hero_axe_custom/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_active", "heroes/npc_dota_hero_axe_custom/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_counter_helix_custom_stack_counter", "heroes/npc_dota_hero_axe_custom/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_berserkers_call_custom_blade_fury", "heroes/npc_dota_hero_axe_custom/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_berserkers_call_custom_blade_fury_counter", "heroes/npc_dota_hero_axe_custom/axe_counter_helix_custom", LUA_MODIFIER_MOTION_NONE )

axe_counter_helix_custom = class({})
axe_counter_helix_custom.modifier_axe_3 = {1,2,3}
axe_counter_helix_custom.modifier_axe_3_interval = 0.3
axe_counter_helix_custom.modifier_axe_3_cooldown = 18
axe_counter_helix_custom.modifier_axe_13 = {30,45,60}
axe_counter_helix_custom.modifier_axe_14 = -5
axe_counter_helix_custom.modifier_axe_14_max = 6
axe_counter_helix_custom.modifier_axe_14_duration = 5
axe_counter_helix_custom.modifier_axe_9 = -60
axe_counter_helix_custom.modifier_axe_10 = 5
axe_counter_helix_custom.modifier_axe_10_damage = {100,150}
axe_counter_helix_custom.modifier_axe_10_radius = 275
axe_counter_helix_custom.modifier_axe_10_duration = 3

function axe_counter_helix_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_counterhelix.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal_golden.vpcf", context)
end

function axe_counter_helix_custom:GetIntrinsicModifierName()
	return "modifier_axe_counter_helix_custom"
end

function axe_counter_helix_custom:GetCooldown(level)
    if self:GetCaster():HasModifier("modifier_axe_3") then
        return self.modifier_axe_3_cooldown
    end
    if self:GetCaster():HasModifier("modifier_axe_9") then
        return 0
    end
    return self.BaseClass.GetCooldown(self, level)
end

function axe_counter_helix_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_axe_3") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function axe_counter_helix_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_axe_counter_helix_custom_active", {})
end

modifier_axe_counter_helix_custom_active = class({})
function modifier_axe_counter_helix_custom_active:GetTexture() return "axe_3" end
function modifier_axe_counter_helix_custom_active:IsPurgable() return false end
function modifier_axe_counter_helix_custom_active:IsPurgeException() return false end

function modifier_axe_counter_helix_custom_active:OnCreated()
    if not IsServer() then return end
    self.modifier_axe_counter_helix_custom = self:GetParent():FindModifierByName("modifier_axe_counter_helix_custom")
    self.counter = self:GetAbility().modifier_axe_3[self:GetCaster():GetTalentLevel("modifier_axe_3")]
    self:StartIntervalThink(self:GetAbility().modifier_axe_3_interval)
    self:OnIntervalThink()
end

function modifier_axe_counter_helix_custom_active:OnIntervalThink()
    if not IsServer() then return end
    self.modifier_axe_counter_helix_custom:StartHelix()
    self.counter = self.counter - 1
    if self.counter <= 0 then
        self:Destroy()
    end
end

modifier_axe_counter_helix_custom = class({})
function modifier_axe_counter_helix_custom:IsPurgable() return false end
function modifier_axe_counter_helix_custom:IsPurgeException() return false end
function modifier_axe_counter_helix_custom:RemoveOnDeath() return false end

function modifier_axe_counter_helix_custom:OnCreated()
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.trigger_attacks = self:GetAbility():GetSpecialValueFor("trigger_attacks")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if not IsServer() then return end
    self:SetStackCount(self.trigger_attacks)
end

function modifier_axe_counter_helix_custom:OnRefresh()
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.trigger_attacks = self:GetAbility():GetSpecialValueFor("trigger_attacks")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_axe_counter_helix_custom:DeclareFunctions()
    return 
    {
         
        MODIFIER_EVENT_ON_DEATH,
    }
end

function modifier_axe_counter_helix_custom:OnDeath(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if self:GetParent():IsIllusion() then return end
    self:SetStackCount(self.trigger_attacks)
end

function modifier_axe_counter_helix_custom:OnAttackLanded(params)
    if not IsServer() then return end
    local bValidAttack = (params.target == self:GetParent() and params.attacker:GetTeamNumber() ~= self:GetParent():GetTeamNumber())
    local bValidCounterAttack = (params.attacker == self:GetParent() and self:GetParent():HasModifier("modifier_axe_7"))
    if not (bValidAttack or bValidCounterAttack) then return end
    if params.no_attack_cooldown then return end
    if self:GetCaster():HasModifier("modifier_axe_counter_helix_custom_cooldown") then return end
    if not self:GetCaster():HasModifier("modifier_axe_3") and not self:GetAbility():IsFullyCastable() then return end
    if not self:GetParent():IsAlive() then return end
    if self:GetParent():PassivesDisabled() then return end
    self:DecrementStackCount()
    if self:GetStackCount() > 0 then return end
    self:SetStackCount(self.trigger_attacks)
    self:StartHelix()
    if not self:GetCaster():HasModifier("modifier_axe_9") then
        if self:GetCaster():HasModifier("modifier_axe_3") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_axe_counter_helix_custom_cooldown", {duration = 0.3})
        else
            self:GetAbility():UseResources(false, false, false, true)
        end
    end
end

function modifier_axe_counter_helix_custom:StartHelix()
    if self:GetCaster():HasModifier("modifier_wodawisp") then return end
    if self:GetCaster():HasModifier("modifier_wodarelax") then return end
    if not self:GetCaster():IsAlive() then return end
    if self:GetCaster():HasModifier("modifier_axe_16") then return end
    self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_3)
    self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_3)
    local damage = self.damage
    if self:GetCaster():HasModifier("modifier_axe_13") then
        damage = damage + self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_axe_13[self:GetCaster():GetTalentLevel("modifier_axe_13")]
    end
    if self:GetCaster():HasModifier("modifier_axe_9") then
        damage = damage + self:GetAbility().modifier_axe_9
    end
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false)
    for _,enemy in pairs(enemies) do
        ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility()})
        if self:GetCaster():HasModifier("modifier_axe_14") then
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_axe_counter_helix_custom_stack_counter", {duration = self:GetAbility().modifier_axe_14_duration * (1-enemy:GetStatusResistance())})
        end
        if self:GetCaster():HasModifier("modifier_axe_9") then
            if enemy:GetUnitName() == "npc_woda_pig" or enemy:GetUnitName() == "npc_woda_frog" or enemy:GetUnitName() == "npc_woda_pig_pve" or enemy:GetUnitName() == "npc_woda_frog_pve" or enemy:GetUnitName() == "npc_dota_weaver_swarm" then
                if enemy:GetHealth() <= 1 then
                    enemy:Kill(self:GetAbility(), self:GetCaster())
                else
                    enemy:SetHealth(enemy:GetHealth() - 1)
                end
            end
        end
    end
    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_axe/axe_counterhelix.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( particle )
    self:GetParent():EmitSound("Hero_Axe.CounterHelix")
    if self:GetCaster():HasModifier("modifier_axe_10") then
        local modifier_axe_berserkers_call_custom_blade_fury_counter = self:GetParent():FindModifierByName("modifier_axe_berserkers_call_custom_blade_fury_counter")
        if modifier_axe_berserkers_call_custom_blade_fury_counter == nil then
            modifier_axe_berserkers_call_custom_blade_fury_counter = self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_axe_berserkers_call_custom_blade_fury_counter", {})
        end
        modifier_axe_berserkers_call_custom_blade_fury_counter:IncrementStackCount()
        if modifier_axe_berserkers_call_custom_blade_fury_counter:GetStackCount() >= self:GetAbility().modifier_axe_10 then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_axe_berserkers_call_custom_blade_fury", {duration = self:GetAbility().modifier_axe_10_duration})
            modifier_axe_berserkers_call_custom_blade_fury_counter:Destroy()
        end
    end
end

modifier_axe_counter_helix_custom_cooldown = class({})
function modifier_axe_counter_helix_custom_cooldown:IsHidden() return true end
function modifier_axe_counter_helix_custom_cooldown:IsPurgable() return false end
function modifier_axe_counter_helix_custom_cooldown:IsPurgeException() return false end
function modifier_axe_counter_helix_custom_cooldown:RemoveOnDeath() return false end

modifier_axe_counter_helix_custom_stack_counter = class({})
function modifier_axe_counter_helix_custom_stack_counter:GetTexture() return "axe_14" end
function modifier_axe_counter_helix_custom_stack_counter:OnCreated()
    if not IsServer() then return end
    if self:GetStackCount() >= self:GetAbility().modifier_axe_14_max then return end
    self:IncrementStackCount()
end
function modifier_axe_counter_helix_custom_stack_counter:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() >= self:GetAbility().modifier_axe_14_max then return end
    self:IncrementStackCount()
end
function modifier_axe_counter_helix_custom_stack_counter:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end
function modifier_axe_counter_helix_custom_stack_counter:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetStackCount() * self:GetAbility().modifier_axe_14
end

modifier_axe_berserkers_call_custom_blade_fury_counter = class({})
function modifier_axe_berserkers_call_custom_blade_fury_counter:GetTexture() return "axe_10" end
function modifier_axe_berserkers_call_custom_blade_fury_counter:IsPurgable() return false end
function modifier_axe_berserkers_call_custom_blade_fury_counter:IsPurgeException() return false end
function modifier_axe_berserkers_call_custom_blade_fury_counter:RemoveOnDeath() return false end

modifier_axe_berserkers_call_custom_blade_fury = class({})
function modifier_axe_berserkers_call_custom_blade_fury:GetTexture() return "axe_10" end
function modifier_axe_berserkers_call_custom_blade_fury:IsPurgable() return false end
function modifier_axe_berserkers_call_custom_blade_fury:IsPurgeException() return false end
function modifier_axe_berserkers_call_custom_blade_fury:OnCreated(params)
	self.tick = 0.2
	self.radius = self:GetCaster():GetAoeBonus(self:GetAbility().modifier_axe_10_radius)
	self.dps = self:GetAbility().modifier_axe_10_damage[self:GetCaster():GetTalentLevel("modifier_axe_10")] / 100 * self:GetCaster():GetAgility()
	self.max_count = params.duration / self.tick
	self.count = 0
	if not IsServer() then return end
    local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/juggernaut/jugg_ti8_sword/juggernaut_blade_fury_abyssal_golden.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 5, Vector( self.radius, 0, 0 ) )
    self:AddParticle(effect_cast, false, false, -1, false, false)
    self:GetParent():EmitSound("Hero_Juggernaut.BladeFuryStart")
    self.damageTable = 
    {
        attacker = self:GetParent(),
        damage = self.dps * self.tick,
        damage_type = DAMAGE_TYPE_PHYSICAL,
        ability = self:GetAbility(),
        damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK,
    }
    self:StartIntervalThink( self.tick )
end

function modifier_axe_berserkers_call_custom_blade_fury:OnDestroy()
    if not IsServer() then return end
	self:GetParent():StopSound("Hero_Juggernaut.BladeFuryStart")
end

function modifier_axe_berserkers_call_custom_blade_fury:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then return end
	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
        local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy )
        ParticleManager:ReleaseParticleIndex( effect_cast )
	end
	self.count = self.count+1
	if self.count>= self.max_count then
		self:Destroy()
	end
end