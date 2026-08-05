--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_immune_bkb_flask", "items/d_items/item_bkb_flask", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_immune_bkb_flask_cd", "items/d_items/item_bkb_flask", LUA_MODIFIER_MOTION_NONE)

item_bkb_flask = class({})

function item_bkb_flask:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function item_bkb_flask:OnSpellStart()
	local caster = self:GetCaster()
	local target_pos = self:GetCursorPosition()
	local projectile_speed = 600

	local dummy = CreateUnitByName(
		"npc_dummy_unit",
		target_pos,
		false,
		self:GetCaster(),
		self:GetCaster(),
		self:GetCaster():GetTeamNumber()
	)
	dummy:AddNewModifier(self:GetCaster(), self, "modifier_dummy", {})

	local info = {
		Target = dummy,
		Source = caster,
		Ability = self,
		bDodgeable = false,
		EffectName = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf",
		iMoveSpeed = projectile_speed,
	}

	ProjectileManager:CreateTrackingProjectile(info)

	EmitSoundOn("Hero_Alchemist.UnstableConcoction.Throw", caster)
end

function item_bkb_flask:OnProjectileHit(target, location)
	if not target then
		return
	end
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	local allies = FindUnitsInRadius(
		DOTA_TEAM_GOODGUYS,
		target:GetOrigin(),
		target,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		0,
		false
	)
	for _, ally in pairs(allies) do
		if not ally:HasModifier("modifier_immune_bkb_flask_cd") then
			ally:AddNewModifier(target, nil, "modifier_magic_immune", { duration = duration })
			ally:AddNewModifier(target, nil, "modifier_immune_bkb_flask", { duration = duration })
			ally:AddNewModifier(target, nil, "modifier_immune_bkb_flask_cd", { duration = 90 })
		end
	end

	local explosion_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_explosion.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(explosion_pfx, 0, location)
	ParticleManager:ReleaseParticleIndex(explosion_pfx)

	local sound_cast = "DOTA_Item.BlackKingBar.Activate"
	-- EmitSoundOnLocationWithCaster(location, sound_cast, caster)
	EmitSoundOn(sound_cast, caster)
	UTIL_Remove(target)
	if self:GetCurrentCharges() > 1 then
		self:SetCurrentCharges(self:GetCurrentCharges() - 1)
	else
		UTIL_Remove(self)
	end
	return true
end

----------------------------------------------------------------------------------

modifier_immune_bkb_flask_cd = class({
	IsHidden = function()
		return false
	end,
	IsPurgable = function()
		return false
	end,
	IsDebuff = function()
		return false
	end,
	RemoveOnDeath = function()
		return false
	end,
	GetTexture = function()
		return "item_bkb_flask"
	end,
})

modifier_immune_bkb_flask = class({
	IsHidden = function()
		return true
	end,
	IsPurgable = function()
		return false
	end,
	IsDebuff = function()
		return false
	end,
	GetTexture = function()
		return "item_bkb_flask"
	end,
	GetEffectName = function()
		return "particles/bkb_flask.vpcf"
	end,
	GetEffectAttachType = function()
		return PATTACH_ABSORIGIN_FOLLOW
	end,
})