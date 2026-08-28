--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_anti_feed_detected = class({})

function modifier_anti_feed_detected:IsHidden()
	return false
end
function modifier_anti_feed_detected:IsDebuff()
	return true
end
function modifier_anti_feed_detected:IsPurgable()
	return false
end
function modifier_anti_feed_detected:RemoveOnDeath()
	return false
end
function modifier_anti_feed_detected:GetTexture()
	return "lion_voodoo_fish"
end
function modifier_anti_feed_detected:OnCreated(kv)
	self.respawn_time_inc = kv.respawn_time_inc
end

function modifier_anti_feed_detected:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_RESPAWNTIME_STACKING,
		MODIFIER_PROPERTY_RESPAWNTIME,
		MODIFIER_PROPERTY_AVOID_DAMAGE,
	}
end

function modifier_anti_feed_detected:GetModifierConstantRespawnTime()
	return self.respawn_time_inc
end
function modifier_anti_feed_detected:GetModifierStackingRespawnTime()
	return self.respawn_time_inc
end

function modifier_anti_feed_detected:GetModifierAvoidDamage(keys)
	if IsClient() then
		return
	end

	local target = keys.target
	local attacker = keys.attacker

	if not IsValidEntity(attacker) or not IsValidEntity(target) then
		return
	end
	if attacker == target then
		return
	end
	if attacker:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
		return
	end
	if target:GetHealth() > keys.damage or IsBitSet(keys.damage_flags, DOTA_DAMAGE_FLAG_NON_LETHAL) then
		return
	end

	target:Kill(nil, target)
end