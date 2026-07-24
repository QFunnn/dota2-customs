--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_hex_aoe", "items/item_hex_aoe", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_hex_aoe_hex", "items/item_hex_aoe", LUA_MODIFIER_MOTION_NONE )

item_hex_aoe = class({})

function item_hex_aoe:Precache(context)
	PrecacheResource("particle", "particles/items_fx/item_sheepstick.vpcf", context)
end

function item_hex_aoe:GetIntrinsicModifierName()
	return "modifier_item_hex_aoe"
end

function item_hex_aoe:GetAOERadius()
	return self:GetSpecialValueFor("aoe_radius")
end

function item_hex_aoe:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- Проверяем, что цель указана
	if not target then
		return
	end

	local Radius = self:GetSpecialValueFor("aoe_radius")
	local Duration = self:GetSpecialValueFor("sheep_duration")

	-- Проверяем Linken's Sphere на основной цели (только герои).
	-- Крипы (golden_roshling и пр.) не могут блокировать — hex проходит сквозь.
	if target:IsHero() and target:TriggerSpellAbsorb(self) then
		-- Если Linken's Sphere сработал на герое, прекращаем выполнение
		return
	end

	-- Применяем hex к основной цели (как обычный hex)
	if target:IsIllusion() then
		target:Kill(self, caster)
	else
		-- Применяем с учетом сопротивления к эффектам
		target:AddNewModifier(caster, self, "modifier_item_hex_aoe_hex", {
			duration = Duration * (1 - target:GetStatusResistance())
		})
	end

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
			if blocked then
				-- Герой заблокировал hex через Linken — пропускаем, остальных продолжаем
			elseif unit:IsIllusion() then
				unit:Kill(self, caster)
			else
				-- Применяем hex (герой без Linken или крип) с учётом сопротивления к эффектам
				unit:AddNewModifier(caster, self, "modifier_item_hex_aoe_hex", {
					duration = Duration * (1 - unit:GetStatusResistance())
				})
			end
		end
	end
end

---------------------------------------------------------------------

modifier_item_hex_aoe = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
			MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
		}
	end,

	GetModifierBonusStats_Intellect			= function(self) return self.Int or 0 end,
	GetModifierConstantManaRegen			= function(self) return self.ManaRegen or 0 end,
})

function modifier_item_hex_aoe:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.Int = ability:GetSpecialValueFor("bonus_intellect")
		self.ManaRegen = ability:GetSpecialValueFor("bonus_mana_regen")
	end
end

modifier_item_hex_aoe.OnRefresh = modifier_item_hex_aoe.OnCreated


modifier_item_hex_aoe_hex = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,
    IsStunDebuff            = function(self) return true end,

    CheckState              = function(self) 
        return {
            [ MODIFIER_STATE_HEXED ]=true,
            [ MODIFIER_STATE_MUTED ] = true,
            [ MODIFIER_STATE_DISARMED ] = true,
            [ MODIFIER_STATE_SILENCED ] = true,
            [ MODIFIER_STATE_BLOCK_DISABLED ] = true,
            [ MODIFIER_STATE_EVADE_DISABLED ] = true
        }
    end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_MODEL_CHANGE,
            MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE
        }
    end,

    GetModifierModelChange    = function(self) 
        return "models/props_gameplay/pig_blue.vmdl"
    end,
    GetModifierMoveSpeedOverride    = function(self) 
        return self.MovementSpeed or 0
    end,
})

function modifier_item_hex_aoe_hex:OnCreated()
	local ability = self:GetAbility()
	if ability then
		self.MovementSpeed = ability:GetSpecialValueFor("sheep_movement_speed")
	end

    if not IsServer() then return end

    local parent = self:GetParent()

    ParticleManager:ReleaseParticleIndex(ParticleManager:CreateParticle("particles/items_fx/item_sheepstick.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent))
    
    EmitSoundOn("DOTA_Item.Sheepstick.Activate", parent)
end

function modifier_item_hex_aoe_hex:OnDestroy()
    if not IsServer() then return end
    
    local parent = self:GetParent()

    parent:FadeGesture(ACT_DOTA_FLAIL)
end