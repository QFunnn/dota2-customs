--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--------------------------------------------------------------------------------
modifier_drow_ranger_marksmanship_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_drow_ranger_marksmanship_lua:IsHidden()
	return true
end

function modifier_drow_ranger_marksmanship_lua:IsDebuff()
	return false
end

function modifier_drow_ranger_marksmanship_lua:IsPurgable()
	return false
end

function modifier_drow_ranger_marksmanship_lua:GetPriority()
	return MODIFIER_PRIORITY_LOW
end
function modifier_drow_ranger_marksmanship_lua:AllowIllusionDuplicate()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_drow_ranger_marksmanship_lua:OnCreated(kv)
	if not IsServer() then return end
	self.active = true

	-- references
	self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.disable = self:GetAbility():GetSpecialValueFor("disable_range")
	self.radius = self:GetAbility():GetSpecialValueFor("agility_range")
	self.split_range = self:GetAbility():GetSpecialValueFor("split_range")
	self.split_count = self:GetAbility():GetSpecialValueFor("split_count")
	self.damage_reduction_scepter = self:GetAbility():GetSpecialValueFor("damage_reduction_scepter")
	self.chance = self:GetAbility():GetSpecialValueFor("chance")
	self.records = {}
	self.procs = false

	-- precache splinter
	self.info = {

		Ability = self:GetAbility(),

		EffectName = self:GetParent():GetRangedProjectileName(),
		iMoveSpeed = self:GetParent():GetProjectileSpeed(),
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,

		bDodgeable = true,
		bIsAttack = true,

		ExtraData = {},
	}

	-- Start interval
	self:StartIntervalThink(1)
	self.LastTime = GameRules:GetGameTime()

	-- play effects
	self:PlayMarksmanshipBuffParticles()
end

function modifier_drow_ranger_marksmanship_lua:OnRefresh(kv)
	if not IsServer() then return end
	-- references
	self.chance = self:GetAbility():GetSpecialValueFor("chance")
	self.damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.disable = self:GetAbility():GetSpecialValueFor("disable_range")
	self.radius = self:GetAbility():GetSpecialValueFor("agility_range")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_drow_ranger_marksmanship_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,


		-- MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,

		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_EVENT_ON_ATTACK_START,
	}

	return funcs
end

function modifier_drow_ranger_marksmanship_lua:CheckState(kv)
	if not IsServer() then return end
	return {
		[MODIFIER_STATE_CANNOT_MISS] = self.procs
	}
end

function modifier_drow_ranger_marksmanship_lua:OnAttackStart(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end

	-- cancel if inactive
	if not self.active then return end

	-- Calculate chance including talent, if any	
	-- local chance = self.chance
	-- if self:GetCaster():HasTalent("special_bonus_unique_drow_ranger_3") then
	-- 	chance = chance + self:GetParent():FindTalentValue("special_bonus_unique_drow_ranger_3")
	-- end

	--在攻击开始的时候 判断是否穿透护甲
	if not RollPercentage(self.chance) then return end
	self.procs = true

end

function modifier_drow_ranger_marksmanship_lua:OnAttack(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end

	-- check if split shot and procs
	if self:GetAbility().split and self:GetAbility().split_procs then
		self.procs = true
	end

	-- check if procs
	if not self.procs then return end
	self.procs = false

	-- procs, record attack
	self.records[params.record] = true
end

function modifier_drow_ranger_marksmanship_lua:GetModifierProcAttack_BonusDamage_Physical(params)
	if not IsServer() then return end
	if not self.records[params.record] then return end
	return self.damage
end

function modifier_drow_ranger_marksmanship_lua:OnAttackRecordDestroy(params)
	if not self.records[params.record] then return end

	-- destroy record, and immediately destroy ignore armor modifier
	local modifier = self.records[params.record]
	if type(modifier) == 'table' and not modifier:IsNull() then
		modifier:Destroy()
	end
	self.records[params.record] = nil
end

function modifier_drow_ranger_marksmanship_lua:GetModifierProjectileName(params)
	-- if not IsServer() then return end

	-- check procs
	-- if not self.procs then return end
	if self.procs then
		return "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
	else
		return "particles/units/heroes/hero_drow/drow_base_attack.vpcf"
	end
end

function modifier_drow_ranger_marksmanship_lua:OnAttackLanded(params)
	if not IsServer() then return end
	local hParent = self:GetParent()
	-- if not self.records[params.record] then return end

	if self.records[params.record] ~= nil then
		-- add ignore armor modifier
		local modifier = params.target:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_drow_ranger_marksmanship_lua_debuff", -- modifier name
		{ duration = 0.5 } -- kv
		)
		self.records[params.record] = modifier
	end

	--7.33小黑A杖修改，去掉分裂部分

	-- if GameRules:GetGameTime() < self.LastTime + 0.2 then
	-- 	return
	-- end

	-- --排除大部分 无限触发
	-- if params.no_attack_cooldown then
	-- 	return
	-- end

	-- --回退掉法力消耗
	-- local ability = self:GetAbility()
	-- if (not ability) or ability:IsNull() then return end
	-- if ability.split then
	-- 	local frost_arrows_ability = hParent:FindAbilityByName("drow_ranger_frost_arrows")
	-- 	if frost_arrows_ability and not frost_arrows_ability:IsNull() and frost_arrows_ability:GetAutoCastState() then
	-- 		hParent:GiveMana(frost_arrows_ability:GetManaCost(-1))
	-- 	end
	-- 	return
	-- end

	-- if params.attacker == self:GetParent() and params.attacker:HasScepter() and not params.attacker:AttackFilter(params.record, ATTACK_STATE_NOT_PROCESSPROCS, ATTACK_STATE_NO_EXTENDATTACK) and not params.attacker:PassivesDisabled() then
	--	 local tTargets = FindUnitsInRadius(params.attacker:GetTeamNumber(), params.target:GetAbsOrigin(), nil, self.split_range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false)
	--	 local iCount = 0
	--	 self.LastTime = GameRules:GetGameTime()
	--	 for n, hTarget in pairs(tTargets) do
	--		 if hTarget ~= params.target then
	--			 local info =				{
	--				 Ability = self:GetAbility(),
	--				 EffectName = "particles/units/heroes/hero_drow/drow_base_attack.vpcf",
	--				 vSourceLoc = params.target:GetAttachmentOrigin(params.target:ScriptLookupAttachment("attach_hitloc")),
	--				 iMoveSpeed = 1250,
	--				 Target = hTarget,
	--				 bIsAttack = true,
	--				 ExtraData = {
	--					 Target = hTarget:entindex()
	--				 }
	--			 }
	--			 ProjectileManager:CreateTrackingProjectile(info)

	--			 iCount = iCount + 1
	--			 if iCount >= self.split_count then
	--				 break
	--			 end
	--		 end
	--	 end
	-- end

	-- find enemies
	-- local enemies = FindUnitsInRadius(
	-- parent:GetTeamNumber(), -- int, your team number
	-- params.target:GetOrigin(), -- point, center point
	-- nil, -- handle, cacheUnit. (not known)
	-- self.split_range, -- float, radius. or use FIND_UNITS_EVERYWHERE
	-- DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
	-- DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
	-- DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, -- int, flag filter
	-- FIND_ANY_ORDER, -- int, order filter
	-- false	-- bool, can grow cache
	-- )

	-- local count = 0
	-- for _, enemy in pairs(enemies) do
	--	 if enemy ~= params.target and count < self.split_count then

	--		 -- Calculate chance including talent, if any	
	--		 -- local chance = self.chance
	--		 -- if self:GetCaster():HasTalent("special_bonus_unique_drow_ranger_3") then
	--		 -- 	chance = chance + parent:FindTalentValue("special_bonus_unique_drow_ranger_3")
	--		 -- end			
	--		 -- roll pierce armor chance
	--		 local procs = false	
	--		 if self.active and RollPercentage(self.chance) then
	--			 procs = true
	--		 end

	--		 -- launch projectile
	--		 self.info.Target = enemy
	--		 self.info.Source = params.target
	--		 if procs then
	--			 self.info.EffectName = "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
	--			 self.info.ExtraData = {
	--				 procs = true,
	--			 }
	--		 else
	--			 self.info.EffectName = parent:GetRangedProjectileName() ~= "" and parent:GetRangedProjectileName() or "particles/units/heroes/hero_drow/drow_base_attack.vpcf"
	--			 self.info.ExtraData = {
	--				 procs = false,
	--			 }
	--		 end

	--		 ProjectileManager:CreateTrackingProjectile(self.info)

	--		 --ability:OnProjectileHit_ExtraData(enemy, enemy:GetAbsOrigin(), self.info )

	--		 count = count + 1
	--	 end
	-- end
end

function modifier_drow_ranger_marksmanship_lua:GetModifierDamageOutgoing_Percentage()
	if not IsServer() then return end

	-- check if split shot
	if self:GetAbility().split then
		return -self.damage_reduction_scepter
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_drow_ranger_marksmanship_lua:OnIntervalThink()
	-- check for enemy
	local enemies = FindUnitsInRadius(
	self:GetParent():GetTeamNumber(), -- int, your team number
	self:GetParent():GetOrigin(), -- point, center point
	nil, -- handle, cacheUnit. (not known)
	self.disable, -- float, radius. or use FIND_UNITS_EVERYWHERE
	DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
	DOTA_UNIT_TARGET_HERO, -- int, type filter
	DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, -- int, flag filter
	0, -- int, order filter
	false	-- bool, can grow cache
	)

	local no_enemies = not self:GetParent():PassivesDisabled() and #enemies == 0

	-- check if change state
	if self.active ~= no_enemies then
		self:PlayMarksmanshipBuffStartParticles(no_enemies)
		self.active = no_enemies
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_drow_ranger_marksmanship_lua:IsAura()

	if IsServer() then
		--幻象不产生光环，光环效果可以加给幻象
		if self:GetParent() and not self:GetParent():IsNull() and not self:GetParent():IsIllusion() and not self:GetParent():IsTempestDouble() then
			return self.active
		else
			return false
		end
	end

end

function modifier_drow_ranger_marksmanship_lua:GetModifierAura()
	return "modifier_drow_ranger_marksmanship_lua_effect"
end

function modifier_drow_ranger_marksmanship_lua:GetAuraRadius()
	return self.radius
end

function modifier_drow_ranger_marksmanship_lua:GetAuraDuration()
	return 0.5
end

function modifier_drow_ranger_marksmanship_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_drow_ranger_marksmanship_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_drow_ranger_marksmanship_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_RANGED_ONLY + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_drow_ranger_marksmanship_lua:PlayMarksmanshipBuffParticles()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_drow/drow_marksmanship.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())

	-- set glowing
	ParticleManager:SetParticleControl(self.effect_cast, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.effect_cast, 2, Vector(2, 0, 0))
	ParticleManager:SetParticleControl(self.effect_cast, 3, self:GetParent():GetAbsOrigin());
	ParticleManager:SetParticleControl(self.effect_cast, 5, self:GetParent():GetAbsOrigin());

	-- buff particle
	self:AddParticle(
	self.effect_cast,
	false, -- bDestroyImmediately
	false, -- bStatusEffect
	-1, -- iPriority
	false, -- bHeroEffect
	false -- bOverheadEffect
	)

	self:PlayMarksmanshipBuffStartParticles(true)
end

function modifier_drow_ranger_marksmanship_lua:PlayMarksmanshipBuffStartParticles(start)
	-- turn on/off cold effect
	local state = 1
	if start then state = 2 end
	ParticleManager:SetParticleControl(self.effect_cast, 2, Vector(state, 0, 0))

	-- play start effect
	if not start then return end

	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_drow/drow_marksmanship_start.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end