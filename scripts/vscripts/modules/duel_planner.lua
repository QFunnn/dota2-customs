--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


-- Дуэльный планировщик v4 (A63(2)): порт JS-эталона planner_final.js + pick-логики gen_demo_v4.js.
-- ЧИСТАЯ логика без Dota-API — файл гоняется в парном тесте против эталона (fengari).
-- Спецификация: Obsidian vault → Projects/ancient-arena-mod/Notes/Duel Matchmaking.md
--   Правила: уникальность пар в переборе железная; при 5+ живых дуэли подряд запрещены;
--   серия 3 подряд запрещена при 3+ живых; коридор ритма (8 живых: 3-5) с пропорциональным
--   штрафом; молодые пары не открывают новый перебор (первые 3 позиции, жёстко при 5+,
--   двухпроходно); при 2 живых правила отключены (LAST_DUEL). Вставка-передышка — только
--   когда иначе нарушился бы запрет.
-- ВАЖНО: любое изменение семантики здесь обязано пройти парный тест с эталоном.

DuelPlanner = DuelPlanner or {}

local HUGE_NEG = -1000000
local BUDGET = 3000 -- узлов DFS; чистовой 2-й проход = x3 (бюджеты сверены с эталоном)

local function pairKey(a, b)
	if a < b then
		return a .. "|" .. b
	end
	return b .. "|" .. a
end

local function overlapPair(p, q)
	if not q then
		return false
	end
	return p[1] == q[1] or p[1] == q[2] or p[2] == q[1] or p[2] == q[2]
end

-- Упорядочить ВСЕ pairsIn (невстреченные пары) начиная с глобальной позиции startSeq.
function DuelPlanner.PlanOrder(pairsIn, alive, startSeq, lastFightIn, lastPair, pairLastIn, rng, streaksIn)
	local nP = #pairsIn
	if nP == 0 then
		return {}
	end
	local n = #alive
	if n <= 2 then -- добивка/лобби-на-двоих: правила не действуют
		local out = {}
		for i = 1, nP do
			out[i] = pairsIn[i]
		end
		return out
	end
	local lo = math.max(2, math.floor(n / 2) - 1)
	local hi = math.ceil(n / 2) + 1
	local best, bestCost, nodes = nil, math.huge, 0
	local seamHard = true
	local budgetCur = BUDGET
	local lastFight = {}
	for k, v in pairs(lastFightIn or {}) do
		lastFight[k] = v
	end
	local streak0 = {}
	for k, v in pairs(streaksIn or {}) do
		streak0[k] = v
	end

	local function hasStreak2(p, streaks)
		return (streaks[p[1]] or 0) >= 2 or (streaks[p[2]] or 0) >= 2
	end

	local seq, used = {}, {}

	local function dfs(prev, cost, streaks)
		if cost >= bestCost then
			return
		end
		local nb = nodes
		nodes = nodes + 1
		if nb > budgetCur then
			return
		end
		local depth = #seq
		if depth == nP then
			bestCost = cost
			best = {}
			for i = 1, nP do
				best[i] = seq[i]
			end
			return
		end
		local d = startSeq + depth

		local function isYoung(i)
			if depth >= 3 or not pairLastIn then
				return false
			end
			local age = d - (pairLastIn[pairKey(pairsIn[i][1], pairsIn[i][2])] or HUGE_NEG)
			return age < n
		end

		local allowConflict, allowYoung = false, false
		do
			local anyFree, anyStrict, anyLeft = false, false, false
			for i = 1, nP do
				if not used[i] then
					anyLeft = true
					local p = pairsIn[i]
					local ok = not (n >= 5 and overlapPair(p, prev)) and not hasStreak2(p, streaks)
					if ok then
						anyFree = true
						if not seamHard or not isYoung(i) then
							anyStrict = true
							break
						end
					end
				end
			end
			if not anyFree and anyLeft then
				allowConflict = true
			end
			if anyFree and not anyStrict then
				allowYoung = true
			end
		end

		local cands = {}
		for i = 1, nP do
			if not used[i] then
				local p = pairsIn[i]
				local skip = false
				if n >= 5 and overlapPair(p, prev) and not allowConflict then
					skip = true
				end
				if not skip and hasStreak2(p, streaks) and not allowConflict then
					skip = true
				end
				if not skip and seamHard and n >= 5 and isYoung(i) and not allowYoung and not allowConflict then
					skip = true
				end
				if not skip then
					local c0 = 0
					if n >= 5 and overlapPair(p, prev) then
						c0 = c0 + 100
					end
					if hasStreak2(p, streaks) then
						c0 = c0 + 500
					end
					if n < 5 and overlapPair(p, prev) then
						c0 = c0 + 10
					end
					local ga = lastFight[p[1]] == nil and 999 or (d - lastFight[p[1]])
					local gb = lastFight[p[2]] == nil and 999 or (d - lastFight[p[2]])
					local c = c0
					if ga < lo then
						c = c + (lo - ga)
					end
					if gb < lo then
						c = c + (lo - gb)
					end
					if ga ~= 999 and ga > hi then
						c = c + (ga - hi)
					end
					if gb ~= 999 and gb > hi then
						c = c + (gb - hi)
					end
					if isYoung(i) then
						c = c + 3
					end
					local gsa = ga == 999 and hi or ga
					local gsb = gb == 999 and hi or gb
					cands[#cands + 1] = { i = i, p = p, c = c, r = rng(), gsum = gsa + gsb }
				end
			end
		end
		table.sort(cands, function(x, y)
			if x.c ~= y.c then
				return x.c < y.c
			end
			if x.gsum ~= y.gsum then
				return x.gsum > y.gsum
			end
			return x.r < y.r
		end)
		for ci = 1, #cands do
			local cd = cands[ci]
			used[cd.i] = true
			seq[#seq + 1] = cd.p
			local pa, pb = lastFight[cd.p[1]], lastFight[cd.p[2]]
			lastFight[cd.p[1]] = d
			lastFight[cd.p[2]] = d
			local ns = {}
			for ai = 1, n do
				local t = alive[ai]
				if t == cd.p[1] or t == cd.p[2] then
					ns[t] = (streaks[t] or 0) + 1
				else
					ns[t] = 0
				end
			end
			dfs(cd.p, cost + cd.c, ns)
			lastFight[cd.p[1]] = pa
			lastFight[cd.p[2]] = pb
			seq[#seq] = nil
			used[cd.i] = false
			if best and bestCost == 0 then
				return
			end
		end
	end

	dfs(lastPair, 0, streak0)
	-- 2-й проход: жёсткий шов сделал идеал недостижимым -> чистовой поиск без него
	if bestCost > 0 then
		local b1, c1 = best, bestCost
		best, bestCost, nodes = nil, math.huge, 0
		seamHard = false
		budgetCur = BUDGET * 3
		seq, used = {}, {}
		dfs(lastPair, 0, streak0)
		if best == nil or c1 < bestCost then
			best, bestCost = b1, c1
		end
	end
	if best then
		return best
	end
	local out = {}
	for i = 1, nP do
		out[i] = pairsIn[i]
	end
	return out
end

function DuelPlanner.NewState()
	return {
		seq = 0,
		count = {},
		lastFight = {},
		pairLast = {},
		streaks = {},
		met = {},
		metList = {},
		queue = {},
		roster = "",
	}
end

local function buildAllPairs(alive)
	local out = {}
	for i = 1, #alive do
		for j = i + 1, #alive do
			out[#out + 1] = { alive[i], alive[j] }
		end
	end
	return out
end

local function aliveHas(alive, t)
	for i = 1, #alive do
		if alive[i] == t then
			return true
		end
	end
	return false
end

-- Выбор пары на дуэль. aliveIn — список живых team ID (порядок любой — сортируется).
-- rng() -> [0,1). Возвращает pair {a,b}, isSpacer. Состояние коммитится здесь же
-- (по модели владельца ливер на выбранной дуэли = победа сопернику, дуэль засчитана).
function DuelPlanner.PickPair(st, aliveIn, rng)
	local alive = {}
	for i = 1, #aliveIn do
		alive[i] = aliveIn[i]
	end
	table.sort(alive)
	local n = #alive
	if n < 2 then
		return nil
	end

	local st_last = st.lastPair

	-- фикс №2: добивка — единственная пара, правила отключены, планировщик не нужен
	if n == 2 then
		local p = { alive[1], alive[2] }
		st.queue = {}
		DuelPlanner._Commit(st, p, alive)
		return p, false
	end

	-- фикс №6: ленивое сверение — очередь фильтруется по фактическим живым
	local rosterKey = table.concat(alive, ",")
	local filtered = {}
	for i = 1, #st.queue do
		local q = st.queue[i]
		if aliveHas(alive, q[1]) and aliveHas(alive, q[2]) then
			filtered[#filtered + 1] = q
		end
	end
	st.queue = filtered
	if rosterKey ~= st.roster and #st.queue > 0 then
		-- состав сменился: перепланировать остаток невстреченных
		st.queue = DuelPlanner.PlanOrder(st.queue, alive, st.seq, st.lastFight, st_last, st.pairLast, rng, st.streaks)
	end
	st.roster = rosterKey

	if #st.queue == 0 then
		st.met = {}
		st.metList = {}
		st.queue = DuelPlanner.PlanOrder(
			buildAllPairs(alive),
			alive,
			st.seq,
			st.lastFight,
			st_last,
			st.pairLast,
			rng,
			st.streaks
		)
	end

	local p = st.queue[1]
	local spacer = false
	local function streak3(pp)
		return (st.streaks[pp[1]] or 0) >= 2 or (st.streaks[pp[2]] or 0) >= 2
	end
	local function badHead(pp)
		return st_last and ((overlapPair(pp, st_last) and n >= 5) or streak3(pp))
	end

	if badHead(p) then
		-- сперва пробуем перепланировать остаток
		local replanned =
			DuelPlanner.PlanOrder(st.queue, alive, st.seq, st.lastFight, st_last, st.pairLast, rng, st.streaks)
		if #replanned > 0 and not badHead(replanned[1]) then
			st.queue = replanned
			p = st.queue[1]
		end
	end
	if badHead(p) then
		-- вставка-передышка: сыгранная пара без нарушений; предпочесть самую давнюю
		local cands = {}
		for i = 1, #st.metList do
			local q = st.metList[i]
			if aliveHas(alive, q[1]) and aliveHas(alive, q[2]) and not streak3(q) then
				if n < 5 or (not overlapPair(q, st_last) and not overlapPair(q, p)) then
					cands[#cands + 1] = q
				end
			end
		end
		local function ageOf(q)
			return st.seq - (st.pairLast[pairKey(q[1], q[2])] or HUGE_NEG)
		end
		local aged = {}
		for i = 1, #cands do
			if ageOf(cands[i]) >= n then
				aged[#aged + 1] = cands[i]
			end
		end
		if #aged > 0 then
			cands = aged
		end
		if #cands > 0 then
			table.sort(cands, function(x, y)
				local ax, ay = ageOf(x), ageOf(y)
				if ax ~= ay then
					return ax > ay
				end
				local cx = (st.count[x[1]] or 0) + (st.count[x[2]] or 0)
				local cy = (st.count[y[1]] or 0) + (st.count[y[2]] or 0)
				if cx ~= cy then
					return cx < cy
				end
				return pairKey(x[1], x[2]) < pairKey(y[1], y[2])
			end)
			p = cands[1]
			spacer = true
		end
	end
	if not spacer then
		table.remove(st.queue, 1)
	end

	DuelPlanner._Commit(st, p, alive)
	return p, spacer
end

function DuelPlanner._Commit(st, p, alive)
	st.seq = st.seq + 1
	local k = pairKey(p[1], p[2])
	if not st.met[k] then
		st.met[k] = true
		st.metList[#st.metList + 1] = { p[1], p[2] }
	end
	st.count[p[1]] = (st.count[p[1]] or 0) + 1
	st.count[p[2]] = (st.count[p[2]] or 0) + 1
	st.lastFight[p[1]] = st.seq
	st.lastFight[p[2]] = st.seq
	st.pairLast[k] = st.seq
	for i = 1, #alive do
		local t = alive[i]
		if t == p[1] or t == p[2] then
			st.streaks[t] = (st.streaks[t] or 0) + 1
		else
			st.streaks[t] = 0
		end
	end
	st.lastPair = { p[1], p[2] }
end