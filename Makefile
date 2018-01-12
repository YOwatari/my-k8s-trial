run: create_secret.txt create_mysql_service.txt create_wordpress_service.txt
	@echo Open http://localhost !
	@echo kubectl port-forward wordpress-mysql-xxxxxxxxx 3306:3306

create_secret.txt: mysql-pass.yaml
	kubectl create -f $<
	kubectl get secrets
	@echo 'YOwatari' > $@

create_mysql_service.txt: mysql-deployment.yaml
	kubectl create -f $<
	kubectl get pods
	kubectl get services
	@touch $@

create_wordpress_service.txt: wordpress-deployment.yaml
	kubectl create -f $< > $@
	kubectl get pods
	kubectl get services
	@touch $@

mysql-deployment.yaml:
	curl -sSL -O https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/mysql-deployment.yaml

wordpress-deployment.yaml:
	curl -sSL -O https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/wordpress-deployment.yaml
