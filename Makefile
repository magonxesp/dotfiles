.PHONY: release build

build:
	./gradlew build; \
	cp cli/build/libs/cli-all.jar bin/dotfiles.jar

release:
	./release.sh
