XCODEBUILD_PATH=/Applications/Xcode.app/Contents/Developer/usr/bin
XCODEBUILD=$XCODEBUILD_PATH/xcodebuild

$XCODEBUILD -project WorldWeatherOnline.xcodeproj -target "WorldWeatherOnline" -sdk "iphonesimulator" -configuration "Release" clean build
$XCODEBUILD -project WorldWeatherOnline.xcodeproj -target "WorldWeatherOnline" -sdk "iphoneos" -configuration "Release" clean build

lipo -create -output "build/WorldWeatherOnline.a" "build/Release-iphoneos/libWorldWeatherOnline.a" "build/Release-iphonesimulator/libWorldWeatherOnline.a"
