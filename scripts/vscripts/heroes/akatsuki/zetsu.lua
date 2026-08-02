--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


_G.zetsu_illusions_table = _G.zetsu_illusions_table or {}

LinkLuaModifier("modifier_zetsu_root_assimilation", "heroes/akatsuki/zetsu", LUA_MODIFIER_MOTION_NONE)

zetsu_root_assimilation = class({})

function zetsu_root_assimilation:GetIntrinsicModifierName()
	return "modifier_zetsu_root_assimilation"
end

---------------------------------------------------------------------------

modifier_zetsu_root_assimilation = class({})

function modifier_zetsu_root_assimilation:IsHidden()
	return true
end
function modifier_zetsu_root_assimilation:IsPurgable()
	return false
end
function modifier_zetsu_root_assimilation:IsPermanent()
	return true
end

function modifier_zetsu_root_assimilation:OnCreated()
	if not IsServer() then
		return
	end
	self:_RefreshValues()
	local parent = self:GetParent()
	if parent:IsRealHero() then
		_G.zetsu_illusions_table[parent:entindex()] = {}
		self:StartIntervalThink(1.0)
	end
end

function modifier_zetsu_root_assimilation:OnRefresh()
	if not IsServer() then
		return
	end
	self:_RefreshValues()
end

function modifier_zetsu_root_assimilation:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local new_level = math.min(math.floor((self:GetParent():GetLevel() - 1) / 6) + 1, ability:GetMaxLevel())
	if ability:GetLevel() ~= new_level then
		ability:SetLevel(new_level)
		self:_RefreshValues()
	end
end

function modifier_zetsu_root_assimilation:_RefreshValues()
	local ab = self:GetAbility()
	self._proc_chance = ab:GetSpecialValueFor("proc_chance_pct")
	self._ill_proc_chance = ab:GetSpecialValueFor("illusion_proc_chance_pct")
	self._max_illusions = ab:GetSpecialValueFor("max_illusions")
	self._duration = ab:GetSpecialValueFor("illusion_duration")
	self._dmg_out = ab:GetSpecialValueFor("illusion_damage_out_pct")
	self._dmg_in = ab:GetSpecialValueFor("illusion_damage_in_pct")
end

function modifier_zetsu_root_assimilation:_GetOwner()
	local parent = self:GetParent()
	if parent:IsRealHero() then
		return parent
	end
	local owner = parent:GetOwner()
	if owner then
		return owner:GetAssignedHero()
	end
	return nil
end

function modifier_zetsu_root_assimilation:_GetIllTable()
	local owner = self:_GetOwner()
	if not owner then
		return nil
	end
	local idx = owner:entindex()
	_G.zetsu_illusions_table[idx] = _G.zetsu_illusions_table[idx] or {}
	return _G.zetsu_illusions_table[idx]
end

function modifier_zetsu_root_assimilation:_CleanTable(tbl)
	for i = #tbl, 1, -1 do
		local ent = EntIndexToHScript(tbl[i])
		if not ent or ent:IsNull() or not ent:IsAlive() then
			table.remove(tbl, i)
		end
	end
end

function modifier_zetsu_root_assimilation:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_zetsu_root_assimilation:OnAttackLanded(data)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if data.attacker ~= parent then
		return
	end
	local target = data.target
	if not target or target:IsNull() or not target:IsAlive() then
		return
	end

	local chance = parent:IsRealHero() and self._proc_chance or self._ill_proc_chance
	if not RollPercentage(chance) then
		return
	end

	local tbl = self:_GetIllTable()
	if not tbl then
		return
	end
	self:_CleanTable(tbl)
	if #tbl >= self._max_illusions then
		return
	end

	local owner = self:_GetOwner()
	if not owner then
		return
	end

	local illusions = CreateIllusions(owner, parent, {
		outgoing_damage = 0,
		incoming_damage = self._dmg_in,
		duration = self._duration,
	}, 1, 72, false, true)

	local avg_dmg = owner:GetAverageTrueAttackDamage(nil) / 100 * self._dmg_out
	local agi = owner:GetAgility()

	local skin_mod = owner:FindModifierByName("modifier_skin_model_override")

	for _, ill in pairs(illusions) do
		ill:SetBaseDamageMin(avg_dmg - agi)
		ill:SetBaseDamageMax(avg_dmg - agi)
		if skin_mod then
			ill:AddNewModifier(
				owner,
				nil,
				"modifier_skin_model_override",
				{ model = skin_mod._model, scale = skin_mod._scale }
			)
		end
		ill:SetAggroTarget(target)
		table.insert(tbl, ill:entindex())

		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phantom_lancer/phantom_lancer_spawn_illusion.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			ill
		)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end

function modifier_zetsu_root_assimilation:OnDeath(data)
	if not IsServer() then
		return
	end
	local tbl = self:_GetIllTable()
	if not tbl then
		return
	end
	local dead_idx = data.unit:entindex()
	for i = #tbl, 1, -1 do
		if tbl[i] == dead_idx then
			table.remove(tbl, i)
		end
	end
end