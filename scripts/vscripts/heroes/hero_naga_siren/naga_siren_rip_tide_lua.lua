--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier( "modifier_naga_siren_rip_tide_lua", "heroes/hero_naga_siren/naga_siren_rip_tide_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_rip_tide_lua_debuff", "heroes/hero_naga_siren/naga_siren_rip_tide_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_rip_tide_lua_count", "heroes/hero_naga_siren/naga_siren_rip_tide_lua", LUA_MODIFIER_MOTION_NONE )

naga_siren_rip_tide_lua = naga_siren_rip_tide_lua or class({})

function naga_siren_rip_tide_lua:IsHiddenWhenStolen() return false end
function naga_siren_rip_tide_lua:IsRefreshable() return false end
function naga_siren_rip_tide_lua:IsStealable() return false end
function naga_siren_rip_tide_lua:IsNetherWardStealable() return false end

function naga_siren_rip_tide_lua:GetAbilityTextureName()
   return "naga_siren_rip_tide"
end

function naga_siren_rip_tide_lua:GetIntrinsicModifierName()
	local level = self:GetLevel()
	if level == 0 then return nil end
    return "modifier_naga_siren_rip_tide_lua"
end



modifier_naga_siren_rip_tide_lua = modifier_naga_siren_rip_tide_lua or class({})

function modifier_naga_siren_rip_tide_lua:IsHidden() return true end

function modifier_naga_siren_rip_tide_lua:OnCreated(  )
	self.hCaster = self:GetCaster()
	self.hAbility = self:GetAbility()
	
end


function modifier_naga_siren_rip_tide_lua:OnRefresh(  )
	self:OnCreated()
end

function modifier_naga_siren_rip_tide_lua:AttackLandedModifier( keys )
	
	local hAbility = keys.ability
	local hTarget = keys.target
	local hAttacker = keys.attacker

	if not self:GetAbility() then
		 return
	end

	if not self:GetParent() then
		 return
	end

	if hAttacker ~= self:GetParent() and self.hCaster ~= hAttacker then return end

	if hTarget:IsBuilding() or self.hCaster:PassivesDisabled() then return end
	if hTarget:IsOther() then return end
  
	self.hits = self:GetAbility():GetSpecialValueFor("hits") 

  local hModifier
   
	if hAttacker:HasModifier("modifier_naga_siren_rip_tide_lua_count") then
      hModifier = hAttacker:FindModifierByName("modifier_naga_siren_rip_tide_lua_count")
	else
		hModifier = hAttacker:AddNewModifier(self.hCaster, self.hAbility,"modifier_naga_siren_rip_tide_lua_count",{})
		if hModifier then
			hModifier:SetStackCount(0)
		end
	end
   
   if hModifier then
     if hModifier:GetStackCount() + 1 >= self.hits then
     	hModifier:SetStackCount(0)
      
			self.damage 				 = self:GetAbility():GetSpecialValueFor("damage")
		  self.radius 				 = self:GetAbility():GetSpecialValueFor("radius")
		  self.duration 				 = self:GetAbility():GetSpecialValueFor("duration")

		  self.damageTable = {
					-- victim = target,
					attacker = self:GetParent(),
					damage = self.damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self:GetAbility(),
			}

		  local enemies = FindUnitsInRadius(
				self.hCaster:GetTeamNumber(),
				self.hCaster:GetOrigin(),	
				nil,
				self.radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,	
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	
				0,	
				0,
				false
		  )

			for _,hEnemy in pairs(enemies) do
				-- apply debuff
				hEnemy:AddNewModifier(
					self.hCaster,
					self:GetAbility(),
					"modifier_naga_siren_rip_tide_lua_debuff",
					{ duration = self.duration }
				)

				self.damageTable.victim = hEnemy
				ApplyDamage( self.damageTable )
			end

			-- play effects
			self:PlayEffects()
     else
     	  hModifier:IncrementStackCount()
     end
   end
	 return 0
end

function modifier_naga_siren_rip_tide_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_siren/naga_siren_riptide.vpcf"
	local sound_cast = "Hero_NagaSiren.Riptide.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end


modifier_naga_siren_rip_tide_lua_count = modifier_naga_siren_rip_tide_lua_count or class({})
function modifier_naga_siren_rip_tide_lua_count:IsDebuff() return false end 
function modifier_naga_siren_rip_tide_lua_count:IsHidden() 
	if self:GetStackCount()==0 then
		return true
	else
		return false
	end
end


modifier_naga_siren_rip_tide_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_naga_siren_rip_tide_lua_debuff:IsHidden()
	return false
end

function modifier_naga_siren_rip_tide_lua_debuff:IsDebuff()
	return true
end

function modifier_naga_siren_rip_tide_lua_debuff:IsStunDebuff()
	return false
end

function modifier_naga_siren_rip_tide_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_naga_siren_rip_tide_lua_debuff:OnCreated( kv )
	self.armor_reduction = 0
	if self:GetAbility() and self:GetCaster() then
	  self.armor_reduction 	= self:GetAbility():GetSpecialValueFor("armor_reduction")
  end
end

function modifier_naga_siren_rip_tide_lua_debuff:OnRefresh( kv )
	self:OnCreated()
end

function modifier_naga_siren_rip_tide_lua_debuff:OnRemoved()
end

function modifier_naga_siren_rip_tide_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_naga_siren_rip_tide_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_naga_siren_rip_tide_lua_debuff:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_naga_siren_rip_tide_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_riptide_debuff.vpcf"
end

function modifier_naga_siren_rip_tide_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end