--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


furion_sprout_custom = class({})
LinkLuaModifier( "modifier_furion_sprout_talent_thinker", "abilities/heroes/furion/sprout", LUA_MODIFIER_MOTION_NONE )

function furion_sprout_custom:OnSpellStart()
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end
	local target = self:GetCursorTarget()
	local target_position
	if not target or target:IsNull() then
		target_position = self:GetCursorPosition()
	else
		if target:TriggerSpellAbsorb( self ) then return end	-- cancel if linken
		target_position = target:GetOrigin()
	end

	self.duration = self:GetSpecialValueFor( "duration" )
	self.radius = self:GetSpecialValueFor( "radius" )
	self.vision_range = self:GetSpecialValueFor( "vision_range" )
	self.sprout_count = 8		-- hehe
	self.large_treant_count = 2
	self.trees = {}
	
	-- spawn trees
	local offset = Vector(self.radius, 0, 0)
	for i = 1, self.sprout_count do
		local tree_position = target_position + RotateVector2D(offset, 360 * i / self.sprout_count, false)
		local tree = CreateTempTree( tree_position, self.duration )
		tree.sprout_tree = true
		tree.origin = tree_position
		table.insert(self.trees, tree)
		ResolveNPCPositions( tree_position, 64.0 ) --Tree Radius
	end

	-- talents
	if caster:HasTalent("special_bonus_unique_furion_4") or caster:HasTalent("special_bonus_unique_furion_7") then
		local thinker = CreateModifierThinker(caster, self, "modifier_furion_sprout_talent_thinker", {duration = self.duration}, target_position, caster:GetTeamNumber(), false)
		if thinker then
			if caster:HasTalent("special_bonus_unique_furion_4") then	-- 100% miss chance
				thinker:AddNewModifier(caster, self, "modifier_furion_sprout_blind_aura", {duration = self.duration})
			end
			if caster:HasTalent("special_bonus_unique_furion_7") then	-- leash
				thinker:AddNewModifier(caster, self, "modifier_furion_sprout_tether_aura", {duration = self.duration})
			end
		end
	end
	
	-- particles
	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_sprout.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControl( nFXIndex, 0, target_position )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 0.0, self.radius, 0.0 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
	
	AddFOWViewer( self:GetCaster():GetTeamNumber(), target_position, self.vision_range, self.duration, false )
	EmitSoundOnLocationWithCaster( target_position, "Hero_Furion.Sprout", self:GetCaster() )
end

function furion_sprout_custom:GetSproutCount()
	return self.sprout_count
end

function furion_sprout_custom:GetSproutTrees()
	return self.trees
end

function furion_sprout_custom:GetLargeTreantTable()
	return self.large_treants
end

function furion_sprout_custom:AppendLargeTreant(large_treant)
	table.insert(self.large_treants, large_treant)
end

function furion_sprout_custom:KillFirstLargeTreant()
	local first_large_treant = self.large_treants[1]
	if first_large_treant and not first_large_treant:IsNull() and IsValidEntity(first_large_treant) and first_large_treant:IsAlive() then
		first_large_treant:Kill(self, first_large_treant)
	end
	table.remove(self.large_treants, 1)
end


-----------------------------------------------------------------------------------------------------------------------------------------------------


modifier_furion_sprout_talent_thinker = class({})

function modifier_furion_sprout_talent_thinker:IsHidden() return true end
function modifier_furion_sprout_talent_thinker:IsPurgable() return false end

function modifier_furion_sprout_talent_thinker:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end

function modifier_furion_sprout_talent_thinker:OnCreated( kv )
end

function modifier_furion_sprout_talent_thinker:OnRefresh( kv )
end

function modifier_furion_sprout_talent_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove(self.parent)
end