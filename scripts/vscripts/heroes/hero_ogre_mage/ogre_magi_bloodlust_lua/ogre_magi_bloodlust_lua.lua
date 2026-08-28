--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


ogre_magi_bloodlust_lua = class({})
LinkLuaModifier(
	"modifier_ogre_magi_bloodlust_lua",
	"heroes/hero_ogre_mage/ogre_magi_bloodlust_lua/ogre_magi_bloodlust_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_ogre_magi_bloodlust_lua_buff",
	"heroes/hero_ogre_mage/ogre_magi_bloodlust_lua/ogre_magi_bloodlust_lua",
	LUA_MODIFIER_MOTION_NONE
)

function ogre_magi_bloodlust_lua:GetIntrinsicModifierName()
	return "modifier_ogre_magi_bloodlust_lua"
end

function ogre_magi_bloodlust_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local duration = self:GetSpecialValueFor("duration")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_ogre_magi_7")
	if ability ~= nil and ability:GetLevel() > 0 then
		duration = duration + 5
	end

	target:AddNewModifier(caster, self, "modifier_ogre_magi_bloodlust_lua_buff", { duration = duration })
	self:PlayEffects(target)
end

function ogre_magi_bloodlust_lua:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_cast.vpcf"
	local sound_cast = "Hero_OgreMagi.Bloodlust.Cast"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
end

-----------------------------------------------------------------------------

modifier_ogre_magi_bloodlust_lua = class({})

function modifier_ogre_magi_bloodlust_lua:IsHidden()
	return true
end

function modifier_ogre_magi_bloodlust_lua:IsPurgable()
	return false
end

function modifier_ogre_magi_bloodlust_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.radius = self.ability:GetCastRange(self.caster:GetOrigin(), self.caster)
	local interval = 1

	if not IsServer() then
		return
	end
	self:StartIntervalThink(interval)
end

function modifier_ogre_magi_bloodlust_lua:OnIntervalThink()
	if not self.ability:GetAutoCastState() then
		return
	end
	if not self.ability:IsFullyCastable() then
		return
	end
	if self.caster:IsSilenced() then
		return
	end
	local allies = FindUnitsInRadius(
		self.caster:GetTeamNumber(), -- int, your team number
		self.caster:GetOrigin(), -- point, center point
		self.caster, -- handle, cacheUnit. (not known)
		self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, -- int, team filter
		DOTA_UNIT_TARGET_HERO, -- int, type filter
		0, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _, ally in pairs(allies) do
		if not ally:HasModifier("modifier_ogre_magi_bloodlust_lua_buff") then
			self.caster:CastAbilityOnTarget(ally, self.ability, self.caster:GetPlayerOwnerID())
			break
		end
	end
end

----------------------------------------------------------

modifier_ogre_magi_bloodlust_lua_buff = class({})

function modifier_ogre_magi_bloodlust_lua_buff:IsHidden()
	return false
end

function modifier_ogre_magi_bloodlust_lua_buff:IsDebuff()
	return false
end

function modifier_ogre_magi_bloodlust_lua_buff:IsPurgable()
	return true
end

function modifier_ogre_magi_bloodlust_lua_buff:OnCreated(kv)
	self.model_scale = self:GetAbility():GetSpecialValueFor("modelscale")
	self.ms_bonus = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
	self.as_bonus = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	self.self_bonus = self:GetAbility():GetSpecialValueFor("self_bonus")

	if self:GetParent() == self:GetCaster() then
		self.as_bonus = self.self_bonus
	end

	local ability = self:GetCaster():FindAbilityByName("special_bonus_ogre_magi_3")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.as_bonus = self.as_bonus + 40
	end

	local sound_cast = "Hero_OgreMagi.Bloodlust.Target"
	EmitSoundOn(sound_cast, self:GetParent())
	local sound_player = "Hero_OgreMagi.Bloodlust.Target.FP"
	EmitSoundOnClient(sound_player, self:GetParent())
end

function modifier_ogre_magi_bloodlust_lua_buff:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_ogre_magi_bloodlust_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
	return funcs
end

function modifier_ogre_magi_bloodlust_lua_buff:GetModifierConstantHealthRegen()
	local ability = self:GetCaster():FindAbilityByName("special_bonus_ogre_magi_6")
	if ability ~= nil and ability:GetLevel() > 0 then
		return self:GetCaster():GetStrength() * 0.5
	end
	return 0
end

function modifier_ogre_magi_bloodlust_lua_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end
function modifier_ogre_magi_bloodlust_lua_buff:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end

function modifier_ogre_magi_bloodlust_lua_buff:GetModifierModelScale()
	return self.model_scale
end

function modifier_ogre_magi_bloodlust_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
end

function modifier_ogre_magi_bloodlust_lua_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end