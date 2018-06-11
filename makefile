APK_DIR=apkbuilding
GAME_DIR=huh
NAME=game

${GAME_DIR}/game.love:
	cd ${GAME_DIR}/ ; \
		make

${APK_DIR}/AndroidManifest.xml:
	#update your makefile
	false

apk: ${GAME_DIR}/game.love ${APK_DIR}/AndroidManifest.xml
		rm -rf ${APK_DIR}/love_decoded
		cd ${APK_DIR}/ ; \
			apktool d -fs -o love_decoded love-11.1-android.apk
		mkdir -p ${APK_DIR}/love_decoded/assets/
		mv ${GAME_DIR}/game.love ${APK_DIR}/love_decoded/assets/
		cp -f  ${APK_DIR}/apktool.yml ${APK_DIR}/love_decoded/apktool.yml
		cp -f  ${APK_DIR}/AndroidManifest.xml ${APK_DIR}/love_decoded/AndroidManifest.xml

		# rm ${APK_DIR}/love_decoded/res/drawable-mdpi/love.png
		# rm ${APK_DIR}/love_decoded/res/drawable-xxxhdpi/love.png
		# rm ${APK_DIR}/love_decoded/res/drawable-hdpi/love.png
		# rm ${APK_DIR}/love_decoded/res/drawable-xxhdpi/love.png
		# rm ${APK_DIR}/love_decoded/res/drawable-xhdpi/love.png

		# cp icons/mdpi.png ${APK_DIR}/love_decoded/res/drawable-mdpi/love.png
		# cp icons/hdpi.png ${APK_DIR}/love_decoded/res/drawable-xxxhdpi/love.png
		# cp icons/xhdpi.png ${APK_DIR}/love_decoded/res/drawable-hdpi/love.png
		# cp icons/xxhdpi.png ${APK_DIR}/love_decoded/res/drawable-xxhdpi/love.png
		# cp icons/xxxhdpi.png ${APK_DIR}/love_decoded/res/drawable-xhdpi/love.png

		cd ${APK_DIR}/ ; \
			apktool b -o ${NAME}_not_zipaligned.apk love_decoded
		#my alias is literally alias_name lmao
		cd ${APK_DIR}/ ; \
			jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore game.keystore ${NAME}_not_zipaligned.apk alias_name
		rm -rf ${APK_DIR}/love_decoded
		cd ${APK_DIR}/ ; \
			zipalign 4 ${NAME}_not_zipaligned.apk ${NAME}.apk
		rm -f ${APK_DIR}/${NAME}_not_zipaligned.apk
		@echo "update your manifest!!!"
		@echo ${APK_DIR}/${NAME}.apk
