--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_mjollnir_lua1 = item_mjollnir_lua1 or class({})
item_mjollnir_lua2 = item_mjollnir_lua1 or class({})
item_mjollnir_lua3 = item_mjollnir_lua1 or class({})

LinkLuaModifier("modifier_item_mjollnir", "items/custom_items/item_mjollnir_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_mjollnir_strike", "items/custom_items/item_mjollnir_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_mjollnir_active", "items/custom_items/item_mjollnir_lua.lua", LUA_MODIFIER_MOTION_NONE)

function item_mjollnir_lua1:GetIntrinsicModifierName()
	return "modifier_item_mjollnir"
end

function item_mjollnir_lua1:OnSpellStart()
	if not IsServer() then
		return
	end

	local target = self:GetCursorTarget()
	if target:IsBuilding() then
		return
	end

	local caster = self:GetCaster()
	if caster:GetTeamNumber() ~= target:GetTeam() then
		return
	end

	target:AddNewModifier(caster, self, "modifier_item_mjollnir_active", { duration = 15 })

	target:EmitSound("DOTA_Item.Mjollnir.Activate")
end

-------------------------------------------------------------------------------------
modifier_item_mjollnir_active = class({})

function modifier_item_mjollnir_active:GetTexture()
	return "item_mjollnir"
end

function modifier_item_mjollnir_active:GetEffectName()
	return "particles/items2_fx/mjollnir_shield.vpcf"
end

function modifier_item_mjollnir_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_mjollnir_active:OnCreated()
	if not IsServer() then
		return
	end

	self.static_chance = self:GetAbility():GetSpecialValueFor("static_chance")
	self.static_strikes = self:GetAbility():GetSpecialValueFor("static_strikes")
	self.static_damage = self:GetAbility():GetSpecialValueFor("static_damage")
	self.static_radius = self:GetAbility():GetSpecialValueFor("static_radius")
	self.static_cooldown = self:GetAbility():GetSpecialValueFor("static_cooldown")
end

function modifier_item_mjollnir_active:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_item_mjollnir_active:OnTakeDamage(keys)
	if not IsServer() then
		return
	end

	if self.onCooldown then
		return
	end

	local parent = self:GetParent()
	if parent ~= keys.unit then
		return
	end

	local attacker = keys.attacker
	if attacker == parent then
		return
	end
	if attacker:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end

	if keys.damage < 5 then
		return
	end

	if RandomInt(1, 5) ~= 5 then
		return
	end

	local nearbyUnits = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		parent,
		self.static_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
		FIND_ANY_ORDER,
		false
	)
	local nearbyUnitsLen = #nearbyUnits

	local leftStaticStrikes = self.static_strikes

	for i = 1, nearbyUnitsLen do
		local enemy = nearbyUnits[i]

		local particle =
			ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
		ParticleManager:SetParticleControlEnt(
			particle,
			0,
			enemy,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			enemy:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			particle,
			1,
			parent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			parent:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle)

		ApplyDamage({
			attacker = self:GetCaster(),
			victim = enemy,
			damage = self.static_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			ability = self:GetAbility(),
		})

		leftStaticStrikes = leftStaticStrikes - 1

		if leftStaticStrikes <= 0 then
			break
		end
	end

	if nearbyUnitsLen > 0 then
		parent:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")
	end

	self.onCooldown = true

	Timers:CreateTimer(0.3, function()
		if self:IsNull() then
			return
		end

		self.onCooldown = false
	end)
end

--------------------------------------------------------------------------------

modifier_item_mjollnir = class({})

function modifier_item_mjollnir:IsHidden()
	return true
end

function modifier_item_mjollnir:IsPurgable()
	return false
end

function modifier_item_mjollnir:RemoveOnDeath()
	return false
end

function modifier_item_mjollnir:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_mjollnir:OnCreated()
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")

	self.static_chance = self:GetAbility():GetSpecialValueFor("static_chance")
	self.static_strikes = self:GetAbility():GetSpecialValueFor("static_strikes")
	self.static_damage = self:GetAbility():GetSpecialValueFor("static_damage")
	self.static_radius = self:GetAbility():GetSpecialValueFor("static_radius")
	self.static_cooldown = self:GetAbility():GetSpecialValueFor("static_cooldown")

	self:StartIntervalThink(0.2)
end

function modifier_item_mjollnir:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_item_mjollnir:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_item_mjollnir:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end

function modifier_item_mjollnir:OnIntervalThink()
	self.prock = true
	self:StartIntervalThink(-1)
end

function modifier_item_mjollnir:OnAttackLanded(keys)
	if keys.attacker ~= self:GetParent() then
		return
	end
	if not self.prock then
		return
	end
	if self:GetParent():IsIllusion() then
		return
	end
	if keys.target:IsMagicImmune() or keys.target:IsBuilding() or keys.target:IsOther() then
		return
	end
	if self:GetParent():GetTeamNumber() == keys.target:GetTeamNumber() then
		return
	end
	if RandomInt(1, 5) ~= 5 then
		return
	end

	self:GetParent():EmitSound("Item.Maelstrom.Chain_Lightning")
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_mjollnir_strike", {
		starting_unit_entindex = keys.target:entindex(),
	})

	self.prock = nil
	self:StartIntervalThink(0.2)
end

-----------------------------------------------------------------------------

modifier_item_mjollnir_strike = class({})

function modifier_item_mjollnir_strike:IsHidden()
	return true
end
function modifier_item_mjollnir_strike:IsPurgable()
	return false
end
function modifier_item_mjollnir_strike:RemoveOnDeath()
	return false
end

function modifier_item_mjollnir_strike:OnCreated(kv)
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.chain_damage = self:GetAbility():GetSpecialValueFor("chain_damage")
	self.chain_strikes = self:GetAbility():GetSpecialValueFor("chain_strikes")
	self.chain_radius = self:GetAbility():GetSpecialValueFor("chain_radius")
	self.chain_delay = self:GetAbility():GetSpecialValueFor("chain_delay")

	self.starting_unit_entindex = kv.starting_unit_entindex

	self.units_affected = {}
	self.unit_counter = 0

	self:OnIntervalThink()
	self:StartIntervalThink(self.chain_delay)
end

function modifier_item_mjollnir_strike:OnIntervalThink()
	self.zapped = false

	for _, enemy in
		pairs(
			FindUnitsInRadius(
				self:GetCaster():GetTeamNumber(),
				self.current_unit:GetAbsOrigin(),
				self.current_unit,
				self.chain_radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
				FIND_CLOSEST,
				false
			)
		)
	do
		if not self.units_affected[enemy] then
			enemy:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")

			self.zap_particle = ParticleManager:CreateParticle(
				"particles/items_fx/chain_lightning.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self.current_unit,
				self:GetCaster()
			)

			if self.unit_counter == 0 then
				ParticleManager:SetParticleControlEnt(
					self.zap_particle,
					0,
					self:GetParent(),
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					self:GetParent():GetAbsOrigin(),
					true
				)
			else
				ParticleManager:SetParticleControlEnt(
					self.zap_particle,
					0,
					self.current_unit,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					self.current_unit:GetAbsOrigin(),
					true
				)
			end

			ParticleManager:SetParticleControlEnt(
				self.zap_particle,
				1,
				enemy,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				enemy:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControl(self.zap_particle, 2, Vector(1, 1, 1))
			ParticleManager:ReleaseParticleIndex(self.zap_particle)

			self.unit_counter = self.unit_counter + 1
			self.current_unit = enemy
			self.units_affected[self.current_unit] = true
			self.zapped = true

			ApplyDamage({
				victim = enemy,
				damage = self.chain_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
				attacker = self:GetCaster(),
				ability = self:GetAbility(),
			})

			break
		end
	end

	if (self.unit_counter >= self.chain_strikes and self.chain_strikes > 0) or not self.zapped then
		self:StartIntervalThink(-1)
		self:Destroy()
	end
end