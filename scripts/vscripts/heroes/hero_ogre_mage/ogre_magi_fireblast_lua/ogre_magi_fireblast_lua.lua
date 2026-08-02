--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_ogre_magi_fireblast_lua_talent",
	"heroes/hero_ogre_mage/ogre_magi_fireblast_lua/ogre_magi_fireblast_lua",
	LUA_MODIFIER_MOTION_NONE
)

ogre_magi_fireblast_lua = class({})

function ogre_magi_fireblast_lua:GetIntrinsicModifierName()
	return "modifier_ogre_magi_fireblast_lua_talent"
end

function ogre_magi_fireblast_lua:GetCooldown(level)
	local tal = self:GetCaster():FindAbilityByName("special_bonus_ogre_magi_5")
	if tal ~= nil and tal:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 2
	end
	return self.BaseClass.GetCooldown(self, level)
end

function ogre_magi_fireblast_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	local duration = self:GetSpecialValueFor("stun_duration")
	local damage = self:GetSpecialValueFor("fireblast_damage")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_ogre_magi_1")
	if ability ~= nil and ability:GetLevel() > 0 then
		damage = damage + 240
	end

	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = duration })

	self:PlayEffects(target)
end

function ogre_magi_fireblast_lua:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast.vpcf"
	local sound_cast = "Hero_OgreMagi.Fireblast.Cast"
	local sound_target = "Hero_OgreMagi.Fireblast.Target"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
	EmitSoundOn(sound_target, target)
end

---------------------------------------------------------------

modifier_ogre_magi_fireblast_lua_talent = class({})

function modifier_ogre_magi_fireblast_lua_talent:IsHidden()
	return true
end

function modifier_ogre_magi_fireblast_lua_talent:IsDebuff()
	return false
end

function modifier_ogre_magi_fireblast_lua_talent:IsPurgable()
	return false
end

function modifier_ogre_magi_fireblast_lua_talent:OnRefresh(kv) end

function modifier_ogre_magi_fireblast_lua_talent:OnRemoved() end

function modifier_ogre_magi_fireblast_lua_talent:OnDestroy() end

function modifier_ogre_magi_fireblast_lua_talent:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_ogre_magi_fireblast_lua_talent:OnAttackLanded(params)
	self.parent = self:GetParent()
	if params.attacker ~= self.parent then
		return
	end
	if params.target:GetTeamNumber() == params.attacker:GetTeamNumber() then
		return
	end
	if self.parent:PassivesDisabled() then
		return
	end

	local ability = self:GetCaster():FindAbilityByName("special_bonus_ogre_magi_4")
	if ability ~= nil and ability:GetLevel() > 0 then
		if RandomInt(1, 100) <= 15 then
			local damage = self:GetAbility():GetSpecialValueFor("fireblast_damage")
			local damageTable = {
				victim = params.target,
				attacker = params.attacker,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			}
			ApplyDamage(damageTable)
			self:GetAbility():PlayEffects(params.target)
		end
	end
end