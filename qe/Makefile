SLURM_SINGLE_DIR = slurm-single
SLURM_PARA_DIR = slurm-para
HQ_SINGLE_DIR = hq-single
HQ_PARA_DIR = hq-para

N ?= 4

slurm-single:
	@mkdir -p $(SLURM_SINGLE_DIR)
	@cp scf.in $(SLURM_SINGLE_DIR) && cp -r pseudo $(SLURM_SINGLE_DIR) && cp submit_qe_single.sh $(SLURM_SINGLE_DIR)
	@cd $(SLURM_SINGLE_DIR) ;\
	sbatch submit_qe_single.sh

slurm-parallel:
	@for (( i=1; i<=$(N); i++ )); do \
		mkdir -p $(SLURM_PARA_DIR)$$i ;\
		cp scf.in $(SLURM_PARA_DIR)$$i ;\
		cp -r pseudo $(SLURM_PARA_DIR)$$i ;\
	done
	@sbatch --nodes=$(N) submit_qe_parallel.sh | awk '{print $$NF}' >> job_ids

submit-slurm-single:
	@sbatch submit_hq_single.sh | awk '{print $$NF}' >> job_ids

submit-slurm-para:
	@sbatch --nodes=$(N) submit_hq_parallel.sh | awk '{print $$NF}' >> job_ids

submit-hq:
	@for (( i=1; i<=$(N); i++ )); do \
		mkdir -p $(HQ_PARA_DIR)$$i ;\
		cp scf.in $(HQ_PARA_DIR)$$i && cp -r pseudo $(HQ_PARA_DIR)$$i;\
		cp qe.sh $(HQ_PARA_DIR)$$i ;\
		cd $(HQ_PARA_DIR)$$i ;\
		hq submit --name QE-run$$i qe.sh | awk '{print $$NF}' >> ../hq_ids ;\
		cd .. ;\
	done

hq-single: submit-slurm-single
	@mkdir -p $(HQ_SINGLE_DIR)
	@cp scf.in $(HQ_SINGLE_DIR) && cp -r pseudo $(HQ_SINGLE_DIR);\
	cp qe.sh $(HQ_SINGLE_DIR) ;\
	cd $(HQ_SINGLE_DIR) ;\
	hq submit --name QE-single qe.sh | awk '{print $$NF}' >> ../hq_ids ;\
	cd ..

hq-serial: submit-slurm-single submit-hq

hq-parallel: submit-slurm-para submit-hq

clean:
	@echo '' >> job_ids && echo '' >> hq_ids
	@for id in $$(cat job_ids); do scancel $$id; done && rm job_ids
	@for id in $$(cat hq_ids); do hq job cancel $$id 2>/dev/null; done && rm hq_ids
	@for dir in $$(find . -type d -not -name pseudo -not -name "."); do rm -rf $$dir; done
	@find . -maxdepth 1 -name "_scheduler*" -o -name report -print0 | xargs -0 rm -f

secs:
	@for out in $$(find . -name scf.out); do echo $$out; grep 'secs' $$out; done

report:
	@echo '------ START ------' > report
	@for out in $$(find . -name scf.out); do echo $$out | tee -a report; grep 'Program PWSCF' $$out | tee -a report; done
	@echo '------ WALLTIME ------' >> report
	@for out in $$(find . -name scf.out); do echo $$out | tee -a report; grep 'PWSCF        :' $$out | tee -a report; done
	@echo >> report
	@echo '------ SECS ------'  >> report
	@echo >> report
	@echo SECS >> report
	@for out in $$(find . -name scf.out); do echo $$out | tee -a report; grep 'secs' $$out | tee -a report; done
