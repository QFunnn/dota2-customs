--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bloodseeker_bloodrage_lua = class({})

function modifier_bloodseeker_bloodrage_lua:IsHidden()
	return true
end
function modifier_bloodseeker_bloodrage_lua:IsDebuff()
	return false
end
function modifier_bloodseeker_bloodrage_lua:IsPurgable()
	return true
end

function modifier_bloodseeker_bloodrage_lua:OnCreated(kv)
	self.shardPctDamage = self:GetAbility():GetSpecialValueFor("shard_damage_pct")
end

function modifier_bloodseeker_bloodrage_lua:OnRefresh(kv)
	self.shardPctDamage = self:GetAbility():GetSpecialValueFor("shard_damage_pct")
end

function modifier_bloodseeker_bloodrage_lua:Recalc(kv)
  self.duration = kv.duration or self:GetRemainingTime()
  self:SetStackCount((kv.stacks or 0))
  self:GetParent():CalculateStatBonus(true)
end

function modifier_bloodseeker_bloodrage_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
	return funcs
end

function modifier_bloodseeker_bloodrage_lua:OnAttackLanded(params)
	local parent = self:GetParent()
	local target = params.target
	if not IsServer() then return end
	if params.attacker ~= parent then return end
	if IsValid(target) and target:IsAlive() and target.IsRoshan and not target:IsRoshan() then
		if UnitFilter(target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, parent:GetTeamNumber()) == UF_SUCCESS then
			local damage = target:GetMaxHealth() * self.shardPctDamage * 0.01
			ApplyDamage({
				victim = target,
				attacker = self:GetParent(),
				damage = damage,
				damage_type = DAMAGE_TYPE_PURE,
				ability = self:GetAbility(),
				damage_flags = DOTA_DAMAGE_FLAG_NONE
			})
		end
	end
end

function modifier_bloodseeker_bloodrage_lua:GetModifierProcAttack_Feedback(params)
	local parent = self:GetParent()
	local target = params.target
	if params.attacker ~= parent then return end
	if IsValid(target) and target:IsAlive() and target.IsRoshan and not target:IsRoshan() then
		if UnitFilter(target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, parent:GetTeamNumber()) == UF_SUCCESS then
			local particleID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
			ParticleManager:ReleaseParticleIndex(particleID)
			SendOverheadEventMessage(parent:GetPlayerOwner(), OVERHEAD_ALERT_HEAL, parent, target:GetMaxHealth() * self.shardPctDamage * 0.01, parent:GetPlayerOwner())
			parent:HealWithParams(target:GetMaxHealth() * self.shardPctDamage * 0.01, self:GetAbility(), true, true, parent, false)
		end
	end
end