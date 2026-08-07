--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


POPUP_SYMBOL_PRE_PLUS = 0
POPUP_SYMBOL_PRE_MINUS = 1
POPUP_SYMBOL_PRE_SADFACE = 2
POPUP_SYMBOL_PRE_BROKENARROW = 3
POPUP_SYMBOL_PRE_SHADES = 4
POPUP_SYMBOL_PRE_MISS = 5
POPUP_SYMBOL_PRE_EVADE = 6
POPUP_SYMBOL_PRE_DENY = 7
POPUP_SYMBOL_PRE_ARROW = 8

POPUP_SYMBOL_POST_EXCLAMATION = 0
POPUP_SYMBOL_POST_POINTZERO = 1
POPUP_SYMBOL_POST_MEDAL = 2
POPUP_SYMBOL_POST_DROP = 3
POPUP_SYMBOL_POST_LIGHTNING = 4
POPUP_SYMBOL_POST_SKULL = 5
POPUP_SYMBOL_POST_EYE = 6
POPUP_SYMBOL_POST_SHIELD = 7
POPUP_SYMBOL_POST_POINTFIVE = 8
if _G.Popups == nil then
	_G.Popups = {}
end
function Popups.Healing(target, amount, player)
	PopupNumbers(
		target,
		"particles/msg_fx/msg_heal.vpcf",
		Vector(0, 255, 0),
		1.0,
		amount,
		POPUP_SYMBOL_PRE_PLUS,
		nil,
		player
	)
end

function Popups.Damage(target, amount, player)
	PopupNumbers(
		target,
		"particles/msg_fx/msg_damage.vpcf",
		Vector(255, 0, 0),
		1.0,
		amount,
		nil,
		POPUP_SYMBOL_POST_DROP,
		player
	)
end

function Popups.AddGold(target, amount, player)
	PopupNumbers(
		target,
		"particles/msg_fx/msg_crit.vpcf",
		Vector(255, 200, 33),
		1.0,
		amount,
		POPUP_SYMBOL_PRE_PLUS,
		nil,
		player
	)
end

function Popups.DamageBig(target, amount, player)
	PopupNumbers(
		target,
		"particles/ability/msg_crit.vpcf",
		Vector(255, 0, 0),
		2.0,
		amount,
		nil,
		POPUP_SYMBOL_POST_DROP,
		player
	)
end

function Popups.DamageColored(target, amount, color, player)
	PopupNumbers(target, "particles/msg_fx/msg_damage.vpcf", color, 1.0, amount, nil, POPUP_SYMBOL_POST_DROP, player)
end

function Popups.CriticalDamage(target, amount, player)
	PopupNumbers(
		target,
		"particles/msg_fx/msg_crit.vpcf",
		Vector(255, 0, 0),
		1.0,
		amount,
		nil,
		POPUP_SYMBOL_POST_LIGHTNING,
		player
	)
end

function Popups.CriticalDamageColored(target, amount, color, player)
	PopupNumbers(target, "particles/msg_fx/msg_crit.vpcf", color, 1.0, amount, nil, POPUP_SYMBOL_POST_LIGHTNING, player)
end

function Popups.DamageOverTime(target, amount, player)
	PopupNumbers(
		target,
		"particles/msg_fx/msg_poison.vpcf",
		Vector(215, 50, 248),
		1.0,
		amount,
		nil,
		POPUP_SYMBOL_POST_EYE,
		player
	)
end

function Popups.DamageBlock(target, amount, player)
	PopupNumbers(
		target,
		"particles/msg_fx/msg_block.vpcf",
		Vector(255, 255, 255),
		1.0,
		amount,
		POPUP_SYMBOL_PRE_MINUS,
		nil,
		player
	)
end

function Popups.GoldGain(target, amount, player)
	PopupNumbers(
		target,
		"particles/msg_fx/msg_gold.vpcf",
		Vector(255, 200, 33),
		1.0,
		amount,
		POPUP_SYMBOL_PRE_PLUS,
		nil,
		player
	)
end

function Popups.ManaGain(target, amount, player)
	PopupNumbers(
		target,
		"particles/msg_fx/msg_gold.vpcf",
		Vector(33, 200, 255),
		1.0,
		amount,
		POPUP_SYMBOL_PRE_PLUS,
		nil,
		player
	)
end

function Popups.Miss(target, player)
	PopupNumbers(
		target,
		"particles/msg_fx/msg_miss.vpcf",
		Vector(255, 0, 0),
		1.0,
		nil,
		POPUP_SYMBOL_PRE_MISS,
		nil,
		player
	)
end

function PopupNumbers(target, pfx, color, lifetime, number, presymbol, postsymbol, player)
	local pidx = nil
	if player then
		-- pidx = ParticleManager:CreateParticle(pfx, PATTACH_OVERHEAD_FOLLOW, target)
		pidx = ParticleManager:CreateParticleForPlayer(pfx, PATTACH_OVERHEAD_FOLLOW, target, player)
	else
		pidx = ParticleManager:CreateParticle(pfx, PATTACH_OVERHEAD_FOLLOW, target)
	end

	local digits = 0
	if number ~= nil then
		digits = #tostring(math.floor(number))
	end
	if presymbol ~= nil then
		digits = digits + 1
	end
	if postsymbol ~= nil then
		digits = digits + 1
	end

	ParticleManager:SetParticleControl(pidx, 1, Vector(tonumber(presymbol), tonumber(number), tonumber(postsymbol)))
	ParticleManager:SetParticleControl(pidx, 2, Vector(lifetime, digits, 0))
	ParticleManager:SetParticleControl(pidx, 3, color)

	ParticleManager:ReleaseParticleIndex(pidx)
end