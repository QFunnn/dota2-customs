--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_enigma_demonic_conversion_custom_creep", "abilities/enigma_demonic_conversion_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_eidolon_overseer", "abilities/enigma_demonic_conversion_custom", LUA_MODIFIER_MOTION_NONE)

enigma_demonic_conversion_custom = class({})

function enigma_demonic_conversion_custom:CastFilterResultTarget( target )
	-- Разрешаем применение на себя (кастера)
	if target == self:GetCaster() then
		return UF_SUCCESS
	end
	
	-- Проверяем, что это крип
	if not target:IsCreep() then
		return UF_FAIL_CUSTOM
	end
	
	-- Исключения для особых крипов (Roshan, Nian)
	local targetName = target:GetUnitName()
	if targetName == "npc_dota_roshan" or targetName == "npc_dota_nian" then
		return UF_FAIL_CUSTOM
	end
	
	-- Проверка на отправленных крипов других игроков
	if target:HasModifier("modifier_skill_call_of_the_ancient_buff") then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end

function enigma_demonic_conversion_custom:GetCustomCastErrorTarget(target)
	-- Разрешаем применение на себя (кастера)
	if target == self:GetCaster() then
		return ""
	end
	
	-- Исключения для особых крипов (Roshan, Nyan и т.д.)
	local targetName = target:GetUnitName()
	if targetName == "npc_dota_roshan" or targetName == "npc_dota_nian" then
		return "Нельзя использовать на особых крипов"
	end
	
	-- Проверка на отправленных крипов других игроков
	if target:HasModifier("modifier_skill_call_of_the_ancient_buff") then
		return "Нельзя использовать на крипов других игроков"
	end
	
	-- Простая проверка: если крип принадлежит другому игроку, показываем ошибку
	if target:GetPlayerOwnerID() and target:GetPlayerOwnerID() ~= -1 and target:GetPlayerOwnerID() ~= self:GetCaster():GetPlayerOwnerID() then
		return "Нельзя использовать на крипов других игроков"
	end
	
	return ""
end

function enigma_demonic_conversion_custom:OnSpellStart()
	if not IsServer() then return end
	local ability = self
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local location = target:GetAbsOrigin()

	EmitSoundOn("Hero_Enigma.Demonic_Conversion",target)

	-- Не убиваем героя, даже если это сам кастер
	if not target:IsHero() or target == caster then
		-- Если цель - сам кастер, не убиваем его, но используем его позицию
		if target ~= caster then
			target:Kill(ability, caster)
			target = nil
		end
	end

	local eidolon_count = ability:GetSpecialValueFor("spawn_count")
	if eidolon_count > 0 then
		for i=1, eidolon_count do
			ability:CreateEidolon(target, location)
		end
	end
end

function enigma_demonic_conversion_custom:CreateEidolon(hParent, vLocation)
	local typs = 
	{
		[1] = "npc_dota_lesser_eidolon",
		[2] = "npc_dota_eidolon",
		[3] = "npc_dota_greater_eidolon",
		[4] = "npc_dota_dire_eidolon",
	}

	local nLevel = self:GetLevel()
	local sType = typs[nLevel]

	local eidolon = CreateUnitByName(sType, vLocation, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
	eidolon:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = 40})
	eidolon:SetOwner(self:GetCaster())
	eidolon:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
	FindClearSpaceForUnit(eidolon, vLocation, true)
	eidolon:AddNewModifier(self:GetCaster(), self, "modifier_demonic_conversion", {duration = 40, allowsplit = 6})

	-- [#1] ЕДИНАЯ система статов. modifier_enigma_demonic_conversion_custom_creep читает
	-- те же ванильные ключи (eidelon_base_damage/eidelon_max_health/eidelon_base_movespeed/
	-- eidolon_bonus_damage), что и C++ → значения совпадают. Вешаем его сразу оригиналам,
	-- а overseer на кастере догоняет раздвоенных (их создаёт C++, минуя этот код).
	if not self:GetCaster():HasModifier("modifier_enigma_eidolon_overseer") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_enigma_eidolon_overseer", {})
	end
	eidolon:AddNewModifier(self:GetCaster(), self, "modifier_enigma_demonic_conversion_custom_creep", {})

	return eidolon
end

modifier_enigma_demonic_conversion_custom_creep = class({})

function modifier_enigma_demonic_conversion_custom_creep:IsHidden() return true end
function modifier_enigma_demonic_conversion_custom_creep:IsPurgable() return false end
function modifier_enigma_demonic_conversion_custom_creep:IsPurgeException() return false end

function modifier_enigma_demonic_conversion_custom_creep:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_enigma_demonic_conversion_custom_creep:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability or self.ability:IsNull() then return end
	-- Читаем ТЕ ЖЕ ключи, что и ванильный C++ modifier_demonic_conversion → значения,
	-- которыми C++ статует раздвоенных, совпадают с тем, что ставим оригиналам.
	self.AttackSpeedBonus = self.ability:GetSpecialValueFor("eidolon_bonus_attack_speed")
	if not IsServer() then return end
	self.parent = self:GetParent()
	self.dmg = self.ability:GetSpecialValueFor("eidelon_base_damage") + self.ability:GetSpecialValueFor("eidolon_bonus_damage")
	self.hp = self.ability:GetSpecialValueFor("eidelon_max_health")
	self.ms = self.ability:GetSpecialValueFor("eidelon_base_movespeed")
	self:ApplyStats(true)
	self:StartIntervalThink(0.5)
end

function modifier_enigma_demonic_conversion_custom_creep:ApplyStats(bSetHealth)
	self.parent:SetBaseDamageMin(self.dmg)
	self.parent:SetBaseDamageMax(self.dmg)
	self.parent:SetBaseMoveSpeed(self.ms)
	-- МАКС hp держим всегда на нашем значении (иначе двойники от C++ имеют 198 вместо 180).
	self.parent:SetBaseMaxHealth(self.hp)
	self.parent:SetMaxHealth(self.hp)
	-- Текущее hp выставляем только при создании, чтобы не «лечить» каждый тик.
	if bSetHealth then
		self.parent:SetHealth(self.hp)
	end
end

function modifier_enigma_demonic_conversion_custom_creep:OnIntervalThink()
	if not IsServer() then return end
	if not self.parent or self.parent:IsNull() or not self.parent:IsAlive() then return end
	-- Держим урон/скорость/макс-HP на наших значениях (на случай если C++ их перезапишет).
	self:ApplyStats(false)
end

function modifier_enigma_demonic_conversion_custom_creep:GetModifierAttackSpeedBonus_Constant()
	return self.AttackSpeedBonus or 0
end

----------------------------------------------------------------------------------------
-- [#1] Overseer: висит на кастере (Энигме), раз в 0.2с находит ВСЕХ его эйдолонов
-- (включая раздвоенных, которых создаёт C++) и вешает им стат-модификатор. Так
-- оригиналы и сплиты гарантированно получают одинаковые статы из одного источника.
----------------------------------------------------------------------------------------
modifier_enigma_eidolon_overseer = class({})

function modifier_enigma_eidolon_overseer:IsHidden() return true end
function modifier_enigma_eidolon_overseer:IsPurgable() return false end
function modifier_enigma_eidolon_overseer:RemoveOnDeath() return false end

function modifier_enigma_eidolon_overseer:OnCreated()
	if not IsServer() then return end
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.pid = self.caster:GetPlayerOwnerID()
	self:StartIntervalThink(0.2)
end

function modifier_enigma_eidolon_overseer:BelongsToMe(u)
	if u:GetPlayerOwnerID() == self.pid then return true end
	-- Двойники, созданные C++, могут иметь владельцем родительского эйдолона, а не игрока —
	-- идём по цепочке владельцев до кастера.
	local o = u.GetOwner and u:GetOwner() or nil
	local guard = 0
	while o and not o:IsNull() and guard < 8 do
		if o == self.caster then return true end
		o = o.GetOwner and o:GetOwner() or nil
		guard = guard + 1
	end
	return false
end

function modifier_enigma_eidolon_overseer:OnIntervalThink()
	if not IsServer() then return end
	local units = FindUnitsInRadius(self.caster:GetTeamNumber(), self.caster:GetAbsOrigin(), nil, 30000,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	for _, u in ipairs(units) do
		if u and not u:IsNull() and string.find(u:GetUnitName() or "", "eidolon") then
			local idx = u:entindex()
			local mine = self:BelongsToMe(u)
			local hasCreep = u:HasModifier("modifier_enigma_demonic_conversion_custom_creep")
			if mine and not hasCreep then
				u:AddNewModifier(self.caster, self.ability, "modifier_enigma_demonic_conversion_custom_creep", {})
			end
		end
	end
end