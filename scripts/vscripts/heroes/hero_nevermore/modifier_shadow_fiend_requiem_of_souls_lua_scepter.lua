--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_shadow_fiend_requiem_of_souls_lua_scepter = class({})

--------------------------------------------------------------------------------

function modifier_shadow_fiend_requiem_of_souls_lua_scepter:IsHidden()
	return false
	-- return true
end

function modifier_shadow_fiend_requiem_of_souls_lua_scepter:IsPurgable()
	return false
end
function modifier_shadow_fiend_requiem_of_souls_lua_scepter:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_shadow_fiend_requiem_of_souls_lua_scepter:OnCreated( kv )
	-- get references
	self.lines = kv.lineNumber
	self.duration = kv.lineDuration

	self.heal = 0

	-- Add timer
	if IsServer() then
		self:StartIntervalThink( self.duration )
	end
end

function modifier_shadow_fiend_requiem_of_souls_lua_scepter:OnRefresh( kv )
end

function modifier_shadow_fiend_requiem_of_souls_lua_scepter:OnDestroy()
	if IsServer() then
		if self.identifier then
			self:GetAbility():DelATValue( self.identifier )
		end
	end
end
--------------------------------------------------------------------------------
-- Interval
function modifier_shadow_fiend_requiem_of_souls_lua_scepter:OnIntervalThink()
	if not self.afterImplode then
		self.afterImplode = true

		-- implode
		self:GetAbility():Implode( self.lines, self )

		-- play effects
		local sound_cast = "Hero_Nevermore.RequiemOfSouls"
		self:GetParent():EmitSound(sound_cast)
	else
		-- Heal
		print("self.heal"..self.heal)
		self:GetParent():Heal( self.heal, self:GetAbility() )

		-- remove references
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_shadow_fiend_requiem_of_souls_lua_scepter:AddTotalHeal( value )
	self.heal = self.heal + value
end