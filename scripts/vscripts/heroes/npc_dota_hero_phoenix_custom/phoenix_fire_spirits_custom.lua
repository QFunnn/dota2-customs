--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phoenix_fire_spirits_custom_count", "heroes/npc_dota_hero_phoenix_custom/phoenix_fire_spirits_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phoenix_fire_spirits_custom_debuff", "heroes/npc_dota_hero_phoenix_custom/phoenix_fire_spirits_custom", LUA_MODIFIER_MOTION_NONE)

phoenix_fire_spirits_custom = class({})
phoenix_fire_spirits_custom.modifier_phoenix_12 = {8,6,4}
phoenix_fire_spirits_custom.modifier_phoenix_13 = {40,60}

function phoenix_fire_spirits_custom:GetIntrinsicModifierName()
    if self:GetCaster():HasModifier("modifier_phoenix_12") then
        return "modifier_phoenix_fire_spirits_custom_count"
    end
end

function phoenix_fire_spirits_custom:GetHealthCost(level)
    local hp_cost_perc = self:GetSpecialValueFor("hp_cost_perc")
    return self:GetCaster():GetHealth() / 100 * hp_cost_perc
end

function phoenix_fire_spirits_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
	EmitSoundOn("Hero_Phoenix.FireSpirits.Cast", caster)
	local spirit_duration = self:GetSpecialValueFor("spirit_duration")
    if self:GetCaster():HasModifier("modifier_phoenix_12") then
        spirit_duration = -1
    end
	caster:AddNewModifier(caster, self, "modifier_phoenix_fire_spirits_custom_count", { duration = spirit_duration})
end

modifier_phoenix_fire_spirits_custom_count = class({})
function modifier_phoenix_fire_spirits_custom_count:IsPurgable() return false end
function modifier_phoenix_fire_spirits_custom_count:IsPurgeException() return false end
function modifier_phoenix_fire_spirits_custom_count:RemoveOnDeath() return not self:GetCaster():HasModifier("modifier_phoenix_12") end
function modifier_phoenix_fire_spirits_custom_count:OnCreated()
	if not IsServer() then return end
    local numSpirits = self:GetAbility():GetSpecialValueFor("spirit_count")
    self.numSpirits = numSpirits
	self.pfx = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_fire_spirits.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl(self.pfx, 1, Vector(numSpirits, 0, 0 ) )
    ParticleManager:SetParticleControl(self.pfx, 6, Vector(numSpirits, 0, 0 ) )
	for i=1, numSpirits do
		ParticleManager:SetParticleControl( self.pfx, 8+i, Vector( 1, 0, 0 ) )
	end
    self:AddParticle( self.pfx, false, false, -1, false, false )
    local phoenix_launch_fire_spirit_custom = self:GetParent():FindAbilityByName("phoenix_launch_fire_spirit_custom")
    if phoenix_launch_fire_spirit_custom then
        phoenix_launch_fire_spirit_custom:SetLevel(self:GetAbility():GetLevel())
    end
    self:GetParent():SwapAbilities( "phoenix_fire_spirits_custom", "phoenix_launch_fire_spirit_custom", false, true )
    self:SetStackCount(numSpirits)
    self.spirit_cooldown = 0
    self:StartIntervalThink(1)    
end

function modifier_phoenix_fire_spirits_custom_count:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():HasModifier("modifier_phoenix_12") then return end
    if self:GetStackCount() >= self.numSpirits then return end
    self.spirit_cooldown = self.spirit_cooldown + 1
    if self.spirit_cooldown >= self:GetAbility().modifier_phoenix_12[self:GetCaster():GetTalentLevel("modifier_phoenix_12")] then
        self.spirit_cooldown = 0
        self:IncrementStackCount()
        if self.pfx then
            ParticleManager:SetParticleControl(self.pfx, 1, Vector(self:GetStackCount(), 0, 0 ) )
            ParticleManager:SetParticleControl(self.pfx, 6, Vector(self:GetStackCount(), 0, 0 ) )
            for i=1, self:GetStackCount() do
                local radius = 0
                if i <= self:GetStackCount() then
                    radius = 1
                end
                ParticleManager:SetParticleControl(self.pfx, 8 + i, Vector(radius, 0, 0 ) )
            end
        end
        local phoenix_launch_fire_spirit_custom = self:GetParent():FindAbilityByName("phoenix_launch_fire_spirit_custom")
        if phoenix_launch_fire_spirit_custom then
            phoenix_launch_fire_spirit_custom:SetActivated(true)
        end
    end
end

function modifier_phoenix_fire_spirits_custom_count:OnDestroy()
	if not IsServer() then return end
    self:GetParent():SwapAbilities( "phoenix_launch_fire_spirit_custom", "phoenix_fire_spirits_custom", false, true )
end

phoenix_launch_fire_spirit_custom = class({})

function phoenix_launch_fire_spirit_custom:GetAOERadius() 
    return self:GetSpecialValueFor("radius") 
end

function phoenix_launch_fire_spirit_custom:GetCastAnimation()
	return ACT_DOTA_OVERRIDE_ABILITY_2
end

function phoenix_launch_fire_spirit_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
    local spirit_speed = self:GetSpecialValueFor("spirit_speed")
	caster:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_2)
	EmitSoundOn("Hero_Phoenix.FireSpirits.Launch", caster)
    local modifier_phoenix_fire_spirits_custom_count = caster:FindModifierByName("modifier_phoenix_fire_spirits_custom_count")
    if not modifier_phoenix_fire_spirits_custom_count then return end
	modifier_phoenix_fire_spirits_custom_count:DecrementStackCount()
	local currentStack = modifier_phoenix_fire_spirits_custom_count:GetStackCount()
	local pfx = modifier_phoenix_fire_spirits_custom_count.pfx
	ParticleManager:SetParticleControl(pfx, 1, Vector( currentStack, 0, 0 ) )
    ParticleManager:SetParticleControl(pfx, 6, Vector(currentStack, 0, 0 ) )
    for i=1, modifier_phoenix_fire_spirits_custom_count.numSpirits do
        local radius = 0
        if i <= currentStack then
            radius = 1
        end
        ParticleManager:SetParticleControl( pfx, 8 + i, Vector( radius, 0, 0 ) )
    end
	local thinker = CreateModifierThinker(self:GetCaster(), self, "modifier_invulnerable", {}, point, self:GetCaster():GetTeamNumber(), false)
    
    local vStartPos = self:GetCaster():GetAttachmentOrigin( self:GetCaster():ScriptLookupAttachment( "attach_hitloc" ) )
	local direction = (point - vStartPos):Normalized()

    local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_phoenix/phoenix_fire_spirit_launch.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControl( nFXIndex, 0, vStartPos );
	ParticleManager:SetParticleControl( nFXIndex, 1, direction * spirit_speed );

	local info =
    {
        Target = thinker,
        Source = caster,
        Ability = self,
        EffectName = "",
        iMoveSpeed = spirit_speed,
        vSourceLoc = direction,
        bDrawsOnMinimap = false,
        bDodgeable = false,
        bIsAttack = false,
        bVisibleToEnemies = true,
        bReplaceExisting = false,
        flExpireTime = GameRules:GetGameTime() + 10,
        bProvidesVision = false,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
        ExtraData = {particle = nFXIndex}
    }
	ProjectileManager:CreateTrackingProjectile(info)
	if currentStack < 1 then
        if self:GetCaster():HasModifier("modifier_phoenix_12") then
            self:SetActivated(false)
        else
		    modifier_phoenix_fire_spirits_custom_count:Destroy()
        end
	end
end

function phoenix_launch_fire_spirit_custom:OnProjectileHit_ExtraData(hTarget, vLocation, data)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local location = vLocation
	if hTarget then
		location = hTarget:GetAbsOrigin()
	end
    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("duration")
	ParticleManager:DestroyParticle(data.particle, true )

    local pfx_explosion = ParticleManager:CreateParticle("particles/units/heroes/hero_phoenix/phoenix_fire_spirit_ground.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx_explosion, 0, location)
    ParticleManager:SetParticleControl(pfx_explosion, 1, Vector( radius, radius, radius ) );
	ParticleManager:ReleaseParticleIndex(pfx_explosion)

	EmitSoundOnLocationWithCaster(location, "Hero_Phoenix.ProjectileImpact", self:GetCaster())
    EmitSoundOnLocationWithCaster(location, "Hero_Phoenix.FireSpirits.Target", self:GetCaster())
	AddFOWViewer(self:GetCaster():GetTeamNumber(), location, radius, 1, true)
	local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), location, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	for _,unit in pairs(units) do
        EmitSoundOn( "Hero_Phoenix.FireSpirits.ProjectileHit", unit )
		unit:AddNewModifier(self:GetCaster(), self, "modifier_phoenix_fire_spirits_custom_debuff", {duration = duration * (1 - unit:GetStatusResistance())} )
	end
    if hTarget then
        UTIL_Remove(hTarget)
    end
	return true
end

modifier_phoenix_fire_spirits_custom_debuff = class({})
function modifier_phoenix_fire_spirits_custom_debuff:GetTexture() return "phoenix_fire_spirits" end
function modifier_phoenix_fire_spirits_custom_debuff:GetEffectName() return "particles/units/heroes/hero_phoenix/phoenix_fire_spirit_burn.vpcf" end
function modifier_phoenix_fire_spirits_custom_debuff:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end

function modifier_phoenix_fire_spirits_custom_debuff:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end
function modifier_phoenix_fire_spirits_custom_debuff:OnCreated()
	self.attackspeed_slow	= self:GetAbility():GetSpecialValueFor("attackspeed_slow")
	if not IsServer() then return end
    local phoenix_fire_spirits_custom = self:GetCaster():FindAbilityByName("phoenix_fire_spirits_custom")
	self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	self.damage_per_second = self:GetAbility():GetSpecialValueFor("damage_per_second")
    if self:GetCaster():HasModifier("modifier_phoenix_13") then
        self.damage_per_second = self.damage_per_second + (self:GetCaster():GetAgility() / 100 * phoenix_fire_spirits_custom.modifier_phoenix_13[self:GetCaster():GetTalentLevel("modifier_phoenix_13")])
    end
	self:StartIntervalThink( self.tick_interval )
end

function modifier_phoenix_fire_spirits_custom_debuff:OnIntervalThink()
	if not IsServer() then return end
	ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage_per_second * self.tick_interval, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end

function modifier_phoenix_fire_spirits_custom_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.attackspeed_slow
end