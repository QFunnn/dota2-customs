--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

magical_damage = class(base_game_perk)

function magical_damage:__OnCreated()
	if IsClient() then
		return
	end

	if not self.dummy_item then
		self.dummy_item = CreateItem("item_magical_damage_perk_dummy", self.parent, self.parent)
	end
end

function magical_damage:OnDestroy()
	if IsClient() then
		return
	end

	if not IsValidEntity(self.dummy_item) then
		return
	end

	UTIL_Remove(self.dummy_item)
end

function magical_damage:DeclareFunctions()
	if self:GetParent():IsIllusion() then
		return
	end
	return { MODIFIER_PROPERTY_PROCATTACK_FEEDBACK }
end

function magical_damage:GetModifierProcAttack_Feedback(params)
	if IsValidEntity(params.target) then
		if params.target:IsBuilding() then
			return
		end

		local damage = ApplyDamage({
			victim = params.target,
			attacker = self.parent,
			ability = self.dummy_item,
			damage = self:CalculateValueByLevel(self.flat, self.level_step, self.per_level),
			damage_type = DAMAGE_TYPE_MAGICAL,
		})

		SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, params.target, damage, nil)
	end
end