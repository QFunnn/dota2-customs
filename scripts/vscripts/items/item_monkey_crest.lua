--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_monkey_crest", "items/item_monkey_crest.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_monkey_crest_friendly", "items/item_monkey_crest.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_monkey_crest_enemy", "items/item_monkey_crest.lua", LUA_MODIFIER_MOTION_NONE )

if item_monkey_crest == nil then
	item_monkey_crest = class({})
end

function item_monkey_crest:GetIntrinsicModifierName()
	return "modifier_item_monkey_crest"
end

function item_monkey_crest:GetAOERadius()
	return self:GetSpecialValueFor("mark_radius")
end

function item_monkey_crest:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not target then
		return
	end

	local Radius = self:GetSpecialValueFor("mark_radius")
	local Duration = self:GetSpecialValueFor("mark_duration")

	if caster:GetTeamNumber() ~= target:GetTeamNumber() and target:TriggerSpellAbsorb(self) then
		return
	end

	if caster:GetTeamNumber() ~= target:GetTeamNumber() then
		target:AddNewModifier(caster, self, "modifier_item_monkey_crest_enemy", {duration=Duration})
	else
		target:AddNewModifier(caster, self, "modifier_item_monkey_crest_friendly", {duration=Duration})
	end

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
		if unit ~= target then
			if not unit:TriggerSpellAbsorb(self) then
				if caster:GetTeamNumber() ~= unit:GetTeamNumber() then
					unit:AddNewModifier(caster, self, "modifier_item_monkey_crest_enemy", {duration=Duration})
				else
					unit:AddNewModifier(caster, self, "modifier_item_monkey_crest_friendly", {duration=Duration})
				end
			end
		end
	end
end

modifier_item_monkey_crest = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsPermanent             = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
			MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
			MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
			MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
			MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
			MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
			MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
			MODIFIER_PROPERTY_HEALTH_BONUS,
			MODIFIER_PROPERTY_MANA_BONUS,
			MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
			MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,

			MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
			MODIFIER_EVENT_ON_ATTACK_RECORD,
			MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		}
	end,

	CheckState				= function(self)
		local State = {}

		if self.bPierce then
			State = {
				[MODIFIER_STATE_CANNOT_MISS] = true,
			}
		end

		return State
	end,

	GetModifierBonusStats_Agility			= function(self) return self.All or 0 end,
	GetModifierBonusStats_Strength			= function(self) return self.All or 0 end,
	GetModifierBonusStats_Intellect			= function(self) return self.All or 0 end,
	GetModifierAttackSpeedBonus_Constant	= function(self) return self.Attackspeed or 0 end,
	GetModifierPreAttack_BonusDamage		= function(self, params)
		local bonus = self.Damage or 0
		if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
			_G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "item_monkey_crest", DAMAGE_TYPE_PHYSICAL)
		end
		return bonus
	end,
	GetModifierPhysicalArmorBonus			= function(self) return self.Armor or 0 end,
	GetModifierConstantManaRegen			= function(self) return self.MpRegen or 0 end,
	GetModifierConstantHealthRegen			= function(self) return self.HpRegen or 0 end,
	GetModifierHealthBonus					= function(self) return self.HealthBonus or 0 end,
	GetModifierManaBonus					= function(self) return self.ManaBonus or 0 end,
	GetModifierMoveSpeedBonus_Constant		= function(self) return self.MoveSpeedBonus or 0 end,
	GetModifierAttackRangeBonus				= function(self)
		-- Vanilla MKB: бонус к атаке только для melee героев.
		local parent = self:GetParent()
		if parent and not parent:IsRangedAttacker() then
			return self.AttackRangeBonus or 0
		end
		return 0
	end,

	OnCreated				= function(self)
		self.bPierce = false
		self.PierceAttacks = {}

		self:OnRefresh()

		if not IsServer() then return end

		local parent = self:GetParent()

		for _, modifier in pairs(parent:FindAllModifiersByName(self:GetName())) do
			modifier:SetStackCount(_)
		end

		-- Т.к пробитие работает на следующую тычку то нужно первую изначально отработать
		if self:GetStackCount() == 1 then
			self.bPierce = RollPseudoRandomPercentage(self.PierceChance, DOTA_PSEUDO_RANDOM_ITEM_MKB, parent)
		end
	end,

	OnRefresh				= function(self)
		local Ability = self:GetAbility()
		if Ability then
			self.All = Ability:GetSpecialValueFor("bonus_all_stats")
			self.Attackspeed = Ability:GetSpecialValueFor("bonus_attack_speed")
			self.Damage = Ability:GetSpecialValueFor("bonus_damage")
			self.Armor = Ability:GetSpecialValueFor("bonus_armor")
			self.MpRegen = Ability:GetSpecialValueFor("bonus_mana_regen")
			self.HpRegen = Ability:GetSpecialValueFor("bonus_hp_regen")
			self.HealthBonus = Ability:GetSpecialValueFor("bonus_health")
			self.ManaBonus = Ability:GetSpecialValueFor("bonus_mana")
			self.MoveSpeedBonus = Ability:GetSpecialValueFor("bonus_movement_speed")
			self.AttackRangeBonus = Ability:GetSpecialValueFor("bonus_attack_range_melee")

			self.PierceChance = Ability:GetSpecialValueFor("pierce_passive_chance")
			self.PierceDamage = Ability:GetSpecialValueFor("pierce_damage")
		end
	end,

	OnDestroy				= function(self)
		if not IsServer() then return end

		for _, modifier in pairs(self:GetParent():FindAllModifiersByName(self:GetName())) do
			modifier:SetStackCount(_)
		end
	end,

	OnAttackRecord		= function(self, event)
		local parent = self:GetParent()

		if event.attacker ~= parent then return end

		local bPierce = self.bPierce
		self.bPierce = false

		if self:GetStackCount() ~= 1 or (parent and parent:HasModifier("modifier_item_monkey_crest_friendly")) then return end

		if bPierce then
			self.PierceAttacks[event.record] = true
		end

		if parent and RollPseudoRandomPercentage(self.PierceChance, DOTA_PSEUDO_RANDOM_ITEM_MKB, parent) then
			self.bPierce = true
		end
	end,

	GetModifierProcAttack_BonusDamage_Magical			= function(self, event)
		if self.PierceAttacks[event.record] and event.target then
			event.target:EmitSound("DOTA_Item.MKB.melee")
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, event.target, self.PierceDamage, nil)
			
			return self.PierceDamage
		end
	end,

	OnAttackRecordDestroy	= function(self, event)
		if event.attacker ~= self:GetParent() then return end

		if self.PierceAttacks[event.record] then
			self.PierceAttacks[event.record] = nil
		end
	end,
})

modifier_item_monkey_crest_friendly = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return false end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
			MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
			MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,

			MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
			MODIFIER_EVENT_ON_ATTACK_RECORD,
			MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,

			MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
		}
	end,

	CheckState				= function(self)
		local State = {}

		if self.bPierce then
			State = {
				[MODIFIER_STATE_CANNOT_MISS] = true,
			}
		end

		return State
	end,

	GetModifierAttackSpeedBonus_Constant	= function(self) return self.Attackspeed or 0 end,
	GetModifierMoveSpeedBonus_Percentage	= function(self) return self.Movespeed or 0 end,
	GetModifierPhysicalArmorBonus			= function(self) return self.Armor or 0 end,

	OnCreated				= function(self)
		self.bPierce = false
		self.PierceAttacks = {}

		if IsServer() then
			self:SetHasCustomTransmitterData(true)
		end

		self:OnRefresh()

		if not IsServer() then return end

		local parent = self:GetParent()

		self.bPierce = RollPseudoRandomPercentage(self.PierceChance, DOTA_PSEUDO_RANDOM_ITEM_MKB, parent)

		-- Чтобы шанс на выпадение пробития был непрерывным
		for _, modif in ipairs(parent:FindAllModifiersByName("modifier_item_monkey_crest")) do
			if modif:GetStackCount() == 1 then
				modif.bPierce = false
			end
		end

		local fx = ParticleManager:CreateParticle("particles/items3_fx/star_emblem_friend.vpcf", PATTACH_OVERHEAD_FOLLOW, parent)
		ParticleManager:SetParticleControlEnt( fx, 1, parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), true )
		self:AddParticle(fx, false, false, -1, false, true)
		
		fx = ParticleManager:CreateParticle("particles/items2_fx/pavise_friend.vpcf", PATTACH_CUSTOMORIGIN, parent)
		ParticleManager:SetParticleControlEnt(fx, 1, parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), true)
		ParticleManager:SetParticleControlEnt(fx, 0, parent, PATTACH_OVERHEAD_FOLLOW, nil, Vector(0,0,0), true)
		self:AddParticle(fx, false, false, -1, false, false)

	end,

	OnDestroy				= function(self)
		if not IsServer() then return end

		local parent = self:GetParent()
		if not parent then return end

		-- Чтобы шанс на выпадение пробития был непрерывным
		for _, modif in ipairs(parent:FindAllModifiersByName("modifier_item_monkey_crest")) do
			if modif:GetStackCount() == 1 then
				modif.bPierce = RollPseudoRandomPercentage(modif.PierceChance or 0, DOTA_PSEUDO_RANDOM_ITEM_MKB, parent)
				
				for record, _ in pairs(self.PierceAttacks) do
					if _ ~= nil then
						modif.PierceAttacks[record] = _
					end
				end
			end
		end
	end,

	OnRefresh				= function(self)
		local Ability = self:GetAbility()
		if Ability then
			self.Attackspeed = Ability:GetSpecialValueFor("mark_friendly_bonus_attack_speed")
			self.Movespeed = Ability:GetSpecialValueFor("mark_friendly_bonus_movespeed_pct")
			self.Armor = Ability:GetSpecialValueFor("mark_friendly_bonus_armor")

			self.PierceChance = Ability:GetSpecialValueFor("mark_friendly_pierce_chance")
			self.PierceDamage = Ability:GetSpecialValueFor("pierce_damage")

			self.BarrierPct = Ability:GetSpecialValueFor("mark_friendly_physical_barrier_pct")
		end

		if IsServer() then
			self.BarrierMaxHealth = math.floor(self:GetParent():GetMaxHealth() * 0.01 * self.BarrierPct)
			self.BarrierCurrentHealth = self.BarrierMaxHealth

			self:SendBuffRefreshToClients()

			self:GetParent():EmitSound("Item.StarEmblem.Friendly")
		end
	end,

	AddCustomTransmitterData		= function(self)
		self.TransmitterTable = self.TransmitterTable or {}

		self.TransmitterTable.BarrierMaxHealth = self.BarrierMaxHealth
		self.TransmitterTable.BarrierCurrentHealth = self.BarrierCurrentHealth

		return self.TransmitterTable
	end,

	HandleCustomTransmitterData		= function(self, data)
		self.BarrierMaxHealth = data.BarrierMaxHealth
		self.BarrierCurrentHealth = data.BarrierCurrentHealth
	end,

	OnAttackRecord		= function(self, event)
		if not IsServer() then return end

		local parent = self:GetParent()

		if event.attacker ~= parent then return end

		if self.bPierce then
			self.bPierce = false
			self.PierceAttacks[event.record] = true
		end

		if parent and RollPseudoRandomPercentage(self.PierceChance, DOTA_PSEUDO_RANDOM_ITEM_MKB, parent) then
			self.bPierce = true
		end
	end,

	GetModifierProcAttack_BonusDamage_Magical			= function(self, event)
		if self.PierceAttacks[event.record] and event.target then
			event.target:EmitSound("DOTA_Item.MKB.melee")
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, event.target, self.PierceDamage, nil)
			
			return self.PierceDamage
		end
	end,

	OnAttackRecordDestroy	= function(self, event)
		if event.attacker ~= self:GetParent() then return end

		if self.PierceAttacks[event.record] then
			self.PierceAttacks[event.record] = nil
		end
	end,

	GetModifierIncomingPhysicalDamageConstant			= function(self, event)
		if IsClient() then
			if event.report_max then
				return self.BarrierMaxHealth
			else
				return self.BarrierCurrentHealth
			end
		end

		if event.damage_type == DAMAGE_TYPE_PHYSICAL then
			if event.original_damage >= self.BarrierCurrentHealth then
				self.BarrierCurrentHealth = 0
				self.BarrierMaxHealth = 0
				self:SendBuffRefreshToClients()
				return self.BarrierCurrentHealth * (-1)
			else
				self.BarrierCurrentHealth = self.BarrierCurrentHealth - event.original_damage
				self:SendBuffRefreshToClients()
				return event.original_damage * (-1)
			end
		end
	end,
})

modifier_item_monkey_crest_enemy = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsPurgeException        = function(self) return true end,
    IsDebuff                = function(self) return true end,
    GetAttributes           = function(self) return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end,

	DeclareFunctions		= function(self)
		return {
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
			MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
			MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,

			MODIFIER_PROPERTY_MISS_PERCENTAGE,
		}
	end,

	GetModifierAttackSpeedBonus_Constant	= function(self) return self.Attackspeed or 0 end,
	GetModifierMoveSpeedBonus_Percentage	= function(self) return self.Movespeed or 0 end,
	GetModifierPhysicalArmorBonus			= function(self) return self.Armor or 0 end,
	GetModifierMiss_Percentage	= function(self) return self.Miss or 0 end,

	OnCreated				= function(self)
		self:OnRefresh()

		if not IsServer() then return end

		local parent = self:GetParent()

		local fx = ParticleManager:CreateParticle("particles/items3_fx/star_emblem.vpcf", PATTACH_OVERHEAD_FOLLOW, parent)
		ParticleManager:SetParticleControlEnt( fx, 1, parent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), true )
		self:AddParticle(fx, false, false, -1, false, true)
	end,

	OnRefresh				= function(self)
		local Ability = self:GetAbility()
		if Ability then
			self.Attackspeed = Ability:GetSpecialValueFor("mark_enemy_bonus_attack_speed")
			self.Movespeed = Ability:GetSpecialValueFor("mark_enemy_bonus_movespeed_pct")
			self.Armor = Ability:GetSpecialValueFor("mark_enemy_bonus_armor")

			self.Miss = Ability:GetSpecialValueFor("mark_enemy_miss_chance")
		end

		if IsServer() then
			self:GetParent():EmitSound("Item.StarEmblem.Enemy")
		end
	end,
})