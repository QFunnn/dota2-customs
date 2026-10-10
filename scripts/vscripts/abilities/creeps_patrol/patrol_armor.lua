--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_patrol_armor", "abilities/creeps_patrol/patrol_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_patrol_armor_buff", "abilities/creeps_patrol/patrol_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_patrol_armor_death", "abilities/creeps_patrol/patrol_armor", LUA_MODIFIER_MOTION_NONE)

patrol_armor = class({})

function patrol_armor:Precache(context)
	PrecacheResource("particle", "particles/patrol/glyph_damage.vpcf", context)
	PrecacheResource("particle", "particles/items2_fx/medallion_of_courage_friend.vpcf", context)
end

function patrol_armor:GetIntrinsicModifierName()
	return "modifier_patrol_armor"
end

modifier_patrol_armor = class(mod_hidden)
function modifier_patrol_armor:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.armor = self.ability:GetSpecialValueFor("armor_first")
	self.ability.death_duration = self.ability:GetSpecialValueFor("death_duration")

	self.radius = self.ability.radius
	self.armor = self.ability.armor
	self.interval = 0.2

	self.parent:AddDeathEvent(self)
	self:OnIntervalThink(true)
	self:StartIntervalThink(self.interval)
end

function modifier_patrol_armor:OnIntervalThink(first)
	if not IsServer() then
		return
	end
	if not IsValid(self.parent) then
		return
	end
	local origin = self.parent:GetAbsOrigin()
	local alive = self.parent:IsAlive()

	if self.parent.patrol_teams then
		if not self.init and alive then
			self.init = true
			for _, tower in pairs(towers) do
				if tower.map_team and self.parent.patrol_teams[tower.map_team] then
					tower.active_patrol[self.parent] = 1
				end
			end
		end

		if not alive and not first then
			for _, tower in pairs(towers) do
				if tower.map_team and self.parent.patrol_teams[tower.map_team] then
					tower.active_patrol[self.parent] = nil
				end
			end
		end
	end

	local teams = {}
	local count = 0

	for _, player in pairs(players) do
		if self.parent.patrol_teams and self.parent.patrol_teams[player.map_team] then
			AddFOWViewer(player:GetTeamNumber(), origin, 500, self.interval + 0.1, false)
		end

		if
			player:IsAlive()
			and not teams[player:GetTeamNumber()]
			and (player:GetAbsOrigin() - origin):Length2D() <= self.radius
		then
			teams[player:GetTeamNumber()] = true
			count = count + 1
			if count > 1 then
				break
			end
		end
	end

	local buff = self.parent:HasModifier("modifier_patrol_armor_buff")

	if count > 1 and not buff then
		self.parent:AddNewModifier(self.parent, self.ability, "modifier_patrol_armor_buff", {})
	elseif count <= 1 and buff then
		self.parent:RemoveModifierByName("modifier_patrol_armor_buff")
	end
end

function modifier_patrol_armor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_patrol_armor:GetModifierIncomingDamage_Percentage(params)
	if not IsServer() then
		return
	end
	if not params.attacker then
		return
	end

	local result = params.damage_type == DAMAGE_TYPE_PURE and self.parent.patrol_pure or 0
	local hero = players[params.attacker:GetId()]

	if hero and (hero:GetAbsOrigin() - self.parent:GetAbsOrigin()):Length2D() > self.radius then
		return result - 200
	end

	if towers[params.attacker:GetTeamNumber()] then
		dota1x6:ActivatePushReduce(params.attacker:GetTeamNumber())
	end

	if self.parent:HasModifier("modifier_patrol_armor_buff") then
		return result + self.armor
	end

	return result
end

function modifier_patrol_armor:DeathEvent(params)
	if not IsServer() then
		return
	end
	if not params.attacker then
		return
	end
	if not dota1x6:IsPatrol(params.unit:GetUnitName()) then
		return
	end
	if (self.parent:GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > self.radius then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_patrol_armor_death",
		{ duration = self.ability.death_duration }
	)
end

modifier_patrol_armor_death = class(mod_hidden)
function modifier_patrol_armor_death:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()

	local particle =
		ParticleManager:CreateParticle("particles/patrol/glyph_damage.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(120, 1, 1))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_patrol_armor_death:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_patrol_armor_death:GetMinHealth()
	if self.parent:HasModifier("modifier_death") then
		return
	end
	return 1
end

modifier_patrol_armor_buff = class(mod_visible)
function modifier_patrol_armor_buff:GetEffectName()
	return "particles/items2_fx/medallion_of_courage_friend.vpcf"
end
function modifier_patrol_armor_buff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end