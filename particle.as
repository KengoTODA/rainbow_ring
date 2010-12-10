// はずむ虹の輪 v1.3

// パーティクル（水しぶきとして使用）を扱うモジュール。モジュール変数として
//   x   ... パーティクルのX座標
//   y   ... パーティクルのY座標
//   z   ... パーティクルのZ座標
//   v_x ... パーティクルのX方向の速度
//   v_y ... パーティクルのY方向の速度
//   v_z ... パーティクルのZ方向の速度
// を持つ。
#module particle x, y, z, v_x, v_y, v_z
#const SPEED   10  // XY平面上での速さ
#const _V_Z    7   // Z方向の速さの初期値
#const R       8   // パーティクルの半径
#const GRAVITY -1  // 重力加速度（負）
//
// パーティクルの生成
#modinit int _x, int _y, double t
	x = _x : y = _y : z = 0
	v_x = cos( t ) * SPEED : v_y = sin( t ) * SPEED : v_z = _V_Z
	return
//
// パーティクルの移動
#modfunc move_particle
	v_z += GRAVITY
	x += v_x : y += v_y : z += v_z
	return z < 0   // 水面に落ちたらもう描画する必要はない（破棄して良い）
//
// パーティクルの描画
#modfunc draw_particle
	d3particle 0, x, y, z, R
	return

#global
	d3mkparticle 0, 255, 255, 255