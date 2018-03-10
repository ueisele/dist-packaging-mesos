.PHONY: dist.tar.gz

dist.tar.gz:
	git ls-files | xargs tar czf env/dist.tar.gz

clean:
	if [ -e env/dist.tar.gz ] ; then rm env/dist.tar.gz ; fi