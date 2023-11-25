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
		-m "/api/livestream/\d+/statistics,/api/user/\w+/statistics,/api/user/\w+/livestream,/api/livestream/\d+/reaction,/api/livestream/\d+/livecomment,/api/livestream/\d+/livecomment/\d+/report,/api/live/stream/\d+,/api/livestream/\d+/enter,/api/livestream/\d+/exit,/api/livestream/\d+/moderate,/api/user/\w+/icon,/api/livestream/\d+/report,/api/livestream/\d+/ngwords,/api/user/\w+/theme,/api/livestream/\d+" \
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
