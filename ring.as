// はずむ虹の輪 v1.3

// 虹の輪を扱うモジュール。モジュール変数として
//   x       ... 虹の輪の中心のX座標
//   y       ... 虹の輪の中心のY座標
//   z       ... 虹の輪の中心のZ座標
//   r       ... 虹の輪の外径
//   r_inner ... 虹の輪の内径
//   ang     ... 虹の輪の回転角度
//   a_ang   ... 虹の輪の回転する速度
//   v_xy    ... 虹の輪のXY平面上での速さ
//   v_z     ... 虹の輪のZ方向の速さ
//   v_ang   ... 虹の輪のXY平面上での進行方向
//   life    ... 虹の輪の寿命
// を持つ。
#module ring x, y, z, r, r_inner, ang, a_ang, v_xy, v_z, v_ang, life
#const DIV_NUM   14     // リングの分割数
#const LIFE_MAX  100    // 寿命の初期値
#const GRAVITY   -2.0   // 重力加速度（負）
#const A_ANG_MAX 0.1    // 回転速度初期値
#const A_ANG_MIN 0.005  // 回転速度最小値
#const REPEL     -0.9   // 反発係数（-1～0）
#const ANG_WIDTH ( PI * 2.0 ) / ( DIV_NUM + 3 ) // 虹の輪のかけらの幅（角度）
//
// 虹の輪の生成（初期化）
#modinit int _x, int _y, int _z, double _r, int _v_xy, double _v_ang
	x = _x : y = _y : z = _z    // 中心の座標
	r = _r                      // 輪の外径
	r_inner = 0.8 * r           // 輪の内径

	v_xy  = _v_xy
	v_z   = 0.0
	v_ang = _v_ang
	ang   = 0.0
	a_ang = A_ANG_MAX
	life  = LIFE_MAX
	return
//
// リングを動かす
#modfunc move_ring
	// 重力によるZ方向の速さの変更
	v_z += GRAVITY
	// 回転
	ang += a_ang
	// 移動
	x += cos( v_ang ) * v_xy
	y += sin( v_ang ) * v_xy
	z += v_z
	// はずむ処理
	if ( z < r ) : gosub *bound
	// 寿命の減少
	life--
	return life <= 0
//
// 水面をはずむ処理
*bound
	// 座標と速度の変更
	z    = r * 2.0 - z
	v_z *= REPEL
	// 角速度の減速
	a_ang = limitf( a_ang - 0.006, A_ANG_MIN, A_ANG_MAX )
	// 波紋をひとつ生成
	newmod mod_ripple@, ripple, x, y
	// パーティクルの生成
	t = PI * rnd( 60 ) / 30.0
	repeat 5
		newmod mod_particle@, particle, x, y, t
		t += PI * ( 1.0 + rnd(3) ) / 5.0
	loop
	return
//
// リングを描く
#modfunc draw_ring
	gosub *calc_alpha           // アルファブレンド値を算出
	gmode GMODE_ADD, , , alpha  // 加算モードで描画
	d3setlocal x, y, z, cos( v_ang ) * cos( ang ), -cos( v_ang ) * sin( ang ),-sin( v_ang ), sin( v_ang ) * cos( ang ), -sin( v_ang ) * sin( ang ), cos( v_ang ), -sin( ang ), -cos( ang ), 0
	gosub *draw_myself

	return
//
// 水面の鏡像を描く
#modfunc draw_mirror
	gosub *calc_alpha               // アルファブレンド値を算出
	gmode GMODE_ADD, , , alpha / 4  // 加算モードで描画（本物の4分の1の濃さ）
	d3setlocal x, y, -z, cos( v_ang ) * cos( ang ), -cos( v_ang ) * sin( ang ), -sin( v_ang ), sin( v_ang ) * cos( ang ), -sin( v_ang ) * sin( ang ), cos( v_ang ), sin( ang ), cos(ang), 0
	gosub *draw_myself
	return
//
// 寿命からアルファブレンドのブレンド率（0～200）を計算
// ifとlimitによって、↓のグラフのように求まる
// ↑ブレンド率
// ｜    ＿＿＿＿＿
// ｜  ／          ＼
// ｜／              ＼
// ┼―――――――――→寿命
*calc_alpha
	if life > ( LIFE_MAX - 40 ) {
		alpha = ( LIFE_MAX - life ) * 5
	} else {
		alpha = limit( life * 5 , 0, 200 )
	}
	return
//
// 座標(0, 0, 0)を中心に、XY平面上にリングを描く
*draw_myself
	repeat DIV_NUM
		hsvcolor cnt * 191 / DIV_NUM, 255, 255
		t = 3.14 * 2 * cnt / DIV_NUM + ang
		d3s_x = r * cos( t ), r * cos( t + ANG_WIDTH ), r_inner * cos( t + ANG_WIDTH ), r_inner * cos( t )
		d3s_y = r * sin( t ), r * sin( t + ANG_WIDTH ), r_inner * sin( t + ANG_WIDTH ), r_inner * sin( t )
		d3square d3s_x, d3s_y, d3s_z
	loop
	return
#global
	d3s_z@ring = 0, 0, 0, 0
