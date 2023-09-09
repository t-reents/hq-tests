qe:
	@cp scf.in manual && cp -r pseudo manual
	@cd manual ;\
	sbatch qe.sh

single:
	@sbatch submit_debug_single.sh | awk '{print $$NF}' >> job_ids
	@mkdir -p single
	@cp scf.in single && cp -r pseudo single;\
	cp qe.sh single ;\
	cd single ;\
	hq submit qe.sh | awk '{print $$NF}' >> ../hq_ids ;\
	cd ..

serial:
	@sbatch submit_debug_single.sh | awk '{print $$NF}' >> job_ids
	@for i in 1 2 3 4; do \
		@mkdir -p run$$i ;\
		cp scf.in run$$i && cp -r pseudo run$$i;\
		cp qe.sh run$$i ;\
		cd run$$i ;\
		hq submit qe.sh | awk '{print $$NF}' >> ../hq_ids ;\
		cd .. ;\
		sleep 1;\
	done

parallel:
	@sbatch submit_debug.sh | awk '{print $$NF}' >> job_ids
	sleep 4
	@for i in 1 2 3 4; do \
		cp scf.in run$$i && cp -r pseudo run$$i;\
		cp qe.sh run$$i ;\
		cd run$$i ;\
		hq submit qe.sh | awk '{print $$NF}' >> ../hq_ids ;\
		cd .. ;\
		sleep 1;\
	done

clean:
	@echo '' >> job_ids && echo '' >> hq_ids
	@for id in $$(cat job_ids); do scancel $$id; done && rm job_ids
	@for id in $$(cat hq_ids); do hq job cancel $$id 2>/dev/null; done && rm hq_ids
	@for dir in $$(find . -type d -not -name pseudo -not -name "."); do rm -rf $$dir; done

report:
	@echo '------ WALLTIME ------' > report
	@for out in $$(find . -name scf.out); do echo $$out | tee -a report; grep 'PWSCF        :' $$out | tee -a report; done
	@echo >> report
	@echo '------ SECS ------'  >> report
	@echo >> report
	@echo SECS >> report
	@for out in $$(find . -name scf.out); do echo $$out | tee -a report; grep 'secs' $$out | tee -a report; done
