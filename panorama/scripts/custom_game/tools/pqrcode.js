--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CreateQRCode(data, container, qrcodesize) {
    container.RemoveAndDeleteChildren();
    container.style.flowChildren = "down";
    let qrcode = new QRCode(-1, 3);
    qrcode.addData(data);
    qrcode.make();
    let size = qrcode.getModuleCount();
    let pix_size = Math.floor(qrcodesize / size);
    const qrcodeWidth = pix_size * size;
    for (let row = 0; row < size; ++row) {
        let row_container = $.CreatePanel("Panel", container, "");
        row_container.style.flowChildren = "right";
        for (let col = 0; col < size; ++col) {
            let pix = $.CreatePanel("Panel", row_container, "");
            pix.style.width = pix_size + "px";
            pix.style.height = pix_size + "px";
            pix.style.backgroundColor = qrcode.isDark(row, col)
                ? "#000000"
                : "#ffffff";
        }
    }
    return qrcodeWidth;
}