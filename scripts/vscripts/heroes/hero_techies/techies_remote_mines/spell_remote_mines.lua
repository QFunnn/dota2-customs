--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


techies_remote_mines_lua = class({})

LinkLuaModifier(
	"modifier_remote_mines",
	"heroes/hero_techies/techies_remote_mines/spell_remote_mines.lua",
	LUA_MODIFIER_MOTION_NONE
)

function techies_remote_mines_lua:GetCastRange(vLocation, hTarget)
	return self:GetSpecialValueFor("cast_range_tooltip")
end
function techies_remote_mines_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end
function techies_remote_mines_lua:GetAssociatedPrimaryAbilities()
	return "techies_focused_detonate_lua"
end
function techies_remote_mines_lua:OnUpgrade()
	local ability = self:GetCaster():FindAbilityByName("techies_focused_detonate_lua")
	if ability then
		ability:SetLevel(1)
	end
end

function techies_remote_mines_lua:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	caster:EmitSound("Hero_Techies.RemoteMine.Toss")
	local pos = self:GetCursorPosition()
	self.mine = CreateUnitByName(
		"npc_dota_techies_remote_mine",
		caster:GetAbsOrigin(),
		true,
		caster,
		caster,
		caster:GetTeamNumber()
	)
	self.mine:AddNoDraw()
	self.mine:ForceKill(false)
	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_techies/techies_remote_mine_plant.vpcf",
		PATTACH_CUSTOMORIGIN,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		self.pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_remote",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.pfx, 1, pos)
	ParticleManager:SetParticleControlEnt(
		self.pfx,
		2,
		self.mine,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.mine:GetAbsOrigin(),
		true
	)
	return true
end

function techies_remote_mines_lua:OnAbilityPhaseInterrupted()
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, true)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
	if self.mine then
		self.mine:ForceKill(false)
	end
end

function techies_remote_mines_lua:OnSpellStart()
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, true)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
	local caster = self:GetCaster()
	local pos = self:GetCursorPosition()
	local mine = CreateUnitByName("npc_dota_techies_remote_mine", pos, true, caster, caster, caster:GetTeamNumber())
	mine:EmitSound("Hero_Techies.RemoteMine.Plant")
	mine:SetControllableByPlayer(caster:GetPlayerID(), false)
	mine:AddNewModifier(caster, self, "modifier_kill", { duration = self:GetSpecialValueFor("duration") })
	mine:AddNewModifier(caster, self, "modifier_remote_mines", { duration = self:GetSpecialValueFor("duration") })
	mine:AddAbility("techies_remote_mines_self_detonate_lua"):SetLevel(1)
end

modifier_remote_mines = class({})

function modifier_remote_mines:IsDebuff()
	return false
end
function modifier_remote_mines:IsHidden()
	return true
end
function modifier_remote_mines:IsPurgable()
	return false
end
function modifier_remote_mines:IsPurgeException()
	return false
end
function modifier_remote_mines:CheckState()
	return { [MODIFIER_STATE_INVISIBLE] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_remote_mines:GetEffectName()
	return "particles/units/heroes/hero_techies/techies_remote_mine.vpcf"
end
function modifier_remote_mines:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_remote_mines:OnDestroy()
	if IsServer() and self:GetStackCount() > 0 then
		local ability = self:GetParent():GetOwnerEntity():FindAbilityByName("techies_remote_mines_lua")
		if not ability then
			return
		end
		local caster = self:GetParent():GetOwnerEntity()
		local ampl = self:GetParent():GetOwner():GetSpellAmplification(false) + 1
		local dmg = ability:GetSpecialValueFor("damage")

		local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_techies_int4")
		if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
			dmg = dmg + 200
		end

		local damage = dmg * ampl

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			self:GetParent(),
			ability:GetSpecialValueFor("radius"),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in pairs(enemies) do
			ApplyDamage({
				victim = enemy,
				attacker = self:GetParent(),
				damage = damage,
				damage_type = ability:GetAbilityDamageType(),
				ability = ability,
			})
		end
		local sound = CreateModifierThinker(
			caster,
			nil,
			"modifier_dummy_thinker",
			{ duration = 1.0 },
			self:GetParent():GetAbsOrigin(),
			caster:GetTeamNumber(),
			false
		)
		sound:EmitSound("Hero_Techies.RemoteMine.Detonate")
		sound:EmitSound("Hero_Techies.RemoteMine.Activate")
		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_techies/techies_remote_mines_detonate.vpcf",
			PATTACH_ABSORIGIN,
			sound
		)
		ParticleManager:SetParticleControl(
			pfx,
			1,
			Vector(
				ability:GetSpecialValueFor("radius"),
				ability:GetSpecialValueFor("radius"),
				ability:GetSpecialValueFor("radius")
			)
		)
		ParticleManager:ReleaseParticleIndex(pfx)
		AddFOWViewer(
			caster:GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			ability:GetSpecialValueFor("vision_radius"),
			ability:GetSpecialValueFor("vision_duration"),
			true
		)
	end
end
-------------------------------------
--СПЕЛЛ НА МИНЕРЕ
-------------------------------------
techies_focused_detonate_lua = class({})

function techies_focused_detonate_lua:IsHiddenWhenStolen()
	return false
end
function techies_focused_detonate_lua:IsRefreshable()
	return true
end
function techies_focused_detonate_lua:IsStealable()
	return false
end
function techies_focused_detonate_lua:IsNetherWardStealable()
	return false
end
function techies_focused_detonate_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end
function techies_focused_detonate_lua:GetAssociatedPrimaryAbilities()
	return "techies_remote_mines_lua"
end

function techies_focused_detonate_lua:OnSpellStart()
	local caster = self:GetCaster()
	local pos = self:GetCursorPosition()
	local mines = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		self:GetSpecialValueFor("radius"),
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_OTHER,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, mine in pairs(mines) do
		if
			mine:GetPlayerOwnerID() == caster:GetPlayerOwnerID()
			and mine:GetUnitName() == "npc_dota_techies_remote_mine"
			and mine:HasAbility("techies_remote_mines_self_detonate_lua")
		then
			if mine:FindModifierByName("modifier_remote_mines") then
				mine:FindModifierByName("modifier_remote_mines"):SetStackCount(1)
				mine:FindModifierByName("modifier_remote_mines"):Destroy()
				mine:ForceKill(false)
			end
		end
	end
end

-------------------------------------
--СПЕЛЛ САМОЙ МИНКИ
-------------------------------------
techies_remote_mines_self_detonate_lua = class({})

function techies_remote_mines_self_detonate_lua:IsHiddenWhenStolen()
	return false
end
function techies_remote_mines_self_detonate_lua:IsRefreshable()
	return true
end
function techies_remote_mines_self_detonate_lua:IsStealable()
	return false
end
function techies_remote_mines_self_detonate_lua:IsNetherWardStealable()
	return false
end
function techies_remote_mines_self_detonate_lua:IsTalentAbility()
	return true
end

function techies_remote_mines_self_detonate_lua:OnSpellStart()
	local ability = self:GetCaster():GetOwnerEntity():FindAbilityByName("techies_remote_mines_lua")
	if ability then
		self:GetCaster():FindModifierByName("modifier_remote_mines"):SetStackCount(1)
		self:GetCaster():FindModifierByName("modifier_remote_mines"):Destroy()
	end
	self:GetCaster():ForceKill(false)
end