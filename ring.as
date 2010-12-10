// �͂��ޓ��̗� v1.3

// ���̗ւ��������W���[���B���W���[���ϐ��Ƃ���
//   x       ... ���̗ւ̒��S��X���W
//   y       ... ���̗ւ̒��S��Y���W
//   z       ... ���̗ւ̒��S��Z���W
//   r       ... ���̗ւ̊O�a
//   r_inner ... ���̗ւ̓��a
//   ang     ... ���̗ւ̉�]�p�x
//   a_ang   ... ���̗ւ̉�]���鑬�x
//   v_xy    ... ���̗ւ�XY���ʏ�ł̑���
//   v_z     ... ���̗ւ�Z�����̑���
//   v_ang   ... ���̗ւ�XY���ʏ�ł̐i�s����
//   life    ... ���̗ւ̎���
// �����B
#module ring x, y, z, r, r_inner, ang, a_ang, v_xy, v_z, v_ang, life
#const DIV_NUM   14     // �����O�̕�����
#const LIFE_MAX  100    // �����̏����l
#const GRAVITY   -2.0   // �d�͉����x�i���j
#const A_ANG_MAX 0.1    // ��]���x�����l
#const A_ANG_MIN 0.005  // ��]���x�ŏ��l
#const REPEL     -0.9   // �����W���i-1�`0�j
#const ANG_WIDTH ( PI * 2.0 ) / ( DIV_NUM + 3 ) // ���̗ւ̂�����̕��i�p�x�j
//
// ���̗ւ̐����i�������j
#modinit int _x, int _y, int _z, double _r, int _v_xy, double _v_ang
	x = _x : y = _y : z = _z    // ���S�̍��W
	r = _r                      // �ւ̊O�a
	r_inner = 0.8 * r           // �ւ̓��a

	v_xy  = _v_xy
	v_z   = 0.0
	v_ang = _v_ang
	ang   = 0.0
	a_ang = A_ANG_MAX
	life  = LIFE_MAX
	return
//
// �����O�𓮂���
#modfunc move_ring
	// �d�͂ɂ��Z�����̑����̕ύX
	v_z += GRAVITY
	// ��]
	ang += a_ang
	// �ړ�
	x += cos( v_ang ) * v_xy
	y += sin( v_ang ) * v_xy
	z += v_z
	// �͂��ޏ���
	if ( z < r ) : gosub *bound
	// �����̌���
	life--
	return life <= 0
//
// ���ʂ��͂��ޏ���
*bound
	// ���W�Ƒ��x�̕ύX
	z    = r * 2.0 - z
	v_z *= REPEL
	// �p���x�̌���
	a_ang = limitf( a_ang - 0.006, A_ANG_MIN, A_ANG_MAX )
	// �g����ЂƂ���
	newmod mod_ripple@, ripple, x, y
	// �p�[�e�B�N���̐���
	t = PI * rnd( 60 ) / 30.0
	repeat 5
		newmod mod_particle@, particle, x, y, t
		t += PI * ( 1.0 + rnd(3) ) / 5.0
	loop
	return
//
// �����O��`��
#modfunc draw_ring
	gosub *calc_alpha           // �A���t�@�u�����h�l���Z�o
	gmode GMODE_ADD, , , alpha  // ���Z���[�h�ŕ`��
	d3setlocal x, y, z, cos( v_ang ) * cos( ang ), -cos( v_ang ) * sin( ang ),-sin( v_ang ), sin( v_ang ) * cos( ang ), -sin( v_ang ) * sin( ang ), cos( v_ang ), -sin( ang ), -cos( ang ), 0
	gosub *draw_myself

	return
//
// ���ʂ̋�����`��
#modfunc draw_mirror
	gosub *calc_alpha               // �A���t�@�u�����h�l���Z�o
	gmode GMODE_ADD, , , alpha / 4  // ���Z���[�h�ŕ`��i�{����4����1�̔Z���j
	d3setlocal x, y, -z, cos( v_ang ) * cos( ang ), -cos( v_ang ) * sin( ang ), -sin( v_ang ), sin( v_ang ) * cos( ang ), -sin( v_ang ) * sin( ang ), cos( v_ang ), sin( ang ), cos(ang), 0
	gosub *draw_myself
	return
//
// ��������A���t�@�u�����h�̃u�����h���i0�`200�j���v�Z
// if��limit�ɂ���āA���̃O���t�̂悤�ɋ��܂�
// ���u�����h��
// �b    �Q�Q�Q�Q�Q
// �b  �^          �_
// �b�^              �_
// ���\�\�\�\�\�\�\�\�\������
*calc_alpha
	if life > ( LIFE_MAX - 40 ) {
		alpha = ( LIFE_MAX - life ) * 5
	} else {
		alpha = limit( life * 5 , 0, 200 )
	}
	return
//
// ���W(0, 0, 0)�𒆐S�ɁAXY���ʏ�Ƀ����O��`��
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
