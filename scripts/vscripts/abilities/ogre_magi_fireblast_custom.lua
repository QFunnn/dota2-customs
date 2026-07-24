--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ogre_magi_fireblast_custom = class({})

-- [NP3-1] Пассивный модификатор для проца Fireblast при автоатаке (талант 25 ур.).
function ogre_magi_fireblast_custom:GetIntrinsicModifierName()
	return "modifier_ogre_magi_fireblast_proc"
end

function ogre_magi_fireblast_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

-- [NP3-1] Применить Fireblast к одной цели (для проца при атаке). Без AOE/курсора.
function ogre_magi_fireblast_custom:ApplyToTarget(target)
	if not IsServer() or not target or target:IsNull() then return end
	local caster = self:GetCaster()
	if target:TriggerSpellAbsorb(self) then return end

	local duration = self:GetSpecialValueFor("stun_duration")
	local damage = self:GetSpecialValueFor("fireblast_damage")

	caster:EmitSound("Hero_OgreMagi.Fireblast.Cast")
	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	})
	target:AddNewModifier(caster, self, "modifier_stunned", { duration = duration * (1 - target:GetStatusResistance()) })
	self:PlayEffects(target)
end

function ogre_magi_fireblast_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor( "stun_duration" )
	local damage = self:GetSpecialValueFor( "fireblast_damage" )

	local cursor_target = self:GetCursorTarget()
	if cursor_target:TriggerSpellAbsorb(self) then return end

	self:GetCaster():EmitSound("Hero_OgreMagi.Fireblast.Cast")
	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
	for _, target in pairs(enemies) do
		local damageTable = 
		{
			victim = target,
			attacker = caster,
			damage = damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self,
		}

		ApplyDamage( damageTable )
		target:AddNewModifier( self:GetCaster(), self,  "modifier_stunned",  {duration = duration * (1-target:GetStatusResistance())} )
		self:PlayEffects( target )
	end
end

function ogre_magi_fireblast_custom:PlayEffects( target )
    if target:IsHero() then
	    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	    ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	    ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
	    ParticleManager:ReleaseParticleIndex( effect_cast )
    end
	target:EmitSound("Hero_OgreMagi.Fireblast.Target")
end