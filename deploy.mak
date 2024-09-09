deploy:
	echo $(date)
	flutter build web --release --base-href=/web/ && \
	cp -a /home/astra/AndroidStudioProjects/kanooniha/build/web/. /home/astra/Documents/kanoon/ && \
	cd /home/astra/Documents/kanoon/ && git add . && \
	git commit -m "add new features" && \
	git push origin main


deployMac:
	echo $(date)
	flutter build web --release --web-renderer canvaskit && \
	cp -a /Users/mohamad/flutterProjects/KanoonihaApp/build/web/. /Users/mohamad/Documents/kanoon/ && \
	cd /Users/mohamad/Documents/kanoon/ && git add . && \
	git commit -m "add new features" && \
	git push origin main