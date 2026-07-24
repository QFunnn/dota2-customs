--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_necrolyte_reapers_scythe_lua", "heroes/hero_necrolyte/necrolyte_reapers_scythe_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_reapers_scythe_lua_stack", "heroes/hero_necrolyte/necrolyte_reapers_scythe_lua.lua", LUA_MODIFIER_MOTION_NONE)
if necrolyte_reapers_scythe_lua == nil then
	necrolyte_reapers_scythe_lua = class({})
end
function necrolyte_reapers_scythe_lua:GetIntrinsicModifierName()
	return "modifier_necrolyte_reapers_scythe_lua_stack"
end
function necrolyte_reapers_scythe_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	if IsValid(hTarget) then
		if not hTarget:TriggerSpellAbsorb(self) then
			EmitSoundOn("Hero_Necrolyte.ReapersScythe.Cast", hCaster)
			EmitSoundOn("Hero_Necrolyte.ReapersScythe.Target", hTarget)
			local iParticle = ParticleManager:CreateParticle("particles/units/heroes/hero_necrolyte/necrolyte_scythe.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControlEnt(iParticle, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
			ParticleManager:ReleaseParticleIndex(iParticle)
			local particleID = ParticleManager:CreateParticle("particles/units/heroes/hero_necrolyte/necrolyte_scythe_start.vpcf", PATTACH_WORLDORIGIN, hCaster)
			ParticleManager:SetParticleControl(particleID, 0, hCaster:GetAbsOrigin())
			ParticleManager:SetParticleControl(particleID, 1, hTarget:GetAbsOrigin())
			ParticleManager:SetParticleControlForward(particleID, 0, (hTarget:GetAbsOrigin() - hCaster:GetAbsOrigin()):Normalized())
			-- ParticleManager:SetParticleControlForward(particleID, 1, (hTarget:GetAbsOrigin() - hCaster:GetAbsOrigin()):Normalized())
			ParticleManager:ReleaseParticleIndex(particleID)

			hTarget:AddNewModifier(hCaster, self, "modifier_necrolyte_reapers_scythe_lua", { duration = stun_duration * hTarget:GetStatusResistanceFactor(hCaster) })
		end
	end
end
function necrolyte_reapers_scythe_lua:Slay(hTarget, bHero, iHealthPct)
	local hCaster = self:GetCaster()
	bHero = bHero or false
	local damage_per_health = self:GetSpecialValueFor("damage_per_health")

	local bKill = false
	local health_pct = iHealthPct or 0
	if IsValid(hTarget) then
		if hTarget:IsAlive() then
			local damage = (hTarget:GetMaxHealth() - hTarget:GetHealth()) * damage_per_health
			health_pct = hTarget:GetHealthPercent()
			ApplyDamage({
				attacker = hCaster,
				victim = hTarget,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			})
			if IsValid(hTarget) and not hTarget:IsAlive() then
				bKill = true
			end
		else
			bKill = true
		end
	else
		bKill = true
	end

	if bKill then
		local cd_back = self:GetSpecialValueFor("cd_back")
		local mana_back = self:GetSpecialValueFor("mana_back")
		local cd_remain = self:GetCooldownTimeRemaining()
		self:EndCooldown()
		self:StartCooldown(cd_remain * (100 - health_pct * cd_back) * 0.01)
		hCaster:GiveMana(self:GetManaCost(-1) * health_pct * mana_back * 0.01)
		if bHero then
			--斩死英雄
			if IsValid(hCaster) and hCaster:HasModifier("modifier_necrolyte_reapers_scythe_lua_stack") then
				hCaster:FindModifierByName("modifier_necrolyte_reapers_scythe_lua_stack"):IncrementStackCount()
			end
		else
			--斩死非英雄
		end
	end

end
---------------------------------------------------------------------
--Modifiers
if modifier_necrolyte_reapers_scythe_lua == nil then
	modifier_necrolyte_reapers_scythe_lua = class({})
end
function modifier_necrolyte_reapers_scythe_lua:IsHidden()
	return true
end
function modifier_necrolyte_reapers_scythe_lua:IsDebuff()
	return false
end
function modifier_necrolyte_reapers_scythe_lua:IsPurgable()
	return false
end
function modifier_necrolyte_reapers_scythe_lua:IsPurgeException()
	return false
end
function modifier_necrolyte_reapers_scythe_lua:IsStunDebuff()
	return true
end
function modifier_necrolyte_reapers_scythe_lua:AllowIllusionDuplicate()
	return false
end
function modifier_necrolyte_reapers_scythe_lua:GetEffectName()
	return "particles/units/heroes/hero_necrolyte/necrolyte_scythe_orig.vpcf"
end
function modifier_necrolyte_reapers_scythe_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_necrolyte_reapers_scythe_lua:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
function modifier_necrolyte_reapers_scythe_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_necrolyte_reapers_scythe_lua:OnCreated()
	if IsServer() then
		local hParent = self:GetParent()
		if IsValid(hParent) and hParent:IsRealHero() then
			self.bHero = true
			self.hp_pct = hParent:GetHealthPercent()
		else
			self.bHero = false
			self.hp_pct = hParent:GetHealthPercent()
		end
	end
end
function modifier_necrolyte_reapers_scythe_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT,
	}
end
function modifier_necrolyte_reapers_scythe_lua:OnDestroy()
	if IsServer() then
		local hParent = self:GetParent()
		if self:GetAbility() ~= nil and IsValid(hParent) then
			self:GetAbility():Slay(hParent, self.bHero, self.hp_pct)
		end
	end
end
function modifier_necrolyte_reapers_scythe_lua:OnTakeDamageKillCredit(params)
	local hParent = self:GetParent()
	if params.target == hParent then
		self.hp_pct = hParent:GetHealthPercent()
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_necrolyte_reapers_scythe_lua_stack == nil then
	modifier_necrolyte_reapers_scythe_lua_stack = class({})
end
function modifier_necrolyte_reapers_scythe_lua_stack:IsHidden()
	return false
end
function modifier_necrolyte_reapers_scythe_lua_stack:IsDebuff()
	return false
end
function modifier_necrolyte_reapers_scythe_lua_stack:IsPurgable()
	return false
end
function modifier_necrolyte_reapers_scythe_lua_stack:IsPurgeException()
	return false
end
function modifier_necrolyte_reapers_scythe_lua_stack:DestroyOnExpire()
	return false
end
function modifier_necrolyte_reapers_scythe_lua_stack:RemoveOnDeath()
	return false
end
function modifier_necrolyte_reapers_scythe_lua_stack:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end
function modifier_necrolyte_reapers_scythe_lua_stack:OnCreated(params)
	self.hp_per_kill = self:GetAbility():GetSpecialValueFor("hp_per_kill")
	self.mana_per_kill = self:GetAbility():GetSpecialValueFor("mana_per_kill")
end
function modifier_necrolyte_reapers_scythe_lua_stack:OnRefresh(params)
	self.hp_per_kill = self:GetAbility():GetSpecialValueFor("hp_per_kill")
	self.mana_per_kill = self:GetAbility():GetSpecialValueFor("mana_per_kill")
end
function modifier_necrolyte_reapers_scythe_lua_stack:GetModifierConstantHealthRegen()
	return self.hp_per_kill * self:GetStackCount()
end
function modifier_necrolyte_reapers_scythe_lua_stack:GetModifierConstantManaRegen()
	return self.mana_per_kill * self:GetStackCount()
end
function modifier_necrolyte_reapers_scythe_lua_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end