--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_siege_attack", "abilities/creeps_lane/npc_siege_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_siege_plusarmor", "abilities/creeps_lane/npc_siege_armor", LUA_MODIFIER_MOTION_NONE)

npc_siege_armor = class({})

function npc_siege_armor:Precache(context)
	PrecacheResource("particle", "particles/items2_fx/medallion_of_courage_friend.vpcf", context)
end

function npc_siege_armor:GetIntrinsicModifierName()
	return "modifier_siege_attack"
end

modifier_siege_attack = class(mod_hidden)
function modifier_siege_attack:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.armor = self.ability:GetSpecialValueFor("armor")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.max = self.ability:GetSpecialValueFor("max")

	if not IsServer() then
		return
	end
	self.parent:AddAttackEvent_out(self, true)
end

function modifier_siege_attack:AttackEvent_out(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.attacker then
		return
	end

	params.target:EmitSound("Item_Desolator.Target")

	for _, friend in pairs(self.parent:FindFriends(1000)) do
		friend:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_siege_plusarmor",
			{ duration = self.ability.duration }
		)
	end
end

modifier_siege_plusarmor = class(mod_visible)
function modifier_siege_plusarmor:GetEffectName()
	return "particles/items2_fx/medallion_of_courage_friend.vpcf"
end
function modifier_siege_plusarmor:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_siege_plusarmor:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.armor = self.ability.armor
	self.max = self.ability.max

	if not IsServer() then
		return
	end
	self.parent:EmitSound("Hero_Dawnbreaker.Luminosity.Heal")
	self:OnRefresh()
end

function modifier_siege_plusarmor:OnRefresh()
	if not IsServer() then
		return
	end
	if self:GetStackCount() >= self.max then
		return
	end
	self:IncrementStackCount()
end

function modifier_siege_plusarmor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_siege_plusarmor:GetModifierPhysicalArmorBonus()
	return self.armor * self:GetStackCount()
end

function modifier_siege_plusarmor:OnTooltip()
	return self.armor * self:GetStackCount()
end