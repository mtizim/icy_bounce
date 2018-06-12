all: game.love
	#empty

game.love: $(shell find -type f)
		rm -rf pak/
		rm -f game.love
		mkdir -p pak/
		mkdir -p pak/dependencies
		mkdir -p pak/game
		mkdir -p pak/trails
		# mkdir -p pak/menus
		mkdir -p pak/misc
		cp -r dependencies/* pak/dependencies/
		cp -r game/* pak/game/
		cp -r trails/* pak/trails/
		# cp -r menus/* pak/menus/
		cp -r misc/* pak/misc/
		cp -f *.png pak/ >/dev/null || :
		cp -f *.lua pak/ >/dev/null || :
		cp -f *.otf pak/ >/dev/null || :
		cd pak/ ; \
		zip -9 -r $(shell pwd)/game.love .
		rm -rd pak/