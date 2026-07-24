--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_naga_siren_mirror_image_custom", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_mirror_image_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_mirror_image_custom_barrier", "heroes/npc_dota_hero_naga_siren_custom/naga_siren_mirror_image_custom", LUA_MODIFIER_MOTION_NONE )

naga_siren_mirror_image_custom = class({})

naga_siren_mirror_image_custom.modifier_naga_siren_17 = {-100,-200}
naga_siren_mirror_image_custom.modifier_naga_siren_10_radius = 600
naga_siren_mirror_image_custom.modifier_naga_siren_10 = {200,275,350}
naga_siren_mirror_image_custom.modifier_naga_siren_10_duration = 20

function naga_siren_mirror_image_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local delay = self:GetSpecialValueFor( "invuln_duration" )
    if caster.naga_illusions == nil then
        caster.naga_illusions = {}
    end
	caster:Stop()
	ProjectileManager:ProjectileDodge( caster )
	caster:Purge( false, true, false, false, false )
	caster:AddNewModifier( caster, self, "modifier_naga_siren_mirror_image_custom", { duration = delay } )
	caster:EmitSound("Hero_NagaSiren.MirrorImage")
end

function naga_siren_mirror_image_custom:SetBarrier()
    Timers:CreateTimer(0.25, function()
        local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self.modifier_naga_siren_10_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, 0, 0, false)
        for _, unit in pairs(units) do
            unit:RemoveModifierByName("modifier_naga_siren_mirror_image_custom_barrier")
            unit:AddNewModifier(self:GetCaster(), self, "modifier_naga_siren_mirror_image_custom_barrier", {duration = self.modifier_naga_siren_10_duration})
        end
    end)
end

modifier_naga_siren_mirror_image_custom = class({})
function modifier_naga_siren_mirror_image_custom:IsHidden() return true end
function modifier_naga_siren_mirror_image_custom:IsPurgable() return false end

function modifier_naga_siren_mirror_image_custom:OnCreated( kv )
	self.count = self:GetAbility():GetSpecialValueFor( "images_count" )
	self.duration = self:GetAbility():GetSpecialValueFor( "illusion_duration" )
	self.outgoing = self:GetAbility():GetSpecialValueFor( "outgoing_damage" )
	self.incoming = self:GetAbility():GetSpecialValueFor( "incoming_damage" )
    if self:GetCaster():HasModifier("modifier_naga_siren_17") then
        self.incoming = self.incoming + self:GetAbility().modifier_naga_siren_17[self:GetCaster():GetTalentLevel("modifier_naga_siren_17")]
    end
	self.distance = 72
end

function modifier_naga_siren_mirror_image_custom:OnDestroy()
	if not IsServer() then return end
	for illusion, _ in pairs(self:GetCaster().naga_illusions) do
		if not illusion:IsNull() then
			illusion:ForceKill( false )
		end
		self:GetCaster().naga_illusions[ illusion ]	= nil	
	end
	local illusions = CreateIllusions( self:GetParent(), self:GetParent(), { outgoing_damage = self.outgoing, incoming_damage = self.incoming, duration = self.duration }, self.count, self.distance, true, true )
	for _,illusion in pairs(illusions) do
		self:GetCaster().naga_illusions[ illusion ] = true
	end
    if self:GetCaster():HasModifier("modifier_naga_siren_10") then
        self:GetAbility():SetBarrier()
    end
end

function modifier_naga_siren_mirror_image_custom:CheckState()
	return
    {
		[MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_naga_siren_mirror_image_custom:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_mirror_image.vpcf"
end

function modifier_naga_siren_mirror_image_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_naga_siren_mirror_image_custom_barrier = class({})

function modifier_naga_siren_mirror_image_custom_barrier:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = self:GetAbility().modifier_naga_siren_10[self:GetCaster():GetTalentLevel("modifier_naga_siren_10")]
	if not IsServer() then return end
	self.max_shield = self.barrier / 100 * self:GetCaster():GetIntellect(false)
	self.current_shield = self.barrier / 100 * self:GetCaster():GetIntellect(false)
	self:SetHasCustomTransmitterData( true )
end

function modifier_naga_siren_mirror_image_custom_barrier:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_naga_siren_mirror_image_custom_barrier:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_naga_siren_mirror_image_custom_barrier:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
end

function modifier_naga_siren_mirror_image_custom_barrier:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local shield = self.current_shield
		self:Destroy()
		return -shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end