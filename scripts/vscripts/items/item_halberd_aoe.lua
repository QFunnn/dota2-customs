--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_halberd_aoe", "items/item_halberd_aoe", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_halberd_aoe_disarm", "items/item_halberd_aoe", LUA_MODIFIER_MOTION_NONE )

item_halberd_aoe = class({})

function item_halberd_aoe:Precache(context)
	PrecacheResource("particle", "particles/items2_fx/heavens_halberd.vpcf", context)
end

function item_halberd_aoe:GetIntrinsicModifierName()
	return "modifier_item_halberd_aoe"
end

function item_halberd_aoe:GetAOERadius()
	return self:GetSpecialValueFor("aoe_radius")
end

function item_halberd_aoe:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- Проверяем, что цель указана
	if not target then
		return
	end

	local Radius = self:GetSpecialValueFor("aoe_radius")

	-- Проверяем Linken's Sphere на основной цели (только герои).
	-- Крипы (golden_roshling и пр.) не могут блокировать — disarm проходит сквозь.
	if target:IsHero() and target:TriggerSpellAbsorb(self) then
		-- Если Linken's Sphere сработал на герое, прекращаем выполнение
		return
	end

	-- Сначала применяем disarm к основной цели
	local Duration = target:IsRangedAttacker() and self:GetSpecialValueFor("disarm_range") or self:GetSpecialValueFor("disarm_melee")
	target:AddNewModifier(caster, self, "modifier_item_halberd_aoe_disarm", {duration=Duration})

	-- Затем ищем дополнительные цели вокруг основной цели
	local All = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetAbsOrigin(), 
		nil, 
		Radius, 
		self:GetAbilityTargetTeam(), 
		self:GetAbilityTargetType(), 
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 
		FIND_ANY_ORDER, 
		false 
	)

	for _, unit in pairs(All) do
		-- Пропускаем основную цель (уже обработали)
		if unit ~= target then
			-- Проверяем Linken's Sphere только на героях — крипы не блокируют.
			local blocked = unit:IsHero() and unit:TriggerSpellAbsorb(self)
			if not blocked then
				-- Применяем disarm (если цель — герой без Linken, либо крип)
				local Duration = unit:IsRangedAttacker() and self:GetSpecialValueFor("disarm_range") or self:GetSpecialValueFor("disarm_melee")
				unit:AddNewModifier(caster, self, "modifier_item_halberd_aoe_disarm", {duration=Duration})
			end
		end
	end
end

---------------------------------------------------------------------

modifier_item_halberd_aoe = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_HEALTH_BONUS,
			MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
			MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
			MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
			MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
			MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK
		}
	end,

	GetModifierHealthBonus					= function(self) return self.Health or 0 end,
	GetModifierConstantHealthRegen			= function(self) return self.HealthRegen or 0 end,
	GetModifierBonusStats_Agility			= function(self) return self.All or 0 end,
	GetModifierBonusStats_Strength			= function(self) return self.All or 0 end,
	GetModifierBonusStats_Intellect			= function(self) return self.All or 0 end,
})

function modifier_item_halberd_aoe:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.Health = ability:GetSpecialValueFor("bonus_health")
		self.HealthRegen = ability:GetSpecialValueFor("bonus_health_regen")
		self.All = ability:GetSpecialValueFor("bonus_all_stats")
		self.BlockMelee = ability:GetSpecialValueFor("block_damage_melee")
		self.BlockRanged = ability:GetSpecialValueFor("block_damage_ranged")
		self.BlockChance = ability:GetSpecialValueFor("block_chance")
	end
end

modifier_item_halberd_aoe.OnRefresh = modifier_item_halberd_aoe.OnCreated

function modifier_item_halberd_aoe:GetModifierPhysical_ConstantBlock()
	if self:GetAbility() and RollPseudoRandomPercentage(self.BlockChance, DOTA_PSEUDO_RANDOM_ITEM_VANGUARD, self:GetParent()) then
		if self:GetParent():IsRangedAttacker() then
			return self.BlockRanged
		else
			return self.BlockMelee
		end
	end
end

modifier_item_halberd_aoe_disarm = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,

    CheckState              = function(self) 
        return {
            [ MODIFIER_STATE_DISARMED ] = true,
        }
    end,

	GetEffectName			= function (self)
		return "particles/items2_fx/heavens_halberd.vpcf"
	end,
	GetEffectAttachType		= function (self)
		return PATTACH_ABSORIGIN_FOLLOW
	end,
})

function modifier_item_halberd_aoe_disarm:OnCreated()
    if not IsServer() then return end

    local parent = self:GetParent()
    
    EmitSoundOn("DOTA_Item.HeavensHalberd.Activate", parent)
end