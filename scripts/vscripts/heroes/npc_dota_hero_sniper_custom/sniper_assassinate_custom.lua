--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_assassinate_custom", "heroes/npc_dota_hero_sniper_custom/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_handler", "heroes/npc_dota_hero_sniper_custom/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_assassinate_custom_stack_debuff", "heroes/npc_dota_hero_sniper_custom/sniper_assassinate_custom", LUA_MODIFIER_MOTION_NONE )

sniper_assassinate_custom = class({})
sniper_assassinate_custom.thinkers = {}
sniper_assassinate_custom.modifier_sniper_13_stun = {0.5,1,1.5}
sniper_assassinate_custom.modifier_sniper_13_cast_point = {-0.5,-1,-1.5}
sniper_assassinate_custom.modifier_sniper_11_agility = {1,2}
sniper_assassinate_custom.modifier_sniper_11_attack_range = {5,10}
sniper_assassinate_custom.modifier_sniper_21_damage = {500}

function sniper_assassinate_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_crosshair.vpcf", context )
    PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_assassinate.vpcf", context )
    PrecacheResource( "particle","particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_assassinate.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_sniper.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_sniper.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_sniper.vpcf", context)
end

function sniper_assassinate_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_sniper_21") then
        return "sniper_21"
    end
    return "sniper_assassinate"
end

function sniper_assassinate_custom:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    caster:EmitSound("Ability.AssassinateLoad")
    self.target = self:GetCursorTarget()
    self.target:AddNewModifier(self:GetCaster(), self, "modifier_sniper_assassinate_custom", {duration = 5})
    return true
end

function sniper_assassinate_custom:GetIntrinsicModifierName()
    return "modifier_sniper_assassinate_custom_handler"
end

function sniper_assassinate_custom:GetCastPoint(iLevel)
    return self:GetCast()
end

function sniper_assassinate_custom:GetCast()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_sniper_13") then
        bonus = self.modifier_sniper_13_cast_point[self:GetCaster():GetTalentLevel("modifier_sniper_13")]
    end
    return self.BaseClass.GetCastPoint(self) + bonus
end

function sniper_assassinate_custom:OnAbilityPhaseInterrupted()
    self:GetCaster():RemoveGesture(ACT_DOTA_CAST_ABILITY_4)
    if not self.target then return end
    local modifier_sniper_assassinate_custom = self.target:FindModifierByName("modifier_sniper_assassinate_custom")
    self.target = nil
    if not modifier_sniper_assassinate_custom then return end
    modifier_sniper_assassinate_custom:Destroy()
end

function sniper_assassinate_custom:OnSpellStart()
    local caster = self:GetCaster()
    if not self.target then
        self.target = self:GetCursorTarget()
    end
    --caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_4)
    EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "Ability.Assassinate", caster)
    local speed = self:GetSpecialValueFor("projectile_speed")
    local distance = self:GetSpecialValueFor("distance")
    local effect_name = "particles/units/heroes/hero_sniper/sniper_assassinate.vpcf"
    if self:GetCaster():HasModifier("modifier_sniper_21") then
        effect_name = "particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_assassinate.vpcf"
    end
    local projTable = 
    {
        EffectName = effect_name,
        Ability = self,
        Source = caster,
        bDodgeable = true,
        vSpawnOrigin = caster:GetAbsOrigin(),
        iMoveSpeed = speed, 
        iVisionRadius = 100,
        iVisionTeamNumber = caster:GetTeamNumber(),
        bProvidesVision = true,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
    }
    local sound_thinker = CreateModifierThinker(caster, self, "modifier_invulnerable", {duration = distance / speed}, caster:GetAbsOrigin(), caster:GetTeamNumber(), false )
    if sound_thinker then
	    sound_thinker:EmitSound("Hero_Sniper.AssassinateProjectile")
    end
	local length = (self.target:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D()
	projTable.Target = self.target
	projTable.ExtraData =   
	{
	    thinker = sound_thinker:entindex(),
	    length = length,
	}
	table.insert(self.thinkers, sound_thinker:entindex())
    ProjectileManager:CreateTrackingProjectile(projTable)
end

function sniper_assassinate_custom:OnProjectileThink_ExtraData(location, data)
    if not IsServer() then return end
    if data.thinker and EntIndexToHScript(data.thinker) and not EntIndexToHScript(data.thinker):IsNull() then 
        EntIndexToHScript(data.thinker):SetAbsOrigin(location)
    end
end

function sniper_assassinate_custom:OnProjectileHit_ExtraData(hTarget, vLocation, data)
    if not hTarget then return end
    local caster = self:GetCaster()
    local ability = self
    local target = hTarget
    local modifier_sniper_assassinate_custom = target:FindModifierByName("modifier_sniper_assassinate_custom")
    if modifier_sniper_assassinate_custom then
        modifier_sniper_assassinate_custom:Destroy()
    end
    if data.thinker and EntIndexToHScript(data.thinker) and not EntIndexToHScript(data.thinker):IsNull() then 
        EntIndexToHScript(data.thinker):StopSound("Hero_Sniper.AssassinateProjectile")
        UTIL_Remove(EntIndexToHScript(data.thinker))
    end
    target:EmitSound("Hero_Sniper.AssassinateDamage")
    if hTarget:TriggerSpellAbsorb(self) then return end
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_sniper_21") then
        damage = damage + self.modifier_sniper_21_damage[self:GetCaster():GetTalentLevel("modifier_sniper_21")]
    end

    --if not target:HasModifier("modifier_sniper_assassinate_custom_stack_debuff") then
        target:AddNewModifier(self:GetCaster(), self, "modifier_sniper_assassinate_custom_stack_debuff", {duration = 3})
    --end

    local damageTable = {victim = target, attacker = caster, ability = self, damage = damage, damage_type = self:GetAbilityDamageType()}
    ApplyDamage(damageTable)

    local duration = FrameTime()
    if caster:HasModifier("modifier_sniper_13") then 
        duration = self.modifier_sniper_13_stun[caster:GetTalentLevel("modifier_sniper_13")]
    end
    self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)
    target:AddNewModifier(caster, self, "modifier_stunned", {duration = duration * (1 - target:GetStatusResistance())})
    local modifier_wisp_relocate_custom_cast_delay = target:FindModifierByName("modifier_wisp_relocate_custom_cast_delay")
    if modifier_wisp_relocate_custom_cast_delay then
        if not target:IsDebuffImmune() and not target:HasModifier("modifier_wisp_6") then
            modifier_wisp_relocate_custom_cast_delay:Destroy()
        end
    end
    local modifier_sniper_assassinate_custom_handler = self:GetCaster():FindModifierByName("modifier_sniper_assassinate_custom_handler")
    if not target:IsAlive() and target:IsRealHero() then
        self:EndCooldown()
        --if modifier_sniper_assassinate_custom_handler then
        --    modifier_sniper_assassinate_custom_handler:IncrementStackCount()
        --end
    end 
end

modifier_sniper_assassinate_custom = class({})
function modifier_sniper_assassinate_custom:IsHidden() return false end
function modifier_sniper_assassinate_custom:IsPurgable() return false end
function modifier_sniper_assassinate_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_sniper_assassinate_custom:OnCreated()
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.effect_cast = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_sniper/sniper_crosshair.vpcf", PATTACH_OVERHEAD_FOLLOW, self.parent, self.caster:GetTeamNumber() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, self:GetStackCount(), 0 ) )
    self:AddParticle(self.effect_cast,false, false, -1, false, false)
    self:OnIntervalThink()
    self:StartIntervalThink(0.1)
end

function modifier_sniper_assassinate_custom:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self, "modifier_truesight", {duration = 0.1 + FrameTime()})
    AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(),10,0.1,true)
end

modifier_sniper_assassinate_custom_handler = class({})
function modifier_sniper_assassinate_custom_handler:IsHidden() return not self:GetCaster():HasModifier("modifier_sniper_11") end
function modifier_sniper_assassinate_custom_handler:IsPurgable() return false end
function modifier_sniper_assassinate_custom_handler:IsPurgeException() return false end
function modifier_sniper_assassinate_custom_handler:RemoveOnDeath() return false end
function modifier_sniper_assassinate_custom_handler:GetTexture() return "sniper_11" end
function modifier_sniper_assassinate_custom_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_TOOLTIP,
    }
end

function modifier_sniper_assassinate_custom_handler:GetModifierAttackRangeBonus()
	local br = self:GetAbility():GetSpecialValueFor("bonus_range")
	local stacks = 0
	if self:GetCaster():HasModifier("modifier_sniper_3") then
		br = 0
	end
    if self:GetCaster():HasModifier("modifier_sniper_11") then
        stacks = (self:GetAbility().modifier_sniper_11_attack_range[self:GetCaster():GetTalentLevel("modifier_sniper_11")] * self:GetStackCount())
    end
    return br + stacks
end

function modifier_sniper_assassinate_custom_handler:OnTooltip()
    local stacks = 0
    if self:GetCaster():HasModifier("modifier_sniper_11") then
        stacks = (self:GetAbility().modifier_sniper_11_attack_range[self:GetCaster():GetTalentLevel("modifier_sniper_11")] * self:GetStackCount())
    end
    return stacks
end

function modifier_sniper_assassinate_custom_handler:GetModifierBonusStats_Agility()
    if self:GetCaster():HasModifier("modifier_sniper_11") then
        return self:GetAbility().modifier_sniper_11_agility[self:GetCaster():GetTalentLevel("modifier_sniper_11")] * self:GetStackCount()
    end
end

modifier_sniper_assassinate_custom_stack_debuff = class({})

function modifier_sniper_assassinate_custom_stack_debuff:IsHidden() return true end
function modifier_sniper_assassinate_custom_stack_debuff:IsPurgable() return false end
function modifier_sniper_assassinate_custom_stack_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_sniper_assassinate_custom_stack_debuff:DeclareFunctions()
    return { MODIFIER_EVENT_ON_DEATH }
end

function modifier_sniper_assassinate_custom_stack_debuff:OnDeath(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if not params.unit:IsRealHero() then return end

    local caster = self:GetCaster()
    if not caster or caster:IsNull() then return end

    local modifier = caster:FindModifierByName("modifier_sniper_assassinate_custom_handler")
    if modifier then
        modifier:IncrementStackCount()
        caster:CalculateStatBonus(true)
    end
end