--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tidehunter_kraken_shell_custom = class({})

LinkLuaModifier( "modifier_tidehunter_kraken_shell_custom", "abilities/tidehunter_kraken_shell_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_tidehunter_kraken_shell_custom_cooldown", "abilities/tidehunter_kraken_shell_custom", LUA_MODIFIER_MOTION_NONE )

function tidehunter_kraken_shell_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf", context )
end

function tidehunter_kraken_shell_custom:GetIntrinsicModifierName()
	return "modifier_tidehunter_kraken_shell_custom"
end

modifier_tidehunter_kraken_shell_custom = class({})
function modifier_tidehunter_kraken_shell_custom:IsHidden() return true end
function modifier_tidehunter_kraken_shell_custom:IsDebuff() return false end
function modifier_tidehunter_kraken_shell_custom:IsPurgable() return false end
function modifier_tidehunter_kraken_shell_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.block = self:GetAbility():GetSpecialValueFor( "damage_reduction" )
	self.purge = self:GetAbility():GetSpecialValueFor( "damage_cleanse" )
	self.reset = self:GetAbility():GetSpecialValueFor( "damage_reset_interval" )
	if not IsServer() then return end
	self.damage = 0
end

function modifier_tidehunter_kraken_shell_custom:OnRefresh( kv )
	self.block = self:GetAbility():GetSpecialValueFor( "damage_reduction" )
	self.purge = self:GetAbility():GetSpecialValueFor( "damage_cleanse" )
	self.reset = self:GetAbility():GetSpecialValueFor( "damage_reset_interval" )
end

function modifier_tidehunter_kraken_shell_custom:DeclareFunctions()
	return
    {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}
end

function modifier_tidehunter_kraken_shell_custom:OnTakeDamage( params )
	if not IsServer() then return end
	if params.unit~=self.parent then return end
	if self.parent:PassivesDisabled() then return end
	if not params.attacker:GetPlayerOwner() then return end
	self:StartIntervalThink( self.reset )
	self.damage = self.damage + params.damage
	if self.damage < self.purge then return end
	self.damage = 0
	if not self.parent:HasModifier("modifier_tidehunter_kraken_shell_custom_cooldown") then
		self.parent:Purge( false, true, false, true, true )
		self:PlayEffects()
		self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_tidehunter_kraken_shell_custom_cooldown", {duration = self:GetAbility():GetSpecialValueFor("cooldown_purge")})
	end
end

function modifier_tidehunter_kraken_shell_custom:GetModifierPhysical_ConstantBlock()
	if self.parent:PassivesDisabled() then return 0 end
	return self.block
end

function modifier_tidehunter_kraken_shell_custom:OnIntervalThink()
	self:StartIntervalThink( -1 )
	self.damage = 0
end

function modifier_tidehunter_kraken_shell_custom:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self.parent:EmitSound("Hero_Tidehunter.KrakenShell")
end

modifier_tidehunter_kraken_shell_custom_cooldown = class({})
function modifier_tidehunter_kraken_shell_custom_cooldown:IsHidden() return true end
function modifier_tidehunter_kraken_shell_custom_cooldown:IsPurgable() return false end 
function modifier_tidehunter_kraken_shell_custom_cooldown:RemoveOnDeath() return false end 