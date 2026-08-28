--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tusk_walrus_punch_flying", "heroes/tusk/walrus_punch.lua", LUA_MODIFIER_MOTION_NONE)

---@class tusk_walrus_punch_lua : CDOTA_Ability_Lua
tusk_walrus_punch_lua = class({})

function tusk_walrus_punch_lua:GetIntrinsicModifierName()
	return "modifier_tusk_walrus_punch_lua"
end

function tusk_walrus_punch_lua:OnSpellStart(keys)
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if caster == nil or caster:IsNull() == true then
		return
	end

	target:AddNewModifier(caster, self, "modifier_tusk_walrus_punch_flying", { duration = 1 })
	target.is_moving = true

	local damage_owner = caster.damage_owner
	if damage_owner == nil or damage_owner:IsNull() == true then
		local particle = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_tusk/tusk_walruspunch_txt_ult.vpcf",
			PATTACH_ABSORIGIN,
			caster
		)
		ParticleManager:SetParticleControl(particle, 2, caster:GetAbsOrigin() + Vector(0, 0, 175))
		ParticleManager:ReleaseParticleIndex(particle)
		damage_owner = caster
	end

	caster:EmitSound("Hero_Tusk.WalrusPunch.Cast")
	target:EmitSound("Hero_Tusk.WalrusPunch.Target")

	--造成伤害
	local bonus_damage = self:GetSpecialValueFor("bonus_damage") or 0
	local crit_multiplier = self:GetSpecialValueFor("crit_multiplier") or 100
	local damage = damage_owner:GetAverageTrueAttackDamage(target) / 100.0 * crit_multiplier + bonus_damage

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self,
	})
end

---@class modifier_tusk_walrus_punch_flying : CDOTA_Modifier_Lua
modifier_tusk_walrus_punch_flying = class({})

---@override
function modifier_tusk_walrus_punch_flying:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = IsServer(), -- Not showing the status bar
	}
end

---@override
function modifier_tusk_walrus_punch_flying:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

---@override
function modifier_tusk_walrus_punch_flying:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

---@override
function modifier_tusk_walrus_punch_flying:OnCreated(keys)
	if IsServer() then
		self.air_time_duration = 1
		local max_height = 650
		-- The height that needs to be gained when the unit moves 1 unit.
		self.z_vel = max_height * 4
		self.direction = Vector(0, 0, self.z_vel)

		self:StartIntervalThink(FrameTime())
	end
end

---@override
function modifier_tusk_walrus_punch_flying:OnIntervalThink()
	local unit = self:GetParent()
	-- Decrease the z velocity
	self.direction.z = self.direction.z - (self.z_vel * 2 * FrameTime())
	unit:SetAbsOrigin(unit:GetAbsOrigin() + self.direction * FrameTime())
end

---@override
function modifier_tusk_walrus_punch_flying:OnDestroy()
	if IsServer() then
		-- Make sure the unit ends on the ground
		-- Don't think this is needed though, the engine sets unit to ground level on movement
		FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
		self:GetParent().is_moving = nil
	end
end