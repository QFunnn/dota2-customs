--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


generic_gold_item_drop = class({})

function generic_gold_item_drop:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability_name = self:GetAbilityName()
	local number_part = string.match(ability_name, "%d+")

	if number_part then
		local total_gold = tonumber(number_part)
		local pct = self:GetSpecialValueFor("gold_value")
		local drop_value = total_gold * 0.1

		drop_value = math.floor(drop_value + 0.5)

		if drop_value > 0 then
			for i = 1, 10 do
				self:SpawnGoldBag(caster:GetAbsOrigin(), drop_value)
			end
		end
	end
	UTIL_Remove(self)
end

function generic_gold_item_drop:SpawnGoldBag(position, value)
	local item = CreateItem("item_bag_of_gold", nil, nil)
	item:SetPurchaseTime(0)
	item:SetCurrentCharges(value)
	local container = CreateItemOnPositionSync(position, item)
	local rand_vector = RandomVector(RandomFloat(100, 200))
	item:LaunchLoot(true, 250, 0.75, position + rand_vector, nil)
end

item_gold_1000 = class(generic_gold_item_drop)
item_gold_1500 = class(generic_gold_item_drop)
item_gold_2000 = class(generic_gold_item_drop)
item_gold_2500 = class(generic_gold_item_drop)
item_gold_3000 = class(generic_gold_item_drop)
item_gold_3500 = class(generic_gold_item_drop)