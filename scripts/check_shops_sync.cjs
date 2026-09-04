--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


// Сверка витрины лавки: scripts/shops.txt (что ПОКАЗЫВАЕТ клиент) против
// scripts/shops/1x8_shops.txt (что РАЗРЕШАЕТ покупать сервер).
//
// Файлов вынужденно два — так устроена сама Dota (проверено строками в бинарниках 2026-08-03):
//   server.dll -> только "scripts/shops/%s_shops.txt"
//   client.dll -> "scripts/shops.txt" И "scripts/shops/%s_shops.txt"
// Если они разъедутся, игрок увидит в лавке не то, что реально продаётся.
//
// Запуск (из папки scripts):  node check_shops_sync.cjs
// Код возврата 1 при расхождении — удобно дёргать перед паблишем.

const fs = require('path') && require('fs');
const path = require('path');

const CLIENT = path.join(__dirname, 'shops.txt');
const SERVER = path.join(__dirname, 'shops', '1x8_shops.txt');

function parse(file) {
    const txt = fs.readFileSync(file, 'utf8');
    const sections = {};
    let sec = null;
    for (const raw of txt.split(/\r?\n/)) {
        const line = raw.replace(/\/\/.*$/, '');            // срезаем комментарии
        const s = line.match(/^\s*"([a-z_0-9]+)"\s*$/);
        if (s && s[1] !== 'dota_shops') { sec = s[1]; sections[sec] = sections[sec] || []; continue; }
        const it = line.match(/^\s*"item"\s+"([a-z_0-9]+)"/);
        if (it && sec) sections[sec].push(it[1]);
    }
    return sections;
}

const a = parse(CLIENT);
const b = parse(SERVER);
let problems = 0;

const allSections = [...new Set([...Object.keys(a), ...Object.keys(b)])];
for (const s of allSections) {
    const listA = a[s] || [];
    const listB = b[s] || [];
    if (listA.join('|') === listB.join('|')) continue;
    problems++;
    console.log(`РАСХОЖДЕНИЕ в секции "${s}":`);
    const onlyClient = listA.filter(x => !listB.includes(x));
    const onlyServer = listB.filter(x => !listA.includes(x));
    if (onlyClient.length) console.log('   только в витрине (клиент): ' + onlyClient.join(', '));
    if (onlyServer.length) console.log('   только у сервера: ' + onlyServer.join(', '));
    if (!onlyClient.length && !onlyServer.length) console.log('   состав одинаковый, но отличается ПОРЯДОК');
}

const totalA = Object.values(a).reduce((n, l) => n + l.length, 0);
const totalB = Object.values(b).reduce((n, l) => n + l.length, 0);

if (problems === 0) {
    console.log(`OK: файлы синхронны — ${allSections.length} секций, ${totalA} позиций.`);
    process.exit(0);
}
console.log(`\nИТОГО расхождений: ${problems} (витрина ${totalA} позиций, сервер ${totalB}).`);
process.exit(1);