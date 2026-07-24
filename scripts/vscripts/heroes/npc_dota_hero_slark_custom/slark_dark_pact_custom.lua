--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_slark_dark_pact_custom", "heroes/npc_dota_hero_slark_custom/slark_dark_pact_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_dark_pact_custom_talent_handler", "heroes/npc_dota_hero_slark_custom/slark_dark_pact_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_dark_pact_custom_buff", "heroes/npc_dota_hero_slark_custom/slark_dark_pact_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_dark_pact_custom_stack_buff", "heroes/npc_dota_hero_slark_custom/slark_dark_pact_custom", LUA_MODIFIER_MOTION_NONE )

slark_dark_pact_custom = class({})

function slark_dark_pact_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_dark_pact_start.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_dark_pact_pulses.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/razor/razor_arcana/razor_arcana_static_link_buff.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_slark.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_slark.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_slark.vpcf", context)
end

slark_dark_pact_custom.modifier_slark_2_dmg = 50
slark_dark_pact_custom.modifier_slark_2_duration = {10,15,20}
slark_dark_pact_custom.modifier_slark_5 = {50,100,150}
slark_dark_pact_custom.modifier_slark_5_heal = {0.5,1,1.5}
slark_dark_pact_custom.modifier_slark_6 = 50
slark_dark_pact_custom.modifier_slark_6_str_damage = {30,60,90}
slark_dark_pact_custom.modifier_slark_7 = 0.6

function slark_dark_pact_custom:GetIntrinsicModifierName()
	return "modifier_slark_dark_pact_custom_talent_handler"
end

function slark_dark_pact_custom:GetManaCost(level)
	if self:GetCaster():HasModifier("modifier_slark_1") then
		return self.BaseClass.GetManaCost(self, level) * 0.5
	end
	if self:GetCaster():HasModifier("modifier_slark_21") then
		return 0
	end
    return self.BaseClass.GetManaCost(self, level)
end

function slark_dark_pact_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_slark_21") then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function slark_dark_pact_custom:GetCooldown(level)
	if self:GetCaster():HasModifier("modifier_slark_21") then
	   	return 0
	end
	return self.BaseClass.GetCooldown( self, level )
end

function slark_dark_pact_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_slark_21") then
	   	return "slark_21"
	end
	return "slark_dark_pact"
end

function slark_dark_pact_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_slark_dark_pact_custom", {} )
end

modifier_slark_dark_pact_custom = class({})

function modifier_slark_dark_pact_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_slark_dark_pact_custom:IsHidden()
	return true
end

function modifier_slark_dark_pact_custom:IsDebuff()
	return false
end

function modifier_slark_dark_pact_custom:IsPurgable()
	return false
end

function modifier_slark_dark_pact_custom:DestroyOnExpire()
	return false
end

function modifier_slark_dark_pact_custom:OnCreated( kv )
	self.delay_time = self:GetAbility():GetSpecialValueFor( "delay" )
	self.pulse_duration = self:GetAbility():GetSpecialValueFor( "pulse_duration" )
	self.total_pulses = self:GetAbility():GetSpecialValueFor( "total_pulses" )
	self.total_damage = self:GetAbility():GetSpecialValueFor( "total_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	if self:GetCaster():HasModifier("modifier_slark_5") then
		self.radius = self.radius + self:GetAbility().modifier_slark_5[self:GetCaster():GetTalentLevel("modifier_slark_5")]
        local heal = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_slark_5_heal[self:GetCaster():GetTalentLevel("modifier_slark_5")]
        self:GetCaster():Heal(heal, self:GetAbility())
	end
	if self:GetCaster():HasModifier("modifier_slark_6") then
		self.total_damage = self.total_damage + self:GetAbility().modifier_slark_6 + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_slark_6_str_damage[self:GetCaster():GetTalentLevel("modifier_slark_6")])
	end
	self.pulse_interval = self:GetAbility():GetSpecialValueFor("pulse_interval")
	self.self_damage_pct = self:GetAbility():GetSpecialValueFor("self_damage_pct")
	self.delay = true
	self.count = 0
	self.damage = self.total_damage/self.total_pulses
	if not IsServer() then return end
	self.attack_target = {}
	self.damageTable = 
	{
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	}

	self:StartIntervalThink( self.delay_time )
	self:PlayEffects1()
end

function modifier_slark_dark_pact_custom:OnRefresh( kv )
	self.delay_time = self:GetAbility():GetSpecialValueFor( "delay" )
	self.pulse_duration = self:GetAbility():GetSpecialValueFor( "pulse_duration" )
	self.total_pulses = self:GetAbility():GetSpecialValueFor( "total_pulses" )
	self.total_damage = self:GetAbility():GetSpecialValueFor( "total_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.delay = true
	self.count = 0
	self.damage = self.total_damage/self.total_pulses
	if not IsServer() then return end
	self.attack_target = {}
	self.damageTable = 
	{
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	}

	self:StartIntervalThink( self.delay_time )
	self:PlayEffects1()
end

function modifier_slark_dark_pact_custom:OnIntervalThink()
	if not IsServer() then return end
	if self.delay then
		if self:GetParent() == self:GetCaster() then
			self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_1)
		end
		self.delay = false
		self:StartIntervalThink( self.pulse_interval )
		self:PlayEffects2()
		if self:GetParent() == self:GetCaster() then
			if self:GetCaster():HasModifier("modifier_slark_2") then
				self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_dark_pact_custom_stack_buff", {duration = self:GetAbility().modifier_slark_2_duration[self:GetCaster():GetTalentLevel("modifier_slark_2")]})
				self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_dark_pact_custom_buff", {duration = self:GetAbility().modifier_slark_2_duration[self:GetCaster():GetTalentLevel("modifier_slark_2")]})
			end
			if self:GetCaster():HasModifier("modifier_slark_7") then
				local slark_shadow_dance_custom = self:GetCaster():FindAbilityByName("slark_shadow_dance_custom")
				if slark_shadow_dance_custom then
					slark_shadow_dance_custom:OnSpellStart(self:GetAbility().modifier_slark_7)
				end
			end
		end
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if self:GetCaster():HasModifier("modifier_slark_4") then
			for _,enemy in pairs(enemies) do
				if self.attack_target[enemy:entindex()] == nil then
					self:GetCaster():PerformAttack(enemy, true, true, true, false, false, false, true)
					self.attack_target[enemy:entindex()] = true
				end
			end
		end
	else
		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		self.damageTable.damage = self.damage
		self.damageTable.damage_flags = 0

		for _,enemy in pairs(enemies) do
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )
		end
		if self:GetParent() == self:GetCaster() then
			self:GetParent():Purge( false, true, false, true, true )
		end
		self.damageTable.damage = self.damage / 100 * self.self_damage_pct
		self.damageTable.damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL
		self.damageTable.victim = self:GetParent()
		if not self:GetCaster():HasModifier("modifier_slark_15") then
			if self:GetParent() == self:GetCaster() then
				ApplyDamage( self.damageTable )
			end
		end

		self.count = self.count + 1

		if self.count >= self.total_pulses then
			self:StartIntervalThink( -1 )
			self:Destroy()
		end
	end
end

function modifier_slark_dark_pact_custom:PlayEffects1()
	local effect_cast = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_slark/slark_dark_pact_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent(), self:GetParent():GetTeamNumber() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitoc", self:GetParent():GetOrigin(), true)
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationForAllies( self:GetParent():GetOrigin(), "Hero_Slark.DarkPact.PreCast", self:GetParent() )
end

function modifier_slark_dark_pact_custom:PlayEffects2()
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_slark/slark_dark_pact_pulses.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetParent():EmitSound("Hero_Slark.DarkPact.Cast")
end

modifier_slark_dark_pact_custom_stack_buff = class({})
function modifier_slark_dark_pact_custom_stack_buff:IsHidden() return true end
function modifier_slark_dark_pact_custom_stack_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

modifier_slark_dark_pact_custom_buff = class({})

function modifier_slark_dark_pact_custom_buff:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    self:StartIntervalThink(FrameTime())
end

function modifier_slark_dark_pact_custom_buff:OnIntervalThink()
    if not IsServer() then return end
    local stack = self:GetParent():FindAllModifiersByName("modifier_slark_dark_pact_custom_stack_buff")
    self:SetStackCount(#stack)
end

function modifier_slark_dark_pact_custom_buff:GetEffectName()
    return "particles/econ/items/razor/razor_arcana/razor_arcana_static_link_buff.vpcf"
end

function modifier_slark_dark_pact_custom_buff:GetTexture() return "slark_2" end

function modifier_slark_dark_pact_custom_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_slark_dark_pact_custom_buff:GetModifierPreAttack_BonusDamage()
    return self:GetStackCount() * self:GetAbility().modifier_slark_2_dmg
end

modifier_slark_dark_pact_custom_talent_handler = class({})

function modifier_slark_dark_pact_custom_talent_handler:IsHidden() return true end
function modifier_slark_dark_pact_custom_talent_handler:IsPurgable() return false end
function modifier_slark_dark_pact_custom_talent_handler:IsPurgeException() return false end

function modifier_slark_dark_pact_custom_talent_handler:DeclareFunctions()
	return
	{
		 
	}
end

function modifier_slark_dark_pact_custom_talent_handler:OnAbilityFullyCast( params )
	if params.unit~=self:GetCaster() then return end
	if params.ability==self:GetAbility() then return end
	if not params.target then return end
	if not self:GetCaster():HasModifier("modifier_slark_21") then return end
	if params.ability:GetAbilityName() == "item_moon_shard" then return end
	if self:FlagExist( params.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ) then
		local target = params.target
		target:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_slark_dark_pact_custom", {} )
	end
end

function modifier_slark_dark_pact_custom_talent_handler:FlagExist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end