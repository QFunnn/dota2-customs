--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_emerald_shell", "items/custom_items/item_emerald_shell", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_emerald_shell_active", "items/custom_items/item_emerald_shell", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_emerald_shell_block", "items/custom_items/item_emerald_shell", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_emerald_shell_ready", "items/custom_items/item_emerald_shell", LUA_MODIFIER_MOTION_NONE)

item_emerald_shell_1 = item_emerald_shell_1 or class({})
item_emerald_shell_2 = item_emerald_shell_1 or class({})
item_emerald_shell_3 = item_emerald_shell_1 or class({})

function item_emerald_shell_1:Precache(context)
	PrecacheResource("particle", "particles/items_fx/black_king_bar_avatar.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/immunity_sphere.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_shield_shell.vpcf", context)
	PrecacheResource("soundfile", "sounds/items/black_king_bar.vsnd", context)
	PrecacheResource("soundfile", "sounds/items/linkens_sphere.vsnd", context)
end

function item_emerald_shell_1:GetIntrinsicModifierName()
	return "modifier_item_emerald_shell"
end

function item_emerald_shell_1:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")

	caster:Purge(false, true, false, false, false)

	caster:AddNewModifier(caster, self, "modifier_item_emerald_shell_active", { duration = duration })
	EmitSoundOn("DOTA_Item.BlackKingBar.Activate", caster)
end

--------------------------------------------------------------------------------

modifier_item_emerald_shell = class({})

function modifier_item_emerald_shell:IsHidden()
	return true
end
function modifier_item_emerald_shell:IsPurgable()
	return false
end
function modifier_item_emerald_shell:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_emerald_shell:OnCreated()
	local ability = self:GetAbility()

	self.bonus_strength = ability:GetSpecialValueFor("bonus_strength")
	self.bonus_agility = ability:GetSpecialValueFor("bonus_agility")
	self.bonus_intelligence = ability:GetSpecialValueFor("bonus_intelligence")
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage")
	self.bonus_health_regen = ability:GetSpecialValueFor("bonus_health_regen")
	self.bonus_mana_regen = ability:GetSpecialValueFor("bonus_mana_regen")
	self.block_cooldown = ability:GetSpecialValueFor("block_cooldown")

	if IsServer() then
		self:StartIntervalThink(0.1)
	end
end

function modifier_item_emerald_shell:OnIntervalThink()
	if IsServer() then
		local parent = self:GetParent()
		local ability = self:GetAbility()
		if not parent:HasModifier("modifier_item_emerald_shell_block") then
			if not parent:HasModifier("modifier_item_emerald_shell_ready") then
				parent:AddNewModifier(parent, ability, "modifier_item_emerald_shell_ready", {})
			end
		end
	end
end

function modifier_item_emerald_shell:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_ABSORB_SPELL,
	}
end

function modifier_item_emerald_shell:GetModifierBonusStats_Strength()
	return self.bonus_strength
end
function modifier_item_emerald_shell:GetModifierBonusStats_Agility()
	return self.bonus_agility
end
function modifier_item_emerald_shell:GetModifierBonusStats_Intellect()
	return self.bonus_intelligence
end
function modifier_item_emerald_shell:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end
function modifier_item_emerald_shell:GetModifierConstantHealthRegen()
	return self.bonus_health_regen
end
function modifier_item_emerald_shell:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end

function modifier_item_emerald_shell:GetAbsorbSpell(event)
	local parent = self:GetParent()
	local ability = self:GetAbility()

	if event.ability and event.ability:GetCaster():GetTeamNumber() ~= parent:GetTeamNumber() then
		if not parent:HasModifier("modifier_item_emerald_shell_block") then
			local pfx = ParticleManager:CreateParticle(
				"particles/items_fx/immunity_sphere.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				parent
			)
			ParticleManager:ReleaseParticleIndex(pfx)
			parent:EmitSound("DOTA_Item.LinkensSphere.Target")

			parent:RemoveModifierByName("modifier_item_emerald_shell_ready")
			parent:AddNewModifier(
				parent,
				ability,
				"modifier_item_emerald_shell_block",
				{ duration = self.block_cooldown }
			)

			return 1
		end
	end

	return 0
end

--------------------------------------------------------------------------------

modifier_item_emerald_shell_ready = class({})
function modifier_item_emerald_shell_ready:IsHidden()
	return false
end
function modifier_item_emerald_shell_ready:IsPurgable()
	return false
end
function modifier_item_emerald_shell_ready:GetTexture()
	return "new/item_emerald_shell_2"
end

--------------------------------------------------------------------------------

modifier_item_emerald_shell_block = class({})
function modifier_item_emerald_shell_block:IsHidden()
	return false
end
function modifier_item_emerald_shell_block:IsDebuff()
	return true
end
function modifier_item_emerald_shell_block:IsPurgable()
	return false
end
function modifier_item_emerald_shell_block:RemoveOnDeath()
	return false
end
function modifier_item_emerald_shell_block:GetTexture()
	return "new/item_emerald_shell_3"
end

--------------------------------------------------------------------------------

modifier_item_emerald_shell_active = class({})

function modifier_item_emerald_shell_active:IsHidden()
	return false
end
function modifier_item_emerald_shell_active:IsPurgable()
	return false
end

function modifier_item_emerald_shell_active:GetEffectName()
	return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_item_emerald_shell_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_emerald_shell_active:OnCreated()
	local ability = self:GetAbility()
	if not ability then
		return
	end

	self.model_scale = ability:GetSpecialValueFor("model_scale")
	if not self.model_scale or self.model_scale == 0 then
		self.model_scale = 30
	end
end

function modifier_item_emerald_shell_active:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true, -- Для старых версий
	}
end

function modifier_item_emerald_shell_active:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_item_emerald_shell_active:GetModifierModelScale()
	return self.model_scale or 30
end