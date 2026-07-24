--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_transform", "heroes/hero_terrorblade/terrorblade_metamorphosis_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_transform_aura_applier", "heroes/hero_terrorblade/terrorblade_metamorphosis_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis", "heroes/hero_terrorblade/terrorblade_metamorphosis_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_terrorblade_metamorphosis_transform_aura", "heroes/hero_terrorblade/terrorblade_metamorphosis_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_infinite_form_mana_drain", "modifiers/modifier_infinite_form_mana_drain", LUA_MODIFIER_MOTION_NONE)

custom_terrorblade_metamorphosis = class({})

function custom_terrorblade_metamorphosis:OnToggle() 
	local caster = self:GetCaster()

	local mod = self:GetCaster():FindModifierByName("modifier_custom_terrorblade_metamorphosis")

	if mod then 
		mod:Destroy()
	end

	if self:GetToggleState() then
		self:UseMeta(nil)
	end

	self:EndCooldown()
	self:StartCooldown(1) 
end

function custom_terrorblade_metamorphosis:GetCooldown(iLevel)
	if self:GetCaster():HasScepter() then
		return 0
	end
	return self.BaseClass.GetCooldown(self, iLevel) 
end

function custom_terrorblade_metamorphosis:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:UseMeta( duration )
end

function custom_terrorblade_metamorphosis:GetBehavior()
  	if self:GetCaster():HasScepter() then
    	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
   	end
 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE 
end

function custom_terrorblade_metamorphosis:UseMeta(duration)
	if not IsServer() then return end

	-- [MF-16] duration==nil → бесконечная (аганим-toggle) форма → навешиваем общий дрейн 3%/сек.
	if duration == nil then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_infinite_form_mana_drain", {})
	end

	local transform_time = self:GetSpecialValueFor("transformation_time")

	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_custom_terrorblade_metamorphosis_transform", {duration = transform_time, meta_duration = duration})

	for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetSpecialValueFor("metamorph_aura_tooltip"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)) do
		if unit ~= self:GetCaster() and unit:IsIllusion() and unit:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() and unit:GetName() == self:GetCaster():GetName() then
			unit:AddNewModifier(self:GetCaster(), self, "modifier_custom_terrorblade_metamorphosis_transform", {duration = transform_time, meta_duration = nil})
		end
	end
end

modifier_custom_terrorblade_metamorphosis_transform = class({})

function modifier_custom_terrorblade_metamorphosis_transform:IsHidden()	return true end
function modifier_custom_terrorblade_metamorphosis_transform:IsPurgable() return false end

function modifier_custom_terrorblade_metamorphosis_transform:OnCreated(params)
	self.duration	= params.meta_duration
	if not IsServer() then return end
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_3)
	self:GetParent():EmitSound("Hero_Terrorblade.Metamorphosis")
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_custom_terrorblade_metamorphosis_transform_aura_applier", {})
end

function modifier_custom_terrorblade_metamorphosis_transform:OnDestroy()
	if not IsServer() then return end

	if not self:GetParent():IsAlive() then 
		self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform_aura_applier")
	end

	local meta = self:GetParent():FindModifierByName("modifier_custom_terrorblade_metamorphosis")

	if not meta then 
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_custom_terrorblade_metamorphosis", {duration = self.duration})
	else 
		meta:SetDuration(meta:GetRemainingTime() + self.duration, true)
	end
end

function modifier_custom_terrorblade_metamorphosis_transform:CheckState()
	return {[MODIFIER_STATE_STUNNED] = true}
end

modifier_custom_terrorblade_metamorphosis = class({})

function modifier_custom_terrorblade_metamorphosis:IsPurgable() return false end
function modifier_custom_terrorblade_metamorphosis:IsHidden() return false end

function modifier_custom_terrorblade_metamorphosis:OnCreated(table)
	if not self:GetAbility() then self:Destroy() return end
	self.bonus_range 	= self:GetAbility():GetSpecialValueFor("bonus_range")
	self.bonus_damage	= self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.baseattack_time = self:GetAbility():GetSpecialValueFor("base_attack_time")
	if not IsServer() then return end
	self.has_scepter = self:GetParent():HasScepter()
	self.previous_attack_cability = self:GetParent():GetAttackCapability()
	self.original_projectile = self:GetParent():GetRangedProjectileName()
	self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
	-- [#24] У меле-героев в форме нет базового ranged-снаряда → атаки-«тычки» невидимы.
	-- Явно задаём ванильный снаряд меты (как у DK Elder Dragon Form) — он рисуется на
	-- любом скелете. Одного GetModifierProjectileName для меле-моделей недостаточно.
	self:GetParent():SetRangedProjectileName("particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf")
	self:StartIntervalThink(0.5)
end

function modifier_custom_terrorblade_metamorphosis:OnIntervalThink()
	if not IsServer() then return end
	if self.has_scepter then

		if not self:GetCaster():HasScepter() then
			self:Destroy()
			self:GetAbility():ToggleAbility()
			self:GetAbility():EndCooldown()
			self:GetAbility():UseResources(false, false, false, true)
		end
	end
end

function modifier_custom_terrorblade_metamorphosis:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
	self:GetParent():SetAttackCapability(self.previous_attack_cability)
	self:GetParent():SetRangedProjectileName(self.original_projectile or "")
	self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform_aura_applier")
end

function modifier_custom_terrorblade_metamorphosis:CheckState()
	if not self:GetAbility() then self:Destroy() return end
end

function modifier_custom_terrorblade_metamorphosis:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS
	}
end

-- [#24/форма] Меле-герои в форме переведены в ranged (SetAttackCapability), но у них
-- скорость снаряда 0 → ranged-атака не долетает (0 урона, нет снаряда). Даём скорость
-- снаряда, как у DK Elder Dragon Form. Для ranged-героев это просто небольшой бонус.
function modifier_custom_terrorblade_metamorphosis:GetModifierProjectileSpeedBonus()
	return 900
end

function modifier_custom_terrorblade_metamorphosis:GetModelScale() return 10 end

function modifier_custom_terrorblade_metamorphosis:CheckState()
	if not self:GetCaster():HasScepter() then return end
	return {
		[MODIFIER_STATE_FLYING] = true,
		-- [A61] без NO_UNIT_COLLISION летающий блокирует наземного врага (коллизия на земле) → застакивание/ловушка в дуэли
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_custom_terrorblade_metamorphosis:GetModifierModelChange()
	return "models/heroes/terrorblade/demon.vmdl"
end

function modifier_custom_terrorblade_metamorphosis:GetAttackSound()
	return "Hero_Terrorblade_Morphed.Attack"
end

function modifier_custom_terrorblade_metamorphosis:GetModifierProjectileName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf"
end

function modifier_custom_terrorblade_metamorphosis:OnAttackStart(keys)
	if keys.attacker == self:GetParent() then
		self:GetParent():EmitSound("Hero_Terrorblade_Morphed.preAttack")
	end
end

function modifier_custom_terrorblade_metamorphosis:OnAttack(keys)
	if keys.attacker == self:GetParent() then
		self:GetParent():EmitSound("Hero_Terrorblade_Morphed.Attack")
	end
end

function modifier_custom_terrorblade_metamorphosis:GetModifierAttackRangeBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_range")
end

function modifier_custom_terrorblade_metamorphosis:GetModifierBaseAttackTimeConstant()
	return self.baseattack_time
end

function modifier_custom_terrorblade_metamorphosis:GetModifierBaseAttack_BonusDamage()
	return self.bonus_damage
end

modifier_custom_terrorblade_metamorphosis_transform_aura_applier = class({})

function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:IsHidden() return true end

function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:OnCreated()
	self.metamorph_aura_tooltip	= self:GetAbility():GetSpecialValueFor("metamorph_aura_tooltip")
end

function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:IsHidden() return true end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:IsAura() return true end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:IsAuraActiveOnDeath() return false end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraDuration()	return 0.5 end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraRadius() return self.metamorph_aura_tooltip end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetModifierAura()	return "modifier_custom_terrorblade_metamorphosis_transform_aura" end

function modifier_custom_terrorblade_metamorphosis_transform_aura_applier:GetAuraEntityReject(hTarget)
	return hTarget == self:GetParent() or self:GetParent():IsIllusion() or not hTarget:IsIllusion() or hTarget:GetPlayerOwnerID() ~= self:GetCaster():GetPlayerOwnerID() and hTarget:GetName() ~= self:GetParent():GetName()
end

modifier_custom_terrorblade_metamorphosis_transform_aura = class({})

function modifier_custom_terrorblade_metamorphosis_transform_aura:IsHidden() return true end

function modifier_custom_terrorblade_metamorphosis_transform_aura:OnCreated()
	if not self:GetAbility() then self:Destroy() return end
	if not IsServer() then return end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_custom_terrorblade_metamorphosis_transform", {duration = self:GetAbility():GetSpecialValueFor("transformation_time")})
end

function modifier_custom_terrorblade_metamorphosis_transform_aura:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform")
	self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis")
end