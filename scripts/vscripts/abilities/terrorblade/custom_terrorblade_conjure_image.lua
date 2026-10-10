--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_conjure_image_custom_tracker",
	"abilities/terrorblade/custom_terrorblade_conjure_image",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_conjure_image_custom_legendary_invun",
	"abilities/terrorblade/custom_terrorblade_conjure_image",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_conjure_image_custom_legendary_legendary_cd",
	"abilities/terrorblade/custom_terrorblade_conjure_image",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_conjure_image_custom_invun",
	"abilities/terrorblade/custom_terrorblade_conjure_image",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_conjure_image_custom_legendary_illusion_mod",
	"abilities/terrorblade/custom_terrorblade_conjure_image",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_conjure_image_custom_illusion_basic",
	"abilities/terrorblade/custom_terrorblade_conjure_image",
	LUA_MODIFIER_MOTION_NONE
)

custom_terrorblade_conjure_image = class({})
custom_terrorblade_conjure_image.talents = {}
custom_terrorblade_conjure_image.illusions = {}

function custom_terrorblade_conjure_image:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf", context)
	PrecacheResource("particle", "particles/terrorblade/terrorblade_feet_effects.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf",
		context
	)
	PrecacheResource("particle", "particles/items2_fx/manta_phase.vpcf", context)
	PrecacheResource("particle", "particles/terrorblade/image_blink.vpcf", context)
	PrecacheResource("particle", "particles/terrorblade/illusion_damage_reduce.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_death_custom.vpcf", context)
end

function custom_terrorblade_conjure_image:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {
			w2_cd = 0,
			w2_mana = 0,

			has_w5 = 0,
			w5_range = caster:GetTalentValue("modifier_terror_illusion_5", "range", true),
			w5_invun = caster:GetTalentValue("modifier_terror_illusion_5", "invun", true),

			has_w6 = 0,
			w6_duration = caster:GetTalentValue("modifier_terror_illusion_6", "duration", true),
			w6_damage_self = caster:GetTalentValue("modifier_terror_illusion_6", "damage_self", true),
			w6_damage_reduce = caster:GetTalentValue("modifier_terror_illusion_6", "damage_reduce", true),

			has_w7 = 0,
			w7_duration = caster:GetTalentValue("modifier_terror_illusion_7", "duration", true),
			w7_damage = caster:GetTalentValue("modifier_terror_illusion_7", "damage", true),
			w7_incoming = caster:GetTalentValue("modifier_terror_illusion_7", "incoming", true),
			w7_max = caster:GetTalentValue("modifier_terror_illusion_7", "max", true),
			w7_chance = caster:GetTalentValue("modifier_terror_illusion_7", "chance", true),
			w7_heal = caster:GetTalentValue("modifier_terror_illusion_7", "heal", true),
		}
	end

	if caster:HasTalent("modifier_terror_illusion_2") then
		self.talents.w2_cd = caster:GetTalentValue("modifier_terror_illusion_2", "cd")
		self.talents.w2_mana = caster:GetTalentValue("modifier_terror_illusion_2", "mana")
	end

	if caster:HasTalent("modifier_terror_illusion_5") then
		self.talents.has_w5 = 1
	end

	if caster:HasTalent("modifier_terror_illusion_6") then
		self.talents.has_w6 = 1
	end

	if caster:HasTalent("modifier_terror_illusion_7") then
		self.talents.has_w7 = 1
		caster:AddAttackEvent_out(self.tracker, true)
	end
end

function custom_terrorblade_conjure_image:GetAbilityTextureName()
	return wearables_system:GetAbilityIconReplacement(self.caster, "terrorblade_conjure_image", self)
end

function custom_terrorblade_conjure_image:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_conjure_image_custom_tracker"
end

function custom_terrorblade_conjure_image:GetCooldown(iLevel)
	return self.BaseClass.GetCooldown(self, iLevel) + (self.talents.w2_cd or 0)
end

function custom_terrorblade_conjure_image:GetManaCost(level)
	return self.BaseClass.GetManaCost(self, level) + (self.talents.w2_mana or 0)
end

function custom_terrorblade_conjure_image:GetCastRange(vLocation, hTarget)
	if self.talents.has_w5 ~= 1 then
		return
	end
	if IsClient() then
		return self.talents.w5_range
	end
	return 999999
end

function custom_terrorblade_conjure_image:GetBehavior()
	if self.talents.has_w5 == 1 then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function custom_terrorblade_conjure_image:OnSpellStart()
	if self.talents.has_w5 == 1 and not self.caster:IsRooted() and not self.caster:IsLeashed() then
		local point = self:GetCursorPosition()
		if point == self.caster:GetAbsOrigin() then
			point = self.caster:GetAbsOrigin() + self.caster:GetForwardVector() * 10
		end

		local vec = point - self.caster:GetAbsOrigin()
		local max_range = self.talents.w5_range + self.caster:GetCastRangeBonus()
		if vec:Length2D() > max_range then
			point = self.caster:GetAbsOrigin() + vec:Normalized() * max_range
		end

		self.caster:AddNewModifier(
			self.caster,
			self,
			"modifier_conjure_image_custom_invun",
			{ x = point.x, y = point.y, duration = self.talents.w5_invun }
		)
	else
		self:SpawnIllusion()
	end
end

function custom_terrorblade_conjure_image:SpawnIllusion(spaw_unit, attack_target)
	local duration = self.illusion_duration
	local outgoing = self.illusion_outgoing_damage
	local incoming = self.illusion_incoming_damage

	local position = 108
	local scramble = false
	local count = 1

	if self.talents.has_w5 == 1 then
		position = 0
		scramble = true
	end

	if spaw_unit then
		spaw_unit:EmitSound("Hero_Terrorblade.ConjureImage")
		duration = self.talents.w7_duration
		outgoing = self.talents.w7_damage - 100
		incoming = self.talents.w7_incoming - 100
		scramble = false

		local effect = ParticleManager:CreateParticle(
			"particles/generic/illusion_created.vpcf",
			PATTACH_CUSTOMORIGIN_FOLLOW,
			spaw_unit
		)
		ParticleManager:SetParticleControlEnt(
			effect,
			0,
			spaw_unit,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			spaw_unit:GetOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(effect)
	else
		if self.talents.has_w6 == 1 then
			self.caster:AddNewModifier(
				self.caster,
				self,
				"modifier_terrorblade_innate_custom_damage_reduce",
				{ duration = self.talents.w6_duration }
			)
		end

		self.caster:EmitSound("Hero_Terrorblade.ConjureImage")
	end

	local illusions = CreateIllusions(self.caster, self.caster, {
		outgoing_damage = outgoing,
		incoming_damage = incoming,
		bounty_base = nil,
		bounty_growth = nil,
		outgoing_damage_structure = nil,
		outgoing_damage_roshan = nil,
		duration = duration,
	}, count, position, scramble, true, spaw_unit ~= nil)

	for _, illusion in pairs(illusions) do
		illusion.owner = self.caster

		illusion:AddNewModifier(
			self.caster,
			self,
			"modifier_conjure_image_custom_illusion_basic",
			{ duration = duration, is_legendary = spaw_unit ~= nil }
		)

		if spaw_unit then
			illusion:SetOwner(nil)
			local point = spaw_unit:GetAbsOrigin() + Vector(100)
			illusion:SetAbsOrigin(point)
			FindClearSpaceForUnit(illusion, point, false)

			local target = nil
			if attack_target then
				target = attack_target
			end

			illusion:AddNewModifier(
				self.caster,
				self,
				"modifier_conjure_image_custom_legendary_illusion_mod",
				{ target = target }
			)
		end

		illusion:RemoveAbility("custom_terrorblade_reflection")
		illusion:RemoveAbility("custom_terrorblade_conjure_image")
		illusion:RemoveAbility("custom_terrorblade_metamorphosis")
		illusion:RemoveAbility("custom_terrorblade_sunder")
		illusion:RemoveAbility("custom_terrorblade_terror_wave")

		illusion:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)

		for _, mod in pairs(self.caster:FindAllModifiers()) do
			if mod.StackOnIllusion ~= nil and mod.StackOnIllusion == true then
				illusion:UpgradeIllusion(mod:GetName(), mod:GetStackCount())
			end
		end
	end
end

modifier_conjure_image_custom_tracker = class(mod_hidden)
function modifier_conjure_image_custom_tracker:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.ability.illusion_duration = self.ability:GetSpecialValueFor("illusion_duration")
	self.ability.illusion_outgoing_damage = self.ability:GetSpecialValueFor("illusion_outgoing_damage")
	self.ability.illusion_incoming_damage = self.ability:GetSpecialValueFor("illusion_incoming_damage")
	self.ability.illusion_max = self.ability:GetSpecialValueFor("illusion_max")
end

function modifier_conjure_image_custom_tracker:OnRefresh()
	self.ability.illusion_outgoing_damage = self.ability:GetSpecialValueFor("illusion_outgoing_damage")
end

function modifier_conjure_image_custom_tracker:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent:GetTeamNumber() ~= params.attacker:GetTeamNumber() then
		return
	end
	if not params.target:IsUnit() then
		return
	end

	local attacker = params.attacker

	if
		self.ability.talents.has_w7 == 1
		and attacker:IsIllusion()
		and attacker.owner
		and attacker.owner == self.parent
		and self:GetStackCount() < self.ability.talents.w7_max
	then
		if RollPseudoRandomPercentage(self.ability.talents.w7_chance, 1842, self.parent) then
			self.ability:SpawnIllusion(attacker, params.target:entindex())
		end
	end

	if self.ability.talents.has_w7 == 0 then
		return
	end
	if
		not attacker.owner
		or attacker.owner ~= self.parent
		or not attacker:IsIllusion()
		or not attacker.owner:IsAlive()
	then
		return
	end

	attacker.owner:GenericHeal(self.ability.talents.w7_heal, self.ability, true, "", "modifier_terror_illusion_7")
end

modifier_conjure_image_custom_invun = class(mod_hidden)
function modifier_conjure_image_custom_invun:OnCreated(table)
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	if not IsServer() then
		return
	end

	self.parent:AddNoDraw()
	self.parent:NoDraw(self)

	self.origin = self.parent:GetAbsOrigin()
	self.point = GetGroundPosition(Vector(table.x, table.y, 0), nil)

	local vec = (self.point - self.origin):Normalized()
	vec.z = 0
	self.parent:FaceTowards(self.origin + vec * 10)
	self.parent:SetForwardVector(vec)

	local point_1 = self.point + Vector(0, 0, 150)
	local point_2 = self.origin + Vector(0, 0, 150)

	EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "TB.Image_blink_start", self.parent)
	EmitSoundOnLocationWithCaster(self.parent:GetAbsOrigin(), "TB.Image_blink_start2", self.parent)

	local effect_cast =
		ParticleManager:CreateParticle("particles/terrorblade/image_blink.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, self.point + Vector(0, 0, 100))
	ParticleManager:SetParticleControl(effect_cast, 1, self.origin + Vector(0, 0, 100))
	ParticleManager:SetParticleControl(effect_cast, 2, self.point)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_conjure_image_custom_invun:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.parent or self.parent:IsNull() then
		return
	end

	self.parent:RemoveNoDraw()
	self.parent:SetAbsOrigin(self.point)

	if not self.parent:HasModifier("modifier_custom_terrorblade_metamorphosis") then
		self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_3_END)
	end

	self.parent:Stop()

	FindClearSpaceForUnit(self.parent, self.point, false)
	self.ability:SpawnIllusion()
end

function modifier_conjure_image_custom_invun:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

modifier_conjure_image_custom_legendary_illusion_mod = class(mod_hidden)
function modifier_conjure_image_custom_legendary_illusion_mod:OnCreated(table)
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.target = nil

	if table.target then
		self.target = EntIndexToHScript(table.target)
	end

	self.mod = self.caster:FindModifierByName("modifier_conjure_image_custom_tracker")
	if self.mod then
		self.mod:IncrementStackCount()
	end

	self:OnIntervalThink()
	self:StartIntervalThink(0.5)
end

function modifier_conjure_image_custom_legendary_illusion_mod:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.mod or self.mod:IsNull() then
		return
	end
	self.mod:DecrementStackCount()
end

function modifier_conjure_image_custom_legendary_illusion_mod:OnIntervalThink()
	if not IsServer() then
		return
	end

	local target = nil

	if self.target and not self.target:IsNull() and self.target:IsAlive() then
		target = self.target
	else
		target = self.parent:FindTargets(1000)[1]
	end

	if not target then
		return
	end

	self.target = target
	self.parent:SetForceAttackTarget(target)
	self.parent:MoveToTargetToAttack(target)
end

function modifier_conjure_image_custom_legendary_illusion_mod:CheckState()
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end

modifier_conjure_image_custom_illusion_basic = class(mod_hidden)
function modifier_conjure_image_custom_illusion_basic:OnCreated(table)
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.max = self.ability.illusion_max
	if not IsServer() then
		return
	end
	self.is_legendary = table.is_legendary

	if self.is_legendary and self.is_legendary == 1 then
		return
	end

	local count = 0
	local min_duration = 9999
	local min_index = nil

	for index, _ in pairs(self.ability.illusions) do
		count = count + 1
		local unit = EntIndexToHScript(index)
		if unit and not unit:IsNull() then
			local mod = unit:FindModifierByName(self:GetName())
			if mod and mod:GetRemainingTime() <= min_duration then
				min_duration = mod:GetRemainingTime()
				min_index = index
			end
		end
		if count >= self.max and min_index then
			local unit = EntIndexToHScript(min_index)
			if unit and not unit:IsNull() then
				unit:Kill(nil, nil)
			end
			break
		end
	end

	self.ability.illusions[self.parent:entindex()] = true
end

function modifier_conjure_image_custom_illusion_basic:OnDestroy(table)
	if not IsServer() then
		return
	end
	if self.is_legendary and self.is_legendary == 1 then
		return
	end

	self.ability.illusions[self.parent:entindex()] = nil
end