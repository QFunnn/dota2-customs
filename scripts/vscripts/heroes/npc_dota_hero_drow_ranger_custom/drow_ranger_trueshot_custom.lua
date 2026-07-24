--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_drow_ranger_trueshot_custom_aura", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_trueshot_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drow_ranger_trueshot_custom", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_trueshot_custom", LUA_MODIFIER_MOTION_NONE)

drow_ranger_trueshot_custom = class({})

function drow_ranger_trueshot_custom:GetIntrinsicModifierName()
    return "modifier_drow_ranger_trueshot_custom_aura"
end

modifier_drow_ranger_trueshot_custom_aura = class({})
function modifier_drow_ranger_trueshot_custom_aura:IsHidden() return true end
function modifier_drow_ranger_trueshot_custom_aura:IsPurgable() return false end
function modifier_drow_ranger_trueshot_custom_aura:IsPurgeException() return false end
function modifier_drow_ranger_trueshot_custom_aura:RemoveOnDeath() return false end

function modifier_drow_ranger_trueshot_custom_aura:IsAura()
	return true and not self:GetParent():IsIllusion()
end

function modifier_drow_ranger_trueshot_custom_aura:GetModifierAura()
	return "modifier_drow_ranger_trueshot_custom"
end

function modifier_drow_ranger_trueshot_custom_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_drow_ranger_trueshot_custom_aura:GetAuraDuration()
	return 0.5
end

function modifier_drow_ranger_trueshot_custom_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_drow_ranger_trueshot_custom_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_drow_ranger_trueshot_custom_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_RANGED_ONLY
end

function modifier_drow_ranger_trueshot_custom_aura:GetAuraEntityReject( hEntity )
	return false
end

function modifier_drow_ranger_trueshot_custom_aura:PlayEffects1()
	self.effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_drow/drow_marksmanship.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(2,0,0) )
	self:AddParticle( self.effect_cast, false,  false,  -1, false,  false  )
	self:PlayEffects2( true )
end

function modifier_drow_ranger_trueshot_custom_aura:PlayEffects2( start )
	local state = 1
	if start then state = 2 end
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(state,0,0) )
	if not start then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_drow/drow_marksmanship_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_drow_ranger_trueshot_custom = class({})

function modifier_drow_ranger_trueshot_custom:OnCreated( kv )
	self.agility = self:GetAbility():GetSpecialValueFor( "trueshot_agi_bonus" )
    self.trueshot_agi_bonus_allies_pct = self:GetAbility():GetSpecialValueFor( "trueshot_agi_bonus_allies_pct" )
	if not IsServer() then return end
end

function modifier_drow_ranger_trueshot_custom:OnRefresh( kv )
	self.agility = self:GetAbility():GetSpecialValueFor( "trueshot_agi_bonus" )
    self.trueshot_agi_bonus_allies_pct = self:GetAbility():GetSpecialValueFor( "trueshot_agi_bonus_allies_pct" )
end

function modifier_drow_ranger_trueshot_custom:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_drow_ranger_trueshot_custom:GetModifierBonusStats_Agility()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_drow_ranger_7") then
		return 0
	end
	if self:GetParent():PassivesDisabled() then return end
	if self:GetCaster()==self:GetParent() then
		if self.lock1 then return end
		self.lock1 = true
		local agi = self:GetCaster():GetAgility()
		self.lock1 = false
		local bonus = self.agility*agi/100
		return bonus
	else
		local agi = self:GetCaster():GetAgility()
		agi = 100 / (100+self.agility) * agi
		local bonus = self.agility*agi/100
		return bonus * 0.5
	end
end

function modifier_drow_ranger_trueshot_custom:GetModifierBonusStats_Strength()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_drow_ranger_7") then
		return 0
	end
	if self:GetParent():PassivesDisabled() then return end
	if self:GetCaster()==self:GetParent() then
		if self.lock1 then return end
		self.lock1 = true
		local agi = self:GetCaster():GetStrength()
		self.lock1 = false
		local bonus = self.agility*agi/100
		return bonus
	else
		local agi = self:GetCaster():GetStrength()
		agi = 100/(100+self.agility)*agi
		local bonus = self.agility*agi/100
		return bonus * 0.5
	end
end