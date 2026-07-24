--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_crystal_maiden_frostbite_custom", "heroes/hero_crystal_maiden/crystal_maiden_frostbite_custom", LUA_MODIFIER_MOTION_NONE )

crystal_maiden_frostbite_custom = class({})

function crystal_maiden_frostbite_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

-- Проверяем цель для применения способности
function crystal_maiden_frostbite_custom:CastFilterResultTarget(hTarget)
	if hTarget == self:GetCaster() then
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end

function crystal_maiden_frostbite_custom:GetCustomCastErrorTarget(hTarget)
	if hTarget == self:GetCaster() then
		return "#dota_hud_error_cant_cast_frostbite_on_self"
	end
	return ""
end

function crystal_maiden_frostbite_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor("radius")

	if target then
		if not target:TriggerSpellAbsorb(self) then
			local duration = self:GetSpecialValueFor("duration")
			if not target:IsHero() then
				duration = self:GetSpecialValueFor("creep_duration")
			end
			
			-- Проверяем, является ли цель крипом с берсерком
			local creepControllModifier = target:FindModifierByName("modifier_creep_controll")
			local isBerserked = creepControllModifier and creepControllModifier:GetStackCount() > 0
			
			-- Применяем стан только если это не крип с берсерком
			if not isBerserked then
				local stun_duration = 0.1
				target:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration })
			end
			
			-- Применяем основной модификатор в любом случае
			target:AddNewModifier(caster, self, "modifier_crystal_maiden_frostbite_custom", { duration = duration * ( 1 - target:GetStatusResistance() ), is_berserked = isBerserked })
			self:PlayEffects( caster, target )

			-- Проверяем юнитов в радиусе действия
			local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
			for _, enemy in pairs(enemies) do
				-- Пропускаем основную цель
				if enemy ~= target then
					local duration = self:GetSpecialValueFor("duration")
					if not enemy:IsHero() then
						duration = self:GetSpecialValueFor("creep_duration")
					end
					
					-- Применяем стан только если это не крип с берсерком
					local creepControllModifier = enemy:FindModifierByName("modifier_creep_controll")
					local isBerserked = creepControllModifier and creepControllModifier:GetStackCount() > 0
					
					if not isBerserked then
						local stun_duration = 0.1
						enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration })
					end
					
					-- Применяем основной модификатор в любом случае
					enemy:AddNewModifier(caster, self, "modifier_crystal_maiden_frostbite_custom", { duration = duration * ( 1 - enemy:GetStatusResistance() ), is_berserked = isBerserked })
					self:PlayEffects( caster, enemy )
				end
			end
		end
	end
end

function crystal_maiden_frostbite_custom:PlayEffects( caster, target )
	local info = {Target = target,Source = caster,Ability = self,EffectName = "particles/units/heroes/hero_crystalmaiden/maiden_frostbite.vpcf",iMoveSpeed = 1000,vSourceLoc= caster:GetAbsOrigin(),bDodgeable = false}
	ProjectileManager:CreateTrackingProjectile(info)
end

modifier_crystal_maiden_frostbite_custom = class({})

function modifier_crystal_maiden_frostbite_custom:IsHidden()
	return false
end

function modifier_crystal_maiden_frostbite_custom:IsDebuff()
	return true
end

function modifier_crystal_maiden_frostbite_custom:IsStunDebuff()
	return false
end

function modifier_crystal_maiden_frostbite_custom:IsPurgable()
	return true
end

function modifier_crystal_maiden_frostbite_custom:OnCreated( kv )
	local tick_damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	self.interval = self:GetAbility():GetSpecialValueFor("tick_interval")
	
	if IsServer() then
		-- Проверяем, является ли цель крипом с берсерком
		self.isBerserked = (kv ~= nil and kv.is_berserked == 1)
		
		-- Если параметр не передан, проверяем наличие модификатора
		if self.isBerserked == nil then
			local creepControllModifier = self:GetParent():FindModifierByName("modifier_creep_controll")
			self.isBerserked = creepControllModifier and creepControllModifier:GetStackCount() > 0
		end
		
		self.damageTable = {victim = self:GetParent(),attacker = self:GetCaster(),damage = tick_damage*self.interval,damage_type = DAMAGE_TYPE_MAGICAL,ability = self:GetAbility()}
		self:StartIntervalThink( self.interval )
		self:GetParent():EmitSound("hero_Crystal.frostbite")
	end
end

function modifier_crystal_maiden_frostbite_custom:OnRefresh( kv )
	self:OnCreated()
end

function modifier_crystal_maiden_frostbite_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("hero_Crystal.frostbite")
end

function modifier_crystal_maiden_frostbite_custom:CheckState()
	-- Если цель - крип с берсерком, не применяем обездвиживание и разоружение
	if self.isBerserked then
		-- Для крипов с берсерком только запрещаем невидимость
		return {[MODIFIER_STATE_INVISIBLE] = false}
	end
	
	-- Для всех остальных применяем стандартные эффекты
	local state = {[MODIFIER_STATE_DISARMED] = true,[MODIFIER_STATE_ROOTED] = true,[MODIFIER_STATE_INVISIBLE] = false}
	return state
end

function modifier_crystal_maiden_frostbite_custom:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

function modifier_crystal_maiden_frostbite_custom:GetEffectName()
	return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end

function modifier_crystal_maiden_frostbite_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end