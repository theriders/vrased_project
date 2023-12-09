default :

install-clean :
	rm -rf ./verif-tools/verilog2smv-1.1.3 ./verif-tools/verilog2smv.sh	

install :
	cd verif-tools ; \
	tar -vxzf verilog2smv-1.1.3.tar.gz ; \
	cd verilog2smv-1.1.3 ; \
	sh build.sh ; \
	cp verilog2smv.sh ../

mem :
	sh build/run "application" true

run :
	sh build/run "application" false

verify :
	sh verif-tools/run

verify_atomicity :
	sh verif-tools/run_atomicity

verify_dma_detect :
	sh verif-tools/run_detect

verify_dma_AC :
	sh verif-tools/run_dma_ac

verify_x_stack :
	sh verif-tools/run_x_stack

verify_dma_x_stack :
	sh verif-tools/run_dma_x_stack

hw-auth-verify :
	sh verif-tools/hw-auth-verify

clean :
	rm -rf simv *.mem pmem.inc stimulus.v tmp-build
