bench: nginx.rotate mysql-slow.rotate
	~/bin/benchmarker --stage=prod --request-timeout=10s --initialize-request-timeout=60s

nginx.rotate:
	sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.old
	sudo systemctl reload nginx

nginx.log:
	sudo tail -f /var/log/nginx/access.log

nginx.alp:
	alp json \
		--sort sum -r \
		-m "/api/livestream/\w+/statistics,/api/user/\w+/statistics,/api/livestream/\w+/reaction,/api/livestream/\w+/livecomment,/api/livestream/\w+/livecomment/\w+/report,/api/live/stream/\w+,/api/livestream/\w+/enter,/api/livestream/\w+/exit,/api/livestream/\w+/moderate,/api/user/\w+/icon,/api/livestream/\w+/report,/api/livestream/\w+/ngwords,/api/user/\w+/theme,/api/livestream/\w+" \
		-o count,method,uri,min,avg,max,sum \
		< /var/log/nginx/access.log

mysql-slow.rotate:
	sudo mv /var/log/mysql/mysql-slow.log /var/log/mysql/mysql-slow.log.old && sudo mysqladmin flush-logs

mysql-slow.log:
	sudo tail -f /var/log/mysql/mysql-slow.log

mysql-slow.dump:
	sudo mysqldumpslow /var/log/mysql/mysql-slow.log

mysql-slow.digest:
	sudo pt-query-digest /var/log/mysql/mysql-slow.log

service.restart:
	sudo systemctl restart isupipe-ruby
service.log:
	sudo journalctl -u isupipe-ruby
mysql.sh:
	sudo mysql -uisucon -pisucon -D isupipe
