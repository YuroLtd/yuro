#!/bin/sh

# 获取flutter sdk目录
flutter_home=$FLUTTER_HOME

# 切换到sdk目录
cd ${flutter_home}

# 切换到stable
git checkout stable

# 执行doctor
flutter doctor

 切换yuro_cli版本
dart pub global deactivate yuro_cli

dart pub global activate --source path D:/github/yuro_kit/yuro_cli