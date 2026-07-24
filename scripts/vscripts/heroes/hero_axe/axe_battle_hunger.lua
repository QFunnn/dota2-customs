--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_axe_battle_hunger_custom_buff", "heroes/hero_axe/axe_battle_hunger", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_battle_hunger_custom_creep", "heroes/hero_axe/axe_battle_hunger", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_battle_hunger_custom_hero", "heroes/hero_axe/axe_battle_hunger", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_battle_hunger_custom_debuff", "heroes/hero_axe/axe_battle_hunger", LUA_MODIFIER_MOTION_NONE )

axe_battle_hunger_custom = class({})

function axe_battle_hunger_custom:GetAOERadius()
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor("aoe_radius")
	end
end

function axe_battle_hunger_custom:GetBehavior()
	if self:GetCaster():HasScepter() then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end



function axe_battle_hunger_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")

	if target:TriggerSpellAbsorb( self ) then return end

	target:AddNewModifier( self:GetCaster(), self, "modifier_axe_battle_hunger_custom_debuff", { duration = duration } )

	if self:GetCaster():HasScepter() then
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetSpecialValueFor("aoe_radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		for _,enemy in pairs(enemies) do 
			enemy:AddNewModifier( self:GetCaster(), self, "modifier_axe_battle_hunger_custom_debuff", { duration = duration } )
		end
	end

	local mod = self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_axe_battle_hunger_custom_buff", {target = target:entindex(),  duration = duration } )

	target:EmitSound("Hero_Axe.Battle_Hunger")
end

modifier_axe_battle_hunger_custom_buff = class({})

function modifier_axe_battle_hunger_custom_buff:IsPurgable()
	return false
end

function modifier_axe_battle_hunger_custom_buff:IsPurgable()
	return not self:GetCaster():HasScepter()
end

function modifier_axe_battle_hunger_custom_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_axe_battle_hunger_custom_buff:GetModifierPhysicalArmorBonus()
	if self:GetCaster():HasScepter() then 
		return (self:GetAbility():GetSpecialValueFor("scepter_armor_change") * self:GetCaster():GetModifierStackCount("modifier_axe_battle_hunger_custom_hero", self:GetCaster())) + ((self:GetAbility():GetSpecialValueFor("scepter_armor_change") / 2) * self:GetCaster():GetModifierStackCount("modifier_axe_battle_hunger_custom_creep", self:GetCaster()))
	end
	return 0
end

function modifier_axe_battle_hunger_custom_buff:GetModifierMoveSpeedBonus_Percentage()
	return (self:GetAbility():GetSpecialValueFor("speed_bonus") * self:GetCaster():GetModifierStackCount("modifier_axe_battle_hunger_custom_hero", self:GetCaster())) + ((self:GetAbility():GetSpecialValueFor("speed_bonus") / 2) * self:GetCaster():GetModifierStackCount("modifier_axe_battle_hunger_custom_creep", self:GetCaster()))
end

modifier_axe_battle_hunger_custom_debuff = class({})

function modifier_axe_battle_hunger_custom_debuff:OnCreated( kv )
	self.slow = self:GetAbility():GetSpecialValueFor( "slow" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	self.armor_multi = self:GetAbility():GetSpecialValueFor("armor_multiplier")
	self.stone_angle = 85
	self.facing = false
	self.scepter_armor_change = self:GetAbility():GetSpecialValueFor("scepter_armor_change")

	self.armor = -1*self.scepter_armor_change

	if not IsServer() then return end

	local name = "modifier_axe_battle_hunger_custom_creep"

	if self:GetParent():IsHero() then 
		name = "modifier_axe_battle_hunger_custom_hero"
	end

	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), name, {})
	self:StartIntervalThink( 1 )
	self:OnIntervalThink()
end

function modifier_axe_battle_hunger_custom_debuff:OnDestroy( kv )
	if not IsServer() then return end
	if self:GetCaster() == nil then return end

	local name = "modifier_axe_battle_hunger_custom_creep"
	if self:GetParent():IsHero() then 
		name = "modifier_axe_battle_hunger_custom_hero"
	end

	local mod = self:GetCaster():FindModifierByName(name)
	if mod then 
		mod:DecrementStackCount()
		if mod:GetStackCount() == 0 then
			mod:Destroy()
		end
	end

	if not self:GetCaster():HasModifier("modifier_axe_battle_hunger_custom_hero") and not self:GetCaster():HasModifier("modifier_axe_battle_hunger_custom_creep") then 
		if self:GetCaster():HasModifier("modifier_axe_battle_hunger_custom_buff") then 
			self:GetCaster():RemoveModifierByName("modifier_axe_battle_hunger_custom_buff")
		end
	end
end

function modifier_axe_battle_hunger_custom_debuff:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_axe_battle_hunger_custom_debuff:GetModifierPhysicalArmorBonus()
	if self:GetCaster():HasScepter() then 
		return self.armor
	end
	return 0
end

function modifier_axe_battle_hunger_custom_debuff:OnDeathEvent( params )
	if not IsServer() then return end
	if params.attacker~=self:GetParent() then return end
	if self:GetCaster() == self:GetParent() then return end
	self:Destroy()
end

function modifier_axe_battle_hunger_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	if not IsServer() then return self.slow end
	if self:GetCaster() == self:GetParent() then return end
	local vector = (self:GetCaster():GetAbsOrigin()-self:GetParent():GetAbsOrigin()):Normalized()
	local center_angle = VectorToAngles( vector ).y
	local facing_angle = VectorToAngles( self:GetParent():GetForwardVector() ).y
	local facing = ( math.abs( AngleDiff(center_angle,facing_angle) ) > self.stone_angle ) 
	if facing then
		return self.slow
	end
end

function modifier_axe_battle_hunger_custom_debuff:OnIntervalThink()
	if not IsServer() then return end
	local damage = self.damage + self:GetCaster():GetPhysicalArmorValue(false) * self.armor_multi
	local damageTable = { victim = self:GetParent(), attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_NONE, }
	ApplyDamage( damageTable )
end

function modifier_axe_battle_hunger_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_battle_hunger.vpcf"
end

function modifier_axe_battle_hunger_custom_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

modifier_axe_battle_hunger_custom_creep = class({})

function modifier_axe_battle_hunger_custom_creep:IsHidden() return true end
function modifier_axe_battle_hunger_custom_creep:IsPurgable() return false end

function modifier_axe_battle_hunger_custom_creep:OnCreated(table)
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_axe_battle_hunger_custom_creep:OnRefresh(table)
	if not IsServer() then return end
	self:IncrementStackCount()
end

modifier_axe_battle_hunger_custom_hero = class({})

function modifier_axe_battle_hunger_custom_hero:IsHidden() return true end
function modifier_axe_battle_hunger_custom_hero:IsPurgable() return false end

function modifier_axe_battle_hunger_custom_hero:OnCreated(table)
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_axe_battle_hunger_custom_hero:OnRefresh(table)
	if not IsServer() then return end
	self:IncrementStackCount()
end
