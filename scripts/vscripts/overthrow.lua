--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_dota_ability_xp_granter", "overthrow.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_get_xp", "overthrow.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dota_ability_xp_granter_arena6", "overthrow.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_get_xp_arena6", "overthrow.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dota_ability_xp_global", "overthrow.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_get_xp_global", "overthrow.lua", LUA_MODIFIER_MOTION_NONE )

dota_ability_xp_granter = 
{
	GetIntrinsicModifierName = function() return "modifier_dota_ability_xp_granter" end
}

modifier_dota_ability_xp_granter = 
{
	IsHidden = function() return true end,
	IsAura = function() return true end,
	GetModifierAura    = function() return "modifier_get_xp" end,
	GetAuraRadius = function(self) return self:GetAbility():GetSpecialValueFor("aura_radius") end,
	GetAuraDuration    = function() return 0.2 end,
	GetAuraSearchTeam = function() return DOTA_UNIT_TARGET_TEAM_BOTH end,
	GetAuraSearchType = function() return DOTA_UNIT_TARGET_HERO end,
	GetAuraSearchFlags = function() return DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end,
}

function modifier_dota_ability_xp_granter:CheckState()
	return 
	{
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end

modifier_get_xp = 
{
	IsHidden = function() return true end,
	IsDebuff = function() return false end,
	GetTexture = function() return "alchemist_goblins_greed" end
}

if IsServer() then
	function modifier_get_xp:OnCreated(keys)
		self:StartIntervalThink(0.5)
	end

	function modifier_get_xp:OnIntervalThink()
		if self:GetParent():HasModifier("modifier_woda_stunned") then return end
		if self:GetParent():HasModifier("modifier_wodarelax") then return end
		if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
		local parent = self:GetParent()
		local ability = self:GetAbility()
		local xp = ability:GetSpecialValueFor("aura_xp")
		local gold = ability:GetSpecialValueFor("aura_gold")
		if not parent:IsRealHero() then return end
		parent:ModifyGold(gold * 0.5, false, 0)
		parent:AddExperience(xp * 0.5, 0, false, true)
	end
end

dota_ability_xp_global = 
{
	GetIntrinsicModifierName = function() return "modifier_dota_ability_xp_global" end
}

modifier_dota_ability_xp_global = {
	IsHidden = function() return true end,
	IsAura = function() return true end,
	GetModifierAura    = function() return "modifier_get_xp_global" end,
	GetAuraRadius = function() return FIND_UNITS_EVERYWHERE end,
	GetAuraDuration    = function() return 0.2 end,
	GetAuraSearchTeam = function() return DOTA_UNIT_TARGET_TEAM_BOTH end,
	GetAuraSearchType = function() return DOTA_UNIT_TARGET_HERO end,
	GetAuraSearchFlags = function() return DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD  end,
}

function modifier_dota_ability_xp_global:CheckState()
	return 
	{
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end

modifier_get_xp_global = 
{
	IsHidden = function() return true end,
	IsDebuff = function() return false end,
}

if IsServer() then
	function modifier_get_xp_global:OnCreated()
		self:StartIntervalThink(0.5)
	end

	function modifier_get_xp_global:OnIntervalThink()
		if self:GetParent():HasModifier("modifier_woda_stunned") then return end
		if self:GetParent():HasModifier("modifier_wodarelax") then return end
		if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
		local parent = self:GetParent()
		local ability = self:GetAbility()
		local xp = ability:GetSpecialValueFor("aura_xp")
		local gold = ability:GetSpecialValueFor("aura_gold")
		if not parent:IsRealHero() then return end
		parent:ModifyGold(gold * 0.5, false, 0)
		parent:AddExperience(xp * 0.5, 0, false, true)
	end
end

dota_ability_throw_sphere_blue = class({})

function dota_ability_throw_sphere_blue:Spawn()
	if not IsServer() then return end
	if not self:IsTrained() then
		self:SetLevel(1)
	end
end

function dota_ability_throw_sphere_blue:OnSpellStart()
	if not IsServer() then return end
	local coinAttach = self:GetCaster():ScriptLookupAttachment( "coin_toss_point" )
	local coinSpawn = Vector( 0, 0, 0 )
	if coinAttach ~= -1 then
		coinSpawn = self:GetCaster():GetAttachmentOrigin( coinAttach )
	end
    if coinSpawn == nil then
        coinSpawn = Vector( 0, 0, 0 )
    end
	arena_system:SpawnSphereBlue(coinSpawn)
end

dota_ability_throw_sphere_red = class({})

function dota_ability_throw_sphere_red:Spawn()
	if not IsServer() then return end
	if not self:IsTrained() then
		self:SetLevel(1)
	end
end

function dota_ability_throw_sphere_red:OnSpellStart()
	if not IsServer() then return end
	local coinAttach = self:GetCaster():ScriptLookupAttachment( "coin_toss_point" )
	local coinSpawn = Vector( 0, 0, 0 )
	if coinAttach ~= -1 then
		coinSpawn = self:GetCaster():GetAttachmentOrigin( coinAttach )
	end
    if coinSpawn == nil then
        coinSpawn = Vector( 0, 0, 0 )
    end
	arena_system:SpawnSphereRed(coinSpawn)
end

dota_ability_xp_granter_arena6 = 
{
	GetIntrinsicModifierName = function() return "modifier_dota_ability_xp_granter_arena6" end
}

modifier_dota_ability_xp_granter_arena6 = 
{
	IsHidden = function() return true end,
	IsAura = function() return true end,
	GetModifierAura    = function() return "modifier_get_xp_arena6" end,
	GetAuraRadius = function(self) return self:GetAbility():GetSpecialValueFor("aura_radius") end,
	GetAuraDuration    = function() return 0.2 end,
	GetAuraSearchTeam = function() return DOTA_UNIT_TARGET_TEAM_BOTH end,
	GetAuraSearchType = function() return DOTA_UNIT_TARGET_HERO end,
	GetAuraSearchFlags = function() return DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end,
}

function modifier_dota_ability_xp_granter_arena6:CheckState()
	return 
	{
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end

modifier_get_xp_arena6 = 
{
	IsHidden = function() return false end,
	IsDebuff = function() return false end,
	GetTexture = function() return "dota_ability_xp_granter_arena6" end
}

if IsServer() then
	function modifier_get_xp_arena6:OnCreated(keys)
		self:StartIntervalThink(0.5)
	end

	function modifier_get_xp_arena6:OnIntervalThink()
		if self:GetParent():HasModifier("modifier_woda_stunned") then return end
		if self:GetParent():HasModifier("modifier_wodarelax") then return end
		if self:GetParent():HasModifier("modifier_wodarelax_invul") then return end
		if self:GetParent():HasModifier("modifier_wodawisp") then return end
		local parent = self:GetParent()
		local ability = self:GetAbility()
		local xp = ability:GetSpecialValueFor("aura_xp")
		if not parent:IsRealHero() then return end
		parent:AddExperience(xp * 0.5, 0, false, true)
	end
end