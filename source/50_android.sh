export PATH

export ANDROID_HOME="$HOME/Library/Android/sdk"
PATH="$(path_remove $ANDROID_HOME/emulator):$ANDROID_HOME/emulator"
PATH="$(path_remove $ANDROID_HOME/tools):$ANDROID_HOME/tools"
PATH="$(path_remove $ANDROID_HOME/tools/bin):$ANDROID_HOME/tools/bin"
PATH="$(path_remove $ANDROID_HOME/platform-tools):$ANDROID_HOME/platform-tools"
