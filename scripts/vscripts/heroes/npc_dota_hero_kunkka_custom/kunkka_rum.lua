--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kunkka_rum", "heroes/npc_dota_hero_kunkka_custom/kunkka_rum", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_rum_debuff", "heroes/npc_dota_hero_kunkka_custom/kunkka_rum", LUA_MODIFIER_MOTION_NONE)

kunkka_rum = class({})

function kunkka_rum:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():EmitSound("Hero_Kunkaa.Tidebringer")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kunkka_rum", {duration = duration})
end

modifier_kunkka_rum = class({})

function modifier_kunkka_rum:OnCreated()
	if IsServer() then
		self.damage_counter = 0
		self:GetAbility():SetActivated(false)
	end
end

function modifier_kunkka_rum:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_kunkka_rum:GetModifierIncomingDamage_Percentage()
	return -self:GetAbility():GetSpecialValueFor("incoming_damage")
end

function modifier_kunkka_rum:DeclareFunctions()
	local decFuncs =
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return decFuncs
end

function modifier_kunkka_rum:OnTakeDamage( params )
	if IsServer() then
		if params.unit == self:GetParent() then
			local rum_reduction = (100 - self:GetAbility():GetSpecialValueFor("incoming_damage"))/100
			local prevented_damage = params.damage / rum_reduction - params.damage
			self.damage_counter = self.damage_counter + prevented_damage
		end
	end
end

function modifier_kunkka_rum:OnDestroy()
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		self:GetParent():AddNewModifier(caster, ability, "modifier_kunkka_rum_debuff", { duration = ability:GetSpecialValueFor("duration"), stored_damage = self.damage_counter })
		self.damage_counter = 0
		if not self:GetCaster():IsAlive() then
			self:GetAbility():SetActivated(true)
		end
	end
end

function modifier_kunkka_rum:GetStatusEffectName()
	return "particles/status_fx/status_effect_rum.vpcf"
end

function modifier_kunkka_rum:StatusEffectPriority()
	return 10
end

function modifier_kunkka_rum:IsPurgeException() return false end

function modifier_kunkka_rum:IsHidden()
	return false
end

function modifier_kunkka_rum:IsPurgable()
	return false
end

function modifier_kunkka_rum:IsDebuff( )
	return false
end

modifier_kunkka_rum_debuff = class({})

function modifier_kunkka_rum_debuff:IsHidden()
	return false
end

function modifier_kunkka_rum_debuff:IsPurgable()
	return false
end

function modifier_kunkka_rum_debuff:IsPurgeException() return false end

function modifier_kunkka_rum_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_kunkka_rum_debuff:OnCreated( params )
	if IsServer() then
		local ability = self:GetAbility()
		local parent = self:GetParent()
		local damage_duration = ability:GetSpecialValueFor("duration")
		local damage_interval = 1
		local ticks = damage_duration / damage_interval
		local damage_amount = params.stored_damage / ticks
		damage_amount = math.abs(damage_amount)
		local current_tick = 0
		Timers:CreateTimer(damage_interval, function()
			if parent:IsAlive() then
				local target_hp = parent:GetHealth()
				if target_hp - damage_amount < 1 then
					parent:SetHealth(1)
				else
					parent:SetHealth(target_hp - damage_amount)
				end
				current_tick = current_tick + 1
				if current_tick >= ticks then
					return nil
				else
					return damage_interval
				end
			else
				return nil
			end
		end)
	end
end

function modifier_kunkka_rum_debuff:OnDestroy()
	if not IsServer() then return end
	self:GetAbility():SetActivated(true)
end