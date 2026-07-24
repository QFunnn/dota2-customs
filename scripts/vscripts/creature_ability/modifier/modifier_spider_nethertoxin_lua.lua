--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_spider_nethertoxin_lua = class({})

function modifier_spider_nethertoxin_lua:GetTexture()
	return "viper_nethertoxin"
end

function modifier_spider_nethertoxin_lua:IsHidden()
	return false
end

function modifier_spider_nethertoxin_lua:IsDebuff()
	return true
end

function modifier_spider_nethertoxin_lua:IsStunDebuff()
	return false
end

function modifier_spider_nethertoxin_lua:IsPurgable()
	return false
end

function modifier_spider_nethertoxin_lua:OnCreated( kv )
	if not IsServer() then return end
    if not self:GetAbility() then return end
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.owner = kv.isProvidedByAura~=1
	if not self.owner then
		self.damageTable = 
        {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(), --Optional.
		}
		self:StartIntervalThink( 0.5 )
	else
		self:PlayEffects()
	end
end

function modifier_spider_nethertoxin_lua:OnRefresh( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_spider_nethertoxin_lua:OnDestroy()
	if not IsServer() then return end
	if not self.owner then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_spider_nethertoxin_lua:CheckState()
	local state = 
    {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}
	return state
end

function modifier_spider_nethertoxin_lua:OnIntervalThink()
    if not IsServer() then return end
	ApplyDamage( self.damageTable )
	self:GetParent():EmitSound("Hero_Viper.NetherToxin.Damage")
end

function modifier_spider_nethertoxin_lua:IsAura()
	return self.owner
end

function modifier_spider_nethertoxin_lua:GetModifierAura()
	return "modifier_spider_nethertoxin_lua"
end

function modifier_spider_nethertoxin_lua:GetAuraRadius()
	return self.radius
end

function modifier_spider_nethertoxin_lua:GetAuraDuration()
	return 0.2
end

function modifier_spider_nethertoxin_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_spider_nethertoxin_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_spider_nethertoxin_lua:GetEffectName()
	if not self.owner then
		return "particles/units/heroes/hero_viper/viper_nethertoxin_debuff.vpcf"
	end
end

function modifier_spider_nethertoxin_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_spider_nethertoxin_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_viper/viper_nethertoxin.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	self:GetParent():EmitSound("Hero_Viper.NetherToxin")
end