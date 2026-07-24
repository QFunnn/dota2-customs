--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tiny_tree_channel_custom", "heroes/npc_dota_hero_tiny_custom/tiny_tree_channel_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tiny_tree_grab_custom_debuff", "heroes/npc_dota_hero_tiny_custom/tiny_tree_grab_custom", LUA_MODIFIER_MOTION_NONE)

tiny_tree_channel_custom = class({})

function tiny_tree_channel_custom:GetAOERadius()
	return self:GetSpecialValueFor( "splash_radius" )
end

function tiny_tree_channel_custom:OnSpellStart()
	if not IsServer() then return end
	self.vTargetPos = self:GetCursorPosition()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_tiny_tree_channel_custom", {})
end

function tiny_tree_channel_custom:OnChannelFinish(bInterrupted)
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_tiny_tree_channel_custom")
end

function tiny_tree_channel_custom:OnProjectileHit( hTarget, vLocation )
	if not IsServer() then return end
    local tiny_toss_tree_custom = self:GetCaster():FindAbilityByName("tiny_toss_tree_custom")
	self.radius = self:GetSpecialValueFor( "splash_radius" )
	EmitSoundOnLocationWithCaster( vLocation, "OgreTank.GroundSmash", self:GetCaster() )
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), vLocation, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
	for _,enemy in pairs( enemies ) do
		if enemy ~= nil then
			EmitSoundOn( "Hero_Tiny.Tree.Target", enemy )
			self:GetCaster():PerformAttack(enemy, true, true, true, true, false, false, true)
            if tiny_toss_tree_custom and tiny_toss_tree_custom:GetLevel() > 0 then
                enemy:AddNewModifier(self:GetCaster(), tiny_toss_tree_custom, "modifier_tiny_tree_grab_custom_debuff", { duration = tiny_toss_tree_custom:GetSpecialValueFor("slow_duration") * (1-enemy:GetStatusResistance()) })
            end
		end
	end
	return true
end

modifier_tiny_tree_channel_custom = class({})

function modifier_tiny_tree_channel_custom:IsHidden() return true end
function modifier_tiny_tree_channel_custom:IsPurgable() return false end
function modifier_tiny_tree_channel_custom:IsPurgeException() return false end

function modifier_tiny_tree_channel_custom:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("interval"))

    local tree_grab_radius = self:GetAbility():GetSpecialValueFor( "tree_grab_radius" )
    local radius = self:GetAbility():GetSpecialValueFor( "splash_radius" )

    local caster_particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_tiny/tiny_tree_channel.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControl( caster_particle, 2, Vector( tree_grab_radius, tree_grab_radius, 1 ) )
    self:AddParticle(caster_particle, false, false, -1, false, false)

    local target_particle = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_tiny/tiny_tree_channel.vpcf", PATTACH_WORLDORIGIN, nil, self:GetCaster():GetTeamNumber() )
    ParticleManager:SetParticleControl( target_particle, 0, self:GetAbility().vTargetPos )
    ParticleManager:SetParticleControl( target_particle, 2, Vector( radius, radius, 1 ) )
    self:AddParticle(target_particle, false, false, -1, false, false)

    self:OnIntervalThink()
end

function modifier_tiny_tree_channel_custom:OnIntervalThink()
	if not IsServer() then return end
	self.bone_speed = self:GetAbility():GetSpecialValueFor( "speed" )
    local tree_grab_radius = self:GetAbility():GetSpecialValueFor( "tree_grab_radius" )
	local vStartPos = self:GetCaster():GetAttachmentOrigin( self:GetCaster():ScriptLookupAttachment( "attach_attack1" ) )
    local trees = GridNav:GetAllTreesAroundPoint(self:GetCaster():GetAbsOrigin(), tree_grab_radius, false)
    if #trees <= 0 then
        CreateTempTree(self:GetCaster():GetAbsOrigin()+RandomVector(tree_grab_radius-100), 1)
    end
    trees = GridNav:GetAllTreesAroundPoint(self:GetCaster():GetAbsOrigin(), tree_grab_radius, false)
    local random_tree = trees[1]
    if random_tree then
        local vPos = self:GetAbility().vTargetPos
        local vDirection = vPos - random_tree:GetAbsOrigin() 
        local flDist2d = vDirection:Length2D()
        local flDist = vDirection:Length()
        vDirection = vDirection:Normalized()
        vDirection.z = 0.0
        local info = 
        {
            EffectName = "particles/units/heroes/hero_tiny/tiny_tree_linear_proj.vpcf",
            Ability = self:GetAbility(),
            vSpawnOrigin = random_tree:GetAbsOrigin(), 
            fStartRadius = 0,
            fEndRadius = 0,
            vVelocity = vDirection * self.bone_speed,
            fDistance = flDist2d,
            Source = self:GetCaster(),
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        }
        ProjectileManager:CreateLinearProjectile( info )
        EmitSoundOn( "Hero_Tiny.Tree.Throw", self:GetCaster() )
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_tiny/tiny_tree_channel_tree.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, random_tree:GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, random_tree:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        if random_tree.CutDown then
            random_tree:CutDown(self:GetCaster():GetTeamNumber())
        else
            GridNav:DestroyTreesAroundPoint(random_tree:GetAbsOrigin(), 10, true)
        end
    end
end