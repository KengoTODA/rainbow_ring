// はずむ虹の輪 v1.3

// 波紋を扱うモジュール。モジュール変数として
//   x ... 波紋の中心点のX座標
//   y ... 波紋の中心点のY座標
//   r ... 波紋の半径
// を持つ。Z座標は0に固定。
#module ripple x, y, r
#const SPEED      6     // 波紋の広がる速さ
#const RIPPLE_DIV 15    // 波紋を何分割して描画するか（大きければ大きいほどなめらかな円に近づく）
#const R_MAX      100   // 波紋の最大半径
//
// 波紋の生成
#modinit int _x, int _y
	x = _x          // 中心の座標X
	y = _y          // 中心の座標Y
	r = 0           // 半径
	return
//
// 波紋の移動（半径の増加）
#modfunc move_ripple
	r += SPEED
	return r > R_MAX    // 波紋が一定以上広がったらもう描画する必要はない（破棄して良い）
//
// 波紋の描画
#modfunc draw_ripple
	d3setlocal x, y, 0  // 波紋の中心をローカル座標系の中心とする
	d3initlineto
	repeat RIPPLE_DIV + 1
		t = PI * 2.0 * cnt / RIPPLE_DIV
		gpd3lineto cos( t ) * r, sin( t ) * r   // d3lineto命令を
		df@d3m = 1      // d3module内の変数を変更（こうしないと連続で描画できない）
	loop
	return

#global