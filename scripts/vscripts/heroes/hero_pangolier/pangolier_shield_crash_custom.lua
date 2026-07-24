--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_pangolier_shield_crash_custom", "heroes/hero_pangolier/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_pangolier_shield_crash_custom_debuff", "heroes/hero_pangolier/pangolier_shield_crash_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

pangolier_shield_crash_custom = class({})

function pangolier_shield_crash_custom:GetCooldown( level )
	if self:GetCaster():HasModifier("modifier_pangolier_gyroshell") and self:GetCaster():HasTalent("special_bonus_unique_pangolier_2") then
		return self:GetSpecialValueFor( "rolling_thunder_cooldown" )
	end
	return self.BaseClass.GetCooldown( self, level )
end

function pangolier_shield_crash_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor( "damage" )
	local radius = self:GetSpecialValueFor( "radius" )
	local distance = self:GetSpecialValueFor( "jump_horizontal_distance" )
	local duration = self:GetSpecialValueFor( "jump_duration" )
	local height = self:GetSpecialValueFor( "jump_height" )
	local buff_duration = self:GetSpecialValueFor( "duration" )

	if self:GetCaster():HasModifier("modifier_pangolier_gyroshell") then
		duration = self:GetSpecialValueFor("jump_duration_gyroshell")
		height = self:GetSpecialValueFor("jump_height_gyroshell")
		distance = 0
	end

	local arc = caster:AddNewModifier( caster, self, "modifier_generic_arc_lua", { distance = distance, duration = duration, height = height, fix_duration = false, isForward = true, isStun = false, activity = ACT_DOTA_FLAIL } )

	arc:SetEndCallback(function()

		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0,	0, false )

		local damageTable = { attacker = caster, damage = damage, damage_type = self:GetAbilityDamageType(), ability = self }

		local stack = 0
		local stack_creep = 0

		for _,enemy in pairs(enemies) do

			damageTable.victim = enemy

			ApplyDamage(damageTable)

			if enemy:IsHero() and not enemy:IsIllusion() then
				stack = stack + 1
			end

			if not enemy:IsHero() then
				stack_creep = stack_creep + 1
			end

			enemy:AddNewModifier(self:GetCaster(), self, "modifier_pangolier_shield_crash_custom_debuff", {duration = self:GetSpecialValueFor("slow_duration")})

			self:PlayEffects4( enemy )
		end

		
		if stack > 0 or stack_creep > 0 then
			caster:AddNewModifier( caster, self, "modifier_pangolier_shield_crash_custom", { duration = buff_duration, stack = stack, stack_creep = stack_creep } )
		end

		self:PlayEffects2()

		if stack > 0 or stack_creep > 0 then
			self:PlayEffects3()
		end
	end)

	self:PlayEffects1( arc )
end

function pangolier_shield_crash_custom:PlayEffects1( modifier )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_tailthump_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	modifier:AddParticle( effect_cast, false,  false,  -1,  false,  false  )
	self:GetCaster():EmitSound("Hero_Pangolier.TailThump.Cast")
end

function pangolier_shield_crash_custom:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Hero_Pangolier.TailThump")
end

function pangolier_shield_crash_custom:PlayEffects3()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_tailthump_hero.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Hero_Pangolier.TailThump.Shield")
end

function pangolier_shield_crash_custom:PlayEffects3()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_tailthump_hero.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Hero_Pangolier.TailThump.Shield")
end

function pangolier_shield_crash_custom:PlayEffects4( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_tailthump_shield_impact.vpcf", PATTACH_ABSORIGIN, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_pangolier_shield_crash_custom = class({})

function modifier_pangolier_shield_crash_custom:IsPurgable() return false end

function modifier_pangolier_shield_crash_custom:OnCreated( kv )
	local stack_pct = self:GetAbility():GetSpecialValueFor( "hero_shield" )
	local creep_stacks = self:GetAbility():GetSpecialValueFor( "creep_shield" )
	if not IsServer() then return end
    self:SetStackCount((kv.stack * stack_pct) + (kv.stack_creep * creep_stacks))
	self:PlayEffects()
end

function modifier_pangolier_shield_crash_custom:OnRefresh( kv )
	local stack_pct = self:GetAbility():GetSpecialValueFor( "hero_shield" )
	local creep_stacks = self:GetAbility():GetSpecialValueFor( "creep_shield" )
	if not IsServer() then return end
	self:SetStackCount( self:GetStackCount() + ((kv.stack * stack_pct) + (kv.stack_creep * creep_stacks)))
end

function modifier_pangolier_shield_crash_custom:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    }
    return funcs
end

function modifier_pangolier_shield_crash_custom:GetModifierTotal_ConstantBlock(kv)
    if IsServer() then
        local target                    = self:GetParent()
        local original_shield_amount    = self:GetStackCount()
        if kv.damage > 0 then
            if kv.damage < original_shield_amount then
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, kv.damage, nil)
                original_shield_amount = original_shield_amount - kv.damage
                self:SetStackCount(original_shield_amount)
                return kv.damage
            else
                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BLOCK, target, original_shield_amount, nil)
                if not self:IsNull() then
                    self:Destroy()
                end
                return original_shield_amount
            end
        end
    end
end

function modifier_pangolier_shield_crash_custom:GetModifierIncomingDamageConstant()
    if (not IsServer()) then
        return self:GetStackCount()
    end
end

function modifier_pangolier_shield_crash_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_pangolier_shield.vpcf"
end

function modifier_pangolier_shield_crash_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_pangolier_shield_crash_custom:PlayEffects()
	if self.effect_cast then
		ParticleManager:DestroyParticle( self.effect_cast, false )
	end
	local parent = self:GetParent()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( self.reduction, 0, 0 ) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self.effect_cast = effect_cast
end

modifier_pangolier_shield_crash_custom_debuff = class({})

function modifier_pangolier_shield_crash_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_pangolier_shield_crash_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("slow")
end