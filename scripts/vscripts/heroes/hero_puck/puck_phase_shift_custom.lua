--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_puck_phase_shift_custom", "heroes/hero_puck/puck_phase_shift_custom", LUA_MODIFIER_MOTION_NONE)

puck_phase_shift_custom = class({})

function puck_phase_shift_custom:OnSpellStart()
	if not IsServer() then return end

	if self:GetCaster():GetName() == "npc_dota_hero_puck" then
		self:GetCaster():EmitSound("puck_puck_ability_phase_0"..RandomInt(1, 7))
	end

	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_puck_phase_shift_custom", {duration = self:GetSpecialValueFor("duration") + FrameTime()})
end

function puck_phase_shift_custom:OnChannelFinish(interrupted)
	if not IsServer() then return end
	local modifier = self:GetCaster():FindModifierByName("modifier_puck_phase_shift_custom")
	if modifier and not modifier:IsNull() then
		modifier:Destroy()
	end
end

modifier_puck_phase_shift_custom = class({})

function modifier_puck_phase_shift_custom:OnRefresh(table)
	self:OnCreated(table)
end

function modifier_puck_phase_shift_custom:IsPurgable() return false end

function modifier_puck_phase_shift_custom:OnCreated(table)
	if not IsServer() then return end
	self.origin = self:GetParent():GetAbsOrigin()
	self:GetParent():EmitSound("Hero_Puck.Phase_Shift")
	ProjectileManager:ProjectileDodge(self:GetParent())

	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_puck/puck_phase_shift.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetParent(), PATTACH_CUSTOMORIGIN_FOLLOW, nil, self:GetParent():GetOrigin(), true )
	self:AddParticle( nFXIndex, false, false, -1, false, false )

	local nStatusFX = ParticleManager:CreateParticle( "particles/status_fx/status_effect_phase_shift.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControlEnt( nStatusFX, 0, self:GetParent(), PATTACH_CUSTOMORIGIN_FOLLOW, nil, self:GetParent():GetOrigin(), true )
	self:AddParticle( nStatusFX, false, true, 75, false, false )

	local parent = self:GetParent()

	if self:GetParent():HasShard() then
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetParent():Script_GetAttackRange() + self:GetAbility():GetSpecialValueFor("shard_attack_range_bonus"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )
		for i, enemy in pairs(enemies) do
			Timers:CreateTimer(0.07 * i, function()
				if enemy and not enemy:IsNull() and enemy:IsAlive() and not enemy:IsAttackImmune() and not enemy:IsInvulnerable() then
					parent:PerformAttack(enemy, true, true, true, false, true, false, false)
				end
			end)
		end
	end

	self:StartIntervalThink(0.03)
	self:GetParent():AddEffects( EF_NODRAW )
end

function modifier_puck_phase_shift_custom:OnIntervalThink()
	if not IsServer() then return end
	-- Фиксируем позицию — баш не сдвинет героя во время Phase Shift
	self:GetParent():SetAbsOrigin(self.origin)
end

function modifier_puck_phase_shift_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():SetAbsOrigin(self.origin)
	self:GetParent():RemoveEffects( EF_NODRAW )
	self:GetParent():StopSound("Hero_Puck.Phase_Shift")
end

function modifier_puck_phase_shift_custom:CheckState()
	local state =
	{
		[MODIFIER_STATE_INVULNERABLE] 	= true,
		[MODIFIER_STATE_OUT_OF_GAME]	= true,
		[MODIFIER_STATE_UNSELECTABLE]	= true,
		[MODIFIER_STATE_NO_HEALTH_BAR]  = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION]  = true,
		[MODIFIER_STATE_DISARMED]		= true,
		-- [MODIFIER_STATE_ROOTED]			= true,
	}
	return state
end

function modifier_puck_phase_shift_custom:GetModifierInvisibilityLevel()
	return 1.0
end

function modifier_puck_phase_shift_custom:DeclareFunctions()
	local funcs =
	{
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}

	return funcs
end