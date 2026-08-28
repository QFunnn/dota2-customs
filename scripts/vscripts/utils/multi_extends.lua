--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
--- 多重继承函数
--
-- 该函数允许一个基类通过多个扩展函数进行扩展，实现类似多重继承的效果。
-- 每个扩展函数接收一个类并返回一个新的扩展类。
--
-- @template B 基类构造函数类型
-- @template E 扩展函数类型
-- @param extendsBase 基类构造函数
-- @param extendsFunctions 扩展函数数组，按顺序应用
-- @returns 扩展后的构造函数，包含所有扩展的功能
-- @example // 定义基类
-- class Animal {
--     name: string;
--     constructor(name: string) {
--         this.name = name;
--     }
--     eat() {
--         print(`${this.name} 正在吃东西`);
--     }
-- }
--
-- // 定义第一个 mixin：可飞行
-- function Flyable<T extends Constructor>(Base: T) {
--     return class extends Base {
--         fly_speed = 10;
--         fly() {
--             print(`以 ${this.fly_speed} 的速度飞行`);
--         }
--     };
-- }
--
-- // 定义第二个 mixin：可游泳
-- function Swimmable<T extends Constructor>(Base: T) {
--     return class extends Base {
--         swim_speed = 5;
--         swim() {
--             print(`以 ${this.swim_speed} 的速度游泳`);
--         }
--     };
-- }
--
-- // 使用多重继承创建一个既能飞又能游的动物类
-- const Duck = multiExtends(Animal, [Flyable, Swimmable]);
--
-- // 创建实例
-- const duck = new Duck("唐老鸭");
-- duck.eat();   // 唐老鸭 正在吃东西
-- duck.fly();   // 以 10 的速度飞行
-- duck.swim();  // 以 5 的速度游泳
-- @example // 在 Dota 2 自定义游戏中的实际应用
-- class BaseModifier {
--     modifier_name: string;
--     constructor(name: string) {
--         this.modifier_name = name;
--     }
-- }
--
-- // 添加伤害加成功能
-- function DamageBonus<T extends Constructor>(Base: T) {
--     return class extends Base {
--         damage_bonus = 50;
--         GetModifierAttackDamageBonus() {
--             return this.damage_bonus;
--         }
--     };
-- }
--
-- // 添加移速加成功能
-- function MoveSpeedBonus<T extends Constructor>(Base: T) {
--     return class extends Base {
--         move_speed_bonus = 20;
--         GetModifierMoveSpeedBonus() {
--             return this.move_speed_bonus;
--         }
--     };
-- }
--
-- // 创建一个同时具有伤害和移速加成的 modifier
-- const PowerModifier = multiExtends(BaseModifier, [DamageBonus, MoveSpeedBonus]);
-- const modifier = new PowerModifier("power_modifier");
function multiExtends(self, extendsBase, extendsFunctions)
	local func
	local ans = extendsBase
	while #extendsFunctions do
		func = table.remove(extendsFunctions, 1)
		ans = func(_G, ans)
	end
	return ans
end