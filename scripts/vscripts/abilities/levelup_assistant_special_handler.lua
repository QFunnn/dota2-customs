--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


levelup_assistant_special_handler = class({})

function levelup_assistant_special_handler:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_assistant_special_handler:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end
	extra_data = extra_data or {}

	if tonumber(extra_data.assistant_attack_projectile) == 1 then
		local caster = self:GetCaster()
		if not IsValid(caster) or not IsValid(target) or not target:IsAlive() then
			return true
		end
		if target:GetTeamNumber() == caster:GetTeamNumber() then
			return true
		end
		if not target._levelup_current_health then
			return true
		end

		local damage = math.max(0, tonumber(extra_data.damage) or 0)
		if damage > 0 then
			ApplyDamage({
				victim = target,
				attacker = caster,
				ability = nil,
				damage = damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage_kind = "physical_attack",
			}, "assistant_attack_projectile")
		end
		return true
	end

	if tonumber(extra_data.assistant_leech_seed) == 1 then
		local caster = self:GetCaster()
		if not IsValid(caster) or not IsValid(target) or not target:IsAlive() then
			return true
		end
		if target:GetTeamNumber() ~= caster:GetTeamNumber() then
			return true
		end
		if IsLevelUpGameplayInteractionIgnored and IsLevelUpGameplayInteractionIgnored(target) then
			return true
		end

		local heal = math.max(0, tonumber(extra_data.heal) or 0)
		if heal <= 0 or not target.LevelUpModifyHealth then
			return true
		end
		local restored, actual_heal = target:LevelUpModifyHealth(heal)
		if restored == false then
			return true
		end

		actual_heal = math.floor(math.max(0, tonumber(actual_heal) or 0) + 0.5)
		if actual_heal > 0 then
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, actual_heal, nil)
		end
		return true
	end

	return true
end