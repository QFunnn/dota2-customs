--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_clinkz_strafe_lua", "heroes/hero_clinkz/hero_clinkz", LUA_MODIFIER_MOTION_NONE)

clinkz_strafe_lua = class({})

function clinkz_strafe_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	EmitSoundOn("Hero_Clinkz.Strafe", caster)
	caster:AddNewModifier(caster, self, "modifier_clinkz_strafe_lua", { duration = duration })
end

---------------------------------------------------------------------------------------------

modifier_clinkz_strafe_lua = class({})

function modifier_clinkz_strafe_lua:IsHidden()
	return false
end
function modifier_clinkz_strafe_lua:IsPurgable()
	return true
end

function modifier_clinkz_strafe_lua:OnCreated()
	self.as = self:GetAbility():GetSpecialValueFor("bonus_as")
	self.range = self:GetAbility():GetSpecialValueFor("range")
	self.split_attack = true
end

function modifier_clinkz_strafe_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_clinkz_strafe_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as
end
function modifier_clinkz_strafe_lua:GetModifierAttackRangeBonus()
	return self.range
end

function modifier_clinkz_strafe_lua:OnAttack(params)
	if not IsServer() then
		return
	end
	if params.attacker ~= self:GetParent() or not self.split_attack then
		return
	end

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_clinkz_7")
	if not (talent and talent:GetLevel() > 0) then
		return
	end

	local caster = params.attacker
	local target = params.target
	local attack_range = caster:Script_GetAttackRange() + 100

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		attack_range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	self.split_attack = false
	for _, enemy in pairs(enemies) do
		if enemy ~= target then
			caster:PerformAttack(enemy, true, true, true, false, true, false, false)
			break
		end
	end
	self.split_attack = true
end

function modifier_clinkz_strafe_lua:GetEffectName()
	return "particles/units/heroes/hero_clinkz/clinkz_strafe_fire.vpcf"
end

function modifier_clinkz_strafe_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_generic_orb_effect_lua",
	"heroes/generic/modifier_generic_orb_effect_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier("modifier_clinkz_searing_arrows_lua", "heroes/hero_clinkz/hero_clinkz", LUA_MODIFIER_MOTION_NONE)

clinkz_searing_arrows_lua = class({})

function clinkz_searing_arrows_lua:GetIntrinsicModifierName()
	return "modifier_clinkz_searing_arrows_lua"
end

function clinkz_searing_arrows_lua:GetProjectileName()
	return "particles/units/heroes/hero_clinkz/clinkz_searing_arrow.vpcf"
end

function clinkz_searing_arrows_lua:OnOrbFire(params)
	local sound_cast = "Hero_Clinkz.SearingArrows"
	EmitSoundOn(sound_cast, self:GetCaster())
end

function clinkz_searing_arrows_lua:OnOrbImpact(params)
	local caster = self:GetCaster()

	local damage = self:GetSpecialValueFor("bonus_damage")

	local damageTable = {
		victim = params.target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}
	ApplyDamage(damageTable)
	local sound_cast = "Hero_Clinkz.SearingArrows.Impact"
	EmitSoundOn(sound_cast, params.target)
end

---------------------------------------------------------------------------------------------

modifier_clinkz_searing_arrows_lua = class({})

function modifier_clinkz_searing_arrows_lua:IsHidden()
	return true
end

function modifier_clinkz_searing_arrows_lua:IsDebuff()
	return false
end

function modifier_clinkz_searing_arrows_lua:IsPurgable()
	return false
end

function modifier_clinkz_searing_arrows_lua:OnCreated(kv)
	if not IsServer() then
		return
	end

	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_orb_effect_lua", -- modifier name
		{} -- kv
	)
end

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_clinkz_skeleton_walk_lua", "heroes/hero_clinkz/hero_clinkz", LUA_MODIFIER_MOTION_NONE)

clinkz_skeleton_walk_lua = class({})

function clinkz_skeleton_walk_lua:GetAbilityTextureName()
	return "clinkz_wind_walk"
end

function clinkz_skeleton_walk_lua:IsHiddenWhenStolen()
	return false
end

function clinkz_skeleton_walk_lua:OnSpellStart()
	local duration = self:GetSpecialValueFor("duration")
	EmitSoundOn("Hero_Clinkz.WindWalk", self:GetCaster())
	local particle_invis_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_clinkz/clinkz_windwalk.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(particle_invis_fx, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_invis_fx, 1, self:GetCaster():GetAbsOrigin())

	self:GetCaster()
		:AddNewModifier(self:GetCaster(), self, "modifier_clinkz_skeleton_walk_lua", { duration = duration })
end

----------------------------------------------------------------------------------------------------------------

modifier_clinkz_skeleton_walk_lua = class({})

function modifier_clinkz_skeleton_walk_lua:IsHidden()
	return false
end
function modifier_clinkz_skeleton_walk_lua:IsPurgable()
	return false
end
function modifier_clinkz_skeleton_walk_lua:IsDebuff()
	return false
end

function modifier_clinkz_skeleton_walk_lua:OnCreated() end

function modifier_clinkz_skeleton_walk_lua:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
	}
end

function modifier_clinkz_skeleton_walk_lua:GetPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_clinkz_skeleton_walk_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_EVENT_ON_ATTACK,
	}
end

function modifier_clinkz_skeleton_walk_lua:GetModifierInvisibilityLevel()
	return 1
end

function modifier_clinkz_skeleton_walk_lua:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_ms")
end

function modifier_clinkz_skeleton_walk_lua:OnAbilityExecuted(keys)
	if IsServer() then
		if self:GetParent() == keys.unit then
			self:Destroy()
		end
	end
end

function modifier_clinkz_skeleton_walk_lua:OnAttack(keys)
	if IsServer() then
		if self:GetParent() == keys.attacker then
			self:Destroy()
		end
	end
end

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_npc_dota_hero_clinkz_permanent_ability",
	"heroes/hero_clinkz/hero_clinkz",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_npc_dota_hero_clinkz_permanent_ability_effect",
	"heroes/hero_clinkz/hero_clinkz",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_npc_dota_hero_clinkz_permanent_ability_hp",
	"heroes/hero_clinkz/hero_clinkz",
	LUA_MODIFIER_MOTION_NONE
)

clinkz_ult_lua = class({})

function clinkz_ult_lua:GetIntrinsicModifierName()
	return "modifier_npc_dota_hero_clinkz_permanent_ability"
end

function clinkz_ult_lua:OnUpgrade()
	if IsServer() then
		self:ToggleAutoCast()
	end
end

----------------------------------------------------------------------------------------------------------------

modifier_npc_dota_hero_clinkz_permanent_ability = class({})

function modifier_npc_dota_hero_clinkz_permanent_ability:IsHidden()
	return true
end

function modifier_npc_dota_hero_clinkz_permanent_ability:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.archers_list = {}
	if IsServer() then
		self:SetStackCount(1)
	end
end

function modifier_npc_dota_hero_clinkz_permanent_ability:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_npc_dota_hero_clinkz_permanent_ability:OnAttackLanded(params)
	if not IsServer() or params.attacker ~= self.caster or self.caster:PassivesDisabled() then
		return
	end
	if not self.ability:GetAutoCastState() then
		return
	end

	local max_stacks = self.ability:GetSpecialValueFor("count")
	local current_stacks = self:GetStackCount()

	if current_stacks < max_stacks then
		self:SetStackCount(current_stacks + 1)
	else
		self:SpawnArcher()
		self:SetStackCount(1)
	end
end

function modifier_npc_dota_hero_clinkz_permanent_ability:SpawnArcher()
	for i = #self.archers_list, 1, -1 do
		if not self.archers_list[i] or self.archers_list[i]:IsNull() or not self.archers_list[i]:IsAlive() then
			table.remove(self.archers_list, i)
		end
	end

	if #self.archers_list >= self.ability:GetSpecialValueFor("archers") then
		return
	end

	local pos = self.caster:GetAbsOrigin() + RandomVector(100)
	local archer = CreateUnitByName(
		"npc_dota_clinkz_skeleton_archer",
		pos,
		true,
		self.caster,
		self.caster,
		self.caster:GetTeamNumber()
	)

	archer:SetControllableByPlayer(self.caster:GetPlayerID(), true)
	archer:SetOwner(self.caster)
	archer:SetForwardVector(self.caster:GetForwardVector())

	archer:AddNewModifier(self.caster, self.ability, "modifier_npc_dota_hero_clinkz_permanent_ability_effect", {})
	archer:AddNewModifier(self.caster, self.ability, "modifier_npc_dota_hero_clinkz_permanent_ability_hp", {})
	archer:AddNewModifier(
		self.caster,
		self.ability,
		"modifier_kill",
		{ duration = self.ability:GetSpecialValueFor("duration") }
	)

	table.insert(self.archers_list, archer)
end

-----------------------------------------------------------------------------------------------------------

modifier_npc_dota_hero_clinkz_permanent_ability_effect = class({})

function modifier_npc_dota_hero_clinkz_permanent_ability_effect:IsHidden()
	return true
end

function modifier_npc_dota_hero_clinkz_permanent_ability_effect:OnCreated()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()

	local c_arrows = caster:FindAbilityByName("clinkz_searing_arrows_lua")
	local p_arrows = parent:FindAbilityByName("clinkz_searing_arrows_lua")

	if c_arrows and p_arrows then
		p_arrows:SetLevel(c_arrows:GetLevel())
		p_arrows:ToggleAutoCast()
	end

	self:SetStackCount(caster:GetAverageTrueAttackDamage(nil))
end

function modifier_npc_dota_hero_clinkz_permanent_ability_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end

function modifier_npc_dota_hero_clinkz_permanent_ability_effect:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end
function modifier_npc_dota_hero_clinkz_permanent_ability_effect:GetModifierAttackRangeBonus()
	return self:GetCaster():Script_GetAttackRange() - 600
end

-----------------------------------------------------------------------------------------------------------

modifier_npc_dota_hero_clinkz_permanent_ability_hp = class({})

function modifier_npc_dota_hero_clinkz_permanent_ability_hp:IsHidden()
	return true
end

function modifier_npc_dota_hero_clinkz_permanent_ability_hp:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_npc_dota_hero_clinkz_permanent_ability_hp:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
end

function modifier_npc_dota_hero_clinkz_permanent_ability_hp:GetModifierIncomingDamage_Percentage()
	return -100
end
function modifier_npc_dota_hero_clinkz_permanent_ability_hp:GetDisableHealing()
	return 1
end

function modifier_npc_dota_hero_clinkz_permanent_ability_hp:OnAttackLanded(params)
	if IsServer() and params.target == self:GetParent() then
		local parent = self:GetParent()
		local new_hp = parent:GetHealth() - 1
		if new_hp > 0 then
			parent:SetHealth(new_hp)
		else
			parent:Kill(nil, params.attacker)
		end
	end
end