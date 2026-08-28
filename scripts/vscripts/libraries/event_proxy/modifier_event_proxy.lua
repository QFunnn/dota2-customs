--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_event_proxy = class({})

function modifier_event_proxy:IsHidden()
	return false
end
function modifier_event_proxy:IsPurgable()
	return false
end

function modifier_event_proxy:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
end

function modifier_event_proxy:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_HERO_KILLED,
		MODIFIER_EVENT_ON_MODIFIER_ADDED,
		MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT,
	}
end

function modifier_event_proxy:OnCreated()
	self.deal_damage_proxy = {}
	self.parent_death_proxy = {}
end

function modifier_event_proxy:OnHeroKilled(event)
	EventDriver:Dispatch("Events:hero_killed", {
		killed = event.target,
		killer = event.attacker,
		last_hit_unit = event.unit,
		inflictor = event.inflictor,
	})
end

function modifier_event_proxy:OnModifierAdded(event)
	local unit = event.unit
	local buff = event.added_buff
	if not IsValidEntity(unit) or not buff or buff:IsNull() then
		return
	end

	EventDriver:Dispatch("EventProxy:OnModifierAdded", {
		unit = unit,
		added_buff = buff,
	})

	if buff.DeclareFunctions then
		local funcs = buff:DeclareFunctions()

		if type(funcs) == "table" then
			for k, v in pairs(funcs) do
				if v == MODIFIER_EVENT_ON_TAKEDAMAGE_CUSTOM and buff.OnTakeDamage then
					EventDriver:Listen("EventProxy:OnTakeDamage", buff.OnTakeDamage, buff)
				elseif v == MODIFIER_PROPERTY_ON_DEALDAMAGE_CUSTOM and buff.OnDealDamage then
					self.deal_damage_proxy[event.unit] = self.deal_damage_proxy[event.unit] or {}

					self.deal_damage_proxy[event.unit][buff] = true
				end
			end
		end
	end
end

function modifier_event_proxy:OnTakeDamageKillCredit(event)
	EventDriver:Dispatch("EventProxy:OnTakeDamage", event)

	local target = event.target
	local attacker = event.attacker
	local damage = event.damage
	local attacker_id = attacker and attacker.GetPlayerOwnerID and attacker:GetPlayerOwnerID()

	if self.deal_damage_proxy[event.attacker] then
		for buff, _ in pairs(self.deal_damage_proxy[event.attacker]) do
			if not buff:IsNull() then
				ErrorTracking.Try(buff.OnDealDamage, buff, event)
			else
				self.deal_damage_proxy[event.attacker][buff] = nil
			end
		end
	end

	if target:IsRealHero() then
		local target_id = target.GetPlayerOwnerID and target:GetPlayerOwnerID()
		if IsValidPlayerID(target_id) then
			EndGameStats:Add_DamageTaken(target_id, event.original_damage)
		end
		if IsValidPlayerID(attacker_id) then
			EndGameStats:Add_HeroDamage(attacker_id, damage)
		end
	elseif target:IsBuilding() and IsValidPlayerID(attacker_id) then
		local is_correct_building = target:IsTower() or target:IsFort() or target:IsBarracks()
		if is_correct_building then
			EndGameStats:Add_BuildingDamage(attacker_id, damage)
			AntiFeed:ProcessBuildingDamage(attacker_id, damage)
		end
	end
end