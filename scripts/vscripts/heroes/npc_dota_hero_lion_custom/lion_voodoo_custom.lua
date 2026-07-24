--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lion_voodoo_custom", "heroes/npc_dota_hero_lion_custom/lion_voodoo_custom", LUA_MODIFIER_MOTION_NONE )

lion_voodoo_custom = class({})

function lion_voodoo_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", context )
end

lion_voodoo_custom.modifier_lion_12 = {8,16,24}
lion_voodoo_custom.modifier_lion_13 = {0.2,0.4}

function lion_voodoo_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	local duration = self:GetSpecialValueFor("duration")
	if self:GetCaster():HasModifier("modifier_lion_13") then
		duration = duration + self.modifier_lion_13[self:GetCaster():GetTalentLevel("modifier_lion_13")]
	end
	target:AddNewModifier( caster, self, "modifier_lion_voodoo_custom", { duration = duration * (1-target:GetStatusResistance()) } )
	self:GetCaster():EmitSound("Hero_Lion.Voodoo")
end

modifier_lion_voodoo_custom = class({})

function modifier_lion_voodoo_custom:IsPurgable() return false end
function modifier_lion_voodoo_custom:IsPurgeException() return true end

function modifier_lion_voodoo_custom:OnCreated( kv )
	self.base_speed = self:GetAbility():GetSpecialValueFor( "movespeed" )
	self.model = "models/props_gameplay/frog.vmdl"
	if IsServer() then
		self:PlayEffects( true )
		if self:GetParent():IsIllusion() then
			self:GetParent():Kill( self:GetAbility(), self:GetCaster() )
		end
	end
end

function modifier_lion_voodoo_custom:OnRefresh( kv )
	self.base_speed = self:GetAbility():GetSpecialValueFor( "movespeed" )
	if IsServer() then
		self:PlayEffects( true )
	end
end

function modifier_lion_voodoo_custom:OnDestroy( kv )
	if IsServer() then
		self:PlayEffects( false )
	end
end

function modifier_lion_voodoo_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
	return funcs
end

function modifier_lion_voodoo_custom:GetModifierMoveSpeedOverride()
	return self.base_speed
end

function modifier_lion_voodoo_custom:GetModifierModelChange()
	return self.model
end

function modifier_lion_voodoo_custom:GetModifierIncomingDamage_Percentage()
	if self:GetCaster():HasModifier("modifier_lion_12") then
		return self:GetAbility().modifier_lion_12[self:GetCaster():GetTalentLevel("modifier_lion_12")]
	end
	return 0
end

function modifier_lion_voodoo_custom:CheckState()
	local state = 
	{
		[MODIFIER_STATE_HEXED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
	return state
end

function modifier_lion_voodoo_custom:PlayEffects( bStart )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lion/lion_spell_voodoo.vpcf", PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	if bStart then
		self:GetParent():EmitSound("Hero_Lion.Hex.Target")
	end
end