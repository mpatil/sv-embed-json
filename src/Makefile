## File generated by the BNF Converter (bnfc 2.9.6).

QRUN = qrun
QRUN_OPTS = -64 -sv -mfcu -permissive -l comp.log -suppress 2875,2240 +incdir+./ +UVM_NO_RELNOTES

.PHONY : clean distclean

all : qrun

clean :
	rm -rf qrun.out test-vcs

distclean : clean
	rm -f comp.log modelsim.ini *.bak y.output

.PHONY: qrun
qrun : fusesoc Test.sv test.w
	${QRUN} ${QRUN_OPTS} -F test-vcs/lib_interp_json_0.scr Test.sv +input=test.w

.PHONY: fusesoc
fusesoc :
	fusesoc --cores-root . run --no-export --target=test --build-root=. --setup lib:interp:json
