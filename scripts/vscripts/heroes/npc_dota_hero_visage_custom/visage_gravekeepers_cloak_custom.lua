--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_gravekeepers_cloak_custom", "heroes/npc_dota_hero_visage_custom/visage_gravekeepers_cloak_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_gravekeepers_cloak_custom_precast", "heroes/npc_dota_hero_visage_custom/visage_gravekeepers_cloak_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_gravekeepers_cloak_custom_buff", "heroes/npc_dota_hero_visage_custom/visage_gravekeepers_cloak_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_gravekeepers_cloak_custom_secondary", "heroes/npc_dota_hero_visage_custom/visage_gravekeepers_cloak_custom", LUA_MODIFIER_MOTION_NONE)

visage_gravekeepers_cloak_custom = class({})

visage_gravekeepers_cloak_custom.modifier_visage_2 = {1,1.5,2}
visage_gravekeepers_cloak_custom.modifier_visage_2_radius = 600
visage_gravekeepers_cloak_custom.modifier_visage_4_recovery = {-1,-1.5}
visage_gravekeepers_cloak_custom.modifier_visage_7_cooldown = 40
visage_gravekeepers_cloak_custom.modifier_visage_7_radius = 375
visage_gravekeepers_cloak_custom.modifier_visage_7_damage_pct = 15
visage_gravekeepers_cloak_custom.modifier_visage_7_stun = 2
visage_gravekeepers_cloak_custom.modifier_visage_7_invuln = 2
visage_gravekeepers_cloak_custom.modifier_visage_7_heal_pct = 15

function visage_gravekeepers_cloak_custom:GetIntrinsicModifierName()
    if not self:GetCaster():IsHero() then return end
	return "modifier_visage_gravekeepers_cloak_custom"
end

function visage_gravekeepers_cloak_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_visage_7") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
    end
    return self.BaseClass.GetBehavior(self)
end

function visage_gravekeepers_cloak_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_visage_7") then
        return self.modifier_visage_7_cooldown
    end
    return 0
end

function visage_gravekeepers_cloak_custom:GetRecoveryTime()
    local recovery = self:GetSpecialValueFor("recovery_time")
    if self:GetCaster():HasModifier("modifier_visage_4") then
        recovery = recovery + self.modifier_visage_4_recovery[self:GetCaster():GetTalentLevel("modifier_visage_4")]
    end
    return math.max(recovery, 0.1)
end

function visage_gravekeepers_cloak_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
    caster:AddNewModifier(caster, self, "modifier_visage_gravekeepers_cloak_custom_precast", {duration = 0.55})
end

modifier_visage_gravekeepers_cloak_custom = class({})
function modifier_visage_gravekeepers_cloak_custom:IsAura() return true end
function modifier_visage_gravekeepers_cloak_custom:IsAuraActiveOnDeath() return false end
function modifier_visage_gravekeepers_cloak_custom:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end
function modifier_visage_gravekeepers_cloak_custom:GetAuraSearchFlags()	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED end
function modifier_visage_gravekeepers_cloak_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_visage_gravekeepers_cloak_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_visage_gravekeepers_cloak_custom:GetModifierAura() return "modifier_visage_gravekeepers_cloak_custom_secondary" end
function modifier_visage_gravekeepers_cloak_custom:GetAuraEntityReject(hTarget)	return self:GetCaster():PassivesDisabled() or not hTarget:GetOwner() or not hTarget:GetOwner() == self:GetCaster() or not string.find(hTarget:GetUnitName(), "npc_dota_visage_familiar") end

function modifier_visage_gravekeepers_cloak_custom:OnCreated()
	if not IsServer() then return end
	self.recovery_timers = {}
	self.pulse_timer = self:GetAbility():GetRecoveryTime()
	self.last_think = GameRules:GetGameTime()
	self.cloak_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_cloak_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    local layer_radius = 0
	for layer = 2, 5 do
		ParticleManager:SetParticleControl(self.cloak_particle, layer, Vector(1, layer_radius, 0))
        layer_radius = layer_radius + 1
	end
    self:SetStackCount(self:GetAbility():GetSpecialValueFor("max_layers"))
	self:AddParticle(self.cloak_particle, false, false, -1, false, false)
	self:StartIntervalThink(0.1)
end

function modifier_visage_gravekeepers_cloak_custom:UpdateCloakParticle()
	if not IsServer() or not self.cloak_particle then return end
	local stacks = self:GetStackCount()
	local layer_radius = 0
	for layer = 2, 5 do
		if stacks + 1 >= layer then
			ParticleManager:SetParticleControl(self.cloak_particle, layer, Vector(1, layer_radius, 0))
		else
			ParticleManager:SetParticleControl(self.cloak_particle, layer, Vector(0, layer_radius, 0))
		end
		layer_radius = layer_radius + 1
	end
end

function modifier_visage_gravekeepers_cloak_custom:DoVisage2Pulse()
	local ability = self:GetAbility()
	local parent = self:GetParent()
    if not parent:IsAlive() then return end
    if parent:HasModifier("modifier_wodawisp") then return end
    if parent:HasModifier("modifier_wodarelax") then return end
    if parent:HasModifier("modifier_disconnect_player_no_damage") then return end
	local damage = parent:GetMaxHealth() * ability.modifier_visage_2[parent:GetTalentLevel("modifier_visage_2")] * 0.01
	local radius_cast = parent:GetAoeBonus(ability.modifier_visage_2_radius)
	local enemies = FindUnitsInRadius(parent:GetTeamNumber(), parent:GetAbsOrigin(), nil, radius_cast, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	for _, enemy in pairs(enemies) do
		ApplyDamage({victim = enemy, attacker = parent, damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = ability, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK})
	end
	local particle = ParticleManager:CreateParticle("particles/visage_vacuum/visage_vacuum.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius_cast, radius_cast, radius_cast))
	ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_visage_gravekeepers_cloak_custom:RefreshAllStacks()
	if not IsServer() then return end
	local max_layers = self:GetAbility():GetSpecialValueFor("max_layers")
	local recovered = max_layers - self:GetStackCount()
	self.recovery_timers = {}
	self:SetStackCount(max_layers)
	self:UpdateCloakParticle()
	if recovered > 0 and self:GetParent():HasModifier("modifier_visage_2") then
		for i = 1, recovered do
			self:DoVisage2Pulse()
		end
		self.pulse_timer = self:GetAbility():GetRecoveryTime()
	end
end

function modifier_visage_gravekeepers_cloak_custom:OnIntervalThink()
	if not IsServer() then return end
	local now = GameRules:GetGameTime()
	local dt = now - self.last_think
	self.last_think = now
	if self:GetParent():PassivesDisabled() then return end
	local max_layers = self:GetAbility():GetSpecialValueFor("max_layers")
	local has_visage_2 = self:GetParent():HasModifier("modifier_visage_2")
	local recovered = 0
	for i = #self.recovery_timers, 1, -1 do
		self.recovery_timers[i] = self.recovery_timers[i] - dt
		if self.recovery_timers[i] <= 0 then
			table.remove(self.recovery_timers, i)
			recovered = recovered + 1
		end
	end
	if recovered > 0 then
		self:SetStackCount(math.min(self:GetStackCount() + recovered, max_layers))
		self:UpdateCloakParticle()
		if has_visage_2 then
			for i = 1, recovered do
				self:DoVisage2Pulse()
			end
			self.pulse_timer = self:GetAbility():GetRecoveryTime()
		end
	end
	if has_visage_2 then
		self.pulse_timer = self.pulse_timer - dt
		if self.pulse_timer <= 0 then
			self.pulse_timer = self:GetAbility():GetRecoveryTime()
			self:DoVisage2Pulse()
		end
	end
end

function modifier_visage_gravekeepers_cloak_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
end

function modifier_visage_gravekeepers_cloak_custom:GetModifierTotal_ConstantBlock(keys)
	if keys.attacker:IsControllableByAnyPlayer() and keys.attacker ~= self:GetParent() and keys.damage > self:GetAbility():GetSpecialValueFor("minimum_damage") and self:GetStackCount() > 0 then
		self:DecrementStackCount()
		if IsServer() then
			table.insert(self.recovery_timers, self:GetAbility():GetRecoveryTime())
		end
		self:UpdateCloakParticle()
        if not self:GetParent():PassivesDisabled() then
		    local reduction = math.min(self:GetAbility():GetSpecialValueFor("damage_reduction") * (self:GetStackCount() + 1), self:GetAbility():GetSpecialValueFor("max_damage_reduction"))
		    return keys.damage * reduction * 0.01
        end
	end
    return 0
end

modifier_visage_gravekeepers_cloak_custom_secondary = class({})

function modifier_visage_gravekeepers_cloak_custom_secondary:OnCreated()
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	self.max_damage_reduction = self:GetAbility():GetSpecialValueFor("max_damage_reduction")
	if not IsServer() then return end
	self.cloak_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_cloak_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	self:AddParticle(self.cloak_particle, false, false, -1, false, false)
	self.last_layers = -1
	self:UpdateCloakParticle()
	self:StartIntervalThink(0.2)
end

function modifier_visage_gravekeepers_cloak_custom_secondary:OnIntervalThink()
	self:UpdateCloakParticle()
end

function modifier_visage_gravekeepers_cloak_custom_secondary:UpdateCloakParticle()
	if not IsServer() or not self.cloak_particle then return end
	local layers = self:GetCaster():GetModifierStackCount("modifier_visage_gravekeepers_cloak_custom", self:GetCaster())
	if layers == self.last_layers then return end
	self.last_layers = layers
    local layer_radius = 0
	for layer = 2, 5 do
		if layers + 1 >= layer then
			ParticleManager:SetParticleControl(self.cloak_particle, layer, Vector(1, layer_radius, 0))
		else
			ParticleManager:SetParticleControl(self.cloak_particle, layer, Vector(0, layer_radius, 0))
		end
        layer_radius = layer_radius + 1
	end
end

function modifier_visage_gravekeepers_cloak_custom_secondary:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
end

function modifier_visage_gravekeepers_cloak_custom_secondary:GetModifierTotal_ConstantBlock(keys)
	local reduction = math.min(self:GetCaster():GetModifierStackCount("modifier_visage_gravekeepers_cloak_custom", self:GetCaster()) * self.damage_reduction, self.max_damage_reduction)
	return keys.damage * reduction * 0.01
end

modifier_visage_gravekeepers_cloak_custom_buff = class({})
function modifier_visage_gravekeepers_cloak_custom_buff:IsPurgable() return false end
function modifier_visage_gravekeepers_cloak_custom_buff:OnCreated()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local damage = caster:GetMaxHealth() * self:GetAbility().modifier_visage_7_damage_pct * 0.01
    local enemies = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, self:GetParent():GetAoeBonus(self:GetAbility().modifier_visage_7_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _, enemy in pairs(enemies) do
        enemy:AddNewModifier(caster, self:GetAbility(), "modifier_stunned", {duration = self:GetAbility().modifier_visage_7_stun * (1 - enemy:GetStatusResistance())})
        ApplyDamage({victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
    end
    caster:Heal(caster:GetMaxHealth() * self:GetAbility().modifier_visage_7_heal_pct * 0.01, self)
    local modifier_cloak = caster:FindModifierByName("modifier_visage_gravekeepers_cloak_custom")
    if modifier_cloak then
        modifier_cloak:RefreshAllStacks()
    end
end

function modifier_visage_gravekeepers_cloak_custom_buff:OnDestroy()
    if not IsServer() then return end
    self:GetParent():FadeGesture(ACT_DOTA_CAST_ABILITY_1)
end

function modifier_visage_gravekeepers_cloak_custom_buff:GetEffectName()
	return "particles/units/heroes/hero_visage/visage_stone_form.vpcf"
end

function modifier_visage_gravekeepers_cloak_custom_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_visage_gravekeepers_cloak_custom_buff:GetStatusEffectName() 
	return "particles/status_fx/status_effect_earth_spirit_petrify.vpcf"
end

function modifier_visage_gravekeepers_cloak_custom_buff:StatusEffectPriority()
    return 10
end

function modifier_visage_gravekeepers_cloak_custom_buff:CheckState()
	return
	{
		[MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_STUNNED] = IsServer(),
	}
end

modifier_visage_gravekeepers_cloak_custom_precast = class({})
function modifier_visage_gravekeepers_cloak_custom_precast:IsPurgable() return false end
function modifier_visage_gravekeepers_cloak_custom_precast:OnRemoved()
	if not IsServer() or not self:GetAbility() or self:GetRemainingTime() > 0 then return end
    self:GetParent():EmitSound("Visage_Familar.StoneForm.Cast")
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_visage_gravekeepers_cloak_custom_buff", {duration = self:GetAbility().modifier_visage_7_invuln})
end
function modifier_visage_gravekeepers_cloak_custom_precast:CheckState()
	return
    {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end