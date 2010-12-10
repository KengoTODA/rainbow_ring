// �͂��ޓ��̗� v1.3

// �p�[�e�B�N���i�����Ԃ��Ƃ��Ďg�p�j���������W���[���B���W���[���ϐ��Ƃ���
//   x   ... �p�[�e�B�N����X���W
//   y   ... �p�[�e�B�N����Y���W
//   z   ... �p�[�e�B�N����Z���W
//   v_x ... �p�[�e�B�N����X�����̑��x
//   v_y ... �p�[�e�B�N����Y�����̑��x
//   v_z ... �p�[�e�B�N����Z�����̑��x
// �����B
#module particle x, y, z, v_x, v_y, v_z
#const SPEED   10  // XY���ʏ�ł̑���
#const _V_Z    7   // Z�����̑����̏����l
#const R       8   // �p�[�e�B�N���̔��a
#const GRAVITY -1  // �d�͉����x�i���j
//
// �p�[�e�B�N���̐���
#modinit int _x, int _y, double t
	x = _x : y = _y : z = 0
	v_x = cos( t ) * SPEED : v_y = sin( t ) * SPEED : v_z = _V_Z
	return
//
// �p�[�e�B�N���̈ړ�
#modfunc move_particle
	v_z += GRAVITY
	x += v_x : y += v_y : z += v_z
	return z < 0   // ���ʂɗ�����������`�悷��K�v�͂Ȃ��i�j�����ėǂ��j
//
// �p�[�e�B�N���̕`��
#modfunc draw_particle
	d3particle 0, x, y, z, R
	return

#global
	d3mkparticle 0, 255, 255, 255