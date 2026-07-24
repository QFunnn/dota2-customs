--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_naga_siren_ensnare_custom", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_ensnare_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_ensnare_custom_handler", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_ensnare_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_ensnare_custom_handler_cooldown", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_ensnare_custom", LUA_MODIFIER_MOTION_NONE )

naga_siren_ensnare_custom = class({})

naga_siren_ensnare_custom.modifier_naga_siren_2 = {80,100,120}
naga_siren_ensnare_custom.modifier_naga_siren_3 = {100,100,100}
naga_siren_ensnare_custom.modifier_naga_siren_3_duration = 1
naga_siren_ensnare_custom.modifier_naga_siren_3_radius = 300
naga_siren_ensnare_custom.modifier_naga_siren_3_cooldown = {9,6,3}

naga_siren_ensnare_custom.illusions = {}

function naga_siren_ensnare_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_naga_siren.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_naga_siren.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_naga_siren.vpcf", context)
end

function naga_siren_ensnare_custom:OnAbilityPhaseStart()
	local caster = self:GetCaster()
    local target = self:GetCursorTarget()
	local fake_radius = self:GetSpecialValueFor( "fake_ensnare_distance" )
	local illusions = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), nil, fake_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, false )
	local playerID = caster:GetPlayerOwnerID()
	local model = caster:GetModelName()
	for _,illusion in pairs(illusions) do
		if illusion:GetPlayerOwnerID()==playerID and illusion:IsIllusion() and illusion:GetModelName()==model then
			illusion:StartGesture( ACT_DOTA_CAST_ABILITY_2 )
            illusion:FaceTowards(target:GetAbsOrigin())
			self.illusions[illusion] = true
		end
	end
	return true
end

function naga_siren_ensnare_custom:GetIntrinsicModifierName()
    return "modifier_naga_siren_ensnare_custom_handler"
end

function naga_siren_ensnare_custom:OnAbilityPhaseInterrupted()
	self.illusions = {}
end

function naga_siren_ensnare_custom:CastNetAoe(target)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local projectile_speed = self:GetSpecialValueFor( "net_speed" )
    if self:GetCaster():HasModifier("modifier_naga_siren_7") then
        projectile_speed = projectile_speed * 1.6
    end
	local fake_radius = self:GetSpecialValueFor( "fake_ensnare_distance" )
    local units = FindUnitsInRadius( caster:GetTeamNumber(), target:GetOrigin(), nil, self.modifier_naga_siren_3_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, 0, false )
    for _, unit in pairs(units) do
        local info = 
        {
            Target = unit,
            Source = caster,
            Ability = self,	
            EffectName = "particles/units/heroes/hero_siren/siren_net_projectile.vpcf",
            iMoveSpeed = projectile_speed,
            bDodgeable = true,
            ExtraData = 
            {
                new_duration = self.modifier_naga_siren_3_duration,
                attack = 1,
            }
        }
        ProjectileManager:CreateTrackingProjectile(info)
    end

	caster:EmitSound("Hero_NagaSiren.Ensnare.Cast")
end

function naga_siren_ensnare_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local projectile_speed = self:GetSpecialValueFor( "net_speed" )
    if self:GetCaster():HasModifier("modifier_naga_siren_7") then
        projectile_speed = projectile_speed * 1.6
    end
	local fake_radius = self:GetSpecialValueFor( "fake_ensnare_distance" )

	local info = 
    {
		Target = target,
		Source = caster,
		Ability = self,	
		EffectName = "particles/units/heroes/hero_siren/siren_net_projectile.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		ExtraData = 
        {
			fake = 0,
		}
	}

	ProjectileManager:CreateTrackingProjectile(info)


    for illusion, _ in pairs(self.illusions) do
        info.Source = illusion
        info.ExtraData = 
        {
            fake = 1
        }
        ProjectileManager:CreateTrackingProjectile(info)
        illusion:EmitSound("Hero_NagaSiren.Ensnare.Cast")
    end
    self.illusions = {}

	caster:EmitSound("Hero_NagaSiren.Ensnare.Cast")
end

function naga_siren_ensnare_custom:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end
	if data.fake==1 then return end
    if data.attack == nil then
	    if target:TriggerSpellAbsorb( self ) then return end
    end
	local duration = self:GetSpecialValueFor( "duration" )
    if data.new_duration then
        duration = data.new_duration
    end
    local ability = self
    if self:GetCaster():HasModifier("modifier_naga_siren_5") then
        ability = self:GetCaster():FindAbilityByName("naga_siren_ensnare_custom")
    end
    target:RemoveModifierByName("modifier_naga_siren_song_of_the_siren_custom_debuff")
    target:EmitSound("Hero_NagaSiren.Ensnare.Target")
    local modifier_naga_siren_ensnare_custom = target:FindModifierByName("modifier_naga_siren_ensnare_custom")
    if modifier_naga_siren_ensnare_custom and modifier_naga_siren_ensnare_custom:GetRemainingTime() > (duration * (1-target:GetStatusResistance())) then return end
	target:AddNewModifier( self:GetCaster(), ability, "modifier_naga_siren_ensnare_custom", { duration = duration * (1-target:GetStatusResistance()) } )
end

naga_siren_ensnare_custom_immune = naga_siren_ensnare_custom

modifier_naga_siren_ensnare_custom = class({})

function modifier_naga_siren_ensnare_custom:IsPurgable() return not self:GetCaster():HasModifier("modifier_naga_siren_7") end

function modifier_naga_siren_ensnare_custom:GetPriority()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_naga_siren_ensnare_custom:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
    self:OnIntervalThink()
end

function modifier_naga_siren_ensnare_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_naga_siren_2") then return end
    local damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_naga_siren_2[self:GetCaster():GetTalentLevel("modifier_naga_siren_2")]
    if self:GetParent():HasModifier("modifier_naga_siren_reel_in_custom_pull") then
        local naga_siren_reel_in_custom = self:GetCaster():FindAbilityByName("naga_siren_reel_in_custom")
        if naga_siren_reel_in_custom then
            damage = damage * naga_siren_reel_in_custom:GetSpecialValueFor("damage_ensnare_multiple")
        end
    end
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility() })
end

function modifier_naga_siren_ensnare_custom:CheckState()
    local states = {}
    states[MODIFIER_STATE_ROOTED] = true
    if self:GetCaster():HasModifier("modifier_naga_siren_7") then
        states[MODIFIER_STATE_PASSIVES_DISABLED] = true
    end
    if not self:GetCaster():HasModifier("modifier_naga_siren_5") then
        if self:GetParent():IsDebuffImmune() then return end
    end
	return states
end

function modifier_naga_siren_ensnare_custom:GetEffectName()
	return "particles/units/heroes/hero_siren/siren_net.vpcf"
end

function modifier_naga_siren_ensnare_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_naga_siren_ensnare_custom_handler = class({})
function modifier_naga_siren_ensnare_custom_handler:IsHidden() return true end
function modifier_naga_siren_ensnare_custom_handler:IsPurgeException() return false end
function modifier_naga_siren_ensnare_custom_handler:IsPurgable() return false end
function modifier_naga_siren_ensnare_custom_handler:RemoveOnDeath() return false end
function modifier_naga_siren_ensnare_custom_handler:DeclareFunctions()
    return
    {
         
    }
end

function modifier_naga_siren_ensnare_custom_handler:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:IsOther() then return end
    if not self:GetCaster():HasModifier("modifier_naga_siren_3") then return end
    if self:GetCaster():HasModifier("modifier_naga_siren_ensnare_custom_handler_cooldown") then return end
    if RollPercentage(self:GetAbility().modifier_naga_siren_3[self:GetCaster():GetTalentLevel("modifier_naga_siren_3")]) then
        self:GetAbility():CastNetAoe(params.target)
        self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_naga_siren_ensnare_custom_handler_cooldown", {duration = self:GetAbility().modifier_naga_siren_3_cooldown[self:GetCaster():GetTalentLevel("modifier_naga_siren_3")]})
    end
end

modifier_naga_siren_ensnare_custom_handler_cooldown = class({})
function modifier_naga_siren_ensnare_custom_handler_cooldown:IsDebuff() return true end
function modifier_naga_siren_ensnare_custom_handler_cooldown:IsPurgeException() return false end
function modifier_naga_siren_ensnare_custom_handler_cooldown:IsPurgable() return false end
function modifier_naga_siren_ensnare_custom_handler_cooldown:RemoveOnDeath() return false end
function modifier_naga_siren_ensnare_custom_handler_cooldown:GetTexture() return "naga_siren_3" end

LinkLuaModifier( "modifier_naga_siren_reel_in_custom_buff", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_ensnare_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_reel_in_custom_pull", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_ensnare_custom", LUA_MODIFIER_MOTION_BOTH )

naga_siren_reel_in_custom = class({})

function naga_siren_reel_in_custom:OnAbilityPhaseStart()
    local units_count = {}
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if unit:HasModifier("modifier_naga_siren_ensnare_custom") then
            table.insert(units_count, unit)
        end
    end
    if #units_count <= 0 then return false end
	return true
end

function naga_siren_reel_in_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_naga_siren_reel_in_custom_buff", {duration = self:GetChannelTime()})
end

modifier_naga_siren_reel_in_custom_buff = class({})
function modifier_naga_siren_reel_in_custom_buff:IsHidden() return false end
function modifier_naga_siren_reel_in_custom_buff:IsPurgeException() return false end
function modifier_naga_siren_reel_in_custom_buff:IsPurgable() return false end
function modifier_naga_siren_reel_in_custom_buff:OnCreated()
    if not IsServer() then return end
    self.units = {}
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self:GetAbility():GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if unit:HasModifier("modifier_naga_siren_ensnare_custom") then
            table.insert(self.units, unit)
            unit:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_naga_siren_reel_in_custom_pull", {})
        end
    end
    self:GetCaster():EmitSound("Hero_NagaSiren.ReelIn.Cast")
    self:StartIntervalThink(FrameTime())
end

function modifier_naga_siren_reel_in_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsChanneling() then
        self:Destroy()
        return
    end
    for i=#self.units, 1, -1 do
        if not self.units[i] or self.units[i]:IsNull() or not self.units[i]:HasModifier("modifier_naga_siren_ensnare_custom") then
            table.remove(self.units, i)
        end
    end
    if #self.units <= 0 then
        self:GetParent():Interrupt()
        self:Destroy()
        return
    end
    local destroy = true
    for _, unit in pairs(self.units) do
        local dir = (self:GetCaster():GetAbsOrigin() - unit:GetAbsOrigin())
        dir.z = 0
        local distance = dir:Length2D()
        dir = dir:Normalized()
        local new_point = unit:GetAbsOrigin() + dir * (self:GetAbility():GetSpecialValueFor("pull_strength") * FrameTime())
        unit:SetAbsOrigin(new_point)
        if distance > self:GetAbility():GetSpecialValueFor("min_pull_distance") then
            destroy = false
        end
    end
    if destroy then
        self:GetParent():Interrupt()
        self:Destroy()
    end
end

function modifier_naga_siren_reel_in_custom_buff:IsHidden() return true end
function modifier_naga_siren_reel_in_custom_buff:OnDestroy()
    if not IsServer() then return end
    self:StartIntervalThink(-1)
    self:GetCaster():StopSound("Hero_NagaSiren.ReelIn.Cast")
    for _, unit in pairs(self.units) do
        if unit and not unit:IsNull() then
            unit:RemoveModifierByName("modifier_naga_siren_reel_in_custom_pull")
        end
    end
end

modifier_naga_siren_reel_in_custom_pull = class({})
function modifier_naga_siren_reel_in_custom_pull:IsPurgable() return false end
function modifier_naga_siren_reel_in_custom_pull:IsPurgeException() return false end
function modifier_naga_siren_reel_in_custom_pull:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end
function modifier_naga_siren_reel_in_custom_pull:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():IsChanneling() then
        self:Destroy()
    end
end
function modifier_naga_siren_reel_in_custom_pull:OnDestroy()
    if not IsServer() then return end
    GridNav:DestroyTreesAroundPoint(self:GetParent():GetAbsOrigin(), 250, true)
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
end
function modifier_naga_siren_reel_in_custom_pull:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end