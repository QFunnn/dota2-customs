--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


elder_titan_ancestral_spirit_lua = class({})
LinkLuaModifier("modifier_elder_titan_ancestral_spirit_lua", "abilities/heroes/elder_titan/elder_titan_ancestral_spirit", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_elder_titan_ancestral_spirit_buff_lua", "abilities/heroes/elder_titan/elder_titan_ancestral_spirit", LUA_MODIFIER_MOTION_NONE)

function elder_titan_ancestral_spirit_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_elder_titan/elder_titan_ancestral_spirit_ambient.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_elder_titan/elder_titan_ancestral_spirit_touch.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_elder_titan/elder_titan_ancestral_spirit_buff.vpcf", context )
end

elder_titan_ancestral_spirit_lua.elder_titan_abilities = {
	["elder_titan_echo_stomp_lua"] = true,
	["elder_titan_return_spirit_lua"] = true,
	["elder_titan_natural_order_lua"] = true,
}

function elder_titan_ancestral_spirit_lua:GetAssociatedSecondaryAbilities()
	return "elder_titan_return_spirit_lua"
end

function elder_titan_ancestral_spirit_lua:Spawn()
	if not IsServer() then return end
	Timers:CreateTimer(0.1, function()
		self:InitSpirit()
	end)
end

function elder_titan_ancestral_spirit_lua:OnSpellStart()
	if not IsServer() then return end

	self.caster = self:GetCaster()

	if not self.caster or self.caster:IsNull() then return end

	local position = self:GetCursorPosition()

	if not IsValidEntity(self.ancestral_spirit) then
		self:InitSpirit()
	end

	self.ancestral_spirit:SetOrigin(position)

	local ancestral_spirit_return_ability = self.caster:FindAbilityByName("elder_titan_return_spirit_lua")
	if ancestral_spirit_return_ability and not ancestral_spirit_return_ability:IsNull() then
		ancestral_spirit_return_ability:SetLevel(1)
	end

	local ancestral_spirit_move_ability = self.caster:FindAbilityByName("elder_titan_move_spirit_lua")
	if ancestral_spirit_move_ability and not ancestral_spirit_move_ability:IsNull() then
		ancestral_spirit_move_ability:SetLevel(1)
		ancestral_spirit_move_ability:SetActivated(true)
		ancestral_spirit_move_ability:SetHidden(false)
	end

	self:UpdateSpiritAbilities()

	EmitSoundOn("Hero_ElderTitan.AncestralSpirit.Spawn", self.ancestral_spirit)

	-- reset modifier from sleeping state
	self.ancestral_spirit.modifier:SetHidden(false)
	self.ancestral_spirit.modifier:OnCreated()

	self.caster:SwapAbilities(self:GetAbilityName(), "elder_titan_return_spirit_lua", false, true)
end

function elder_titan_ancestral_spirit_lua:OnUnStolen()
	if IsValidEntity(self.ancestral_spirit) then self.ancestral_spirit:Destroy() end
end

function elder_titan_ancestral_spirit_lua:GetAncestralSpirit()
	return self.ancestral_spirit
end


function elder_titan_ancestral_spirit_lua:InitSpirit()
	self.caster = self:GetCaster()
	local fv = self.caster:GetForwardVector()

	self.ancestral_spirit = CreateUnitByName("npc_dota_elder_titan_ancestral_spirit", self.caster:GetAbsOrigin(), true, self.caster, self.caster, self.caster:GetTeamNumber())
	self.ancestral_spirit:SetControllableByPlayer(self.caster:GetPlayerID(), false)
	self.ancestral_spirit:SetForwardVector((-1) * fv)	-- set facing the caster
	self.ancestral_spirit:SetDayTimeVisionRange(350)
	self.ancestral_spirit:SetNightTimeVisionRange(350)

	local m = self.ancestral_spirit:AddNewModifier(self.caster, self, "modifier_elder_titan_ancestral_spirit_lua", {duration = -1})
	m:SetHidden(true)
	self.ancestral_spirit.modifier = m

	self:UpdateSpiritAbilities()
end


function elder_titan_ancestral_spirit_lua:UpdateSpiritAbilities()
	if not IsValidEntity(self.ancestral_spirit) then return end
	-- level up ancestral spirit abilities to match hero
	for ability_name, _ in pairs(self.elder_titan_abilities) do
		local caster_ability = self.caster:FindAbilityByName(ability_name)
		if caster_ability and not caster_ability:IsNull() then
			local ancestral_spirit_ability = self.ancestral_spirit:FindAbilityByName(ability_name)
			if ancestral_spirit_ability and not ancestral_spirit_ability:IsNull() then
				ancestral_spirit_ability:SetHidden(false)
				ancestral_spirit_ability:SetLevel(math.max(caster_ability:GetLevel(), 1))
			end
		end
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


elder_titan_return_spirit_lua = class({})

function elder_titan_return_spirit_lua:IsStealable() return false end
function elder_titan_return_spirit_lua:IsHiddenWhenStolen() return true end
function elder_titan_return_spirit_lua:IsHiddenAsSecondaryAbility() return true end
function elder_titan_return_spirit_lua:ProcsMagicStick() return false end

function elder_titan_return_spirit_lua:OnSpellStart()
	if not IsServer() then return end

	self.caster = self:GetCaster()
	if not self.caster or self.caster:IsNull() then return end

	self.owner = self.caster
	if self.caster:GetUnitName() == "npc_dota_elder_titan_ancestral_spirit" then
		self.owner = self.caster:GetOwner()
		self.ancestral_spirit = self.caster
		if not self.owner or self.owner:IsNull() then return end
	else
		-- Fetch the spirit
		local ancestral_spirit_ability = self.owner:FindAbilityByName("elder_titan_ancestral_spirit_lua")
		if ancestral_spirit_ability and not ancestral_spirit_ability:IsNull() then
			self.ancestral_spirit = ancestral_spirit_ability:GetAncestralSpirit()
		end
	end

	if self.ancestral_spirit and not self.ancestral_spirit:IsNull() and IsValidEntity(self.ancestral_spirit) and not self.ancestral_spirit.is_returning then
		local echo_stomp = self.owner:FindAbilityByName("elder_titan_echo_stomp_lua")
		local ancestral_spirit_echo_stomp = self.ancestral_spirit:FindAbilityByName("elder_titan_echo_stomp_lua")
		if (echo_stomp and not echo_stomp:IsNull() and (echo_stomp:IsInAbilityPhase() or echo_stomp:IsChanneling()))
		or
		(ancestral_spirit_echo_stomp and not ancestral_spirit_echo_stomp:IsNull() and (ancestral_spirit_echo_stomp:IsInAbilityPhase() or ancestral_spirit_echo_stomp:IsChanneling())) then
			return
		end

		self.ancestral_spirit:MoveToNPC(self.owner)
		self.ancestral_spirit.is_returning = true
		self.ancestral_spirit:StartGesture(ACT_DOTA_FLAIL)
		EmitSoundOn("Hero_ElderTitan.AncestralSpirit.Return", self.ancestral_spirit)
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


elder_titan_move_spirit_lua = class({})

function elder_titan_move_spirit_lua:IsStealable() return false end
function elder_titan_move_spirit_lua:ProcsMagicStick() return false end

function elder_titan_move_spirit_lua:OnSpellStart()
	if not IsServer() then return end

	self.caster = self:GetCaster()
	if not self.caster or self.caster:IsNull() then return end
	self.position = self:GetCursorPosition()
	self.owner = self.caster

	-- Fetch the spirit
	local ancestral_spirit_ability = self.owner:FindAbilityByName("elder_titan_ancestral_spirit_lua")
	if ancestral_spirit_ability and not ancestral_spirit_ability:IsNull() then
		self.ancestral_spirit = ancestral_spirit_ability:GetAncestralSpirit()
	end

	if self.ancestral_spirit and not self.ancestral_spirit:IsNull() and IsValidEntity(self.ancestral_spirit) and not self.ancestral_spirit.is_returning then
		local echo_stomp = self.owner:FindAbilityByName("elder_titan_echo_stomp_lua")
		local ancestral_spirit_echo_stomp = self.ancestral_spirit:FindAbilityByName("elder_titan_echo_stomp_lua")
		if (echo_stomp and not echo_stomp:IsNull() and (echo_stomp:IsInAbilityPhase() or echo_stomp:IsChanneling()))
		or
		(ancestral_spirit_echo_stomp and not ancestral_spirit_echo_stomp:IsNull() and (ancestral_spirit_echo_stomp:IsInAbilityPhase() or ancestral_spirit_echo_stomp:IsChanneling())) then
			return
		end

		self.ancestral_spirit:MoveToPosition(self.position)
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_elder_titan_ancestral_spirit_lua = class({})

function modifier_elder_titan_ancestral_spirit_lua:IsHidden() return false end
function modifier_elder_titan_ancestral_spirit_lua:IsPurgable() return false end

function modifier_elder_titan_ancestral_spirit_lua:GetEffectName()
	return "particles/units/heroes/hero_elder_titan/elder_titan_ancestral_spirit_ambient.vpcf"
end

function modifier_elder_titan_ancestral_spirit_lua:OnCreated( kv )
	self:SetHasCustomTransmitterData(true)
	if not IsServer() then return end

	self.parent = self:GetParent()
	if not self.parent or self.parent:IsNull() then return end
	self.owner = self.parent:GetOwner()
	if not self.owner or self.owner:IsNull() then return end
	self.ability = self:GetAbility()
	if not self.ability or self.ability:IsNull() then return end

	self.game_time_start = GameRules:GetGameTime()
	self.speed = self.owner:GetIdealSpeed()
	self.return_speed = self.ability:GetSpecialValueFor("return_speed")
	self.radius = self.ability:GetSpecialValueFor("radius")
	self.pass_damage = self.ability:GetSpecialValueFor("pass_damage")
	self.spirit_duration = self.ability:GetSpecialValueFor("spirit_duration")
	self.buff_duration = self.ability:GetSpecialValueFor("buff_duration")
	self.damage_heroes = self.ability:GetSpecialValueFor("damage_heroes")
	self.damage_creeps = self.ability:GetSpecialValueFor("damage_creeps")
	self.move_pct_cap = self.ability:GetSpecialValueFor("move_pct_cap")
	self.move_pct_heroes = self.ability:GetSpecialValueFor("move_pct_heroes")
	self.move_pct_creeps = self.ability:GetSpecialValueFor("move_pct_creeps")
	self.armor_creeps = self.ability:GetSpecialValueFor("armor_creeps")
	self.armor_heroes = self.ability:GetSpecialValueFor("armor_heroes")
	self.scepter_magic_immune_per_hero = self.ability:GetSpecialValueFor("scepter_magic_immune_per_hero")
	self.scepter_max_duration = self.ability:GetSpecialValueFor("scepter_max_duration")
	self.spirit_max_heroes = self.ability:GetSpecialValueFor("spirit_max_heroes")

	self.bonus_damage = 0
	self.bonus_move_pct = 0
	self.bonus_armor = 0
	self.real_hero_counter = 0
	self.targets_hit = {}

	-- magic numbers
	--self.max_distance = 5000
	self.min_distance = 180
	self.hull_distance = 100

	self.damage_table = {
		attacker 		= self.owner,
		ability 		= self.ability,
		damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
		damage 			= self.pass_damage,
		damage_type 	= DAMAGE_TYPE_MAGICAL,
	}

	self.is_hidden = false
	self.parent.is_hidden = false
	self.parent.is_returning = false

	self:StartIntervalThink(0.1)
	self:SendBuffRefreshToClients()
end

function modifier_elder_titan_ancestral_spirit_lua:SetHidden(state)
	self.is_hidden = state
	self.parent.is_hidden = state

	if state then
		self.parent:AddNoDraw()
		self.parent:Stop()
	else
		self.parent:RemoveNoDraw()
	end
end

function modifier_elder_titan_ancestral_spirit_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_elder_titan_ancestral_spirit_lua:AddCustomTransmitterData()
	return {
		is_returning = self.parent.is_returning,
		override_animation = self.parent.override_animation,
		speed = self.speed,
		return_speed = self.return_speed,
	}
end

function modifier_elder_titan_ancestral_spirit_lua:HandleCustomTransmitterData(kv)
	self.is_returning = kv.is_returning
	self.override_animation = kv.override_animation
	self.speed = kv.speed
	self.return_speed = kv.return_speed
end

function modifier_elder_titan_ancestral_spirit_lua:CheckState()
	local state = {
		[MODIFIER_STATE_OUT_OF_GAME] 		= true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] 	= true,
		[MODIFIER_STATE_DISARMED] 			= true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] 	= true,
		[MODIFIER_STATE_INVULNERABLE] 		= true,
		[MODIFIER_STATE_MUTED] 				= true,
		[MODIFIER_STATE_NO_HEALTH_BAR] 		= true,
		[MODIFIER_STATE_FLYING] 			= true,
		[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = false,
	}

	if self.parent.is_returning then
		state[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true
	end

	if self.is_hidden then
		state[MODIFIER_STATE_UNSELECTABLE] = true
	end

	return state
end

function modifier_elder_titan_ancestral_spirit_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}
end

function modifier_elder_titan_ancestral_spirit_lua:GetModifierMoveSpeed_Absolute()
	if (IsServer() and self:GetParent().is_returning) or (IsClient() and self.is_returning == 1) then
		return self.return_speed
	end
	return self.speed
end

function modifier_elder_titan_ancestral_spirit_lua:GetModifierIgnoreMovespeedLimit() return 1 end

function modifier_elder_titan_ancestral_spirit_lua:OnIntervalThink()
	if not self.parent or self.parent:IsNull() then return end
	if not IsValidEntity(self.owner) or not IsValidEntity(self.ability) then
		UTIL_Remove(self.parent)
		return
	end

	if self.is_hidden then
		self.parent:SetOrigin(self.owner:GetAbsOrigin())
		return
	end

	if not self.owner:IsAlive() then
		self:SetHidden(true)
		self:OnDestroy()
		return
	end

	local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

	for _, enemy in pairs(enemies) do
		if not table.contains(self.targets_hit, enemy) then
			table.insert(self.targets_hit, enemy)
			if enemy:IsRealHero() then
				if self.real_hero_counter < self.spirit_max_heroes then
					self.bonus_damage = self.bonus_damage + self.damage_heroes
					self.bonus_move_pct = self.bonus_move_pct + self.move_pct_heroes
					self.bonus_armor = self.bonus_armor + self.armor_heroes
					self.real_hero_counter = self.real_hero_counter + 1
				end
			else
				self.bonus_damage = self.bonus_damage + self.damage_creeps
				self.bonus_move_pct = self.bonus_move_pct + self.move_pct_creeps
				self.bonus_armor = self.bonus_armor + self.armor_creeps
			end

			-- Particle
			local particle_cast = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_elder_titan/elder_titan_ancestral_spirit_touch.vpcf", self.owner)
			local hit_pfx = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, enemy)
			ParticleManager:SetParticleControl(hit_pfx, 0, self.parent:GetAbsOrigin())
			ParticleManager:SetParticleControlEnt(hit_pfx, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(hit_pfx)
			EmitSoundOn("Hero_ElderTitan.AncestralSpirit.Buff", enemy)

			self.damage_table.victim = enemy
			ApplyDamage(self.damage_table)
		end
	end

	local echo_stomp = self.owner:FindAbilityByName("elder_titan_echo_stomp_lua")
	local ancestral_spirit_echo_stomp = self.parent:FindAbilityByName("elder_titan_echo_stomp_lua")

	if self.parent.is_returning then
		if echo_stomp and not echo_stomp:IsNull() and not echo_stomp:IsInAbilityPhase() and not echo_stomp:IsChanneling() and
		ancestral_spirit_echo_stomp and not ancestral_spirit_echo_stomp:IsNull() and not ancestral_spirit_echo_stomp:IsInAbilityPhase() and not ancestral_spirit_echo_stomp:IsChanneling() then
			self.parent:MoveToNPC(self.owner)
		end
	else
		if (GameRules:GetGameTime() >= self.game_time_start + self.spirit_duration) and
		ancestral_spirit_echo_stomp and not ancestral_spirit_echo_stomp:IsNull() and not ancestral_spirit_echo_stomp:IsInAbilityPhase() and not ancestral_spirit_echo_stomp:IsChanneling() then
			self.parent:MoveToNPC(self.owner)
			self.parent.is_returning = true
			self.parent:StartGesture(ACT_DOTA_FLAIL)
			EmitSoundOn("Hero_ElderTitan.AncestralSpirit.Return", self.parent)
		end
	end

	if (self.owner:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.min_distance then
		self.parent:MoveToPosition(self.owner:GetAbsOrigin())
		if not self.parent.is_returning then
			self.parent.is_returning = true
			self.parent:StartGesture(ACT_DOTA_FLAIL)
			EmitSoundOn("Hero_ElderTitan.AncestralSpirit.Return", self.parent)
		end
	end

	if (self.owner:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() <= self.hull_distance then
		if ancestral_spirit_echo_stomp and not ancestral_spirit_echo_stomp:IsNull() then
			if not ancestral_spirit_echo_stomp:IsInAbilityPhase() and not ancestral_spirit_echo_stomp:IsChanneling() then
				if self.bonus_damage > 0 then
					self.owner:AddNewModifier(self.owner, self.ability, "modifier_elder_titan_ancestral_spirit_buff_lua",
					{
						duration = self.buff_duration,
						bonus_damage = self.bonus_damage,
						bonus_move_pct = self.bonus_move_pct,
						bonus_armor = self.bonus_armor,
					})
				end

				if self.owner:HasScepter() then
					local remaining = 0
					local modifier = self.owner:FindModifierByName("modifier_elder_titan_echo_stomp_magic_immune")
					if modifier then
						remaining = self:GetRemainingTime()
					end
					local duration = self.scepter_magic_immune_per_hero * self.real_hero_counter + remaining
					if duration > 0 then
						self.owner:AddNewModifier(self.owner, self.ability, "modifier_elder_titan_echo_stomp_magic_immune", {duration = duration})
					end
					self.owner:Purge(false, true, false, true, false)
				end

				self:SetHidden(true)
				self:OnDestroy()
			end
		end
	end

	self:SendBuffRefreshToClients()
end

function modifier_elder_titan_ancestral_spirit_lua:OnDestroy()
	if not IsValidEntity(self.owner) or not IsValidEntity(self.ability) then
		return
	end

	if IsValidEntity(self.parent) then
		self.parent.is_returning = nil
		self.parent:RemoveGesture(ACT_DOTA_FLAIL)
	end

	self:SwapDeactivateRemove()
end

function modifier_elder_titan_ancestral_spirit_lua:SwapDeactivateRemove()
	self.owner:SwapAbilities(self.ability:GetAbilityName(), "elder_titan_return_spirit_lua", true, false)
	local ancestral_spirit_move_ability = self.owner:FindAbilityByName("elder_titan_move_spirit_lua")
	if ancestral_spirit_move_ability and not ancestral_spirit_move_ability:IsNull() then
		ancestral_spirit_move_ability:SetActivated(false)
		ancestral_spirit_move_ability:SetHidden(true)
	end
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_elder_titan_ancestral_spirit_buff_lua = class({})

function modifier_elder_titan_ancestral_spirit_buff_lua:IsHidden() return false end
function modifier_elder_titan_ancestral_spirit_buff_lua:IsPurgable() return true end
function modifier_elder_titan_ancestral_spirit_buff_lua:IsBuff() return true end
function modifier_elder_titan_ancestral_spirit_buff_lua:IsDebuff() return false end

function modifier_elder_titan_ancestral_spirit_buff_lua:GetEffectName()
	return "particles/units/heroes/hero_elder_titan/elder_titan_ancestral_spirit_buff.vpcf"
end

function modifier_elder_titan_ancestral_spirit_buff_lua:OnCreated( kv )
	self:SetHasCustomTransmitterData(true)
	if not IsServer() then return end
	self.parent = self:GetParent()
	if not self.parent or self.parent:IsNull() then return end
	self.ability = self:GetAbility()
	if not self.ability or self.ability:IsNull() then return end

	self.bonus_damage = kv.bonus_damage
	self.bonus_move_pct = kv.bonus_move_pct
	self.bonus_armor = kv.bonus_armor

	self:SendBuffRefreshToClients()
end

function modifier_elder_titan_ancestral_spirit_buff_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_elder_titan_ancestral_spirit_buff_lua:AddCustomTransmitterData()
	return {
		bonus_damage = self.bonus_damage,
		bonus_move_pct = self.bonus_move_pct,
		bonus_armor = self.bonus_armor,
	}
end

function modifier_elder_titan_ancestral_spirit_buff_lua:HandleCustomTransmitterData(kv)
	self.bonus_damage = kv.bonus_damage
	self.bonus_move_pct = kv.bonus_move_pct
	self.bonus_armor = kv.bonus_armor
end

function modifier_elder_titan_ancestral_spirit_buff_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_elder_titan_ancestral_spirit_buff_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_elder_titan_ancestral_spirit_buff_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_move_pct
end

function modifier_elder_titan_ancestral_spirit_buff_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end