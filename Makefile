
# Target��dependentҲ���Բ���һ���ļ�������һ����ţ�label������ʱ���ͳ�֮Ϊpseudotarget��α�ļ�����
# Pseudotarget�����ֲ����뵱ǰĿ¼�µ��κ��ļ�����ͬ

ALL: _DuiLib _test1
# _DuiLib _test1
_DuiLib:
	@echo to compile DuiLib...
	@cd DuiLib
	@$(MAKE) /nologo
	@cd ..

_test1:
	@echo to compile test1...
	@cd test1
	@$(MAKE) /nologo
	@cd ..
