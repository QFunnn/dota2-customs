--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_bounty_hunter_jinada_custom_passive", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_jinada_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_jinada_custom_crit", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_jinada_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bounty_hunter_shuriken_toss_custom_gold", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_jinada_custom", LUA_MODIFIER_MOTION_NONE )

bounty_hunter_jinada_custom = class({})

function bounty_hunter_jinada_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinda_slow.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinada.vpcf', context )
    PrecacheResource( "particle", 'particles/items2_fx/medallion_of_courage.vpcf', context )
    PrecacheResource( "particle", 'particles/units/heroes/hero_bounty_hunter/bounty_hunter_hand_l.vpcf', context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_bounty_hunter.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_bounty_hunter.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_bounty_hunter.vpcf", context)
end

function bounty_hunter_jinada_custom:GetIntrinsicModifierName()
    return "modifier_bounty_hunter_jinada_custom_passive"
end

function bounty_hunter_jinada_custom:OnUpgrade()
    if not IsServer() then return end
    if self and self:GetLevel() == 1 then
        self:ToggleAutoCast()
    end
end

bounty_hunter_jinada_custom.modifier_bounty_hunter_5 = {12}
bounty_hunter_jinada_custom.modifier_bounty_hunter_1 = {50,100}
bounty_hunter_jinada_custom.modifier_bounty_hunter_17_dmg = {50,100}

function bounty_hunter_jinada_custom:OnOrbFire()
    if not IsServer() then return end
    if self:GetCaster():IsRangedAttacker() then
        self:UseResources(true, false, false, true)
    end
end

function bounty_hunter_jinada_custom:OnOrbImpact( params )

    self:GetCaster():EmitSound("Hero_BountyHunter.Jinada")

    local particle_hit_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinda_slow.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl(particle_hit_fx, 0, params.target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle_hit_fx)

    if params.target:IsRealHero() or self:GetCaster():HasModifier("modifier_bounty_hunter_17") then
        if params.target:GetUnitName() ~= "npc_dota_bounty_hunter_gold_bag" then
            local money_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinada.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)
            ParticleManager:SetParticleControlEnt(money_particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
            ParticleManager:ReleaseParticleIndex(money_particle)

            if params.target:IsRealHero() then
                local gold = self:GetSpecialValueFor("gold_steal")
                self:GetCaster():ModifyGold(gold, true, 0)
                params.target:SpendGold(gold, 0)
                SendOverheadEventMessage(self:GetCaster(), OVERHEAD_ALERT_GOLD, self:GetCaster(), gold, nil)
            end
        end
    end

    if self:GetCaster():HasModifier("modifier_bounty_hunter_1") then
        DoCleaveAttack(self:GetCaster(), params.target, self, (params.original_damage + self:GetSpecialValueFor("bonus_damage")) / 100 * self.modifier_bounty_hunter_1[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_1")], 150, 360, 650, "particles/items_fx/battlefury_cleave.vpcf") 
    end

    if self:GetCaster():HasModifier("modifier_bounty_hunter_5") then
        local gold_bag = CreateUnitByName("npc_dota_bounty_hunter_gold_bag", params.target:GetAbsOrigin(), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
        if gold_bag then
            gold_bag:AddNewModifier(self:GetCaster(), self, "modifier_bounty_hunter_shuriken_toss_custom_gold", {duration = self.modifier_bounty_hunter_5[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_5")]})
        end
    end

    self:UseResources( true, false, false, true )
    self:GetCaster():RemoveModifierByName("modifier_bounty_hunter_jinada_custom_crit")
end

modifier_bounty_hunter_jinada_custom_passive = class({})

function modifier_bounty_hunter_jinada_custom_passive:IsHidden()
    return true
end

function modifier_bounty_hunter_jinada_custom_passive:IsDebuff()
    return false
end

function modifier_bounty_hunter_jinada_custom_passive:IsPurgable()
    return false
end

function modifier_bounty_hunter_jinada_custom_passive:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_bounty_hunter_jinada_custom_passive:OnCreated( kv )
    self.ability = self:GetAbility()
    self.cast = false
    self.records = {}
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_bounty_hunter_jinada_custom_passive:OnIntervalThink()
    if not IsServer() then return end
    if self:GetAbility():IsFullyCastable() then
        if not self:GetCaster():HasModifier("modifier_bounty_hunter_jinada_custom_crit") then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_bounty_hunter_jinada_custom_crit", {})
        end
    end
end

function modifier_bounty_hunter_jinada_custom_passive:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_EVENT_ON_ATTACK_FAIL,
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
        MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
        MODIFIER_EVENT_ON_ORDER,
        MODIFIER_PROPERTY_PROJECTILE_NAME,
        MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
    return funcs
end

function modifier_bounty_hunter_jinada_custom_passive:OnAttack( params )
    if params.attacker~=self:GetParent() then return end
    if self:ShouldLaunch( params.target ) then
        --self.records[params.record] = true
        --if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end
    end
    self.cast = false
end

function modifier_bounty_hunter_jinada_custom_passive:GetModifierProcAttack_Feedback( params )
    if self.records[params.record] then
        if self.ability.OnOrbImpact then self.ability:OnOrbImpact( params ) end
    end
end
function modifier_bounty_hunter_jinada_custom_passive:OnAttackFail( params )
    if self.records[params.record] then
        if self.ability.OnOrbFail then self.ability:OnOrbFail( params ) end
    end
end
function modifier_bounty_hunter_jinada_custom_passive:OnAttackRecordDestroy( params )
    self.records[params.record] = nil
end

function modifier_bounty_hunter_jinada_custom_passive:OnOrder( params )
    if params.unit~=self:GetParent() then return end

    if params.ability then
        if params.ability==self:GetAbility() then
            self.cast = true
            return
        end
        local pass = false
        local behavior = params.ability:GetBehaviorInt()
        if self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL ) or 
            self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT ) or
            self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL )
        then
            local pass = true -- do nothing
        end

        if self.cast and (not pass) then
            self.cast = false
        end
    else
        if self.cast then
            if self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_POSITION ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_TARGET ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_MOVE ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_TARGET ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_STOP ) or
                self:FlagExist( params.order_type, DOTA_UNIT_ORDER_HOLD_POSITION )
            then
                self.cast = false
            end
        end
    end
end

function modifier_bounty_hunter_jinada_custom_passive:ShouldLaunch( target )
    if self.ability:GetAutoCastState() then
        if self.ability.CastFilterResultTarget~=CDOTA_Ability_Lua.CastFilterResultTarget then
            if self.ability:CastFilterResultTarget( target )==UF_SUCCESS then
                self.cast = true
            end
        else
            local nResult = UnitFilter(
                target,
                self.ability:GetAbilityTargetTeam(),
                self.ability:GetAbilityTargetType(),
                self.ability:GetAbilityTargetFlags(),
                self:GetCaster():GetTeamNumber()
            )
            if nResult == UF_SUCCESS then
                self.cast = true
            end
        end
    end

    if self.cast and self.ability:IsFullyCastable() then
        return true
    end

    return false
end

function modifier_bounty_hunter_jinada_custom_passive:FlagExist(a,b)
    local p,c,d=1,0,b
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c==d
end

function modifier_bounty_hunter_jinada_custom_passive:GetModifierPreAttack_BonusDamage( params )
    if IsClient() and self:GetCaster():HasModifier("modifier_bounty_hunter_jinada_custom_crit") then
        local bonus = 0
        if self:GetCaster():HasModifier("modifier_bounty_hunter_17") then
            bonus = self:GetAbility().modifier_bounty_hunter_17_dmg[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_17")]
        end
        return self:GetAbility():GetSpecialValueFor("bonus_damage") + bonus
    end
    if ((self:GetCaster():HasModifier("modifier_bounty_hunter_jinada_custom_crit") and self.ability:GetAutoCastState()) or self.cast) and self.ability:IsFullyCastable() and params.target then
        local bonus = 0
        if self:GetCaster():HasModifier("modifier_bounty_hunter_17") then
            bonus = self:GetAbility().modifier_bounty_hunter_17_dmg[self:GetCaster():GetTalentLevel("modifier_bounty_hunter_17")]
        end
        self.records[params.record] = true
        if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end
        return self:GetAbility():GetSpecialValueFor("bonus_damage") + bonus
    end
end

modifier_bounty_hunter_jinada_custom_crit = class({})

function modifier_bounty_hunter_jinada_custom_crit:IsPurgable() return false end
function modifier_bounty_hunter_jinada_custom_crit:IsHidden() return true end
function modifier_bounty_hunter_jinada_custom_crit:RemoveOnDeath() return false end

function modifier_bounty_hunter_jinada_custom_crit:OnCreated()
    if not IsServer() then return end

    local particle_glow_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_bounty_hunter/bounty_hunter_hand_l.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle_glow_fx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_weapon1", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle_glow_fx, false, false, -1, false, false)

    local particle_glow_fx_2 = ParticleManager:CreateParticle("particles/units/heroes/hero_bounty_hunter/bounty_hunter_hand_l.vpcf", PATTACH_ABSORIGIN, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle_glow_fx_2, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_weapon2", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle_glow_fx_2, false, false, -1, false, false)
end


modifier_bounty_hunter_shuriken_toss_custom_gold = class({})

function modifier_bounty_hunter_shuriken_toss_custom_gold:IsHidden() return true end
function modifier_bounty_hunter_shuriken_toss_custom_gold:IsPurgable() return false end
function modifier_bounty_hunter_shuriken_toss_custom_gold:IsPurgeException() return false end

function modifier_bounty_hunter_shuriken_toss_custom_gold:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_bounty_hunter_shuriken_toss_custom_gold:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 10, FrameTime()*2, true)
end

function modifier_bounty_hunter_shuriken_toss_custom_gold:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    }
end

function modifier_bounty_hunter_shuriken_toss_custom_gold:OnDestroy()
    if not IsServer() then return end
    UTIL_Remove(self:GetParent())
end

function modifier_bounty_hunter_shuriken_toss_custom_gold:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
    return funcs
end

function modifier_bounty_hunter_shuriken_toss_custom_gold:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_bounty_hunter_shuriken_toss_custom_gold:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_bounty_hunter_shuriken_toss_custom_gold:GetAbsoluteNoDamagePure()
    return 1
end