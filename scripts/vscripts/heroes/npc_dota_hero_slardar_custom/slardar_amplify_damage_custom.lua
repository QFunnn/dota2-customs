--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_slardar_amplify_damage_custom", "heroes/npc_dota_hero_slardar_custom/slardar_amplify_damage_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slardar_slithereen_crush_custom_puddle", "heroes/npc_dota_hero_slardar_custom/slardar_slithereen_crush_custom", LUA_MODIFIER_MOTION_NONE )

slardar_amplify_damage_custom = class({})

function slardar_amplify_damage_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_slardar.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_slardar.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_slardar.vpcf", context)
end

slardar_amplify_damage_custom.modifier_slardar_5 = -8
slardar_amplify_damage_custom.modifier_slardar_18 = {-10,-20,-30}
slardar_amplify_damage_custom.modifier_slardar_21 = 50

function slardar_amplify_damage_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	local duration = self:GetSpecialValueFor("duration")
	target:AddNewModifier( self:GetCaster(), self, "modifier_slardar_amplify_damage_custom", { duration = duration * (1 - target:GetStatusResistance()) } )
	target:EmitSound("Hero_Slardar.Amplify_Damage")
end

function slardar_amplify_damage_custom:CustomActive(target, duration)
	if not IsServer() then return end
    local modifier_slardar_amplify_damage_custom = target:FindModifierByName("modifier_slardar_amplify_damage_custom")
    if modifier_slardar_amplify_damage_custom and modifier_slardar_amplify_damage_custom:GetRemainingTime() > (duration * (1-target:GetStatusResistance())) then return end
	target:AddNewModifier( self:GetCaster(), self, "modifier_slardar_amplify_damage_custom", { duration = duration * (1 - target:GetStatusResistance()) } )
	target:EmitSound("Hero_Slardar.Amplify_Damage")
end

modifier_slardar_amplify_damage_custom = class({})

function modifier_slardar_amplify_damage_custom:IsPurgable()
	return not self:GetCaster():HasModifier("modifier_slardar_18")
end

function modifier_slardar_amplify_damage_custom:OnCreated( kv )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
	if self:GetCaster():HasModifier("modifier_slardar_5") then
		self.armor_reduction = self.armor_reduction + self:GetAbility().modifier_slardar_5
	end
	if not IsServer() then return end
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent() ,PATTACH_OVERHEAD_FOLLOW, nil, self:GetParent():GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_OVERHEAD_FOLLOW, nil, self:GetParent():GetOrigin(), true)
	ParticleManager:SetParticleControlEnt(particle, 2, self:GetParent(), PATTACH_OVERHEAD_FOLLOW, nil, self:GetParent():GetOrigin(), true)
	self:AddParticle( particle, false, false, -1, false, true)
	self.puddle_timer = 0
	self:StartIntervalThink(FrameTime())
end

function modifier_slardar_amplify_damage_custom:OnRefresh( kv )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
	if self:GetCaster():HasModifier("modifier_slardar_5") then
		self.armor_reduction = self.armor_reduction + self:GetAbility().modifier_slardar_5
	end
end

function modifier_slardar_amplify_damage_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
	return funcs
end

function modifier_slardar_amplify_damage_custom:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end

function modifier_slardar_amplify_damage_custom:GetModifierIncomingDamage_Percentage(params)
	if self:GetCaster():HasModifier("modifier_slardar_21") then
		if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL or params.inflictor ~= nil then
			return self:GetAbility().modifier_slardar_21
		end
	end
	return 0
end

function modifier_slardar_amplify_damage_custom:GetModifierPropertyRestorationAmplification()
	if self:GetCaster():HasModifier("modifier_slardar_18") then
		return self:GetAbility().modifier_slardar_18[self:GetCaster():GetTalentLevel("modifier_slardar_18")]
	end
	return 0
end

function modifier_slardar_amplify_damage_custom:OnIntervalThink( kv )
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_truesight", {duration = FrameTime()+FrameTime()})
    AddFOWViewer(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), 50, FrameTime()+FrameTime(), false)
    self.puddle_timer = self.puddle_timer + FrameTime()
    if self.puddle_timer >= 0.5 then

    	self.puddle_timer = 0

    	local thinker_near = nil

    	local hThinkersNearby = Entities:FindAllByClassnameWithin( "npc_dota_thinker", self:GetParent():GetAbsOrigin(), 50 )

		for _, hThinker in pairs( hThinkersNearby ) do
			if ( hThinker:HasModifier( "modifier_slardar_slithereen_crush_custom_puddle" ) ) then
				thinker_near = hThinker
			end
		end

		local puddle_duration = self:GetAbility():GetSpecialValueFor("puddle_duration")

		if thinker_near == nil then
			CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_slardar_slithereen_crush_custom_puddle", {duration = puddle_duration, ultimate = 1}, self:GetParent():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
			CreateModifierThinker(self:GetCaster(), self:GetAbility(), "modifier_slardar_slithereen_crush_custom_puddle_buff_aura", {duration = puddle_duration, ultimate = 1}, self:GetParent():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
		else
			local modifier_slardar_slithereen_crush_custom_puddle = thinker_near:FindModifierByName("modifier_slardar_slithereen_crush_custom_puddle")
			if modifier_slardar_slithereen_crush_custom_puddle then
				modifier_slardar_slithereen_crush_custom_puddle:SetDuration(puddle_duration, true)
			end
		end
    end
end