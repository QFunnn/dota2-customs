--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lion_speed_rain", "heroes/npc_dota_hero_lion_custom/lion_speed_rain", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lion_speed_rain_debuff", "heroes/npc_dota_hero_lion_custom/lion_speed_rain", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lion_speed_rain_buff", "heroes/npc_dota_hero_lion_custom/lion_speed_rain", LUA_MODIFIER_MOTION_NONE )

lion_speed_rain = class({})

function lion_speed_rain:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/lion_green_static.vpcf", context )
end

lion_speed_rain.modifiers = {}

function lion_speed_rain:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb( self ) then
		return
	end

	local duration = self:GetSpecialValueFor("duration")
	local modifier = target:AddNewModifier( self:GetCaster(), self, "modifier_lion_speed_rain", { duration = duration })
	self.modifiers[modifier] = true
	self:GetCaster():EmitSound("Hero_Lion.ManaDrain")
end

function lion_speed_rain:OnChannelFinish( bInterrupted )

	for modifier,_ in pairs(self.modifiers) do
		if not modifier:IsNull() then
			modifier.forceDestroy = bInterrupted
			modifier:Destroy()
		end
	end

	self.modifiers = {}

	self:GetCaster():StopSound("Hero_Lion.ManaDrain")
end

function lion_speed_rain:Unregister( modifier )
	self.modifiers[modifier] = nil

	local counter = 0

	for modifier,_ in pairs(self.modifiers) do
		if not modifier:IsNull() then
			counter = counter+1
		end
	end

	if counter == 0 and self:IsChanneling() then
		self:EndChannel( false )
	end
end

modifier_lion_speed_rain = class({})

function modifier_lion_speed_rain:IsPurgable() return false end
function modifier_lion_speed_rain:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_lion_speed_rain:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "break_distance" ) + self:GetCaster():GetCastRangeBonus()
	self.interval = self:GetAbility():GetSpecialValueFor( "tick_interval" )

	self.speed_agility = self:GetCaster():GetAgility() / 100 * self:GetAbility():GetSpecialValueFor( "speed_agility" )
	self.speed_agility = self.speed_agility * self.interval

	print(self.speed_agility)

	if IsServer() then
		self:StartIntervalThink( self.interval )
		self:PlayEffects()
	end
end

function modifier_lion_speed_rain:OnDestroy()
	if not IsServer() then return end

	self:GetCaster():StopSound("Hero_Lion.ManaDrain")

	if not self.forceDestroy then
		self:GetAbility():Unregister( self )
	end

	if self:GetParent():IsIllusion() then
		self:GetParent():Kill( self:GetAbility(), self:GetCaster() )
	end
end

function modifier_lion_speed_rain:OnIntervalThink()
	if not IsServer() then return end

	if self:GetParent():IsInvulnerable() or self:GetParent():IsIllusion() then
		self:Destroy()
		return
	end

	if (self:GetParent():GetOrigin()-self:GetCaster():GetOrigin()):Length2D() > self.radius then
		self:Destroy()
		return
	end

	if self.modifier_lion_speed_rain_debuff then
		self.modifier_lion_speed_rain_debuff:SetStackCount(self.modifier_lion_speed_rain_debuff:GetStackCount() + self.speed_agility)
		self.modifier_lion_speed_rain_debuff:ForceRefresh()
	else
		self.modifier_lion_speed_rain_debuff = self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lion_speed_rain_debuff", {duration = self:GetAbility():GetSpecialValueFor("buff_duration")})
		self.modifier_lion_speed_rain_debuff:SetStackCount(self.modifier_lion_speed_rain_debuff:GetStackCount() + self.speed_agility)
	end

	if self.modifier_lion_speed_rain_buff then
		self.modifier_lion_speed_rain_buff:SetStackCount(self.modifier_lion_speed_rain_buff:GetStackCount() + self.speed_agility)
		self.modifier_lion_speed_rain_buff:ForceRefresh()
	else
		self.modifier_lion_speed_rain_buff = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lion_speed_rain_buff", {duration = self:GetAbility():GetSpecialValueFor("buff_duration")})
		self.modifier_lion_speed_rain_buff:SetStackCount(self.modifier_lion_speed_rain_buff:GetStackCount() + self.speed_agility)
	end
end

function modifier_lion_speed_rain:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle( "particles/lion_green_static.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	self:AddParticle( effect_cast, false, false, -1, false, false )
end

modifier_lion_speed_rain_debuff = class({})

function modifier_lion_speed_rain_debuff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_lion_speed_rain_debuff:IsPurgable() return false end

function modifier_lion_speed_rain_debuff:OnCreated()

end

function modifier_lion_speed_rain_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_lion_speed_rain_debuff:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount() * -1
end

modifier_lion_speed_rain_buff = class({})

function modifier_lion_speed_rain_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_lion_speed_rain_buff:IsPurgable() return false end

function modifier_lion_speed_rain_buff:OnCreated()

end

function modifier_lion_speed_rain_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_lion_speed_rain_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount()
end