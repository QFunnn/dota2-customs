--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_soul_assumption_custom", "heroes/npc_dota_hero_visage_custom/visage_soul_assumption_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_soul_assumption_custom_stacks", "heroes/npc_dota_hero_visage_custom/visage_soul_assumption_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_soul_assumption_custom_counter", "heroes/npc_dota_hero_visage_custom/visage_soul_assumption_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_soul_assumption_custom_resist", "heroes/npc_dota_hero_visage_custom/visage_soul_assumption_custom", LUA_MODIFIER_MOTION_NONE)

visage_soul_assumption_custom = class({})

visage_soul_assumption_custom.modifier_visage_15_targets = {1,2}
visage_soul_assumption_custom.modifier_visage_15_search = 600
visage_soul_assumption_custom.modifier_visage_16_charge = {1,2,3}
visage_soul_assumption_custom.modifier_visage_18 = {3,5}
visage_soul_assumption_custom.modifier_visage_18_duration = 7
visage_soul_assumption_custom.modifier_visage_21 = 3

function visage_soul_assumption_custom:GetIntrinsicModifierName()
	return "modifier_visage_soul_assumption_custom"
end

function visage_soul_assumption_custom:GetStackLimit()
	local stack_limit = self:GetSpecialValueFor("stack_limit")
	if self:GetCaster():HasModifier("modifier_visage_21") then
		stack_limit = stack_limit + self.modifier_visage_21
	end
	return stack_limit
end

function visage_soul_assumption_custom:GetTargetCount()
	local target_count = 1
	if self:GetCaster():HasModifier("modifier_visage_15") then
		target_count = target_count + self.modifier_visage_15_targets[self:GetCaster():GetTalentLevel("modifier_visage_15")]
	end
	return target_count
end

function visage_soul_assumption_custom:GetMinCharge()
	if self:GetCaster():HasModifier("modifier_visage_16") then
		return self.modifier_visage_16_charge[self:GetCaster():GetTalentLevel("modifier_visage_16")]
	end
	return 0
end

function visage_soul_assumption_custom:OnSpellStart()
	local target = self:GetCursorTarget()
	self:GetCaster():EmitSound("Hero_Visage.SoulAssumption.Cast")
	local assumption_counter_modifier = self:GetCaster():FindModifierByNameAndCaster("modifier_visage_soul_assumption_custom_counter", self:GetCaster())
	local damage_bars = 0
	local effect_name = "particles/units/heroes/hero_visage/visage_soul_assumption_bolt.vpcf"
	local overflow_counter = 1
	if assumption_counter_modifier then
		damage_bars = math.floor(assumption_counter_modifier:GetStackCount() / self:GetSpecialValueFor("damage_limit"))
		overflow_counter = math.max(assumption_counter_modifier:GetStackCount() - (self:GetSpecialValueFor("damage_limit") * self:GetStackLimit()), 0)
		local assumption_stack_modifiers = self:GetCaster():FindAllModifiersByName("modifier_visage_soul_assumption_custom_stacks")
		for _, mod in pairs(assumption_stack_modifiers) do
			mod:Destroy()
		end
		assumption_counter_modifier:Destroy()
	end
	damage_bars = math.min(damage_bars + self:GetMinCharge(), self:GetStackLimit())
	if damage_bars > 0 then
		effect_name = "particles/units/heroes/hero_visage/visage_soul_assumption_bolt"..math.min(damage_bars, 6)..".vpcf"
	end
	local projectile =
	{
		Target = nil,
		Source = self:GetCaster(),
		Ability = self,
		EffectName = effect_name,
		iMoveSpeed = self:GetSpecialValueFor("bolt_speed"),
		vSourceLoc = self:GetCaster():GetAbsOrigin(),
		bDrawsOnMinimap = false,
		bDodgeable = true,
		bIsAttack = false,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		flExpireTime = GameRules:GetGameTime() + 10.0,
		bProvidesVision = false,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
		ExtraData = 
        {
			charges = damage_bars
		}
	}

	local targets = { target }
	local target_count = self:GetTargetCount()
	if target_count > 1 and target then
		for _, target_type in pairs({ DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC }) do
			if #targets >= target_count then break end
			local extra_enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self.modifier_visage_15_search, DOTA_UNIT_TARGET_TEAM_ENEMY, target_type, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_CLOSEST, false)
			for _, enemy in pairs(extra_enemies) do
				if enemy ~= target and #targets < target_count then
					table.insert(targets, enemy)
				end
			end
		end
	end
	for _, projectile_target in pairs(targets) do
		projectile.Target = projectile_target
		ProjectileManager:CreateTrackingProjectile(projectile)
	end
end

function visage_soul_assumption_custom:OnProjectileHit_ExtraData(target, location, data)
	if target and not target:TriggerSpellAbsorb(self) then
		target:EmitSound("Hero_Visage.SoulAssumption.Target")
        local soul_base_damage = self:GetSpecialValueFor("soul_base_damage")
        local soul_charge_damage = self:GetSpecialValueFor("soul_charge_damage")
		if self:GetCaster():HasModifier("modifier_visage_18") and data.charges > 0 then
			local resist_reduction = data.charges * self.modifier_visage_18[self:GetCaster():GetTalentLevel("modifier_visage_18")]
            target:RemoveModifierByName("modifier_visage_soul_assumption_custom_resist")
			target:AddNewModifier(self:GetCaster(), self, "modifier_visage_soul_assumption_custom_resist", {duration = self.modifier_visage_18_duration, resist_reduction = resist_reduction})
		end
		ApplyDamage({victim = target, damage = soul_base_damage + (soul_charge_damage * data.charges), damage_type = self:GetAbilityDamageType(), damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self})
	end
end

modifier_visage_soul_assumption_custom = class({})
function modifier_visage_soul_assumption_custom:IsHidden() return self:GetStackCount() <= 0 end
function modifier_visage_soul_assumption_custom:IsPurgable() return false end
function modifier_visage_soul_assumption_custom:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_visage_soul_assumption_custom:UpdateCharges()
	if not IsServer() then return end
	if self:GetParent():HasModifier("modifier_visage_4") then
		self:SetStackCount(0)
		self:UpdateChargesParticle(0)
		return
	end
	local ability = self:GetAbility()
	local damage_limit = ability:GetSpecialValueFor("damage_limit")
	local stack_limit = ability:GetStackLimit()
	local min_charge = ability:GetMinCharge()
	local assumption_counter_modifier = self:GetParent():FindModifierByNameAndCaster("modifier_visage_soul_assumption_custom_counter", self:GetCaster())
	local counter_stacks = assumption_counter_modifier and assumption_counter_modifier:GetStackCount() or 0
	local charges = math.min(math.floor(counter_stacks / damage_limit) + min_charge, stack_limit)
	self:SetStackCount(charges)
	self:UpdateChargesParticle(charges)
end

function modifier_visage_soul_assumption_custom:UpdateChargesParticle(charges)
	if not IsServer() or not self.particle then return end
	for control_point = 1, self:GetAbility():GetStackLimit() do
		if control_point <= charges then
			ParticleManager:SetParticleControl(self.particle, control_point, Vector(1, 0, 0))
		else
			ParticleManager:SetParticleControl(self.particle, control_point, Vector(0, 0, 0))
		end
	end
end

function modifier_visage_soul_assumption_custom:OnCreated()
	if not IsServer() then return end
	if self:GetParent():HasModifier("modifier_visage_4") then return end
	if self:GetAbility() and self:GetAbility():GetLevel() >= 1 and not self.particle then
        local pfx_name = "particles/units/heroes/hero_visage/visage_soul_overhead.vpcf"
        if self:GetCaster():HasModifier("modifier_visage_21") then
            pfx_name = "particles/units/heroes/hero_visage/visage_soul_overhead_custom.vpcf"
        end
		self.particle = ParticleManager:CreateParticle(pfx_name, PATTACH_OVERHEAD_FOLLOW, self:GetParent())
		self:AddParticle(self.particle, false, false, -1, false, false)
	end
end

function modifier_visage_soul_assumption_custom:UpdateFastPfx()
    if self:GetParent():HasModifier("modifier_visage_4") then return end
    if self.particle then
        ParticleManager:DestroyParticle(self.particle, true)
        ParticleManager:ReleaseParticleIndex(self.particle)
        self.particle = nil
    end
    if self:GetAbility() and self:GetAbility():GetLevel() >= 1 and not self.particle then
        local pfx_name = "particles/units/heroes/hero_visage/visage_soul_overhead.vpcf"
        if self:GetCaster():HasModifier("modifier_visage_21") then
            pfx_name = "particles/units/heroes/hero_visage/visage_soul_overhead_custom.vpcf"
        end
		self.particle = ParticleManager:CreateParticle(pfx_name, PATTACH_OVERHEAD_FOLLOW, self:GetParent())
		self:AddParticle(self.particle, false, false, -1, false, false)
        self:UpdateCharges()
	end
end

function modifier_visage_soul_assumption_custom:DisableForTalent4()
	if not IsServer() then return end
	if self.particle then
		ParticleManager:DestroyParticle(self.particle, true)
		ParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end
	local assumption_stack_modifiers = self:GetParent():FindAllModifiersByName("modifier_visage_soul_assumption_custom_stacks")
	for _, mod in pairs(assumption_stack_modifiers) do
		mod:Destroy()
	end
	local assumption_counter_modifier = self:GetParent():FindModifierByNameAndCaster("modifier_visage_soul_assumption_custom_counter", self:GetCaster())
	if assumption_counter_modifier then
		assumption_counter_modifier:Destroy()
	end
	self:SetStackCount(0)
end

function modifier_visage_soul_assumption_custom:OnDestroy()
	if IsServer() and self.particle then
		ParticleManager:DestroyParticle(self.particle, true)
		ParticleManager:ReleaseParticleIndex(self.particle)
	end
end

function modifier_visage_soul_assumption_custom:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_visage_soul_assumption_custom:OnTakeDamage(keys)
	if self:GetParent():HasModifier("modifier_visage_4") then return end
	if (keys.unit:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D() <= self:GetAbility():GetSpecialValueFor("radius") and 
    (keys.attacker:IsControllableByAnyPlayer()) 
    and (keys.unit:IsRealHero() or self:GetParent():HasModifier("modifier_visage_16")) 
    and keys.unit ~= keys.attacker 
    and keys.original_damage >= self:GetAbility():GetSpecialValueFor("damage_min") 
    and keys.original_damage <= self:GetAbility():GetSpecialValueFor("damage_max") 
    and keys.inflictor ~= self:GetAbility() then	
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_visage_soul_assumption_custom_counter", {duration	= self:GetAbility():GetSpecialValueFor("stack_duration"), stacks = keys.original_damage})
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_visage_soul_assumption_custom_stacks", {duration = self:GetAbility():GetSpecialValueFor("stack_duration"), stacks = keys.original_damage})
	end
end

modifier_visage_soul_assumption_custom_stacks = class({})
function modifier_visage_soul_assumption_custom_stacks:IsHidden() return true end
function modifier_visage_soul_assumption_custom_stacks:IsPurgable() return false end
function modifier_visage_soul_assumption_custom_stacks:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_visage_soul_assumption_custom_stacks:OnCreated(params)
	if not IsServer() then return end
	self.damage_limit = self:GetAbility():GetSpecialValueFor("damage_limit")
	self.stack_limit = self:GetAbility():GetStackLimit()
	self:SetStackCount(params.stacks)
	local assumption_modifier = self:GetParent():FindModifierByNameAndCaster("modifier_visage_soul_assumption_custom", self:GetCaster())
	local assumption_counter_modifier = self:GetParent():FindModifierByNameAndCaster("modifier_visage_soul_assumption_custom_counter", self:GetCaster())
	if assumption_modifier and assumption_counter_modifier then
		assumption_counter_modifier:SetStackCount(assumption_counter_modifier:GetStackCount() + params.stacks)
		assumption_modifier:UpdateCharges()
	end
end

function modifier_visage_soul_assumption_custom_stacks:OnDestroy()
	if not IsServer() then return end
	local assumption_modifier = self:GetParent():FindModifierByNameAndCaster("modifier_visage_soul_assumption_custom", self:GetCaster())
	local assumption_counter_modifier = self:GetParent():FindModifierByNameAndCaster("modifier_visage_soul_assumption_custom_counter", self:GetCaster())
	if assumption_counter_modifier then
		assumption_counter_modifier:SetStackCount(assumption_counter_modifier:GetStackCount() - self:GetStackCount())
		if assumption_modifier then
			assumption_modifier:UpdateCharges()
		end
	end
end

modifier_visage_soul_assumption_custom_counter = class({})
function modifier_visage_soul_assumption_custom_counter:IsHidden() return true end
function modifier_visage_soul_assumption_custom_counter:IsPurgable() return false end

modifier_visage_soul_assumption_custom_resist = class({})
function modifier_visage_soul_assumption_custom_resist:IsHidden() return false end
function modifier_visage_soul_assumption_custom_resist:IsDebuff() return true end
function modifier_visage_soul_assumption_custom_resist:GetTexture() return "visage_18" end

function modifier_visage_soul_assumption_custom_resist:OnCreated(params)
    if not IsServer() then return end
    self.resist_reduction = params.resist_reduction
    self:SetHasCustomTransmitterData(true)
end

function modifier_visage_soul_assumption_custom_resist:OnRefresh(params)
    if not IsServer() then return end
    self.resist_reduction = math.max(params.resist_reduction, params.resist_reduction)
    self:SendBuffRefreshToClients()
end

function modifier_visage_soul_assumption_custom_resist:AddCustomTransmitterData() 
	return 
	{
		resist_reduction = self.resist_reduction,
	} 
end

function modifier_visage_soul_assumption_custom_resist:HandleCustomTransmitterData(data)
	self.resist_reduction  = data.resist_reduction
end

function modifier_visage_soul_assumption_custom_resist:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_visage_soul_assumption_custom_resist:GetModifierMagicalResistanceBonus()
	return -self.resist_reduction
end