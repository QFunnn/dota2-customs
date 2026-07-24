--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_neutral_from_2", "neutrals/woda_neutral_from_2", LUA_MODIFIER_MOTION_NONE)

woda_neutral_from_2 = class({})

function woda_neutral_from_2:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/frogmen_water_bubble.vpcf", context )
end

function woda_neutral_from_2:OnSpellStart()
	if not IsServer() then return end
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})
    Timers:CreateTimer(0.1, function()
        if not self:GetCaster():IsAlive() then return end
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_from_2", {duration = self:GetSpecialValueFor("duration")})
        self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
        self:GetCaster():EmitSound("n_frogs.WaterBubble.Target")
    end)
end

modifier_woda_neutral_from_2 = class({})

function modifier_woda_neutral_from_2:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor( "shield" )
	if not IsServer() then return end
	self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
	local effect_cast = ParticleManager:CreateParticle( "particles/neutral_fx/frogmen_water_bubble.vpcf", PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(80,80,80) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
end

function modifier_woda_neutral_from_2:OnDestroy()
	if not IsServer() then return end
    self:GetParent():EmitSound("n_frogs.WaterBubble.Destroy")
end

function modifier_woda_neutral_from_2:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_woda_neutral_from_2:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_woda_neutral_from_2:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
	}
end

function modifier_woda_neutral_from_2:GetModifierIncomingSpellDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
		self:Destroy()
		return -self.current_shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end