// �͂��ޓ��̗� v1.3

// �g����������W���[���B���W���[���ϐ��Ƃ���
//   x ... �g��̒��S�_��X���W
//   y ... �g��̒��S�_��Y���W
//   r ... �g��̔��a
// �����BZ���W��0�ɌŒ�B
#module ripple x, y, r
#const SPEED      6     // �g��̍L���鑬��
#const RIPPLE_DIV 15    // �g������������ĕ`�悷�邩�i�傫����Α傫���قǂȂ߂炩�ȉ~�ɋ߂Â��j
#const R_MAX      100   // �g��̍ő唼�a
//
// �g��̐���
#modinit int _x, int _y
	x = _x          // ���S�̍��WX
	y = _y          // ���S�̍��WY
	r = 0           // ���a
	return
//
// �g��̈ړ��i���a�̑����j
#modfunc move_ripple
	r += SPEED
	return r > R_MAX    // �g�䂪���ȏ�L������������`�悷��K�v�͂Ȃ��i�j�����ėǂ��j
//
// �g��̕`��
#modfunc draw_ripple
	d3setlocal x, y, 0  // �g��̒��S�����[�J�����W�n�̒��S�Ƃ���
	d3initlineto
	repeat RIPPLE_DIV + 1
		t = PI * 2.0 * cnt / RIPPLE_DIV
		gpd3lineto cos( t ) * r, sin( t ) * r   // d3lineto���߂�
		df@d3m = 1      // d3module���̕ϐ���ύX�i�������Ȃ��ƘA���ŕ`��ł��Ȃ��j
	loop
	return

#global