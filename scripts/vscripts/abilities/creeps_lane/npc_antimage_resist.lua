--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_antimage_resist", "abilities/creeps_lane/npc_antimage_resist", LUA_MODIFIER_MOTION_NONE)

npc_antimage_resist = class({})

function npc_antimage_resist:GetIntrinsicModifierName()
	return "modifier_antimage_resist"
end

modifier_antimage_resist = class(mod_hidden)
function modifier_antimage_resist:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.resist = self.ability:GetSpecialValueFor("resist")
	self.ability.health = self.ability:GetSpecialValueFor("health")
	self.ability.bkb = self.ability:GetSpecialValueFor("bkb")

	if not IsServer() then
		return
	end
	self.parent:AddDamageEvent_inc(self, true)
end

function modifier_antimage_resist:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_antimage_resist:GetModifierMagicalResistanceBonus()
	return self.ability.resist
end

function modifier_antimage_resist:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if self.proc then
		return
	end
	if not self.parent:IsAlive() then
		return
	end
	if self.parent:GetHealthPercent() > self.ability.health then
		return
	end

	self.proc = true
	self.parent:Purge(false, true, false, true, true)
	self.parent:EmitSound("DOTA_Item.MinotaurHorn.Cast")
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_generic_debuff_immune",
		{ magic = -50, effect = 1, duration = self.ability.bkb }
	)
end