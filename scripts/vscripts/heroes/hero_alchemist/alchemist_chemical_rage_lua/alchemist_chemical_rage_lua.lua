--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


alchemist_chemical_rage_lua = class({})
LinkLuaModifier(
	"modifier_alchemist_chemical_rage_lua",
	"heroes/hero_alchemist/alchemist_chemical_rage_lua/alchemist_chemical_rage_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_cleave",
	"heroes/hero_alchemist/alchemist_chemical_rage_lua/alchemist_chemical_rage_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_alchemist_resist",
	"heroes/hero_alchemist/alchemist_chemical_rage_lua/alchemist_chemical_rage_lua",
	LUA_MODIFIER_MOTION_NONE
)

function alchemist_chemical_rage_lua:Precache(context)
	PrecacheResource(
		"particle",
		"particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf",
		context
	)
end

function alchemist_chemical_rage_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_alchemist_chemical_rage_lua", -- modifier name
		{ duration = duration } -- kv
	)

	local talent = self:GetCaster():FindAbilityByName("special_bonus_alchemist_agi3")
	if talent and talent:GetLevel() > 0 then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemist_cleave", {})
	end

	local talent = self:GetCaster():FindAbilityByName("special_bonus_alchemist_agi4")
	if talent and talent:GetLevel() > 0 then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_alchemist_resist", {})
	end

	local sound_cast = "Hero_Alchemist.ChemicalRage.Cast"
	EmitSoundOn(sound_cast, self:GetCaster())
end

function alchemist_chemical_rage_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
	local sound_cast = "string"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_NAME, hOwner)
	ParticleManager:SetParticleControl(effect_cast, iControlPoint, vControlVector)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward(effect_cast, iControlPoint, vForward)
	SetParticleControlOrientation(effect_cast, iControlPoint, vForward, vRight, vUp)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	-- EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn(sound_location, self:GetCaster())
	EmitSoundOn(sound_target, target)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

modifier_alchemist_chemical_rage_lua = class({})

function modifier_alchemist_chemical_rage_lua:IsHidden()
	return false
end

function modifier_alchemist_chemical_rage_lua:IsDebuff()
	return false
end

function modifier_alchemist_chemical_rage_lua:IsStunDebuff()
	return false
end

function modifier_alchemist_chemical_rage_lua:IsPurgable()
	return false
end

function modifier_alchemist_chemical_rage_lua:AllowIllusionDuplicate()
	return true
end

function modifier_alchemist_chemical_rage_lua:OnCreated(kv)
	self.bat = self:GetAbility():GetSpecialValueFor("base_attack_time")
	self.health_regen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	self.mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
	self.movespeed = self:GetAbility():GetSpecialValueFor("bonus_movespeed")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_alchemist_agi7")
	if talent and talent:GetLevel() > 0 then
		self.bat = self.bat - 0.1
	end

	local talent = self:GetCaster():FindAbilityByName("special_bonus_alchemist_agi8")
	if talent and talent:GetLevel() > 0 then
		self.health_regen = self.health_regen + 150
	end

	if not IsServer() then
		return
	end
	ProjectileManager:ProjectileDodge(self:GetParent())
	self:GetParent():Purge(false, true, false, false, false)
	if self:GetCaster():GetUnitName() == "npc_dota_hero_alchemist" then
		self:GetCaster():StartGesture(ACT_DOTA_ALCHEMIST_CHEMICAL_RAGE_START)
	end
end

function modifier_alchemist_chemical_rage_lua:OnRefresh(kv)
	self.bat = self:GetAbility():GetSpecialValueFor("base_attack_time")
	self.health_regen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	self.mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
	self.movespeed = self:GetAbility():GetSpecialValueFor("bonus_movespeed")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_alchemist_agi7")
	if talent and talent:GetLevel() > 0 then
		self.bat = self.bat - 0.1
	end

	local talent = self:GetCaster():FindAbilityByName("special_bonus_alchemist_agi8")
	if talent and talent:GetLevel() > 0 then
		self.health_regen = self.health_regen + 150
	end

	if not IsServer() then
		return
	end
	ProjectileManager:ProjectileDodge(self:GetParent())
	self:GetParent():Purge(false, true, false, false, false)
end

function modifier_alchemist_chemical_rage_lua:OnRemoved() end

function modifier_alchemist_chemical_rage_lua:OnDestroy()
	if not IsServer() then
		return
	end

	if self:GetCaster():HasModifier("modifier_alchemist_cleave") then
		self:GetCaster():RemoveModifierByName("modifier_alchemist_cleave")
	end

	if self:GetCaster():HasModifier("modifier_alchemist_resist") then
		self:GetCaster():RemoveModifierByName("modifier_alchemist_resist")
	end

	if self:GetCaster():GetUnitName() == "npc_dota_hero_alchemist" and self:GetCaster() == self:GetParent() then
		self:GetCaster():StartGesture(ACT_DOTA_ALCHEMIST_CHEMICAL_RAGE_END)
	end

	local sound_cast = "Hero_Alchemist.ChemicalRage"
	StopSoundOn(sound_cast, self:GetParent())
end

function modifier_alchemist_chemical_rage_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_alchemist_chemical_rage_lua:GetModifierBaseAttackTimeConstant()
	local bat = self.bat
	local parent = self:GetParent()
	if parent and parent.dms_bat_factor then
		bat = bat * parent.dms_bat_factor
	end
	return bat
end

function modifier_alchemist_chemical_rage_lua:GetModifierConstantHealthRegen()
	return self.health_regen
end

function modifier_alchemist_chemical_rage_lua:GetModifierConstantManaRegen()
	return self.mana_regen
end

function modifier_alchemist_chemical_rage_lua:GetModifierMoveSpeedBonus_Constant()
	return self.movespeed
end

function modifier_alchemist_chemical_rage_lua:GetHeroEffectName()
	return "particles/units/heroes/hero_alchemist/alchemist_chemical_rage_hero_effect.vpcf"
end

function modifier_alchemist_chemical_rage_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf"
	local sound_cast = "Hero_Alchemist.ChemicalRage"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_NAME, self:GetParent())

	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	EmitSoundOn(sound_cast, self:GetParent())
end

--------------------------------------------------------------------------

function modifier_alchemist_chemical_rage_lua:GetEffectName()
	return "particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf"
end

function modifier_alchemist_chemical_rage_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_alchemist_chemical_rage_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_chemical_rage.vpcf"
end

function modifier_alchemist_chemical_rage_lua:StatusEffectPriority()
	return 10
end

function modifier_alchemist_chemical_rage_lua:GetHeroEffectName()
	return "particles/units/heroes/hero_alchemist/alchemist_chemical_rage_hero_effect.vpcf"
end

function modifier_alchemist_chemical_rage_lua:HeroEffectPriority()
	return 10
end

--------------------------------------------------------------------------
--------------------------------------------------------------------------

modifier_alchemist_cleave = class({})

function modifier_alchemist_cleave:IsHidden()
	return true
end

function modifier_alchemist_cleave:IsPurgable()
	return false
end

function modifier_alchemist_cleave:OnCreated(kv) end

function modifier_alchemist_cleave:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_alchemist_cleave:OnAttackLanded(keys)
	if
		not (
			IsServer()
			and self:GetParent() == keys.attacker
			and keys.attacker:GetTeam() ~= keys.target:GetTeam()
			and not keys.attacker:IsRangedAttacker()
		)
	then
		return
	end

	local ability = self:GetAbility()
	local damage = keys.original_damage
	local damageMod = 100
	local radius = 500
	local particle_cast = "particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf"

	damageMod = damageMod * 0.01
	damage = damage * damageMod

	DoCleaveAttack(self:GetParent(), keys.target, ability, damage, 150, 360, radius, particle_cast)
end

--------------------------------------------------------------------
--------------------------------------------------------------------

modifier_alchemist_resist = class({})

function modifier_alchemist_resist:IsHidden()
	return true
end

function modifier_alchemist_resist:IsPurgable()
	return false
end

function modifier_alchemist_resist:OnCreated(kv) end

function modifier_alchemist_resist:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end

function modifier_alchemist_resist:GetModifierMagicalResistanceBonus(keys)
	return 50
end