
# Target和dependent也可以不是一个文件，而是一个标号（label）。这时，就称之为pseudotarget（伪文件）。
# Pseudotarget的名字不能与当前目录下的任何文件名相同

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
