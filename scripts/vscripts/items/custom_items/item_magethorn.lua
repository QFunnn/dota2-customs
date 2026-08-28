--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_magethorn_lua", "items/custom_items/item_magethorn", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_magethorn_lua_effect", "items/custom_items/item_magethorn", LUA_MODIFIER_MOTION_NONE)

item_magethorn_lua1 = item_magethorn_lua1 or class({})
item_magethorn_lua2 = item_magethorn_lua1 or class({})
item_magethorn_lua3 = item_magethorn_lua1 or class({})

function item_magethorn_lua1:GetIntrinsicModifierName()
	return "modifier_item_magethorn_lua"
end

function item_magethorn_lua1:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:IsMagicImmune() then return end

	target:AddNewModifier(self:GetCaster(), self, "modifier_item_magethorn_lua_effect", {duration = self:GetSpecialValueFor("duration")})
end

------------------------------------------------------------------------

modifier_item_magethorn_lua = class({})

function modifier_item_magethorn_lua:IsHidden() return true end

function modifier_item_magethorn_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_magethorn_lua:OnCreated()
	self.bonus_all_stats = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_magethorn_lua:DeclareFunctions() return {
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
} end

function modifier_item_magethorn_lua:GetModifierBonusStats_Strength()
	return self.bonus_all_stats
end

function modifier_item_magethorn_lua:GetModifierBonusStats_Agility()
	return self.bonus_all_stats
end

function modifier_item_magethorn_lua:GetModifierBonusStats_Intellect()
	return self.bonus_all_stats
end

------------------------------------------------------------------------

modifier_item_magethorn_lua_effect = class({})
function modifier_item_magethorn_lua_effect:IsHidden() return false end
function modifier_item_magethorn_lua_effect:IsDebuff() return true end
function modifier_item_magethorn_lua_effect:IsPurgable() return true end

function modifier_item_magethorn_lua_effect:GetEffectName()
	return "particles/items2_fx/orchid.vpcf"
end

function modifier_item_magethorn_lua_effect:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_item_magethorn_lua_effect:OnCreated()
	if IsServer() then
        if not self:GetAbility() then self:Destroy() end
    end

	if IsServer() then
		local owner = self:GetParent()
		owner.orchid_damage_storage = owner.orchid_damage_storage or 0
		self.damage_factor = self:GetAbility():GetSpecialValueFor("spell_power")
	end
end

function modifier_item_magethorn_lua_effect:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE
	}
end

function modifier_item_magethorn_lua_effect:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = true
		[MODIFIER_STATE_SILENCED] = true
	}
end

-- Track damage taken
function modifier_item_magethorn_lua_effect:OnTakeDamage(keys)
	if IsServer() then
		local owner = self:GetParent()
		local target = keys.unit

		-- If this unit is the one suffering damage, store it
		if owner == target then
			owner.orchid_damage_storage = owner.orchid_damage_storage + keys.damage
		end
	end
end

-- When the debuff ends, deal damage
function modifier_item_magethorn_lua_effect:OnDestroy()
	if IsServer() then

		-- Parameters
		local owner = self:GetParent()
		local ability = self:GetAbility()
		local caster = ability:GetCaster()

		-- If damage was taken, play the effect and damage the owner
		if owner.orchid_damage_storage > 0 then

			-- Calculate and deal damage
			local damage = owner.orchid_damage_storage * self.damage_factor * 0.01
			ApplyDamage({attacker = caster, victim = owner, ability = ability, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})

			-- Fire damage particle
			local orchid_end_pfx = ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_OVERHEAD_FOLLOW, owner)
			ParticleManager:SetParticleControl(orchid_end_pfx, 0, owner:GetAbsOrigin())
			ParticleManager:SetParticleControl(orchid_end_pfx, 1, Vector(100, 0, 0))
			ParticleManager:ReleaseParticleIndex(orchid_end_pfx)
		end

		-- Clear damage taken variable
		self:GetParent().orchid_damage_storage = nil
	end
end