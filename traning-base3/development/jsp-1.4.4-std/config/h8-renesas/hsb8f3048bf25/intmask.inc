;
;  TOPPERS/JSP Kernel
;      Toyohashi Open Platform for Embedded Real-Time Systems/
;      Just Standard Profile Kernel
;
;  Copyright (C) 2000-2004 by Embedded and Real-Time Systems Laboratory
;                              Toyohashi Univ. of Technology, JAPAN
;  Copyright (C) 2001-2007 by Industrial Technology Institute,
;                              Miyagi Prefectural Government, JAPAN
;  Copyright (C) 2001-2004 by Dep. of Computer Science and Engineering
;                   Tomakomai National College of Technology, JAPAN
;
;  �嵭����Ԥϡ��ʲ��� (1)��(4) �ξ�狼��Free Software Foundation
;  �ˤ�äƸ�ɽ����Ƥ��� GNU General Public License �� Version 2 �˵�
;  �Ҥ���Ƥ���������������˸¤ꡤ�ܥ��եȥ��������ܥ��եȥ�����
;  ����Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ�������ѡ������ۡʰʲ���
;  ���ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
;  (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
;      ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
;      ����������˴ޤޤ�Ƥ��뤳�ȡ�
;  (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
;      �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
;      �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
;      ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
;  (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
;      �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
;      �ȡ�
;    (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
;        �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
;    (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ��������Ȥ�
;        ��𤹤뤳�ȡ�
;  (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
;      ������⡤�嵭����Ԥ����TOPPERS�ץ��������Ȥ����դ��뤳�ȡ�
;
;  �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
;  ���TOPPERS�ץ��������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����Ŭ�Ѳ�ǽ����
;  �ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ����������Ѥˤ��ľ
;  ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤������Ǥ�����ʤ���
;
;  @(#) $Id: intmask.inc,v 1.4 2007/03/23 07:58:33 honda Exp $
;

;
;  ����ߥޥ��������
;
;�������Υե������vecter.src���饤�󥯥롼�ɤ��졢����ߤ�����������
;�����������Ѥ����롣
;��������ߥϥ�ɥ���ɲä���ݤϡ����Υե�������Խ����롣
;
;��������ߥϥ�ɥ��C����롼����˸ƤӽФ�ľ�������ꤹ�����ߵ��Ļ�
;�����γ���ߥޥ������ͤ�������롣
;����IPM_LEVEL1��IPM_LEVEL2�Τ����줫�ˤ��뤳�ȡ�
;����C����롼����̾xxxx���Ф��ơ�����ߥޥ���̾��xxxx_intmask�Ȥ��롣
;
;��������
;�����������դ�������ߤ�Ʊ����٥�γ���ߤ�ޥ������뤿�ᡢIPM�ˤ�
;���������ľ�Υ�٥�����ꤹ�롣
;

; �����ޥϥ�ɥ�
timer_handler_intmask:         .DEFINE         "IPM_LEVEL2"

; ���ꥢ��ϥ�ɥ�
SCI_MASK:                      .DEFINE         "IPM_LEVEL1"
; ���ꥢ�� 1ch��
sio_err_handler_intmask:       .DEFINE         "SCI_MASK"
sio_in_handler_intmask:        .DEFINE         "SCI_MASK"
sio_out_handler_intmask:       .DEFINE         "SCI_MASK"
; ���ꥢ�� 2ch��
sio_err2_handler_intmask:      .DEFINE         "SCI_MASK"
sio_in2_handler_intmask:       .DEFINE         "SCI_MASK"
sio_out2_handler_intmask:      .DEFINE         "SCI_MASK"
