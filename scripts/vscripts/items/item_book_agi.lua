--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_book_agi", "items/item_book_agi", LUA_MODIFIER_MOTION_NONE)

item_book_agi = class({})

function item_book_agi:Spawn()
    if not IsServer() then return end
    self:UseBook()
end

function item_book_agi:UseBook()
	if not IsServer() then return end
	local caster = self:GetCaster()
	Timers:CreateTimer(FrameTime(),function()
        if not caster then
            caster = self:GetCaster()
            return 0.1
        end
        if self:IsNull() then return end
		caster:AddNewModifierDelay(caster, nil, "modifier_item_book_agi", {})
		caster:EmitSound("Item.TomeOfKnowledge")
		UTIL_Remove( self )
		if caster.attribute_book == nil then 
			caster.attribute_book = 1
		else
			caster.attribute_book = caster.attribute_book + 1
		end
	end)
end

modifier_item_book_agi = class({})

function modifier_item_book_agi:IsPurgable()
    return false
end

function modifier_item_book_agi:RemoveOnDeath()
    return false
end

function modifier_item_book_agi:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_item_book_agi:OnRefresh()
	if not IsServer() then return end
	self:IncrementStackCount()
	self:GetParent():CalculateStatBonus(true)
end

function modifier_item_book_agi:GetTexture()
  	return "items/book_agi"
end

function modifier_item_book_agi:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    }
    return funcs
end

function modifier_item_book_agi:GetModifierBonusStats_Agility()
    return self:GetStackCount() * 3
end