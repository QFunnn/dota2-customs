--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dark_seer_surge_lua", "heroes/hero_dark_seer/dark_seer_surge_lua.lua", LUA_MODIFIER_MOTION_NONE)

if dark_seer_surge_lua == nil then
	dark_seer_surge_lua = class({}) ---@class dark_seer_surge_lua : CDOTA_Ability_Lua
end

function dark_seer_surge_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function dark_seer_surge_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")
	local target = self:GetCursorTarget()
	EmitSoundOn("Hero_Dark_Seer.Surge", caster)
	if not IsValid(target) then ---@cast target CDOTA_BaseNPC
		return
	end

	if radius > 0 then
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetAbsOrigin(),
			nil,
			radius,
			self:GetAbilityTargetTeam(),
			self:GetAbilityTargetType(),
			self:GetAbilityTargetFlags(),
			FIND_ANY_ORDER,
			false
		)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				target:AddNewModifier(caster, self, "modifier_dark_seer_surge_lua", { duration = duration })
			end
		end
	else
		target:AddNewModifier(caster, self, "modifier_dark_seer_surge_lua", { duration = duration })
	end
end

---------------------------------------------------------------------
if modifier_dark_seer_surge_lua == nil then
	modifier_dark_seer_surge_lua = class({}) ---@class modifier_dark_seer_surge_lua : CDOTA_Modifier_Lua
end

function modifier_dark_seer_surge_lua:OnCreated(params)
	self.speed_boost = self:GetAbility():GetSpecialValueFor("speed_boost")
	if not IsServer() then return end

	local hParent = self:GetParent()
	self:StartIntervalThink(0)
	self.vPos = hParent:GetAbsOrigin()
	self.fLength = 0
	self:OnIntervalThink()
end

function modifier_dark_seer_surge_lua:OnRefresh(params)
	if IsServer() then
		self:OnIntervalThink()
	end
end

function modifier_dark_seer_surge_lua:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSLOWABLE] = true,
	}
end

function modifier_dark_seer_surge_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}
end

function modifier_dark_seer_surge_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_dark_seer_surge_lua:GetEffectName()
	return "particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf"
end

function modifier_dark_seer_surge_lua:GetModifierMoveSpeed_AbsoluteMin()
	return self.speed_boost
end

function modifier_dark_seer_surge_lua:OnIntervalThink()
	local ability = self:GetAbility()
	if not ability then return end

	local cd_reduce = ability:GetSpecialValueFor("cd_reduce")
	local cd_min = ability:GetSpecialValueFor("cd_min")
	if self:GetAbility() ~= nil then
		local hParent = self:GetParent()
		local vPos_current = hParent:GetAbsOrigin()
		local length = (vPos_current - self.vPos):Length2D() or 0
		self.fLength = self.fLength + length
		self.fLength = math.min(self.fLength, 1200)
		self.vPos = vPos_current
		local reduce_time = math.floor(self.fLength / 100)
		if reduce_time > 0 then
			self.fLength = 0
			for i = 1, reduce_time do
				if cd_reduce > 0 then
					local ability_list = {}
					for i = 0, hParent:GetAbilityCount() - 1 do
						local ability = hParent:GetAbilityByIndex(i)
						if ability ~= nil and (not ability:IsPassive()) and (not ability:IsHidden()) and string.find(ability:GetAbilityName(), "special_bonus_") == nil then
							if not ability:IsCooldownReady() then
								local cd_remain = ability:GetCooldownTimeRemaining()
								if cd_remain > cd_min and ability ~= self:GetAbility() then
									table.insert(ability_list, ability)
								end
							end
						end
					end
					if #ability_list > 0 then
						local target_ability = ability_list[RandomInt(1, #ability_list)]
						local cd_remain = target_ability:GetCooldownTimeRemaining()
						target_ability:EndCooldown()
						target_ability:StartCooldown(cd_remain - cd_reduce)
					end
				end
			end
		end
	end
end