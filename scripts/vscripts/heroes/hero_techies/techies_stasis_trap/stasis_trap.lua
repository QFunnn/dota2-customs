--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


techies_stasis_trap_lua = class({})

LinkLuaModifier(
	"modifier_stasis_trap",
	"heroes/hero_techies/techies_stasis_trap/stasis_trap.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_stasis_trap_active_delay",
	"heroes/hero_techies/techies_stasis_trap/stasis_trap.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_stasis_trap_explose_delay",
	"heroes/hero_techies/techies_stasis_trap/stasis_trap.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_stasis_trap_root_pfx",
	"heroes/hero_techies/techies_stasis_trap/stasis_trap.lua",
	LUA_MODIFIER_MOTION_NONE
)

function techies_stasis_trap_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function techies_stasis_trap_lua:CastFilterResultLocation(location)
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
			if unitName == "npc_dota_techies_stasis_trap" then
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

function techies_stasis_trap_lua:GetCustomCastErrorLocation(location)
	return "Cannot place mine in range of other mines"
end

function techies_stasis_trap_lua:OnSpellStart()
	local caster = self:GetCaster()
	local pos = self:GetCursorPosition()
	local mine = CreateUnitByName("npc_dota_techies_stasis_trap", pos, true, caster, caster, caster:GetTeamNumber())
	mine:EmitSound("Hero_Techies.StasisTrap.Plant")
	mine:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
	mine:AddNewModifier(
		caster,
		self,
		"modifier_stasis_trap_active_delay",
		{ duration = self:GetSpecialValueFor("activation_delay") }
	)
	mine:AddNewModifier(caster, self, "modifier_stasis_trap", {})
	mine:AddNewModifier(caster, self, "modifier_kill", { duration = 600 })
end

modifier_stasis_trap_active_delay = class({})

function modifier_stasis_trap_active_delay:IsDebuff()
	return false
end
function modifier_stasis_trap_active_delay:IsHidden()
	return true
end
function modifier_stasis_trap_active_delay:IsPurgable()
	return false
end
function modifier_stasis_trap_active_delay:IsPurgeException()
	return false
end
function modifier_stasis_trap_active_delay:GetEffectName()
	return "particles/units/heroes/hero_techies/techies_stasis_beams_heroelec.vpcf"
end

modifier_stasis_trap = class({})

function modifier_stasis_trap:IsDebuff()
	return false
end
function modifier_stasis_trap:IsHidden()
	return true
end
function modifier_stasis_trap:IsPurgable()
	return false
end
function modifier_stasis_trap:IsPurgeException()
	return false
end
function modifier_stasis_trap:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_MAX, MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE }
end
function modifier_stasis_trap:GetModifierMoveSpeed_Max()
	return 25
end
function modifier_stasis_trap:GetModifierMoveSpeed_Absolute()
	return 25
end
function modifier_stasis_trap:CheckState()
	return (
		self:GetParent():HasModifier("modifier_stasis_trap_active_delay")
			and { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
		or { [MODIFIER_STATE_INVISIBLE] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
	)
end

function modifier_stasis_trap:OnCreated()
	self:StartIntervalThink(0.1)
end

function modifier_stasis_trap:OnIntervalThink()
	if IsServer() then
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			self:GetParent(),
			self:GetAbility():GetSpecialValueFor("radius"),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		if
			#enemies > 0
			and not self:GetParent():HasModifier("modifier_stasis_trap_active_delay")
			and not self:GetParent():HasModifier("modifier_stasis_trap_explose_delay")
		then
			self:GetParent():AddNewModifier(
				self:GetCaster(),
				self:GetAbility(),
				"modifier_stasis_trap_explose_delay",
				{ duration = self:GetAbility():GetSpecialValueFor("explosion_delay") }
			)
		end
	end
end

function modifier_stasis_trap:OnDestroy()
	if IsServer() and self:GetStackCount() > 0 then
		local sound = CreateModifierThinker(
			self:GetCaster(),
			nil,
			"modifier_dummy_thinker",
			{ duration = 1.0 },
			self:GetParent():GetAbsOrigin(),
			self:GetCaster():GetTeamNumber(),
			false
		)
		sound:EmitSound("Hero_Techies.StasisTrap.Stun")
		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_techies/techies_stasis_trap_explode.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(pfx, 1, Vector(self:GetAbility():GetSpecialValueFor("radius"), 0, 0))
		Timers:CreateTimer(3.0, function()
			ParticleManager:DestroyParticle(pfx, true)
			ParticleManager:ReleaseParticleIndex(pfx)
			return nil
		end)
		self.duration = self:GetAbility():GetSpecialValueFor("root_duration")
		local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_techies_int1")
		if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
			self.duration = self.duration * 2
		end

		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			self:GetParent(),
			self:GetAbility():GetSpecialValueFor("radius"),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_rooted", { duration = self.duration })
			enemy:AddNewModifier(
				self:GetCaster(),
				self:GetAbility(),
				"modifier_stasis_trap_root_pfx",
				{ duration = self.duration }
			)
		end
	end
end

modifier_stasis_trap_explose_delay = class({})

function modifier_stasis_trap_explose_delay:IsDebuff()
	return false
end
function modifier_stasis_trap_explose_delay:IsHidden()
	return true
end
function modifier_stasis_trap_explose_delay:IsPurgable()
	return false
end
function modifier_stasis_trap_explose_delay:IsPurgeException()
	return false
end

function modifier_stasis_trap_explose_delay:OnDestroy()
	if IsServer() then
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			self:GetParent(),
			self:GetAbility():GetSpecialValueFor("radius"),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		if #enemies > 0 and self:GetElapsedTime() >= self:GetDuration() then
			local buff = self:GetParent():FindModifierByName("modifier_stasis_trap")
			if buff then
				buff:SetStackCount(1)
			end
			self:GetParent():ForceKill(false)
		end
	end
end

modifier_stasis_trap_root_pfx = class({})

function modifier_stasis_trap_root_pfx:IsDebuff()
	return true
end
function modifier_stasis_trap_root_pfx:IsHidden()
	return true
end
function modifier_stasis_trap_root_pfx:IsPurgable()
	return true
end
function modifier_stasis_trap_root_pfx:IsPurgeException()
	return true
end
function modifier_stasis_trap_root_pfx:GetStatusEffectName()
	return "particles/status_fx/status_effect_techies_stasis.vpcf"
end
function modifier_stasis_trap_root_pfx:StatusEffectPriority()
	return 15
end
function modifier_stasis_trap_root_pfx:GetEffectName()
	return "particles/units/heroes/hero_techies/techies_stasis_beams_heroelec.vpcf"
end

function modifier_stasis_trap_root_pfx:OnCreated()
	self.debuff_armor = self:GetAbility():GetSpecialValueFor("debuff_armor")
	self.debuff_resist = self:GetAbility():GetSpecialValueFor("debuff_resist")

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_techies_int1")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		self.debuff_armor = selfdebuff_armordebuff * 2
	end

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_techies_int1")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		self.debuff_resist = self.debuff_resist * 2
	end
end

function modifier_stasis_trap_root_pfx:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_stasis_trap_root_pfx:GetModifierPhysicalArmorBonus()
	local armor = self:GetParent():GetPhysicalArmorBaseValue() / 100
	return armor * self.debuff_armor * -1
end

function modifier_stasis_trap_root_pfx:GetModifierMagicalResistanceBonus()
	return self.debuff_resist * -1
end