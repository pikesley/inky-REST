run:
	foreman start

install:
	sudo pip install -r requirements.txt

lint:
	flake8 *py

clean:
	find . -name "*pyc" -delete

foreman: install
	rm -fr /tmp/inky-rest
	mkdir /tmp/inky-rest
	foreman export -a inky-rest -u pi systemd /tmp/inky-rest
	sudo rsync -av /tmp/inky-rest/ /etc/systemd/system/
	sudo systemctl daemon-reload
	sudo systemctl restart inky-rest.target
