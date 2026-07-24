--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_furion_wrath_of_nature_custom",  "heroes/npc_dota_hero_furion_custom/furion_wrath_of_nature_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_furion_wrath_of_nature_custom_buff",  "heroes/npc_dota_hero_furion_custom/furion_wrath_of_nature_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_furion_wrath_of_nature_custom_buff_stack",  "heroes/npc_dota_hero_furion_custom/furion_wrath_of_nature_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_furion_wrath_of_nature_custom_root",  "heroes/npc_dota_hero_furion_custom/furion_wrath_of_nature_custom", LUA_MODIFIER_MOTION_NONE )

furion_wrath_of_nature_custom = class({})

furion_wrath_of_nature_custom.modifier_furion_14 = 0
furion_wrath_of_nature_custom.modifier_furion_14_duration_vision = 6
furion_wrath_of_nature_custom.modifier_furion_14_bonus_radius = 900

function furion_wrath_of_nature_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_wrath_of_nature_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_wrath_of_nature_start.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_wrath_of_nature.vpcf", context )
    PrecacheResource( "particle", "particles/treant_root.vpcf", context )
end

function furion_wrath_of_nature_custom:GetCastRange(vLocation, hTarget)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_furion_14") then
        bonus = self.modifier_furion_14_bonus_radius
    end
    return self:GetSpecialValueFor("radius") + bonus
end

function furion_wrath_of_nature_custom:GetCooldown(level)
	if self:GetCaster():HasModifier("modifier_furion_14") then
		return self.BaseClass.GetCooldown( self, level ) - self.modifier_furion_14
	end
    return self.BaseClass.GetCooldown( self, level )
end

function furion_wrath_of_nature_custom:OnAbilityPhaseStart()
	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_wrath_of_nature_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( nFXIndex, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin(), false )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
	return true
end

function furion_wrath_of_nature_custom:OnSpellStart()
	if not IsServer() then return end
	self.hTarget = self:GetCursorTarget()
	self.vTargetPos = self:GetCursorPosition()
	EmitSoundOn( "Hero_Furion.WrathOfNature_Cast", self:GetCaster() )
	if self:GetCaster():HasModifier("modifier_furion_14") then
		AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), 2700, self.modifier_furion_14_duration_vision, false )
	end
	Timers:CreateTimer(FrameTime(), function()
		CreateModifierThinker( self:GetCaster(), self, "modifier_furion_wrath_of_nature_custom", {}, self.vTargetPos, self:GetCaster():GetTeamNumber(), false )
	end)
end

modifier_furion_wrath_of_nature_custom = class({})

function modifier_furion_wrath_of_nature_custom:IsHidden()
	return true
end

function modifier_furion_wrath_of_nature_custom:OnCreated( kv )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.max_targets = self:GetAbility():GetSpecialValueFor( "max_targets" )
	self.damage_percent_add = self:GetAbility():GetSpecialValueFor( "damage_percent_add" )
	self.jump_delay = self:GetAbility():GetSpecialValueFor( "jump_delay" )
	self.kill_damage = self:GetAbility():GetSpecialValueFor("kill_damage")
	self.kill_damage_duration = self:GetAbility():GetSpecialValueFor("kill_damage_duration")

	if IsServer() then
		self.hTarget = self:GetAbility().hTarget

		if self.hTarget == nil then
			local vPos = self:GetParent():GetOrigin()
			local nFXIndexStart = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_wrath_of_nature_start.vpcf", PATTACH_CUSTOMORIGIN, nil )
			ParticleManager:SetParticleControl( nFXIndexStart, 0, self:GetParent():GetOrigin() )
			ParticleManager:ReleaseParticleIndex( nFXIndexStart )
			self.hTarget = self:GetNextTarget()
			if self.hTarget == nil then
				self:Destroy()
				return
			end
		end

		self.flLastTickTime = GameRules:GetGameTime()
		self.flTimeAccumlator = 0.0
		self.hTargetsHit = {}
		self:StartIntervalThink( 0.0 )
		self:CreateBounceFX( self.hTarget )
		self:GetParent():SetOrigin( self.hTarget:GetOrigin() )
		self:HitTarget( self.hTarget )
	end
end

function modifier_furion_wrath_of_nature_custom:OnDestroy()
	if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_furion_wrath_of_nature_custom:OnIntervalThink()
	if IsServer() then
		local flCurTime = GameRules:GetGameTime()
		local dt = flCurTime - self.flLastTickTime 
		self.flLastTickTime = flCurTime
		self.flTimeAccumlator = self.flTimeAccumlator + dt
		if self.flTimeAccumlator < self.jump_delay then
			return
		end
		self.flTimeAccumlator = self.flTimeAccumlator - self.jump_delay
		local hNewTarget = self:GetNextTarget()
		if hNewTarget == nil then
			self:Destroy()
			return
		end
		self:CreateBounceFX( hNewTarget )
		self:GetParent():SetOrigin( hNewTarget:GetOrigin() )
		self:HitTarget( hNewTarget )
	end
end

function modifier_furion_wrath_of_nature_custom:GetNextTarget()
    local find_radius = self:GetAbility():GetSpecialValueFor("radius")
    if self:GetCaster():HasModifier("modifier_furion_14") then
        find_radius = find_radius + self:GetAbility().modifier_furion_14_bonus_radius
    end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, find_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	local hClosestTarget = nil
	local flClosestDist = 0.0
	if #enemies > 0 then
		for _,enemy in pairs(enemies) do
			if enemy ~= nil and self:GetCaster():CanEntityBeSeenByMyTeam( enemy ) then
				local bHitByWrath = false

				if self.hTargetsHit ~= nil then
					for _,hHitEnemy in ipairs(self.hTargetsHit) do
						if enemy == hHitEnemy then
							bHitByWrath = true
						end 
					end
				end
				if bHitByWrath == false then
					local vToTarget = enemy:GetOrigin() - self:GetParent():GetOrigin()
					local flDistToTarget = vToTarget:Length()

					if hClosestTarget == nil or flDistToTarget < flClosestDist then
						hClosestTarget = enemy
						flClosestDist = flDistToTarget
					end
				end			
			end
		end
	end
	return hClosestTarget
end

function modifier_furion_wrath_of_nature_custom:HitTarget( hTarget )
	if hTarget == nil then
		return
	end
	local nTargetsHit = 0
	if self.hTargetsHit ~= nil then
		nTargetsHit = math.min(self:GetAbility():GetSpecialValueFor("max_targets"), #self.hTargetsHit)
	end
	local flDamagePct = math.pow( 1.0 + ( self.damage_percent_add / 100.0 ), nTargetsHit )
	local flDamage = self.damage

	flDamage = flDamage * flDamagePct

	local damage = 
	{
		victim = hTarget,
		attacker = self:GetCaster(),
		damage = flDamage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility()
	}

	ApplyDamage( damage )

	if self:GetCaster():HasModifier("modifier_furion_14") then
		self:GetCaster():PerformAttack(hTarget, true, true, true, false, false, false, true)
		self:GetCaster():PerformAttack(hTarget, true, true, true, false, false, false, true)
	end

	if not hTarget:IsAlive() then
		--self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_furion_wrath_of_nature_custom_buff_stack", {duration = self.kill_damage_duration})
		--self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_furion_wrath_of_nature_custom_buff", {duration = self.kill_damage_duration})
	end

	if hTarget:IsHero() then
		EmitSoundOn( "Hero_Furion.WrathOfNature_Damage", hTarget )
	else
		EmitSoundOn( "Hero_Furion.WrathOfNature_Damage.Creep", hTarget )
	end

	table.insert( self.hTargetsHit, hTarget )
end

function modifier_furion_wrath_of_nature_custom:CreateBounceFX( hTarget )
	local vTarget1 = self:GetParent():GetOrigin()
	local vTarget2 = hTarget:GetOrigin() - vTarget1 
	local flDistance = math.min( vTarget2:Length() / 2, 256.0 )
	vTarget2 = vTarget2:Normalized() * flDistance
	local vTarget3 = vTarget1 - hTarget:GetOrigin()
	vTarget3 = vTarget3:Normalized() * flDistance
	vTarget2 = vTarget2 + vTarget1
	vTarget3 = vTarget3 + hTarget:GetOrigin()
	local vTarget4 = hTarget:GetOrigin()
	vTarget2.z = vTarget2.z + math.max( flDistance, 128 )
	vTarget3.z = vTarget3.z + math.max( flDistance, 128 )
	vTarget4.z = vTarget4.z + 100
	local nFXIndexHit = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_wrath_of_nature.vpcf", PATTACH_CUSTOMORIGIN, nil );
	ParticleManager:SetParticleControl( nFXIndexHit, 0, vTarget1 );
	ParticleManager:SetParticleControl( nFXIndexHit, 1, vTarget2 );
	ParticleManager:SetParticleControl( nFXIndexHit, 2, vTarget3 );
	ParticleManager:SetParticleControl( nFXIndexHit, 3, vTarget4 );
	ParticleManager:SetParticleControlOrientation( nFXIndexHit, 0, Vector( 0, 0, 1), Vector( 0, 1, 0), Vector( 1, 0, 0 ) );
	ParticleManager:SetParticleControlOrientation( nFXIndexHit, 1, Vector( 0, 0, 1), Vector( 0, 1, 0), Vector( 1, 0, 0 ) );
	ParticleManager:SetParticleControlOrientation( nFXIndexHit, 2, Vector( 0, 0, 1), Vector( 0, 1, 0), Vector( 1, 0, 0 ) );
	ParticleManager:SetParticleControlEnt( nFXIndexHit, 4, self.hTarget, PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetOrigin(), false );
	ParticleManager:ReleaseParticleIndex( nFXIndexHit );
end

modifier_furion_wrath_of_nature_custom_buff_stack = class({})
function modifier_furion_wrath_of_nature_custom_buff_stack:IsHidden() return true end
function modifier_furion_wrath_of_nature_custom_buff_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_furion_wrath_of_nature_custom_buff = class({})
function modifier_furion_wrath_of_nature_custom_buff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end
function modifier_furion_wrath_of_nature_custom_buff:OnIntervalThink()
	if not IsServer() then return end
	local modifier = self:GetParent():FindAllModifiersByName("modifier_furion_wrath_of_nature_custom_buff_stack")
	local damage = self:GetAbility():GetSpecialValueFor("kill_damage")
	self:SetStackCount(#modifier*damage)
end
function modifier_furion_wrath_of_nature_custom_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end

function modifier_furion_wrath_of_nature_custom_buff:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end

modifier_furion_wrath_of_nature_custom_root = class({})

function modifier_furion_wrath_of_nature_custom_root:OnCreated()
	if not IsServer() then return end
    local particle = ParticleManager:CreateParticle( "particles/treant_root.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_furion_wrath_of_nature_custom_root:CheckState()
	return 
	{
		[MODIFIER_STATE_ROOTED] = true
	}
end