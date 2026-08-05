--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


item_veil_of_discord_lua1 = item_veil_of_discord_lua1 or class({})
item_veil_of_discord_lua2 = item_veil_of_discord_lua1 or class({})
item_veil_of_discord_lua3 = item_veil_of_discord_lua1 or class({})

LinkLuaModifier(
	"modifier_item_veil_of_discord_lua",
	"items/custom_items/item_veil_of_discord_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_veil_of_discord_active_lua",
	"items/custom_items/item_veil_of_discord_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_veil_of_discord_aura_lua",
	"items/custom_items/item_veil_of_discord_lua.lua",
	LUA_MODIFIER_MOTION_NONE
)

function item_veil_of_discord_lua1:GetIntrinsicModifierName()
	return "modifier_item_veil_of_discord_lua"
end

function item_veil_of_discord_lua1:OnSpellStart()
	-- Ability properties
	local caster = self:GetCaster()
	local target_loc = self:GetCursorPosition()
	local particle = "particles/items2_fx/veil_of_discord.vpcf"

	-- Emit sound
	caster:EmitSound("DOTA_Item.VeilofDiscord.Activate")

	-- Emit the particle
	local particle_fx = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle_fx, 0, target_loc)
	ParticleManager:SetParticleControl(particle_fx, 1, Vector(self:GetSpecialValueFor("debuff_radius"), 1, 1))
	ParticleManager:ReleaseParticleIndex(particle_fx)

	-- Find units around the target point
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target_loc,
		nil,
		self:GetSpecialValueFor("debuff_radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		0,
		FIND_ANY_ORDER,
		false
	)

	-- Iterate through the unit table and give each unit its respective modifier
	for _, enemy in pairs(enemies) do
		-- Give enemies a debuff
		enemy:AddNewModifier(
			caster,
			self,
			"modifier_item_veil_of_discord_active_lua",
			{ duration = self:GetSpecialValueFor("resist_debuff_duration") * (1 - enemy:GetStatusResistance()) }
		)
	end
end
-----------------------------------------------------------------------------------
modifier_item_veil_of_discord_active_lua = class({})

function modifier_item_veil_of_discord_active_lua:IsDebuff()
	return true
end
function modifier_item_veil_of_discord_active_lua:IsHidden()
	return false
end
function modifier_item_veil_of_discord_active_lua:IsPurgable()
	return true
end

function modifier_item_veil_of_discord_active_lua:OnCreated()
	self.spell_amp = self:GetAbility():GetSpecialValueFor("spell_amp")
end

function modifier_item_veil_of_discord_active_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_item_veil_of_discord_active_lua:GetModifierIncomingDamage_Percentage(keys)
	if IsClient() or keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then
		return self.spell_amp
	end
end

function modifier_item_veil_of_discord_active_lua:GetEffectName()
	return "particles/items2_fx/veil_of_discord_debuff.vpcf"
end

-----------------------------------------------------------------------------------

modifier_item_veil_of_discord_lua = class({})

function modifier_item_veil_of_discord_lua:IsHidden()
	return true
end

function modifier_item_veil_of_discord_lua:OnCreated()
	self.bonus_all_stats = self:GetAbility():GetSpecialValueFor("bonus_all_stats")
end

function modifier_item_veil_of_discord_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_veil_of_discord_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_item_veil_of_discord_lua:GetModifierBonusStats_Strength()
	return self.bonus_all_stats
end

function modifier_item_veil_of_discord_lua:GetModifierBonusStats_Agility()
	return self.bonus_all_stats
end

function modifier_item_veil_of_discord_lua:GetModifierBonusStats_Intellect()
	return self.bonus_all_stats
end

-------------------------------------------------------------------------------

function modifier_item_veil_of_discord_lua:GetModifierAura()
	return "modifier_item_veil_of_discord_aura_lua"
end

function modifier_item_veil_of_discord_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

function modifier_item_veil_of_discord_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_veil_of_discord_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_item_veil_of_discord_lua:IsAura()
	return true
end

function modifier_item_veil_of_discord_lua:GetAuraRadius()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("aura_radius")
	end
end

------------------------------------------------------------------------------

modifier_item_veil_of_discord_aura_lua = class({})

function modifier_item_veil_of_discord_aura_lua:IsHidden()
	return false
end
function modifier_item_veil_of_discord_aura_lua:IsPurgable()
	return false
end
function modifier_item_veil_of_discord_aura_lua:RemoveOnDeath()
	return false
end
function modifier_item_veil_of_discord_aura_lua:IsAuraActiveOnDeath()
	return false
end

function modifier_item_veil_of_discord_aura_lua:OnCreated()
	self.aura_mana_regen = self:GetAbility():GetSpecialValueFor("aura_mana_regen")
end
function modifier_item_veil_of_discord_aura_lua:OnRefresh()
	self:OnCreated()
end

function modifier_item_veil_of_discord_aura_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_item_veil_of_discord_aura_lua:GetModifierConstantManaRegen()
	return self.aura_mana_regen
end