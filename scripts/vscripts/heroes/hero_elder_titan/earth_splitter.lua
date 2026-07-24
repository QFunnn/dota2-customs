--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_elder_titan_earth_splitter_thinker", "heroes/hero_elder_titan/earth_splitter.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ability_elder_titan_earth_splitter", "heroes/hero_elder_titan/earth_splitter.lua", LUA_MODIFIER_MOTION_NONE )

if ability_elder_titan_earth_splitter == nil then
	ability_elder_titan_earth_splitter = class({})
end

function ability_elder_titan_earth_splitter:OnSpellStart()
	local caster = self:GetCaster()
	local casterPos = caster:GetAbsOrigin()

	local Distance = self:GetSpecialValueFor("crack_distance")
	local CrackDelay = self:GetSpecialValueFor("crack_time")

	local Position = GetGroundPosition(self:GetCursorPosition(), caster)
	if Position == casterPos then
		Position = Position + caster:GetForwardVector()
	end
	
	local Direction = CalculateDirection(Position, caster)
	local EndPos = casterPos + Direction * Distance

	CreateModifierThinker(
		caster, 
		self, 
		"modifier_ability_elder_titan_earth_splitter_thinker", 
		{
			duration = CrackDelay,
			start_x = casterPos.x,
			start_y = casterPos.y,
			end_x = EndPos.x,
			end_y = EndPos.y,
		}, 
		caster:GetAbsOrigin(), 
		caster:GetTeamNumber(), 
		false
	)

	EmitSoundOn("Hero_ElderTitan.EarthSplitter.Cast", caster)

	local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_elder_titan/elder_titan_earth_splitter.vpcf", PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(fx, 0, casterPos)
	ParticleManager:SetParticleControl(fx, 1, EndPos+Direction*315)
	ParticleManager:SetParticleControl(fx, 3, Vector(0, CrackDelay, 0))
end

modifier_ability_elder_titan_earth_splitter_thinker = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	OnCreated				= function(self, table)
		local ability = self:GetAbility()
		if ability then
			self.Width = ability:GetSpecialValueFor("crack_width")
			self.SlowDuration = ability:GetSpecialValueFor("slow_duration")
			self.DamagePct = ability:GetSpecialValueFor("damage_pct")
		end

		if not IsServer() then return end

		self.StartPos = Vector(table.start_x, table.start_y, 0)
		self.EndPos = Vector(table.end_x, table.end_y, 0)
	end,

	OnDestroy				= function(self)
		if not IsServer() then return end

		local caster = self:GetCaster()
		local parent = self:GetParent()
		local ability = self:GetAbility()
		
		if not caster or not parent or self.StartPos == nil or self.EndPos == nil or not ability then return end

		local Direction = CalculateDirection(self.EndPos, self.StartPos)

		local enemies = FindUnitsInLine(
			caster:GetTeamNumber(), 
			self.StartPos, 
			self.EndPos, 
			nil, 
			self.Width, 
			ability:GetAbilityTargetTeam(), 
			ability:GetAbilityTargetType(), 
			ability:GetAbilityTargetFlags()
		)

		for _, enemy in pairs(enemies) do
			-- [NP-25] Не задевать цели в ДРУГОЙ арене: Earth Splitter частично перехлёстывает
			-- в соседнюю арену, а :Interrupt() и FindClearSpaceForUnit (форс-мув) ниже НЕ
			-- фильтруются (в отличие от урона/слоу) и сбивали чужой каст. Пропускаем межаренные.
			if not Players:IsUnitCanAttackOrCastOnThis(caster, enemy) then goto continue end

			local Damage = (enemy:GetMaxHealth() * self.DamagePct * 0.01) * 0.5

			if (enemy:GetUnitName() ~= "npc_dota_roshan" and enemy:GetUnitName() ~= "npc_dota_nian" and Rounds:GetCurrentRound() < 90) or enemy:IsHero() or (GetRealUnit(enemy) ~= nil and GetRealUnit(enemy):IsRealHero()) then
				ApplyDamage({
					victim = enemy, 
					attacker = caster, 
					damage = Damage, 
					damage_type = DAMAGE_TYPE_PHYSICAL, 
					ability = ability
				})
				ApplyDamage({
					victim = enemy, 
					attacker = caster, 
					damage = Damage, 
					damage_type = DAMAGE_TYPE_MAGICAL, 
					ability = ability
				})
			end

			if enemy:IsAlive() then
				enemy:Interrupt()
				enemy:AddNewModifier(caster, ability, "modifier_ability_elder_titan_earth_splitter", {duration = self.SlowDuration * (1 - enemy:GetStatusResistance())})

				local ClosestPoint = FindNearestPointFromLine(self.StartPos, Direction, enemy:GetAbsOrigin())
				FindClearSpaceForUnit(enemy, ClosestPoint, false)
			end

			::continue::
		end

		EmitSoundOn("Hero_ElderTitan.EarthSplitter.Destroy", caster)
	end
})

function FindNearestPointFromLine(caster, dir, affected)
	local castertoaffected = affected - caster
	local len = castertoaffected:Dot(dir)
	local ntgt = Vector(dir.x * len, dir.y * len, caster.z)
	return caster + ntgt
end

modifier_ability_elder_titan_earth_splitter = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
		}
	end,

	GetModifierMoveSpeedBonus_Percentage		= function(self) return -(self.Slow or 0) end,

	OnCreated				= function(self, table)
		self:OnRefresh()
	end,

	OnRefresh				= function(self, table)
		local ability = self:GetAbility()
		if ability then
			self.Slow = ability:GetSpecialValueFor("slow_pct")
		end
	end,
})