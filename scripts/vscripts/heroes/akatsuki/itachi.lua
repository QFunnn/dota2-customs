--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


-- Itachi: вороны хаотично летают вокруг героя, атакуют ближайших врагов

LinkLuaModifier("modifier_itachi_crows", "heroes/akatsuki/itachi", LUA_MODIFIER_MOTION_NONE)

itachi_crow_guard = class({})

function itachi_crow_guard:GetIntrinsicModifierName()
	return "modifier_itachi_crows"
end

---------------------------------------------------------------------------

modifier_itachi_crows = class({})

local THINK_RATE = 0.05
local WANDER_MIN = 60
local ARRIVE_DIST = 80
local ATTACK_RANGE = 60
local MOVE_UPDATE = 0.15
local TELEPORT_DIST = 500

function modifier_itachi_crows:IsHidden()
	return true
end
function modifier_itachi_crows:IsPurgable()
	return false
end
function modifier_itachi_crows:IsPermanent()
	return true
end

function modifier_itachi_crows:OnCreated()
	if not IsServer() then
		return
	end
	local ab = self:GetAbility()
	self:_RefreshValues()
	self._crows = nil
	self._spawned = false
	self._last_caster_pos = nil
	self:StartIntervalThink(THINK_RATE)
end

function modifier_itachi_crows:OnRefresh()
	if not IsServer() then
		return
	end
	self:_RefreshValues()
	self:_DestroyCrows()
end

function modifier_itachi_crows:OnRemoved()
	if not IsServer() then
		return
	end
	self:_DestroyCrows()
end

function modifier_itachi_crows:_RefreshValues()
	local ab = self:GetAbility()
	self._wander_radius = ab and ab:GetSpecialValueFor("wander_radius") or 380
	self._attack_radius = ab and ab:GetSpecialValueFor("attack_radius") or 400
	self._damage_pct = ab and (ab:GetSpecialValueFor("attack_damage_pct") / 100) or 0.5
	self._speed_wander = ab and ab:GetSpecialValueFor("speed_wander") or 280
	self._speed_attack = ab and ab:GetSpecialValueFor("speed_attack") or 700
	self._attack_cd_base = ab and ab:GetSpecialValueFor("attack_cd_base") or 1.5
end

function modifier_itachi_crows:_GetCrowCount()
	return math.min(math.floor((self:GetParent():GetLevel() - 1) / 6) + 1, 5)
end

function modifier_itachi_crows:_RandomNearHero(center)
	local angle = math.random() * 2 * math.pi
	local dist = math.random(WANDER_MIN, self._wander_radius)
	return Vector(center.x + dist * math.cos(angle), center.y + dist * math.sin(angle), center.z)
end

function modifier_itachi_crows:_MoveTo(crow, pos)
	crow:MoveToPosition(pos)
end

function modifier_itachi_crows:_SpawnOneCrow()
	local caster = self:GetParent()
	local caster_pos = caster:GetAbsOrigin()
	local spawn_pos = self:_RandomNearHero(caster_pos)
	local crow = CreateUnitByName("npc_itachi_crow", spawn_pos, false, nil, nil, caster:GetTeamNumber())
	if crow and not crow:IsNull() then
		crow:SetOwner(caster)
		crow:AddNewModifier(crow, nil, "modifier_invulnerable", {})
		crow:SetBaseMoveSpeed(self._speed_wander)
		local first_target = self:_RandomNearHero(caster_pos)
		table.insert(self._crows, {
			unit = crow,
			state = "wander",
			target = nil,
			wander_pos = nil, -- think-цикл выдаст новый ордер на первом тике
			last_attack = -99,
			last_move = -99,
		})
		-- Первый ордер сразу — если юнит уже готов, летит немедленно
		-- Если нет — think-цикл подхватит через 0.05 сек
		self:_MoveTo(crow, first_target)
	end
end

function modifier_itachi_crows:_SpawnCrows()
	self._crows = {}
	local count = self:_GetCrowCount()
	for i = 1, count do
		self:_SpawnOneCrow()
	end
	self._spawned = true
end

function modifier_itachi_crows:_DestroyCrows()
	if self._crows then
		for _, cd in pairs(self._crows) do
			if cd.unit and not cd.unit:IsNull() then
				cd.unit:RemoveSelf()
			end
		end
	end
	self._crows = nil
	self._spawned = false
end

function modifier_itachi_crows:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not caster or caster:IsNull() then
		return
	end

	if not caster:IsAlive() then
		if self._spawned then
			self:_DestroyCrows()
		end
		return
	end

	-- авто-повышение уровня способности каждые 5 уровней героя
	local ab = self:GetAbility()
	local new_level = math.min(math.floor((caster:GetLevel() - 1) / 6) + 1, ab:GetMaxLevel())
	if ab:GetLevel() ~= new_level then
		ab:SetLevel(new_level)
		self:_RefreshValues()
	end

	if not self._spawned then
		self:_SpawnCrows()
	end

	-- Левел-ап: добавляем ворон если нужно
	local expected = self:_GetCrowCount()
	while #self._crows < expected do
		self:_SpawnOneCrow()
	end

	local now = GameRules:GetGameTime()
	local caster_pos = caster:GetAbsOrigin()
	local attack_cd = self._attack_cd_base

	-- Детекция блинка/TP: если герой прыгнул далеко — телепортируем ворон рядом с ним
	if self._last_caster_pos and (caster_pos - self._last_caster_pos):Length2D() > TELEPORT_DIST then
		for _, cd in ipairs(self._crows) do
			if cd.unit and not cd.unit:IsNull() then
				local angle = math.random() * 2 * math.pi
				local r = math.random(50, 150)
				local near =
					Vector(caster_pos.x + r * math.cos(angle), caster_pos.y + r * math.sin(angle), caster_pos.z)
				cd.unit:SetAbsOrigin(near)
				FindClearSpaceForUnit(cd.unit, near, true)
				cd.state = "wander"
				cd.target = nil
				cd.wander_pos = nil
				cd.unit:SetBaseMoveSpeed(self._speed_wander)
			end
		end
	end
	self._last_caster_pos = caster_pos

	for _, cd in ipairs(self._crows) do
		local crow = cd.unit
		if not crow or crow:IsNull() then
			goto continue
		end

		local crow_pos = crow:GetAbsOrigin()

		if cd.state == "wander" then
			local need_new = false

			if not cd.wander_pos then
				need_new = true
			elseif (crow_pos - cd.wander_pos):Length2D() < ARRIVE_DIST then
				need_new = true -- достигли точки, берём новую
			elseif (crow_pos - caster_pos):Length2D() > self._wander_radius + 80 then
				need_new = true -- улетел слишком далеко от героя
			end

			if need_new then
				cd.wander_pos = self:_RandomNearHero(caster_pos)
				self:_MoveTo(crow, cd.wander_pos)
				cd.last_move = now
			elseif (now - cd.last_move) >= 0.5 then
				-- Переиздаём ордер если ворона не двигалась (движок проигнорил первый раз)
				self:_MoveTo(crow, cd.wander_pos)
				cd.last_move = now
			end

			-- Ищем врага если кулдаун прошёл
			if (now - cd.last_attack) >= attack_cd then
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					caster_pos,
					nil,
					self._attack_radius,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_CLOSEST,
					false
				)
				if #enemies > 0 then
					cd.target = enemies[1]
					cd.state = "attacking"
					cd.last_move = -99
					crow:SetBaseMoveSpeed(self._speed_attack)
					EmitSoundOn("Hero_Beastmaster.Hawk.Reveal", crow)
					self:_MoveTo(crow, enemies[1]:GetAbsOrigin())
				end
			end
		elseif cd.state == "attacking" then
			local tgt = cd.target
			if not tgt or tgt:IsNull() or not tgt:IsAlive() then
				cd.state = "wander"
				cd.target = nil
				cd.wander_pos = nil
				crow:SetBaseMoveSpeed(self._speed_wander)
			else
				local dist = (tgt:GetAbsOrigin() - crow_pos):Length2D()

				if dist <= ATTACK_RANGE then
					local dmg = caster:GetAverageTrueAttackDamage(caster) * self._damage_pct
					ApplyDamage({
						victim = tgt,
						attacker = caster,
						damage = dmg,
						damage_type = DAMAGE_TYPE_PHYSICAL,
						ability = self:GetAbility(),
					})
					cd.last_attack = now
					cd.state = "wander"
					cd.target = nil
					cd.wander_pos = nil
					crow:SetBaseMoveSpeed(self._speed_wander)
				elseif (now - cd.last_move) >= MOVE_UPDATE then
					self:_MoveTo(crow, tgt:GetAbsOrigin())
					cd.last_move = now
				end
			end
		end

		::continue::
	end
end