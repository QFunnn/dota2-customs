--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().event = {
	"1": {
		event_id: 1,
		describe: "抽卡target次（param_1卡池限制）",
		param_1: "0：任意卡池"
	},
	"2": {
		event_id: 2,
		describe: "通关target次（param_1使用英雄，param_2难度；param_3时间限制，param_s1受击次数限制；param_4是否需要单/多人通关）",
		param_1: "0：任意英雄",
		param_2: "0：任意难度",
		param_3: "0：无规定时间；大于0:在规定时间（秒）内通关",
		param_4: "0：无条件 1：单人 2：多人",
		param_s1: "受击次数(空为无条件）"
	},
	"3": {
		event_id: 3,
		describe: "信使总星级达到target星"
	},
	"4": {
		event_id: 4,
		describe: "登录target天（param_1是否需要连续登录）",
		param_1: "0：任意登录 1：连续登录"
	},
	"5": {
		event_id: 5,
		describe: "在线target分钟"
	},
	"6": {
		event_id: 6,
		describe: "target只信使到达param_1星（param_1星级限制）",
		param_1: "信使星级"
	},
	"7": {
		event_id: 7,
		describe: "英雄（账号）提升到target级"
	},
	"8": {
		event_id: 8,
		describe: "购买商品target次（param_1商品限制，param_2购买使用货币限制）",
		param_1: "0：任意商品",
		param_2: "0：任意货币"
	},
	"9": {
		event_id: 9,
		describe: "领取target次param_1类型任务的奖励",
		param_1: "0：任意任务 1：每日任务 2：周常任务 3：成就"
	},
	"10": {
		event_id: 10,
		describe: "前端事件收集",
		param_1: "1：单个房间只靠陷阱清除所有怪物
2：手动成功钓鱼
3：单局游戏激活所有param_2流派祝福(1雷电2冰冻3剧毒4狂暴5暴击6神圣7御风)
4：击杀param_s1(怪物ID）
5：酒馆购买param_2道具（param_2道具：1威士忌：2啤酒：3朗姆酒：4龙舌兰）
6：拾取param_2道具（param_2道具：1属性书：2神杖祝福：3金币袋：4在许愿池花费金币许愿）
7：玩家死亡\""
	}
};