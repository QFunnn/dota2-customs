--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_gravekeepers_cloak_lua", "heroes/hero_visage/visage_gravekeepers_cloak_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_gravekeepers_cloak_secondary_lua", "heroes/hero_visage/visage_gravekeepers_cloak_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_visage_gravekeepers_cloak_lua_shard_buff", "heroes/hero_visage/visage_gravekeepers_cloak_lua", LUA_MODIFIER_MOTION_NONE)

visage_gravekeepers_cloak_lua = class({})

function visage_gravekeepers_cloak_lua:GetIntrinsicModifierName()
	return "modifier_visage_gravekeepers_cloak_lua"
end

function visage_gravekeepers_cloak_lua:GetBehavior()
	if self:GetCaster():HasShard() then return DOTA_ABILITY_BEHAVIOR_NO_TARGET end

	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end
function visage_gravekeepers_cloak_lua:OnSpellStart()

	local caster = self:GetCaster()
	local stun_delay = self:GetSpecialValueFor("stun_delay")
	local stun_radius = self:GetSpecialValueFor("stun_radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local stun_damage = self:GetSpecialValueFor("stun_damage")
	if not caster or caster:IsNull() then return end

	if not caster:HasShard() then return end
	local shard_duration = self:GetSpecialValueFor("shard_duration")
	caster:AddNewModifier(caster, self, "modifier_visage_gravekeepers_cloak_lua_shard_buff", { duration = shard_duration })
	caster:StartGesture(self:GetCastAnimation())

	Timers:CreateTimer(stun_delay, function()
		local units = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, stun_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				unit:AddNewModifier(caster, self, "modifier_stunned", { duration = stun_duration * unit:GetStatusResistanceFactor(caster) })
				ApplyDamage({
					victim = unit,
					attacker = caster,
					damage = stun_damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self
				})
			end
		end
		local particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_stone_form.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(particleID, 1, Vector(stun_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particleID)

		return nil
	end)
end

modifier_visage_gravekeepers_cloak_lua = class({})

function modifier_visage_gravekeepers_cloak_lua:IsHidden() return false end
function modifier_visage_gravekeepers_cloak_lua:IsDebuff() return false end
function modifier_visage_gravekeepers_cloak_lua:IsPurgable() return false end
function modifier_visage_gravekeepers_cloak_lua:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_visage_gravekeepers_cloak_lua:IsAura() return true end
function modifier_visage_gravekeepers_cloak_lua:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end
function modifier_visage_gravekeepers_cloak_lua:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_visage_gravekeepers_cloak_lua:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_visage_gravekeepers_cloak_lua:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_visage_gravekeepers_cloak_lua:GetModifierAura() return "modifier_visage_gravekeepers_cloak_secondary_lua" end

function modifier_visage_gravekeepers_cloak_lua:GetAuraEntityReject(hEntity)
	if not IsServer() then return false end

	-- reject if it's not familiar
	if hEntity:GetUnitName():find("npc_dota_visage_familiar") then
		return false
	end

	return true
end

function modifier_visage_gravekeepers_cloak_lua:OnStackCountChanged(old_stack_count)
	if IsServer() then return end

	local parent = self:GetParent()
	if not parent or parent:IsNull() then return end

	local new_stack_count = self:GetStackCount()
	if new_stack_count and new_stack_count > 0 then
		local cloak_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_cloak_lyr4.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
		ParticleManager:ReleaseParticleIndex(cloak_pfx)

		if not self.barrier_pfx then
			self.barrier_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_visage/visage_cloak_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
		end

		local rock_count = 4
		if self.barrier_pfx then
			for i = 2, 5 do		-- control points for rocks go from 2 to 5
				if new_stack_count >= rock_count * (i - 1) then
					ParticleManager:SetParticleControl(self.barrier_pfx, i, Vector(1, 0, 0))
				else
					ParticleManager:SetParticleControl(self.barrier_pfx, i, Vector(0, 0, 0))
				end
			end
		end
	end
end


function modifier_visage_gravekeepers_cloak_lua:OnCreated()

	self.max_layers = self:GetAbilitySpecialValueFor("max_layers")
	self.damage_reduction = self:GetAbilitySpecialValueFor("damage_reduction")
	self.recovery_time = self:GetAbilitySpecialValueFor("recovery_time")
	self.minimum_damage = self:GetAbilitySpecialValueFor("minimum_damage")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.max_damage_reduction = self:GetAbilitySpecialValueFor("max_damage_reduction")
	self.hero_multiplier = self:GetAbilitySpecialValueFor("hero_multiplier")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
	if IsServer() then
		self:SetStackCount(self.max_layers)
		self.tStack = {}
		self:StartIntervalThink(0)
	end
end
function modifier_visage_gravekeepers_cloak_lua:OnRefresh()
	self.max_layers = self:GetAbilitySpecialValueFor("max_layers")
	self.damage_reduction = self:GetAbilitySpecialValueFor("damage_reduction")
	self.recovery_time = self:GetAbilitySpecialValueFor("recovery_time")
	self.minimum_damage = self:GetAbilitySpecialValueFor("minimum_damage")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.max_damage_reduction = self:GetAbilitySpecialValueFor("max_damage_reduction")
	self.hero_multiplier = self:GetAbilitySpecialValueFor("hero_multiplier")
	self.bonus_armor = self:GetAbilitySpecialValueFor("bonus_armor")
end

function modifier_visage_gravekeepers_cloak_lua:OnDestroy()
	self.tStack = nil
	if self.barrier_pfx then
		ParticleManager:DestroyParticle(self.barrier_pfx, false)
		ParticleManager:ReleaseParticleIndex(self.barrier_pfx)
		self.barrier_pfx = nil
	end
end
function modifier_visage_gravekeepers_cloak_lua:OnIntervalThink()
	if self.max_layers > self:GetStackCount() then
		for i = #self.tStack, 1, -1 do
			local info = self.tStack[i]
			if info ~= nil then
				if info.time <= GameRules:GetGameTime() then
					self:IncrementStackCount()
					table.remove(self.tStack, i)
				end
			else
				table.remove(self.tStack, i)
			end
		end
	end
end
function modifier_visage_gravekeepers_cloak_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end
function modifier_visage_gravekeepers_cloak_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end
function modifier_visage_gravekeepers_cloak_lua:GetModifierIncomingDamage_Percentage(params)
	local hTarget = params.target
	local hAttacker = params.attacker
	local fDamage = params.damage
	local iStackCount = self:GetStackCount()
	if IsValid(hTarget) and IsValid(hAttacker) and iStackCount > 0 then
		if fDamage > self.minimum_damage and bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) ~= DOTA_DAMAGE_FLAG_HPLOSS then
			local iLoseStack = 1
			if hAttacker:IsHero() then
				iLoseStack = math.min(iLoseStack * self.hero_multiplier, iStackCount)
			end
			self:LoseStack(iLoseStack)
			return -(math.min(self.max_damage_reduction, self.damage_reduction * iStackCount))
		end
	end
end
function modifier_visage_gravekeepers_cloak_lua:LoseStack(iStack)
	if self.tStack == nil then
		self.tStack = {}
	end
	for i = 1, iStack do
		self:DecrementStackCount()
		table.insert(self.tStack, { time = GameRules:GetGameTime() + self.recovery_time })
	end
end

modifier_visage_gravekeepers_cloak_secondary_lua = class({})

function modifier_visage_gravekeepers_cloak_secondary_lua:IsHidden() return false end
function modifier_visage_gravekeepers_cloak_secondary_lua:IsDebuff() return false end
function modifier_visage_gravekeepers_cloak_secondary_lua:IsPurgable() return false end

function modifier_visage_gravekeepers_cloak_secondary_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_visage_gravekeepers_cloak_secondary_lua:OnCreated()
	if not IsServer() then return end

	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end
	local ability_level = ability:GetLevel() - 1

	self.damage_reduction = ability:GetLevelSpecialValueFor("damage_reduction", ability_level)
	self.max_damage_reduction = ability:GetSpecialValueFor("max_damage_reduction")
end

function modifier_visage_gravekeepers_cloak_secondary_lua:GetModifierIncomingDamage_Percentage(keys)
	if not keys.target or keys.target:IsNull() then return end
	if not keys.attacker or keys.attacker:IsNull() then return end

	--no minimum damage threshold on secondary modifier
	if bit:_and(keys.damage_flags, DOTA_DAMAGE_FLAG_HPLOSS) == DOTA_DAMAGE_FLAG_HPLOSS then return end

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end
	local aura = caster:FindModifierByName("modifier_visage_gravekeepers_cloak_lua")
	if not aura or aura:IsNull() then return end

	-- still implement the cap unlike vanilla
	return -(math.min(self.max_damage_reduction, self.damage_reduction * aura:GetStackCount()))
end

modifier_visage_gravekeepers_cloak_lua_shard_buff = class({})

function modifier_visage_gravekeepers_cloak_lua_shard_buff:IsHidden() return false end
function modifier_visage_gravekeepers_cloak_lua_shard_buff:IsDebuff() return false end
function modifier_visage_gravekeepers_cloak_lua_shard_buff:IsPurgable() return false end

function modifier_visage_gravekeepers_cloak_lua_shard_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
end
function modifier_visage_gravekeepers_cloak_lua_shard_buff:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end
function modifier_visage_gravekeepers_cloak_lua_shard_buff:OnCreated()
	self.health_regen_pct = self:GetAbility():GetSpecialValueFor("health_regen_pct") / (self:GetAbility():GetSpecialValueFor("shard_duration") or 1)
end
function modifier_visage_gravekeepers_cloak_lua_shard_buff:StatusEffectPriority()
	return 1
end
function modifier_visage_gravekeepers_cloak_lua_shard_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_earth_spirit_petrify.vpcf"
end
function modifier_visage_gravekeepers_cloak_lua_shard_buff:GetModifierHealthRegenPercentage()
	return self.health_regen_pct
end