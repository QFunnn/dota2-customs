--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_bounty_hunter_shuriken_toss_custom_dummy", "heroes/npc_dota_hero_bounty_hunter_custom/bounty_hunter_shuriken_toss_custom", LUA_MODIFIER_MOTION_NONE )

bristleback_hairball_custom = class({})

function bristleback_hairball_custom:GetAOERadius() 
	return self:GetSpecialValueFor("radius")
end

function bristleback_hairball_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Bristleback.Hairball.Cast")
	local projectile =
    {
        Ability              = self,
        EffectName           = "particles/units/heroes/hero_bristleback/bristleback_hairball.vpcf",
        vSpawnOrigin        = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_hitloc")),
        fDistance            = (self:GetCursorPosition() - self:GetCaster():GetAbsOrigin()):Length2D(),
        fStartRadius        = 0,
        fEndRadius            = 0,
        Source                = self:GetCaster(),
        bHasFrontalCone        = false,
        bReplaceExisting    = false,
        iUnitTargetTeam        = DOTA_UNIT_TARGET_TEAM_NONE,
        iUnitTargetFlags    = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType        = DOTA_UNIT_TARGET_NONE,
        fExpireTime         = GameRules:GetGameTime() + 5.0,
        bDeleteOnHit        = false,
        vVelocity            = (self:GetCursorPosition() - self:GetCaster():GetAbsOrigin()):Normalized()*self:GetSpecialValueFor("projectile_speed")*(Vector(1,1,0)),
        bProvidesVision        = false,
    }
    ProjectileManager:CreateLinearProjectile(projectile)
end

function bristleback_hairball_custom:OnProjectileHit(hTarget, vLocation)
	if not IsServer() then return end
	local goo = self:GetCaster():FindAbilityByName("bristleback_viscous_nasal_goo_custom")
	local spray = self:GetCaster():FindAbilityByName("bristleback_quill_spray_custom")
	local unit = CreateUnitByName("npc_dota_companion", vLocation, false, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
	unit:AddNewModifier(unit, self, "modifier_bounty_hunter_shuriken_toss_custom_dummy", {})

	if goo and goo:IsTrained() then 
		local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), vLocation, nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
		for _,enemy in ipairs(enemies) do
			goo:OnSpellStart(enemy, unit, true)
		end
	end

	if spray and spray:IsTrained() then 
  		spray:MakeSpray(GetGroundPosition(vLocation,nil))
	end

	Timers:CreateTimer(0.1, function()
  		if unit then 
    		unit:Destroy()
		end
	end)
end