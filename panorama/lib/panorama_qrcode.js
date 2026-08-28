--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function CreateQRCode(data, container, width) {
	container.RemoveAndDeleteChildren();
	container.style.flowChildren = "none";
	let qrcode = new QRCode(-1, 0);
	qrcode.addData(data);
	qrcode.make();
	let size = qrcode.getModuleCount();
	let pix_size = width / size;
	container.style.backgroundColor = '#fff';
	for (let row = 0; row < size; ++row) {
		for (let col = 0; col < size; ++col) {
			if (!qrcode.isDark(row, col)) continue;
			let pix = $.CreatePanel("Panel", container, "");
			pix.style.marginLeft = col * pix_size + `px`;
			pix.style.marginTop = row * pix_size + `px`;
			// 如果某个区域有连续的dark module
			// 那么将这些区域做成同一个panel，以提升渲染效率
			let rect_width = pix_size;
			while (col + 1 < size && qrcode.isDark(row, col + 1)) {
				rect_width += pix_size;
				col++;
			}
			pix.style.width = rect_width + "px";
			pix.style.height = pix_size + "px";
			pix.style.backgroundColor = "#000";
		}
	}
}

function CreateQRCodeByImg(pixImg, data, container, width) {

	if(!pixImg)
	{
		return;
	}
	container.RemoveAndDeleteChildren();
	container.style.flowChildren = "down";
	const qrcode = new QRCode(-1, 0);
	qrcode.addData(data);
	qrcode.make();
	const size = qrcode.getModuleCount();
	const pix_size = Math.floor(width / size);
	const qrcodeWidth = pix_size * size;
	container.style.padding = Math.floor(width - qrcodeWidth) / 2 - 1 + 'px';
	container.style.backgroundColor = '#fff';

	//backgroundImage和backgroundPosition属性的上限是1024个字符，所以尽量让图片路径简短，以容下更多背景
	//通过pixImg的长度算出每组像素点最多可以有多少张背景图
	//数字70是假设backgroundPosition平均值为千位数时，1024个字符能容下的最多个坐标数
	//size是每行的像素数
	//三个值取最小值，作为像素组的黑色像素数量
	const pixGroupBgCount = Math.min(Math.floor(1024 / (pixImg.length + 1)), size, 70);

	for (let row = 0; row < size; ++row) {
		const row_container = $.CreatePanel("Panel", container, "");
		row_container.style.flowChildren = "right";
		const bgImgArr = [];
		const bgPosArr = [];
		let pixIdx = 0;
		let pixGroup

		for (let col = 0; col <= size; ++col) {

			let packUp = false;
			let isDark = false;
			if(col == size)
			{
				packUp = true;
			}
			else
			{
				isDark = qrcode.isDark(row, col);
				if(isDark && bgImgArr.length == pixGroupBgCount)
				{
					packUp = true;
				}
			}

			if(packUp)
			{
				pixGroup = $.CreatePanel("Panel", row_container, "");
				pixGroup.style.width = `${pix_size * pixIdx}px`;
				pixGroup.style.height = `${pix_size}px`;
				pixGroup.style.backgroundRepeat = "no-repeat";
				pixGroup.style.backgroundSize = `${pix_size}px ${pix_size}px`;
				pixGroup.style.backgroundImage = bgImgArr.join(",");
				pixGroup.style.backgroundPosition = bgPosArr.join(",");

				bgImgArr.length = 0;
				bgPosArr.length = 0;
				pixIdx = 0;
			}

			if(isDark)
			{
				bgImgArr.push(pixImg);
				bgPosArr.push(`${pixIdx * pix_size}px 0px`);
			}

			pixIdx++;
		}
	}
}

function CreateQRCodeByImg2(pixImg, data, container, width) {

	if(!pixImg)
	{
		return;
	}
	container.RemoveAndDeleteChildren();
	container.style.flowChildren = "down";
	const qrcode = new QRCode(-1, 0);
	qrcode.addData(data);
	qrcode.make();
	const size = qrcode.getModuleCount();
	const pix_size = Math.floor(width / size);
	const qrcodeWidth = pix_size * size;
	container.style.padding = Math.floor(width - qrcodeWidth) / 2 - 1 + 'px';
	container.style.backgroundColor = '#fff';

	const pixGroupBgCount = 3;
	const pixGroupSize = pix_size * pixGroupBgCount;

	for (let row = 0; row < size; ++row) {
		const row_container = $.CreatePanel("Panel", container, "");
		row_container.style.flowChildren = "right";
		const bgImgArr = [];
		const bgPosArr = [];
		let pixIdx = 0;
		let pixGroup

		for (let col = 0; col <= size; ++col) {

			let packUp = false;
			let isDark = false;
			if(col == size)
			{
				packUp = true;
			}
			else
			{
				isDark = qrcode.isDark(row, col);
				if(pixIdx == pixGroupBgCount)
				{
					packUp = true;
				}
			}

			if(packUp)
			{
				pixGroup = $.CreatePanel("Panel", row_container, "");
				pixGroup.style.width = `${pixGroupSize}px`;
				pixGroup.style.height = `${pix_size}px`;
				if(bgImgArr.length > 0)
				{
					pixGroup.style.backgroundRepeat = "no-repeat";
					pixGroup.style.backgroundSize = `${pix_size}px ${pix_size}px`;
					pixGroup.style.backgroundImage = bgImgArr.join(",");
					pixGroup.style.backgroundPosition = bgPosArr.join(",");
				}

				bgImgArr.length = 0;
				bgPosArr.length = 0;
				pixIdx = 0;
			}
			
			if(isDark)
			{
				let pos = "left";
				switch(pixIdx)
				{
					case 1:
						pos = "center";
						break;
					case 2:
						pos = "right";
						break;
				}
				bgImgArr.push(pixImg);
				bgPosArr.push(`${pos} top`);
			}

			pixIdx++;
		}
	}
}