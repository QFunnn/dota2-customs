--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_vengefulspirit_magic_missile_custom_stack", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_magic_missile_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengefulspirit_magic_missile_custom_passive", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_magic_missile_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengefulspirit_magic_missile_custom_stack_debuff", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_magic_missile_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengefulspirit_magic_missile_custom_stack_creep", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_magic_missile_custom", LUA_MODIFIER_MOTION_NONE)

vengefulspirit_magic_missile_custom = class({})

function vengefulspirit_magic_missile_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_vengeful/vengeful_magic_missle.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_vengefulspirit.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_vengefulspirit.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_vengefulspirit.vpcf", context)
end

vengefulspirit_magic_missile_custom.modifier_vengefulspirit_17 = {15,30}
vengefulspirit_magic_missile_custom.modifier_vengefulspirit_18 = {6,12}
vengefulspirit_magic_missile_custom.modifier_vengefulspirit_15 = {1,2,3}
vengefulspirit_magic_missile_custom.modifier_vengefulspirit_15_per_creep = 0.75

function vengefulspirit_magic_missile_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local index = DoUniqueString("vengefulspirit_magic_missile_custom")
    self[index] = {}
	self:StartMissile(self:GetCaster(), target, 0, index)
end

function vengefulspirit_magic_missile_custom:GetIntrinsicModifierName()
	return "modifier_vengefulspirit_magic_missile_custom_passive"
end

function vengefulspirit_magic_missile_custom:StartMissile(caster, target, count, index)
	if not IsServer() then return end
	local projectile =
	{
		Target 				= target,
		Source 				= caster,
		Ability 			= self,
		EffectName 			= "particles/units/heroes/hero_vengeful/vengeful_magic_missle.vpcf",
		iMoveSpeed			= 1350,
		bDrawsOnMinimap 	= false,
		bDodgeable 			= true,
		bIsAttack 			= false,
		bVisibleToEnemies 	= true,
		bReplaceExisting 	= false,
		flExpireTime 		= GameRules:GetGameTime() + 10,
		bProvidesVision 	= false,
		iSourceAttachment 	= DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
		ExtraData			= {count = count, index = index}
	}
	ProjectileManager:CreateTrackingProjectile(projectile)
	self:GetCaster():EmitSound("Hero_VengefulSpirit.MagicMissile")
end

function vengefulspirit_magic_missile_custom:OnProjectileHit_ExtraData(target, location, ExtraData)
	if not IsServer() then return end
	if target == nil then return end
	if target:TriggerSpellAbsorb(self) then return end
	if target:IsMagicImmune() then return end
	self[ExtraData.index][target:entindex()] = true
	local magic_missile_stun = self:GetSpecialValueFor("magic_missile_stun")
	local magic_missile_damage = self:GetSpecialValueFor("magic_missile_damage")
	if self:GetCaster():HasModifier("modifier_vengefulspirit_18") then
		magic_missile_damage = magic_missile_damage + (self:GetCaster():GetMana() / 100 * self.modifier_vengefulspirit_18[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_18")])
	end
    local modifier_vengefulspirit_magic_missile_custom_stack_creep = self:GetCaster():FindModifierByName("modifier_vengefulspirit_magic_missile_custom_stack_creep")
    if modifier_vengefulspirit_magic_missile_custom_stack_creep then
        magic_missile_damage = magic_missile_damage + (modifier_vengefulspirit_magic_missile_custom_stack_creep:GetStackCount() * self.modifier_vengefulspirit_15_per_creep)
    end
    target:AddNewModifier(self:GetCaster(), self, "modifier_vengefulspirit_magic_missile_custom_stack_debuff", {duration = 3})
	EmitSoundOnLocationWithCaster(location, "Hero_VengefulSpirit.MagicMissileImpact", self:GetCaster())
	ApplyDamage({victim = target, attacker = self:GetCaster(), ability = self, damage = magic_missile_damage, damage_type = DAMAGE_TYPE_MAGICAL})
	target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = magic_missile_stun * (1 - target:GetStatusResistance())})

	if self:GetCaster():HasModifier("modifier_vengefulspirit_15") and ExtraData.count < self.modifier_vengefulspirit_15[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_15")] then
		ExtraData.count = ExtraData.count + 1

		local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetCastRange(target:GetAbsOrigin(), target), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, FIND_CLOSEST, false)
		local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetCastRange(target:GetAbsOrigin(), target), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)

		for i = #heroes, 1, -1 do
        	if heroes[i] ~= nil and self[ExtraData.index][heroes[i]:entindex()] ~= nil then
	            table.remove(heroes, i)
	        end
	    end
	    for i = #units, 1, -1 do
        	if units[i] ~= nil and self[ExtraData.index][units[i]:entindex()] ~= nil then
	            table.remove(units, i)
	        end
	    end
		local new_target = nil

		if #heroes > 0 then
			new_target = heroes[1]
		end

		if new_target == nil then
			if #units > 0 then
				new_target = units[1]
			end
		end

		if new_target == nil then return end
		self:StartMissile(target, new_target, ExtraData.count, ExtraData.index)
	end
end

modifier_vengefulspirit_magic_missile_custom_stack = class({})
modifier_vengefulspirit_magic_missile_custom_stack.radius = 450

function modifier_vengefulspirit_magic_missile_custom_stack:IsHidden() return true end
function modifier_vengefulspirit_magic_missile_custom_stack:IsPurgable() return false end
function modifier_vengefulspirit_magic_missile_custom_stack:RemoveOnDeath() return false end

function modifier_vengefulspirit_magic_missile_custom_stack:DeclareFunctions()
	return 
	{
		MODIFIER_EVENT_ON_DEATH
	}
end

function modifier_vengefulspirit_magic_missile_custom_stack:OnDeath(params)
	local target = params.unit
	if self:GetCaster():GetTeamNumber() == target:GetTeamNumber() then return end
	if target:IsReincarnating() then return end
	if not self:GetCaster():IsRealHero() then return end
	if not target:IsRealHero() then return end
	if self:GetParent():HasModifier("modifier_wodarelax") then return end

	if params.unit:HasModifier("modifier_vengefulspirit_magic_missile_custom_stack_debuff") then
		if params.attacker and params.attacker == self:GetParent() then
			self:SetStackCount(self:GetStackCount() + 1)
		end
	end
end

modifier_vengefulspirit_magic_missile_custom_stack_debuff = class({})
function modifier_vengefulspirit_magic_missile_custom_stack_debuff:IsHidden() return true end
function modifier_vengefulspirit_magic_missile_custom_stack_debuff:IsPurgeException() return false end
function modifier_vengefulspirit_magic_missile_custom_stack_debuff:IsPurgable() return false end
function modifier_vengefulspirit_magic_missile_custom_stack_debuff:RemoveOnDeath() return false end

modifier_vengefulspirit_magic_missile_custom_passive = class({})

function modifier_vengefulspirit_magic_missile_custom_passive:IsDebuff() return false end
function modifier_vengefulspirit_magic_missile_custom_passive:IsHidden() return not self:GetCaster():HasModifier("modifier_vengefulspirit_17") end
function modifier_vengefulspirit_magic_missile_custom_passive:IsPurgable() return false end
function modifier_vengefulspirit_magic_missile_custom_passive:IsStunDebuff() return false end
function modifier_vengefulspirit_magic_missile_custom_passive:RemoveOnDeath() return false end

function modifier_vengefulspirit_magic_missile_custom_passive:OnCreated()
	if not IsServer() then return end
	if not self:GetParent():IsIllusion() then
		self:StartIntervalThink(0.1)
	end
end

function modifier_vengefulspirit_magic_missile_custom_passive:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_vengefulspirit_17") then
		return
	end
	if self:GetCaster():HasModifier("modifier_vengefulspirit_magic_missile_custom_stack") then
		self:SetStackCount(self:GetCaster():FindModifierByName("modifier_vengefulspirit_magic_missile_custom_stack"):GetStackCount())
	end
	self:GetCaster():CalculateStatBonus(true)
end

function modifier_vengefulspirit_magic_missile_custom_passive:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_vengefulspirit_magic_missile_custom_passive:GetModifierManaBonus()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_vengefulspirit_17") then
		bonus = self:GetAbility().modifier_vengefulspirit_17[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_17")]
	end
	return bonus * self:GetStackCount()
end

function modifier_vengefulspirit_magic_missile_custom_passive:OnDeath(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.unit:IsHero() then return end
    if params.inflictor == nil then return end
    if params.inflictor ~= self:GetAbility() then return end
    if not self:GetParent():HasModifier("modifier_vengefulspirit_15") then return end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_vengefulspirit_magic_missile_custom_stack_creep", {})
end

modifier_vengefulspirit_magic_missile_custom_stack_creep = class({})
function modifier_vengefulspirit_magic_missile_custom_stack_creep:IsPurgable() return false end
function modifier_vengefulspirit_magic_missile_custom_stack_creep:IsPurgeException() return false end
function modifier_vengefulspirit_magic_missile_custom_stack_creep:RemoveOnDeath() return false end
function modifier_vengefulspirit_magic_missile_custom_stack_creep:GetTexture() return "vegenfulspirit_15" end
function modifier_vengefulspirit_magic_missile_custom_stack_creep:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
end
function modifier_vengefulspirit_magic_missile_custom_stack_creep:OnRefresh()
    if not IsServer() then return end
    self:IncrementStackCount()
end