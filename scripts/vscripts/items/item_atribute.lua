--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_atribute", "items/item_atribute", LUA_MODIFIER_MOTION_NONE)

ListenToGameEvent("npc_spawned", function(data)
	local unit = EntIndexToHScript(data.entindex)

	if not unit then
		return
	end
	if not unit.IsBaseNPC or not unit:IsBaseNPC() then
		return
	end
	if not unit:IsRealHero() then
		return
	end

	Timers:CreateTimer(0.05, function()
		local primaryAttribute = unit:GetPrimaryAttribute()
		local tempAttribute = primaryAttribute == DOTA_ATTRIBUTE_STRENGTH and DOTA_ATTRIBUTE_AGILITY
			or DOTA_ATTRIBUTE_STRENGTH

		unit:SetPrimaryAttribute(tempAttribute)

		Timers:CreateTimer(0.05, function()
			unit:SetPrimaryAttribute(primaryAttribute)
			unit:CalculateStatBonus(true)
		end)
	end)
end, nil)

item_str_atribute = class({})
item_agi_atribute = class({})
item_int_atribute = class({})

function item_str_atribute:OnSpellStart()
	item_atribute.OnSpellStart(self)
end

function item_agi_atribute:OnSpellStart()
	item_atribute.OnSpellStart(self)
end

function item_int_atribute:OnSpellStart()
	item_atribute.OnSpellStart(self)
end

if item_atribute == nil then
	item_atribute = {}
end

function item_atribute.OnSpellStart(self)
	if IsServer() then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_atribute", { item = self:GetName() })
		self:GetCaster():EmitSound("Item.TomeOfKnowledge")
		self:SpendCharge(0)
		local new_charges = self:GetCurrentCharges()
		if new_charges <= 0 then
			UTIL_Remove(self)
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
modifier_item_atribute = class({})

function modifier_item_atribute:IsHidden()
	return true
end

function modifier_item_atribute:RemoveOnDeath()
	return false
end

function modifier_item_atribute:IsPurgable()
	return false
end

function modifier_item_atribute:OnCreated(kv)
	self.item = kv.item
	self.str = 0
	self.agi = 0
	self.int = 0
	if self.item == "item_str_atribute" then
		self.str = 1
		self:GetParent():SetPrimaryAttribute(0)
	end
	if self.item == "item_agi_atribute" then
		self.agi = 1
		self:GetParent():SetPrimaryAttribute(1)
	end
	if self.item == "item_int_atribute" then
		self.int = 1
		self:GetParent():SetPrimaryAttribute(2)
	end
	if not IsServer() then
		return
	end
	self:GetParent():CalculateStatBonus(true)
end

function modifier_item_atribute:OnRefresh(kv)
	self.item = kv.item
	self.str = 0
	self.agi = 0
	self.int = 0
	if self.item == "item_str_atribute" then
		self.str = 1
		self:GetParent():SetPrimaryAttribute(0)
	end
	if self.item == "item_agi_atribute" then
		self.agi = 1
		self:GetParent():SetPrimaryAttribute(1)
	end
	if self.item == "item_int_atribute" then
		self.int = 1
		self:GetParent():SetPrimaryAttribute(2)
	end
	if not IsServer() then
		return
	end
	self:GetParent():CalculateStatBonus(true)
end

function modifier_item_atribute:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

function modifier_item_atribute:GetModifierBonusStats_Strength()
	return self.str * self:GetParent():GetLevel()
end

function modifier_item_atribute:GetModifierBonusStats_Agility()
	return self.agi * self:GetParent():GetLevel()
end

function modifier_item_atribute:GetModifierBonusStats_Intellect()
	return self.int * self:GetParent():GetLevel()
end