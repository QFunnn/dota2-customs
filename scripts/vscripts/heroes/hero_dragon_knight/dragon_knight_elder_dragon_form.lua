--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_custom", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_custom_corrosive", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_custom_frost", "heroes/hero_dragon_knight/dragon_knight_elder_dragon_form", LUA_MODIFIER_MOTION_NONE )

dragon_knight_elder_dragon_form_custom = class({})

function dragon_knight_elder_dragon_form_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_corrosive.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf", context)
	PrecacheResource("particle", "particles/dk_attack.vpcf", context)
end

function dragon_knight_elder_dragon_form_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier( caster, self, "modifier_dragon_knight_elder_dragon_form_custom", { duration = duration } )
end

modifier_dragon_knight_elder_dragon_form_custom = class({})

local level1 = 
{
	["projectile"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_corrosive.vpcf",
	["attack_sound"] = "Hero_DragonKnight.ElderDragonShoot1.Attack",
	["transform"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_green.vpcf",
	["scale"] = 0,
}

local level2 = 
{
	["projectile"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf",
	["attack_sound"] = "Hero_DragonKnight.ElderDragonShoot2.Attack",
	["transform"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_red.vpcf",
	["scale"] = 10,
}

local level3 = 
{
	["projectile"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf",
	["attack_sound"] = "Hero_DragonKnight.ElderDragonShoot3.Attack",
	["transform"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_blue.vpcf",
	["scale"] = 20,
}

local level4 = 
{
	["projectile"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf",
	["attack_sound"] = "Hero_DragonKnight.ElderDragonShoot3.Attack",
	["transform"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_blue.vpcf",
	["scale"] = 50,
}

modifier_dragon_knight_elder_dragon_form_custom.effect_data = 
{
	[1] = level1,
	[2] = level2,
	[3] = level3,
	[4] = level4,
}

function modifier_dragon_knight_elder_dragon_form_custom:IsHidden()
	return false
end

function modifier_dragon_knight_elder_dragon_form_custom:IsDebuff()
	return false
end

function modifier_dragon_knight_elder_dragon_form_custom:IsPurgable()
	return false
end

function modifier_dragon_knight_elder_dragon_form_custom:AllowIllusionDuplicate()
	return true
end

function modifier_dragon_knight_elder_dragon_form_custom:OnCreated( kv )
	self.parent = self:GetParent()
	self.scepter = false
	self.level = self:GetAbility():GetLevel()
	if self.parent:HasScepter() then
		self.scepter = true
		self.level = self.level + 1
	end
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_attack_damage" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )

	self.blood_bonus_regen = 0
	self.blood_bonus_armor = 0
	local blood_innate = self.parent:FindAbilityByName("dragon_knight_dragon_blood")
	if blood_innate and not blood_innate:IsNull() then
		local multiplier = blood_innate:GetSpecialValueFor("regen_and_armor_multiplier_during_dragon_form") / 100
		self.blood_bonus_regen = blood_innate:GetSpecialValueFor("health_regen") * multiplier
		self.blood_bonus_armor = blood_innate:GetSpecialValueFor("armor") * multiplier
		print("[DK DRAGON FORM] innate blood: regen_bonus=" .. self.blood_bonus_regen .. " armor_bonus=" .. self.blood_bonus_armor)
	end
	self.magic_resist = 0
	self.corrosive_duration = self:GetAbility():GetSpecialValueFor( "corrosive_breath_duration" )
	self.splash_radius = self:GetAbility():GetSpecialValueFor( "splash_radius" )
	self.splash_pct = self:GetAbility():GetSpecialValueFor( "splash_damage_percent" )/100
	self.frost_radius = self:GetAbility():GetSpecialValueFor( "frost_aoe" )
	self.frost_duration = self:GetAbility():GetSpecialValueFor( "frost_duration" )
	if self.level==4 then
		self.bonus_range = self.bonus_range + 100
		self.splash_pct = self.splash_pct * 1.5
		self.magic_resist = 30
	end
	if not IsServer() then return end
	self.attack_info = self.parent:GetAttackCapability()
	self.original_projectile = self.parent:GetRangedProjectileName()
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_RANGED_ATTACK )
	self.parent:SetRangedProjectileName( self.effect_data[self.level].projectile )
	self:StartIntervalThink( 1 )
	self.projectile = self.effect_data[self.level].projectile
	self.attack_sound = self.effect_data[self.level].attack_sound
	self.scale = self.effect_data[self.level].scale
	self:PlayEffects()
	EmitSoundOn( "Hero_DragonKnight.ElderDragonForm", self.parent )
end

function modifier_dragon_knight_elder_dragon_form_custom:OnRefresh( kv )
	self.parent = self:GetParent()
	self.level = self:GetAbility():GetLevel()
	self.scepter = false
	if self.parent:HasScepter() then
		self.level = self.level + 1
		self.scepter = true
	end
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_attack_damage" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )
	self.magic_resist = 0
	self.corrosive_duration = self:GetAbility():GetSpecialValueFor( "corrosive_breath_duration" )
	self.splash_radius = self:GetAbility():GetSpecialValueFor( "splash_radius" )
	self.splash_pct = self:GetAbility():GetSpecialValueFor( "splash_damage_percent" )/100
	self.frost_radius = self:GetAbility():GetSpecialValueFor( "frost_aoe" )
	self.frost_duration = self:GetAbility():GetSpecialValueFor( "frost_duration" )
	if self.level==4 then
		self.bonus_range = self.bonus_range + 100
		self.splash_pct = self.splash_pct * 1.5
		self.magic_resist = 30
	end
	if not IsServer() then return end
	self.parent:SetRangedProjectileName( self.effect_data[self.level].projectile )
	self.projectile = self.effect_data[self.level].projectile
	self.attack_sound = self.effect_data[self.level].attack_sound
	self.scale = self.effect_data[self.level].scale
	self:PlayEffects()
end

function modifier_dragon_knight_elder_dragon_form_custom:OnDestroy()
	if not IsServer() then return end
	self.parent:SetAttackCapability( self.attack_info )
	self.parent:SetRangedProjectileName( self.original_projectile or "" )
	self:PlayEffects()
	EmitSoundOn( "Hero_DragonKnight.ElderDragonForm.Revert", self.parent )
end

function modifier_dragon_knight_elder_dragon_form_custom:OnIntervalThink()
	self.parent:SetSkin( self.level-1 )
end

function modifier_dragon_knight_elder_dragon_form_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierConstantHealthRegen()
	return self.blood_bonus_regen or 0
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierPhysicalArmorBonus()
	return self.blood_bonus_armor or 0
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierBaseAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_ms
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierAttackRangeBonus()
	return self.bonus_range
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierMagicalResistanceBonus()
	return self.magic_resist
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierModelChange()
	return "models/heroes/dragon_knight/dragon_knight_dragon.vmdl"
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierModelScale()
	return self.scale
end

function modifier_dragon_knight_elder_dragon_form_custom:GetAttackSound()
	return self.attack_sound
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierProjectileName()
	-- Per-level ванильный projectile (green corrosive / red fire / blue frost).
	-- Раньше был жёстко dk_attack.vpcf (наш кастом со sphere.vmdl + CP4-attract),
	-- который не отрисовывался для melee-героев в форме дракона: их combat-скелет
	-- не совпадал с visual моделью dragon_knight_dragon.vmdl, и projectile
	-- спавнился в невидимой точке. Ванильные particle'ы Valve используют
	-- стандартные CP0/CP1 — работают для любого скелета.
	local data = self.effect_data[self.level]
	if data and data.projectile then return data.projectile end
	return self.effect_data[1].projectile  -- safety fallback
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierProjectileSpeedBonus()
	return 900
end

function modifier_dragon_knight_elder_dragon_form_custom:GetModifierProcAttack_Feedback( params )
	if params.target:GetTeamNumber()==self.parent:GetTeamNumber() then return end
	if self.parent.anchor_attack_talent then print("СОРРИ ПАССИВКА ТАЙДА") return end
	if self.parent.bCanTriggerLock then print("СОРРИ ПАССИВКА ВОЙДА") return end

	if self.level==1 then
		self:Corrosive( params.target )
	elseif self.level==2 then
		self:Corrosive( params.target )
		if not params.no_attack_cooldown then
			self:Splash( params.target, params.damage )
		end
	elseif self.level==3 then
		self:Corrosive( params.target )
		if not params.no_attack_cooldown then
			self:Splash( params.target, params.damage )
		end
		self:Frost( params.target )
	else
		self:Corrosive( params.target )
		if not params.no_attack_cooldown then
			self:Splash( params.target, params.damage )
		end
		self:Frost( params.target )
	end
end

function modifier_dragon_knight_elder_dragon_form_custom:Corrosive( target )
    if not IsServer() then return end
	target:AddNewModifier( self.parent, self:GetAbility(), "modifier_dragon_knight_elder_dragon_form_custom_corrosive", { duration = self.corrosive_duration })
end

function modifier_dragon_knight_elder_dragon_form_custom:Splash( target, damage )
    if not IsServer() then return end
	if self.parent.split_attack then return end
	if self.parent:HasModifier("modifier_item_bfury_2") then return end
	if self.parent:HasModifier("modifier_item_bfury_3") then return end
	if self.parent:HasModifier("modifier_item_ranged_cleave") then return end
	if self.parent:HasModifier("modifier_item_ranged_cleave_2") then return end
	if self.parent:HasModifier("modifier_item_ranged_cleave_3") then return end
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.splash_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	local fury_swipes_damage = 0
	if self.parent:HasAbility("ursa_fury_swipes") and target:HasModifier("modifier_ursa_fury_swipes_damage_increase") then
		local ursa_swipes = self.parent:FindAbilityByName("ursa_fury_swipes")
		if ursa_swipes and not ursa_swipes:IsNull() then
			local stacks = target:GetModifierStackCount("modifier_ursa_fury_swipes_damage_increase", self.parent)
			fury_swipes_damage = stacks * ursa_swipes:GetSpecialValueFor("damage_per_stack")
		end
	end
	for _,enemy in pairs(enemies) do
		if enemy~=target then
			local damageTable = 
            {
				victim = enemy,
				attacker = self.parent,
				damage = (damage + fury_swipes_damage) * self.splash_pct,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self:GetAbility(),
			}
			ApplyDamage(damageTable)
			self:Corrosive( enemy )
		end
	end
end

function modifier_dragon_knight_elder_dragon_form_custom:CheckState()
	if not self.scepter then return end
	return
    {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		-- [A61] Без этого летающий DK СВОЕЙ коллизией (она по вики остаётся на земле даже
		-- в полёте) блокирует наземного врага — можно «застакать» его снизу и он не выйдет.
		-- NO_UNIT_COLLISION убирает коллизию летающего → враг свободно проходит сквозь, ловушки нет.
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_dragon_knight_elder_dragon_form_custom:Frost( target )
    if not IsServer() then return end
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.frost_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(
			self.parent, -- player source
			self:GetAbility(), -- ability source
			"modifier_dragon_knight_elder_dragon_form_custom_frost", -- modifier name
			{ duration = self.frost_duration } -- kv
		)
	end
end

function modifier_dragon_knight_elder_dragon_form_custom:PlayEffects()
	local particle_cast = self.effect_data[self.level].transform
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_dragon_knight_elder_dragon_form_custom_corrosive = class({})

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:IsHidden()
	return false
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:IsDebuff()
	return true
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:IsStunDebuff()
	return false
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:IsPurgable()
	return false
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:OnCreated( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "corrosive_breath_damage" )
	local level = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		level = level + 1
	end
	if level==4 then
		damage = damage*1.5
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}
	if not IsServer() then return end
	self:StartIntervalThink( 1 )
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:OnRefresh( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "corrosive_breath_damage" )
	local level = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		level = level + 1
	end
	if level==4 then
		damage = damage*1.5
	end
	self.damageTable.damage = damage
end

function modifier_dragon_knight_elder_dragon_form_custom_corrosive:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

modifier_dragon_knight_elder_dragon_form_custom_frost = class({})

function modifier_dragon_knight_elder_dragon_form_custom_frost:IsHidden()
	return false
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:IsDebuff()
	return true
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:IsStunDebuff()
	return false
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:IsPurgable()
	return false
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:OnCreated( kv )
	self.frost_as = self:GetAbility():GetSpecialValueFor( "frost_bonus_attack_speed" )
	self.frost_ms = self:GetAbility():GetSpecialValueFor( "frost_bonus_movement_speed" )
	local level = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		level = level + 1
	end
	if level==4 then
		self.frost_as = self.frost_as*1.5
		self.frost_ms = self.frost_ms*1.5
	end
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:OnRefresh( kv )
	self.frost_as = self:GetAbility():GetSpecialValueFor( "frost_bonus_attack_speed" )
	self.frost_ms = self:GetAbility():GetSpecialValueFor( "frost_bonus_movement_speed" )	
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:GetModifierMoveSpeedBonus_Percentage()
	if self:GetParent():IsMagicImmune() then return end
	return self.frost_ms
end

function modifier_dragon_knight_elder_dragon_form_custom_frost:GetModifierAttackSpeedBonus_Constant()
	if self:GetParent():IsMagicImmune() then return end
	return self.frost_as
end