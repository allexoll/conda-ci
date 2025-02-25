 if [ $SKIP ]; then
    exit 0;
fi
if [ $OS_NAME = "windows" ]; then
    export PATH="$PATH:/c/ProgramData/Chocolatey/bin/"
    export PATH="$PATH:/c/Program Files/Git/usr/bin/"
fi
# Used in the scripts to locate other scripts.
export CI_SCRIPTS_PATH="$GITHUB_ACTION_PATH"

source $GITHUB_ACTION_PATH/common.sh
bash $GITHUB_ACTION_PATH/download_sdk.sh
bash $GITHUB_ACTION_PATH/install.sh
set -x
if [ $SCRIPT ]; then
    bash $SCRIPT
else
    bash $GITHUB_ACTION_PATH/script.sh
fi
if [ $? -eq 0 ]; then
    source $GITHUB_ACTION_PATH/after_success.sh
else
    source $GITHUB_ACTION_PATH/after_failure.sh
fi