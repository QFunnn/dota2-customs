--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_snapfire_lil_shredder_custom", "abilities/snapfire_lil_shredder_custom.lua", LUA_MODIFIER_MOTION_NONE)

snapfire_lil_shredder_custom = class({})

function snapfire_lil_shredder_custom:GetCooldown(level)
	return self.BaseClass.GetCooldown( self, level )
end

function snapfire_lil_shredder_custom:GetManaCost(level)
    return self.BaseClass.GetManaCost(self, level)
end

function snapfire_lil_shredder_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_snapfire_lil_shredder_custom", {duration = duration})
end

modifier_snapfire_lil_shredder_custom = class({})

function modifier_snapfire_lil_shredder_custom:IsPurgable()
	return true
end

function modifier_snapfire_lil_shredder_custom:OnCreated( kv )
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
	self.attacks = self.ability:GetSpecialValueFor( "buffed_attacks" )
	self.damage = self.ability:GetSpecialValueFor( "damage" )
	self.range_bonus = self.ability:GetSpecialValueFor( "attack_range_bonus" )
	if not IsServer() then return end
	self:SetStackCount( self.attacks )
	self.records = {}
	self:PlayEffects()
end

function modifier_snapfire_lil_shredder_custom:OnRefresh( kv )
	self.attacks = self.ability:GetSpecialValueFor( "buffed_attacks" )
	self.damage = self.ability:GetSpecialValueFor( "damage" )
	self.range_bonus = self.ability:GetSpecialValueFor( "attack_range_bonus" )
	if not IsServer() then return end
	self:SetStackCount( self.attacks )
end

function modifier_snapfire_lil_shredder_custom:DeclareFunctions()
	local funcs =
	{
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_TOOLTIP
	}
	return funcs
end

function modifier_snapfire_lil_shredder_custom:OnTooltip()
	return self:GetStackCount()
end

function modifier_snapfire_lil_shredder_custom:GetModifierPreAttack_BonusDamage(params)
	if self:GetStackCount()<=0 then return end
	if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
		_G.Players:QueueAttackBonus(params.attacker, params.target, self.damage, "snapfire_lil_shredder", DAMAGE_TYPE_PHYSICAL)
	end
	return self.damage
end

function modifier_snapfire_lil_shredder_custom:AttackModifier( params )
	if params.attacker~=self.parent then return end
	if self:GetStackCount()<=0 then return end
	self.records[params.record] = true
	if params.no_attack_cooldown then return end
	self.parent:EmitSound("Hero_Snapfire.ExplosiveShellsBuff.Attack")

	if self.parent:HasTalent("special_bonus_unique_snapfire_8") then
		local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.parent:Script_GetAttackRange(), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES+DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false )
		for _, enemy in pairs(enemies) do
			if enemy ~= params.target then
				self.parent:PerformAttack(enemy, true, true, true, false, true, false, false)
			end
		end
	end

	if self:GetStackCount()>0 then
		self:DecrementStackCount()
	end
end

function modifier_snapfire_lil_shredder_custom:AttackLandedModifier( params )
	if params.attacker~=self.parent then return end
	params.target:EmitSound("Hero_Snapfire.ExplosiveShellsBuff.Target")
end

function modifier_snapfire_lil_shredder_custom:OnAttackRecordDestroy( params )
	if self.records[params.record] then
		self.records[params.record] = nil
		if next(self.records)==nil and self:GetStackCount()<=0 then
			if not self:IsNull() then
                self:Destroy()
            end
		end
	end
end

function modifier_snapfire_lil_shredder_custom:GetModifierProjectileName()
	if self:GetStackCount()<=0 then return end
	return "particles/units/heroes/hero_snapfire/hero_snapfire_shells_projectile.vpcf"
end

function modifier_snapfire_lil_shredder_custom:GetModifierOverrideAttackDamage()
	if self:GetStackCount()<=0 then return end
	return self.damage
end

function modifier_snapfire_lil_shredder_custom:GetModifierAttackRangeBonus()
	if self:GetStackCount()<=0 then return end
	return self.range_bonus
end

function modifier_snapfire_lil_shredder_custom:GetModifierAttackSpeedBonus_Constant()
	if self:GetStackCount()<=0 then return end
	return self.ability:GetSpecialValueFor("attack_speed_bonus")
end

function modifier_snapfire_lil_shredder_custom:GetModifierBaseAttackTimeConstant()
	return self.ability:GetSpecialValueFor("base_attack_time")
end

function modifier_snapfire_lil_shredder_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_snapfire/hero_snapfire_shells_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 3, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
	ParticleManager:SetParticleControlEnt( effect_cast, 4, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 5, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false  )
end