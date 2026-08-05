--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


techies_land_mines_lua = class({})

LinkLuaModifier(
	"modifier_land_mines",
	"heroes/hero_techies/techies_land_mines/techies_land_mines.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_land_mines_explose_delay",
	"heroes/hero_techies/techies_land_mines/techies_land_mines.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_dummy_thinker",
	"heroes/hero_techies/techies_land_mines/techies_land_mines.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_range_indicator",
	"heroes/hero_techies/techies_land_mines/techies_land_mines.lua",
	LUA_MODIFIER_MOTION_NONE
)

modifier_dummy_thinker = {}

function techies_land_mines_lua:IsHidden()
	return false
end
function techies_land_mines_lua:IsRefreshable()
	return true
end
function techies_land_mines_lua:IsStealable()
	return true
end
function techies_land_mines_lua:IsNetherWardStealable()
	return false
end
function techies_land_mines_lua:GetAOERadius()
	return self:GetSpecialValueFor("small_radius")
end

function techies_land_mines_lua:CastFilterResultLocation(location)
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self
		local radius = self:GetSpecialValueFor("small_radius")
		local friendly_units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			location,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_ALL,
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
			FIND_ANY_ORDER,
			false
		)

		local banan_found = false
		for _, unit in pairs(friendly_units) do
			local unitName = unit:GetUnitName()
			if unitName == "land_mine_trap" then
				banan_found = true
				break
			end
		end

		if banan_found then
			return UF_FAIL_CUSTOM
		else
			return UF_SUCCESS
		end
	end
end

function techies_land_mines_lua:GetCustomCastErrorLocation(location)
	return "Cannot place mine in range of other mines"
end

function techies_land_mines_lua:OnSpellStart()
	local caster = self:GetCaster()
	local pos = self:GetCursorPosition()
	local count = 1

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_techies_int2")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		count = 2
	end

	for i = 1, count do
		local mine = CreateUnitByName(
			"land_mine_trap",
			pos + RandomVector(RandomInt(count * 10, count * 10)),
			true,
			caster,
			caster,
			caster:GetTeamNumber()
		)
		mine:EmitSound("Hero_Techies.LandMine.Plant")
		mine:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
		mine:AddNewModifier(caster, self, "modifier_land_mines", {})
		mine:AddNewModifier(caster, self, "modifier_kill", { duration = 600 })
		mine:AddNewModifier(caster, nil, "modifier_range_indicator", {
			sAttribute = nil,
			iRange = self:GetSpecialValueFor("small_radius"),
			iRed = 150,
			iGreen = 22,
			iBlue = 22,
			bShowOnCooldown = false,
			bShowAlways = true,
			bWithCastRangeIncrease = true,
			bRemoveOnDeath = true,
		})
	end
end

---------------------------------------------------------------------------------------------------

modifier_range_indicator = modifier_range_indicator or class({})
function modifier_range_indicator:IsDebuff()
	return false
end
function modifier_range_indicator:IsHidden()
	return true
end
function modifier_range_indicator:IsPurgable()
	return false
end
function modifier_range_indicator:IsPurgeException()
	return false
end
function modifier_range_indicator:IsStunDebuff()
	return false
end
function modifier_range_indicator:RemoveOnDeath()
	return self.bRemoveOnDeath
end

-------------------------------------------

function modifier_range_indicator:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_range_indicator:OnCreated(params)
	if not IsServer() then
		return
	end

	self.range_pfx = ParticleManager:CreateParticleForPlayer(
		"particles/range_indicator.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent(),
		self:GetCaster():GetPlayerOwner()
	)
	ParticleManager:SetParticleControl(self.range_pfx, 1, Vector(params.iRed, params.iGreen, params.iBlue))
	self.hAbility = self:GetAbility()
	self.iRange = params.iRange
	self.bRemoveOnDeath = params.bRemoveOnDeath or true
	self.sAttribute = params.sAttribute
	self.bShowOnCooldown = params.bShowOnCooldown
	self.bShowAlways = params.bShowAlways
	self.bWithCastRangeIncrease = params.bWithCastRangeIncrease
	self:StartIntervalThink(0.2)
end

function modifier_range_indicator:OnIntervalThink()
	if not IsServer() then
		return
	end

	if not self:GetCaster():IsAlive() then
		self:StartIntervalThink(-1)
		self:Destroy()
		return
	end

	local caster = self:GetCaster()

	if (caster:IsAlive() or (self.bShowAlways == 1)) and self.hAbility then
		if (self.hAbility:IsCooldownReady() or (self.bShowOnCooldown == 1)) and not caster.norange then
			self.iRange = self.hAbility:GetSpecialValueFor(self.sAttribute)
			if self.bWithCastRangeIncrease then
				self.iRange = self.iRange + GetCastRangeIncrease(caster)
			end
			ParticleManager:SetParticleControl(self.range_pfx, 3, Vector(self.iRange, 0, 0))
		else
			ParticleManager:SetParticleControl(self.range_pfx, 3, Vector(0, 0, 0))
		end
	elseif
		(caster:IsAlive() or (self.bShowAlways == 1))
		and self.iRange
		and not caster.norange
		and not self.hAbility
	then
		ParticleManager:SetParticleControl(self.range_pfx, 3, Vector(self.iRange, 0, 0))
	end
end

function modifier_range_indicator:OnDestroy()
	if not IsServer() then
		return
	end
	if self.range_pfx then
		ParticleManager:DestroyParticle(self.range_pfx, true)
		ParticleManager:ReleaseParticleIndex(self.range_pfx)
	end
end
---------------------------------------------------------------------------------------------------

modifier_land_mines = class({})

function modifier_land_mines:IsDebuff()
	return false
end

function modifier_land_mines:IsHidden()
	return true
end

function modifier_land_mines:IsPurgable()
	return false
end

function modifier_land_mines:IsPurgeException()
	return false
end

function modifier_land_mines:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_MAX,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
end

function modifier_land_mines:GetModifierMoveSpeed_Max()
	return 0
end

function modifier_land_mines:GetModifierMoveSpeed_Absolute()
	return 0
end

function modifier_land_mines:GetDisableHealing()
	return 1
end

function modifier_land_mines:CheckState()
	return {
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
end

function modifier_land_mines:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_land_mines:OnCreated()
	self.ability = self:GetCaster():FindAbilityByName("techies_land_mines_lua")
	self.mine = self:GetParent()
	self.caster = self:GetCaster()
	self.damage = self.ability:GetSpecialValueFor("damage")
	self.small_radius = self.ability:GetSpecialValueFor("small_radius")

	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end

function modifier_land_mines:OnIntervalThink()
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.mine:GetAbsOrigin(),
		self.mine,
		self.small_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_ANY_ORDER,
		false
	)
	if #enemies > 0 and not self.mine:HasModifier("modifier_land_mines_explose_delay") then
		local sound = CreateModifierThinker(
			self.caster,
			self.ability,
			"modifier_dummy_thinker",
			{ duration = 0.5 },
			self.mine:GetAbsOrigin(),
			self.caster:GetTeamNumber(),
			false
		)
		local sound_cast = "Hero_Techies.RemoteMine.Priming"
		-- EmitSoundOnLocationWithCaster(sound:GetAbsOrigin(), sound_cast, sound)
		EmitSoundOn(sound_cast, sound)
		self.mine:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_land_mines_explose_delay",
			{ duration = self.ability:GetSpecialValueFor("activation_time") }
		)
	end
end

function modifier_land_mines:OnDestroy()
	if IsServer() and self:GetStackCount() > 0 then
		local ampl = self:GetParent():GetOwner():GetSpellAmplification(false) + 1
		mine_damage = self.ability:GetSpecialValueFor("damage") * ampl

		local enemies = FindUnitsInRadius(
			self.caster:GetTeamNumber(),
			self.mine:GetAbsOrigin(),
			self.mine,
			self.small_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in pairs(enemies) do
			ApplyDamage({
				victim = enemy,
				attacker = self.mine,
				damage = mine_damage,
				damage_type = self.ability:GetAbilityDamageType(),
				ability = self.ability,
			})
		end

		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(pfx, 0, self.mine:GetAbsOrigin())
		ParticleManager:SetParticleControl(pfx, 2, Vector(self.small_radius, self.small_radius, self.small_radius))
		Timers:CreateTimer(5.0, function()
			ParticleManager:DestroyParticle(pfx, true)
			ParticleManager:ReleaseParticleIndex(pfx)
			return nil
		end)
		local sound = CreateModifierThinker(
			self.caster,
			self.ability,
			"modifier_dummy_thinker",
			{ duration = 0.5 },
			self.mine:GetAbsOrigin(),
			self.caster:GetTeamNumber(),
			false
		)
		sound:EmitSound("Hero_Techies.RemoteMine.Detonate")
		self:GetParent():ForceKill(false)
	end
	self.ability = nil
	self.mine = nil
	self.caster = nil
	self.damage = nil
	self.small_radius = nil
end

---------------------------------------------------------------------------

modifier_land_mines_explose_delay = class({})

function modifier_land_mines_explose_delay:IsDebuff()
	return false
end
function modifier_land_mines_explose_delay:IsHidden()
	return true
end
function modifier_land_mines_explose_delay:IsPurgable()
	return false
end
function modifier_land_mines_explose_delay:IsPurgeException()
	return false
end

function modifier_land_mines_explose_delay:OnDestroy()
	self.small_radius = self:GetAbility():GetSpecialValueFor("small_radius")

	if IsServer() then
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			self:GetParent(),
			self.small_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER,
			false
		)
		if #enemies > 0 and self:GetElapsedTime() >= self:GetDuration() then
			local buff = self:GetParent():FindModifierByName("modifier_land_mines")
			if buff then
				buff:SetStackCount(1)
				buff:Destroy()
			end
		end
	end
end