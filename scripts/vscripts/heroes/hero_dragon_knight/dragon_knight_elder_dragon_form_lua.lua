--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dragon_knight_elder_dragon_form_lua_form", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_elder_dragon_form_lua_green", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_elder_dragon_form_lua_red", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_elder_dragon_form_lua_blue", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_elder_dragon_form_lua_corrosive", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_elder_dragon_form_lua_frost", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_elder_dragon_form_lua", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dragon_knight_elder_dragon_form_lua_scepter", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form_lua.lua", LUA_MODIFIER_MOTION_NONE)

--Abilities
if dragon_knight_elder_dragon_form_lua == nil then
	dragon_knight_elder_dragon_form_lua = class({})
end
function dragon_knight_elder_dragon_form_lua:GetIntrinsicModifierName()
	local hCaster = self:GetCaster()

	if hCaster:IsRealHero() and not hCaster:IsTempestDouble() then
		return "modifier_dragon_knight_elder_dragon_form_lua"
	end
end
function dragon_knight_elder_dragon_form_lua:Corrosive(hTarget)
	local hCaster = self:GetCaster()
	local iLevel = self:GetLevel()
	if hCaster:HasScepter() then
		iLevel = iLevel + 1
	end

	if UnitFilter(hTarget, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, hCaster:GetTeamNumber()) ~= UF_SUCCESS then
		return
	end

	local corrosive_breath_duration = self:GetSpecialValueFor("corrosive_breath_duration")

	hTarget:AddNewModifier(hCaster, self, "modifier_dragon_knight_elder_dragon_form_lua_corrosive", { duration = corrosive_breath_duration })
end
function dragon_knight_elder_dragon_form_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local iLevel = self:GetLevel()
	-- if hCaster:HasScepter() then
	--	 iLevel = iLevel + 1
	-- end
	local duration = self:GetLevelSpecialValueFor("duration", iLevel - 1)

	hCaster:RemoveModifierByName("modifier_dragon_knight_elder_dragon_form_lua_form")
	hCaster:AddNewModifier(hCaster, self, "modifier_dragon_knight_elder_dragon_form_lua_form", { duration = duration })

	hCaster:AddNewModifier(hCaster, self, "modifier_dragon_knight_elder_dragon_form_lua_green", { duration = duration })

	local iSkin = 0
	if iLevel >= 2 then
		iSkin = 1
		hCaster:AddNewModifier(hCaster, self, "modifier_dragon_knight_elder_dragon_form_lua_red", { duration = duration })
	end
	if iLevel >= 3 then
		iSkin = 2
		hCaster:AddNewModifier(hCaster, self, "modifier_dragon_knight_elder_dragon_form_lua_blue", { duration = duration })
	end
	-- if iLevel >= 4 then
	--	 iSkin = 3
	-- end
	hCaster:SetSkin(iSkin)

	hCaster:StartGesture(ACT_DOTA_CAST_ABILITY_4)

	hCaster:EmitSound("Hero_DragonKnight.ElderDragonForm")
end
function dragon_knight_elder_dragon_form_lua:IsHiddenWhenStolen()
	return false
end
---------------------------------------------------------------------
--Modifiers
if modifier_dragon_knight_elder_dragon_form_lua_form == nil then
	modifier_dragon_knight_elder_dragon_form_lua_form = class({})
end
function modifier_dragon_knight_elder_dragon_form_lua_form:IsHidden()
	return true
end
function modifier_dragon_knight_elder_dragon_form_lua_form:IsDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_form:IsPurgable()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_form:IsPurgeException()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_form:IsStunDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_form:OnCreated(params)
	self.iLevel = self:GetAbility():GetLevel()
	-- if self:GetCaster():HasScepter() then
	--	 self.iLevel = self.iLevel + 1
	-- end
	self.bonus_movement_speed = self:GetAbilityLevelSpecialValueFor("bonus_movement_speed", self.iLevel - 1)
	self.bonus_attack_range = self:GetAbilityLevelSpecialValueFor("bonus_attack_range", self.iLevel - 1)
	self.magic_resistance = self:GetAbilityLevelSpecialValueFor("magic_resistance", self.iLevel - 1)
	self.model_scale = self:GetAbilityLevelSpecialValueFor("model_scale", self.iLevel - 1)
	if IsServer() then
		local hParent = self:GetParent()

		if hParent:GetProjectileSpeed() == 0 then
			self.bonus_projectile_speed = 900
		end
		hParent:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
		-- self.key = DotaImba:SetAttackCapability(hParent, DOTA_UNIT_CAP_RANGED_ATTACK, self.key)

		self.sParticlePath = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_green.vpcf"
		if self.iLevel == 2 then
			self.sParticlePath = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_red.vpcf"
		elseif self.iLevel == 3 then
			self.sParticlePath = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_blue.vpcf"
		elseif self.iLevel == 4 then
			self.sParticlePath = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_black.vpcf"
			-- self:StartIntervalThink(0)
		end

		local iParticleID = ParticleManager:CreateParticle(self.sParticlePath, PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc", hParent:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
end
function modifier_dragon_knight_elder_dragon_form_lua_form:OnDestroy()
	if IsServer() then
		local hParent = self:GetParent()

		GridNav:DestroyTreesAroundPoint(hParent:GetAbsOrigin(), 250, false)

		-- self.key = DotaImba:SetAttackCapability(hParent, nil, self.key)
		if GetUnitKeyValuesByName(hParent:GetUnitName()).AttackCapabilities ~= "DOTA_UNIT_CAP_RANGED_ATTACK" and not hParent:HasModifier("modifier_terrorblade_metamorphosis") then
			hParent:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
		end

		hParent:EmitSound("Hero_DragonKnight.ElderDragonForm.Revert")

		hParent:SetSkin(0)

		local iParticleID = ParticleManager:CreateParticle(ParticleManager:GetParticleReplacement(self.sParticlePath, self:GetCaster()), PATTACH_ABSORIGIN_FOLLOW, hParent)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc", hParent:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end
end
-- function modifier_dragon_knight_elder_dragon_form_lua_form:OnIntervalThink()
--	 if IsServer() then
--		 local hParent = self:GetParent()
--		 -- AddFOWViewer(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), hParent:GetCurrentVisionRange(), FrameTime(), false)
--	 end
-- end
function modifier_dragon_knight_elder_dragon_form_lua_form:CheckState()
	local hParent = self:GetParent()
	if hParent:HasScepter() then
		return {
			-- [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
			[MODIFIER_STATE_FLYING] = true,
		}
	else
		return {}
	end
end
function modifier_dragon_knight_elder_dragon_form_lua_form:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_VISUAL_Z_DELTA,
	}
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetModifierMoveSpeedBonus_Constant(params)
	return self.bonus_movement_speed
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetModifierAttackRangeBonus(params)
	return self.bonus_attack_range
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetModifierMagicalResistanceBonus(params)
	return self.magic_resistance
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetModifierCastRangeBonusStacking(params)
	if IsValid(params.ability) and bit.band(tonumber(tostring(params.ability:GetBehavior())), DOTA_ABILITY_BEHAVIOR_ATTACK) == DOTA_ABILITY_BEHAVIOR_ATTACK then
		return self.bonus_attack_range
	end
	return 0
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetModifierProjectileName(params)
	if self.iLevel == 2 then
		return "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf"
	elseif self.iLevel == 3 then
		return "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf"
	elseif self.iLevel == 4 then
		-- return "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf"
		return "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf"
	end
	return "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_corrosive.vpcf"
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetModifierProjectileSpeedBonus(params)
	return self.bonus_projectile_speed
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetModifierModelChange(params)
	return "models/heroes/dragon_knight/dragon_knight_dragon.vmdl"
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetModifierModelScale(params)
	return self.model_scale
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetAttackSound(params)
	if self.iLevel == 2 then
		return "Hero_DragonKnight.ElderDragonShoot2.Attack"
	elseif self.iLevel >= 3 then
		return "Hero_DragonKnight.ElderDragonShoot3.Attack"
	end
	return "Hero_DragonKnight.ElderDragonShoot1.Attack"
end
function modifier_dragon_knight_elder_dragon_form_lua_form:GetVisualZDelta(params)
	return math.min(self:GetElapsedTime(), 0.5) * 256
end
---------------------------------------------------------------------
if modifier_dragon_knight_elder_dragon_form_lua_green == nil then
	modifier_dragon_knight_elder_dragon_form_lua_green = class({})
end
function modifier_dragon_knight_elder_dragon_form_lua_green:IsHidden()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_green:IsDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_green:IsPurgable()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_green:IsPurgeException()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_green:IsStunDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_green:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end
function modifier_dragon_knight_elder_dragon_form_lua_green:GetModifierProcAttack_Feedback(params)
	if not IsValid(params.target) or params.target:GetClassname() == "dota_item_drop" then return end
	local hAbility = self:GetAbility()
	-- if params.attacker == self:GetParent() then
	if IsValid(hAbility) then
		hAbility:Corrosive(params.target)
	end
	-- end
end
---------------------------------------------------------------------
if modifier_dragon_knight_elder_dragon_form_lua_red == nil then
	modifier_dragon_knight_elder_dragon_form_lua_red = class({})
end
function modifier_dragon_knight_elder_dragon_form_lua_red:IsHidden()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_red:IsDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_red:IsPurgable()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_red:IsPurgeException()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_red:IsStunDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_red:AllowIllusionDuplicate()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_red:OnCreated(params)
	self.iLevel = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		self.iLevel = self.iLevel + 1
	end
	self.splash_radius = self:GetAbilityLevelSpecialValueFor("splash_radius", self.iLevel - 1)
	self.splash_damage_percent = self:GetAbilityLevelSpecialValueFor("splash_damage_percent", self.iLevel - 1)
end
function modifier_dragon_knight_elder_dragon_form_lua_red:OnRefresh(params)
	self.iLevel = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		self.iLevel = self.iLevel + 1
	end
	self.splash_radius = self:GetAbilityLevelSpecialValueFor("splash_radius", self.iLevel - 1)
	self.splash_damage_percent = self:GetAbilityLevelSpecialValueFor("splash_damage_percent", self.iLevel - 1)
end
function modifier_dragon_knight_elder_dragon_form_lua_red:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end
function modifier_dragon_knight_elder_dragon_form_lua_red:GetModifierProcAttack_Feedback(params)
	if not IsValid(params.target) or params.target:GetClassname() == "dota_item_drop" then return end
	local hParent = self:GetParent()

	-- if params.attacker == self:GetParent() then
		 local vPosition = params.target:GetAbsOrigin()
		 local tTargets = FindUnitsInRadius(params.attacker:GetTeamNumber(), vPosition, nil, self.splash_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 1, false)
		 for n, hTarget in pairs(tTargets) do
			 if hTarget ~= params.target then
				 local fDamagePercent = self.splash_damage_percent

				 local modifier_dragon_knight_elder_dragon_form_lua_green = params.attacker:FindModifierByName("modifier_dragon_knight_elder_dragon_form_lua_green")
				 if modifier_dragon_knight_elder_dragon_form_lua_green then
					 if IsValid(self:GetAbility()) then
						 self:GetAbility():Corrosive(hTarget)
					 end
				 end

				 local tDamageTable = {
					 ability = self:GetAbility(),
					 victim = hTarget,
					 attacker = params.attacker,
					 damage = params.original_damage * fDamagePercent * 0.01,
					 damage_type = DAMAGE_TYPE_PHYSICAL,
					 damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
				 }
				 ApplyDamage(tDamageTable)
			 end
		 end
	-- end
end
---------------------------------------------------------------------
if modifier_dragon_knight_elder_dragon_form_lua_blue == nil then
	modifier_dragon_knight_elder_dragon_form_lua_blue = class({})
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:IsHidden()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:IsDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:IsPurgable()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:IsPurgeException()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:IsStunDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:OnCreated(params)
	self.iLevel = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		self.iLevel = self.iLevel + 1
	end
	self.frost_duration = self:GetAbilityLevelSpecialValueFor("frost_duration", self.iLevel - 1)
	self.frost_aoe = self:GetAbilityLevelSpecialValueFor("frost_aoe", self.iLevel - 1)
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:OnRefresh(params)
	self.iLevel = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		self.iLevel = self.iLevel + 1
	end
	self.frost_duration = self:GetAbilityLevelSpecialValueFor("frost_duration", self.iLevel - 1)
	self.frost_aoe = self:GetAbilityLevelSpecialValueFor("frost_aoe", self.iLevel - 1)
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:OnDestroy()
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end
function modifier_dragon_knight_elder_dragon_form_lua_blue:GetModifierProcAttack_Feedback(params)
	if not IsValid(params.target) or params.target:GetClassname() == "dota_item_drop" then return end
	-- if params.attacker == self:GetParent() then
	local tTargets = FindUnitsInRadius(params.attacker:GetTeamNumber(), params.target:GetAbsOrigin(), nil, self.frost_aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 1, false)
	for n, hTarget in pairs(tTargets) do
		hTarget:AddNewModifier(params.attacker, self:GetAbility(), "modifier_dragon_knight_elder_dragon_form_lua_frost", { duration = self.frost_duration * hTarget:GetStatusResistanceFactor(params.attacker) })
	end
	-- end
end
---------------------------------------------------------------------
if modifier_dragon_knight_elder_dragon_form_lua_corrosive == nil then
	modifier_dragon_knight_elder_dragon_form_lua_corrosive = class({})
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:IsHidden()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:IsDebuff()
	return true
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:IsPurgable()
	return true
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:IsPurgeException()
	return true
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:IsStunDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:OnCreated(params)
	self.corrosive_breath_armor_reduce = self:GetAbility():GetSpecialValueFor("corrosive_breath_armor_reduce")
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:OnRefresh(params)
	self.corrosive_breath_armor_reduce = self:GetAbility():GetSpecialValueFor("corrosive_breath_armor_reduce")
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:OnTooltip(params)
	return self.corrosive_breath_armor_reduce
end
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:GetModifierPhysicalArmorBonus()
	return -self.corrosive_breath_armor_reduce
end
---------------------------------------------------------------------
if modifier_dragon_knight_elder_dragon_form_lua_frost == nil then
	modifier_dragon_knight_elder_dragon_form_lua_frost = class({})
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:IsHidden()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:IsDebuff()
	return true
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:IsPurgable()
	return true
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:IsPurgeException()
	return true
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:IsStunDebuff()
	return false
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:StatusEffectPriority()
	return 10
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:OnCreated(params)
	self.iLevel = 1
	if self:GetAbility() ~= nil and self:GetAbility().GetLevel ~= nil then
		self.iLevel = self:GetAbility():GetLevel()
	end
	if self:GetCaster():HasScepter() then
		self.iLevel = self.iLevel + 1
	end
	self.frost_bonus_movement_speed = self:GetAbilityLevelSpecialValueFor("frost_bonus_movement_speed", self.iLevel - 1)
	self.frost_bonus_attack_speed = self:GetAbilityLevelSpecialValueFor("frost_bonus_attack_speed", self.iLevel - 1)
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:OnRefresh(params)
	self.iLevel = 1
	if self:GetAbility() ~= nil and self:GetAbility().GetLevel ~= nil then
		self.iLevel = self:GetAbility():GetLevel()
	end
	if self:GetCaster():HasScepter() then
		self.iLevel = self.iLevel + 1
	end
	self.frost_bonus_movement_speed = self:GetAbilityLevelSpecialValueFor("frost_bonus_movement_speed", self.iLevel - 1)
	self.frost_bonus_attack_speed = self:GetAbilityLevelSpecialValueFor("frost_bonus_attack_speed", self.iLevel - 1)
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:GetModifierMoveSpeedBonus_Percentage(params)
	if IsValid(self:GetCaster()) and self:GetCaster():IsIllusion() then return end

	return self.frost_bonus_movement_speed
end
function modifier_dragon_knight_elder_dragon_form_lua_frost:GetModifierAttackSpeedBonus_Constant(params)
	if IsValid(self:GetCaster()) and self:GetCaster():IsIllusion() then return end

	return self.frost_bonus_attack_speed
end