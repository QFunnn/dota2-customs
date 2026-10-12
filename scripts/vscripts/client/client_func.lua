--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- client/client_func.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__New = ____lualib.__TS__New
____debugRuntime.register(
	"client/client_func.lua",
	{
		["10"] = "2:7",
		["11"] = "6:7",
		["12"] = "8:15",
		["13"] = "9:9",
		["14"] = "9:47",
		["15"] = "9:52",
		["16"] = "9:55",
		["17"] = "9:9",
		["18"] = "9:93",
		["19"] = "9:110",
		["20"] = "9:130",
		["21"] = "9:9",
		["22"] = "10:9",
		["23"] = "7:37",
		["24"] = "14:7",
		["25"] = "24:5",
		["26"] = "25:9",
		["27"] = "26:9",
		["28"] = "27:9",
		["29"] = "28:9",
		["30"] = "29:9",
		["31"] = "24:37",
		["32"] = "31:5",
		["33"] = "32:9",
		["34"] = "33:9",
		["35"] = "34:9",
		["36"] = "35:9",
		["37"] = "36:9",
		["38"] = "31:37",
		["39"] = "38:5",
		["40"] = "39:9",
		["41"] = "40:9",
		["42"] = "41:9",
		["43"] = "42:9",
		["44"] = "43:9",
		["45"] = "38:38",
		["46"] = "45:5",
		["47"] = "46:9",
		["48"] = "47:9",
		["49"] = "48:9",
		["50"] = "49:9",
		["51"] = "50:9",
		["52"] = "45:37",
		["53"] = "52:5",
		["54"] = "53:9",
		["55"] = "54:9",
		["56"] = "55:9",
		["57"] = "56:9",
		["58"] = "57:9",
		["59"] = "52:36",
		["60"] = "59:5",
		["61"] = "60:9",
		["62"] = "61:9",
		["63"] = "62:9",
		["64"] = "63:9",
		["65"] = "64:9",
		["66"] = "59:36",
		["67"] = "66:5",
		["68"] = "67:9",
		["69"] = "68:9",
		["70"] = "69:9",
		["71"] = "70:9",
		["72"] = "71:9",
		["73"] = "66:37",
		["74"] = "73:5",
		["75"] = "74:9",
		["76"] = "75:9",
		["77"] = "76:9",
		["78"] = "77:9",
		["79"] = "78:9",
		["80"] = "73:38",
		["81"] = "80:5",
		["82"] = "81:9",
		["83"] = "82:9",
		["84"] = "83:9",
		["85"] = "84:9",
		["86"] = "85:9",
		["87"] = "80:43",
		["88"] = "87:5",
		["89"] = "88:9",
		["90"] = "89:9",
		["91"] = "90:9",
		["92"] = "91:9",
		["93"] = "92:9",
		["94"] = "87:51",
		["95"] = "94:5",
		["96"] = "95:9",
		["97"] = "96:9",
		["98"] = "97:9",
		["99"] = "98:9",
		["100"] = "99:9",
		["101"] = "94:52",
		["102"] = "102:5",
		["103"] = "103:9",
		["104"] = "104:9",
		["105"] = "105:9",
		["106"] = "106:9",
		["107"] = "107:9",
		["108"] = "102:42",
		["109"] = "109:5",
		["110"] = "110:9",
		["111"] = "111:9",
		["112"] = "112:9",
		["113"] = "113:9",
		["114"] = "114:9",
		["115"] = "109:42",
		["116"] = "116:5",
		["117"] = "117:9",
		["118"] = "118:9",
		["119"] = "119:9",
		["120"] = "120:9",
		["121"] = "121:9",
		["122"] = "116:42",
		["123"] = "123:5",
		["124"] = "124:9",
		["125"] = "125:9",
		["126"] = "126:9",
		["127"] = "127:9",
		["128"] = "128:9",
		["129"] = "123:41",
		["130"] = "130:5",
		["131"] = "131:9",
		["132"] = "132:9",
		["133"] = "133:9",
		["134"] = "134:9",
		["135"] = "135:9",
		["136"] = "130:41",
		["137"] = "137:5",
		["138"] = "138:9",
		["139"] = "139:9",
		["140"] = "140:9",
		["141"] = "141:9",
		["142"] = "142:9",
		["143"] = "137:43",
		["144"] = "144:5",
		["145"] = "145:9",
		["146"] = "146:9",
		["147"] = "147:9",
		["148"] = "148:9",
		["149"] = "149:9",
		["150"] = "144:43",
		["151"] = "151:5",
		["152"] = "152:9",
		["153"] = "153:9",
		["154"] = "154:9",
		["155"] = "155:9",
		["156"] = "156:9",
		["157"] = "151:41",
		["158"] = "158:5",
		["159"] = "159:9",
		["160"] = "160:9",
		["161"] = "161:9",
		["162"] = "162:9",
		["163"] = "163:9",
		["164"] = "158:44",
		["165"] = "23:5",
		["166"] = "167:1",
		["167"] = "167:14",
		["168"] = "167:1",
		["170"] = "172:5",
		["171"] = "169:9",
		["172"] = "169:27",
		["173"] = "169:49",
		["174"] = "169:88",
		["175"] = "169:9",
		["176"] = "168:5",
		["177"] = "177:5",
		["178"] = "178:14",
		["181"] = "180:13",
		["182"] = "181:13",
		["183"] = "184:13",
		["184"] = "185:17",
		["186"] = "186:22",
		["187"] = "186:29",
		["188"] = "187:21",
		["189"] = "188:21",
		["192"] = "186:46",
		["195"] = "192:17",
		["196"] = "193:17",
		["197"] = "194:17",
		["200"] = "198:13",
		["203"] = "201:14",
		["206"] = "203:15",
		["207"] = "204:9",
		["208"] = "205:13",
		["210"] = "177:5",
		["211"] = "209:5",
		["212"] = "210:15",
		["213"] = "211:15",
		["214"] = "212:15",
		["215"] = "214:15",
		["216"] = "215:13",
		["217"] = "216:13",
		["219"] = "209:5",
		["220"] = "220:5",
		["221"] = "221:15",
		["222"] = "222:15",
		["223"] = "223:15",
		["224"] = "225:15",
		["225"] = "226:14",
		["228"] = "228:15",
		["229"] = "229:13",
		["230"] = "230:13",
		["232"] = "220:5",
		["233"] = "234:5",
		["234"] = "236:15",
		["235"] = "237:15",
		["236"] = "238:15",
		["237"] = "241:15",
		["238"] = "242:15",
		["239"] = "249:15",
		["240"] = "250:14",
		["243"] = "252:17",
		["244"] = "252:24",
		["245"] = "252:38",
		["246"] = "252:50",
		["247"] = "252:61",
		["248"] = "255:15",
		["249"] = "258:9",
		["250"] = "258:44",
		["251"] = "258:52",
		["252"] = "258:55",
		["253"] = "258:9",
		["254"] = "262:13",
		["255"] = "263:13",
		["256"] = "263:31",
		["258"] = "264:13",
		["259"] = "264:32",
		["261"] = "266:15",
		["262"] = "267:9",
		["263"] = "267:44",
		["264"] = "267:52",
		["265"] = "267:55",
		["266"] = "267:9",
		["267"] = "270:9",
		["268"] = "272:9",
		["269"] = "234:5",
		["270"] = "276:1",
	}
)
local ____exports = {}
local PARTICLE_PATHS = { DAMAGE_CRIT = GENERIC_PARTICLES.popup_crit }
local EFFECT_HANDLERS = {
	[1] = function(____, ent)
		local pid = ParticleManager:CreateParticle(GENERIC_PARTICLES.heart_strike, PATTACH_POINT_FOLLOW, ent)
		ParticleManager:SetParticleControlEnt(
			pid,
			0,
			ent,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			ent:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(pid)
	end,
}
local NUMBER_TYPE_CONFIG = {
	[1] = {
		color = Vector(255, 215, 0),
		particlePath = PARTICLE_PATHS.DAMAGE_CRIT,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = 4,
		preSymbol = -1,
	},
	[2] = {
		color = Vector(POPUP_COLORS.SPELL_CRITICAL.r, POPUP_COLORS.SPELL_CRITICAL.g, POPUP_COLORS.SPELL_CRITICAL.b),
		particlePath = PARTICLE_PATHS.DAMAGE_CRIT,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = 4,
		preSymbol = -1,
	},
	[3] = {
		color = Vector(POPUP_COLORS.MANA.r, POPUP_COLORS.MANA.g, POPUP_COLORS.MANA.b),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = 0,
	},
	[4] = {
		color = Vector(POPUP_COLORS.GOLD.r, POPUP_COLORS.GOLD.g, POPUP_COLORS.GOLD.b),
		particlePath = GENERIC_PARTICLES.popup_gold,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 0,
	},
	[20] = {
		color = Vector(POPUP_COLORS.EXP.r, POPUP_COLORS.EXP.g, POPUP_COLORS.EXP.b),
		particlePath = GENERIC_PARTICLES.popup_gold,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 0,
	},
	[5] = {
		color = Vector(POPUP_COLORS.PHYSICAL_DAMAGE.r, POPUP_COLORS.PHYSICAL_DAMAGE.g, POPUP_COLORS.PHYSICAL_DAMAGE.b),
		particlePath = GENERIC_PARTICLES.popup_damage,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = -1,
	},
	[7] = {
		color = Vector(POPUP_COLORS.HEALING.r, POPUP_COLORS.HEALING.g, POPUP_COLORS.HEALING.b),
		particlePath = GENERIC_PARTICLES.popup_healing,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = 0,
	},
	[8] = {
		color = Vector(POPUP_COLORS.GOLD.r, POPUP_COLORS.GOLD.g, POPUP_COLORS.GOLD.b),
		particlePath = GENERIC_PARTICLES.popup_gold,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 1,
	},
	[9] = {
		color = Vector(POPUP_COLORS.MAGICAL_DAMAGE.r, POPUP_COLORS.MAGICAL_DAMAGE.g, POPUP_COLORS.MAGICAL_DAMAGE.b),
		particlePath = GENERIC_PARTICLES.popup_damage,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = -1,
	},
	[10] = {
		color = Vector(
			POPUP_COLORS.SPECIAL_PHYSICAL.r,
			POPUP_COLORS.SPECIAL_PHYSICAL.g,
			POPUP_COLORS.SPECIAL_PHYSICAL.b
		),
		particlePath = GENERIC_PARTICLES.popup_damage,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = 3,
	},
	[19] = {
		color = Vector(120, 0, 255),
		particlePath = GENERIC_PARTICLES.popup_damage,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = -1,
		preSymbol = 3,
	},
	[11] = {
		color = Vector(0, 128, 64),
		particlePath = GENERIC_PARTICLES.popup_dot,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = 5,
		preSymbol = -1,
	},
	[12] = {
		color = Vector(255, 0, 0),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 0,
	},
	[13] = {
		color = Vector(255, 0, 0),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 1,
	},
	[14] = {
		color = Vector(0, 255, 0),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 0,
	},
	[15] = {
		color = Vector(0, 255, 0),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 1,
	},
	[16] = {
		color = Vector(15, 202, 235),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 0,
	},
	[17] = {
		color = Vector(15, 202, 235),
		particlePath = GENERIC_PARTICLES.popup_mana,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = -1,
		preSymbol = 1,
	},
	[18] = {
		color = Vector(POPUP_COLORS.BLOCK.r, POPUP_COLORS.BLOCK.g, POPUP_COLORS.BLOCK.b),
		particlePath = GENERIC_PARTICLES.popup_block,
		attachment = PATTACH_OVERHEAD_FOLLOW,
		postSymbol = 7,
		preSymbol = 1,
	},
	[6] = {
		color = Vector(POPUP_COLORS.DOT_DAMAGE.r, POPUP_COLORS.DOT_DAMAGE.g, POPUP_COLORS.DOT_DAMAGE.b),
		particlePath = GENERIC_PARTICLES.popup_dot,
		attachment = PATTACH_ABSORIGIN,
		postSymbol = 6,
		preSymbol = -1,
	},
}
____exports.ClientFunc = __TS__Class()
local ClientFunc = ____exports.ClientFunc
ClientFunc.name = "ClientFunc"
function ClientFunc.prototype.____constructor(self)
	self._client_particle_callback = { [2] = self._CreateDamageParticle, [1] = self._CreateEffect }
	ListenToGameEvent("client_game_events", function(keys)
		return self:_OnClientGameEvent(keys)
	end, nil)
end
function ClientFunc.prototype._OnClientGameEvent(self, keys)
	if not keys.data then
		return
	end
	local raw = keys.data
	local targetPlayerId
	if string.sub(raw, 1, 1) == "@" then
		local secondAt = 0
		do
			local i = 2
			while i <= #raw do
				if string.sub(raw, i, i) == "@" then
					secondAt = i
					break
				end
				i = i + 1
			end
		end
		if secondAt > 0 then
			targetPlayerId = tonumber(string.sub(raw, 2, secondAt - 1))
			raw = string.sub(raw, secondAt + 1)
		end
	end
	if targetPlayerId ~= nil and targetPlayerId ~= -1 and targetPlayerId ~= GetLocalPlayerID() then
		return
	end
	if not raw or raw == "" then
		return
	end
	local dataArr = __TS__StringSplit(raw, "&")
	for ____, str in ipairs(dataArr) do
		self:_HandleSingleData(str)
	end
end
function ClientFunc.prototype._HandleSingleData(self, str)
	local parts = __TS__StringSplit(str, ":")
	local dataType = tonumber(parts[1])
	local content = parts[2]
	local callback = self._client_particle_callback[dataType]
	if callback then
		callback(nil, content)
	end
end
function ClientFunc.prototype._CreateEffect(self, content)
	local args = __TS__StringSplit(content, ",")
	local entIndex = tonumber(args[1])
	local effectType = tonumber(args[2])
	local ent = EntIndexToHScript(entIndex)
	if not ent or not IsValid(ent) then
		return
	end
	local handler = EFFECT_HANDLERS[effectType]
	if handler then
		handler(nil, ent)
	end
end
function ClientFunc.prototype._CreateDamageParticle(self, content)
	local args = __TS__StringSplit(content, ",")
	local entIndex = tonumber(args[1])
	local ent = EntIndexToHScript(entIndex)
	local numType = tonumber(args[2])
	local num = tonumber(args[3])
	local config = NUMBER_TYPE_CONFIG[numType]
	if not config then
		return
	end
	local color = config.color
	local particlePath = config.particlePath
	local postSymbol = config.postSymbol
	local preSymbol = config.preSymbol
	local attachment = config.attachment
	local pIndex = ParticleManager:CreateParticle(particlePath, attachment, ent)
	ParticleManager:SetParticleControl(pIndex, 1, Vector(preSymbol, num, postSymbol))
	local len = #tostring(num)
	if preSymbol ~= -1 then
		len = len + 1
	end
	if postSymbol ~= -1 then
		len = len + 1
	end
	local duration = 3
	ParticleManager:SetParticleControl(pIndex, 2, Vector(duration, len, 0))
	ParticleManager:SetParticleControl(pIndex, 3, color)
	ParticleManager:ReleaseParticleIndex(pIndex)
end
__TS__New(____exports.ClientFunc)
return ____exports