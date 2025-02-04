#------------------------------------------------------------------------------
# set the $PATH variable (Windows cygwin, mingw) to call installed software,
# also has startup functions for installed software 
#------------------------------------------------------------------------------

# add Java to PATH
export JAVA_HOME="/c/Program Files/Java/jdk-21"
export PATH="${JAVA_HOME}/bin:${PATH}"

# add Maven path, Java system property {user.home} defines where mvn places .m2
# mvn does not understand xterm-256color in .mintty.rc to colorize output
# use mvn -B to avoid colors
export M2_HOME="$(cygpath ${HOMEPATH})/.m2"
export MAVEN_HOME="/c/opt/maven"
export PATH="${PATH}:${MAVEN_HOME}/bin"

# add Python path
export PYTHON_HOME="/c/Users/svgr2/AppData/Local/Programs/Python/Python312"
export PATH="${PATH}:${PYTHON_HOME}"
export PATH="${PATH}:${PYTHON_HOME}/Scripts"

# add Docker path
export DOCKER_HOME="/c/Program Files/Docker/Docker"
export PATH="${PATH}:${DOCKER_HOME}/resources/bin"

# add MySQL workbench path to find mysql client
export MYSQL_HOME="/c/Program Files/MySQL/MySQL Workbench 8.0 CE"
export PATH="${PATH}:${MYSQL_HOME}"

# add Qt paths
export QT_HOME="/c/opt/Qt6"
export PATH="${PATH}:${QT_HOME}/Tools/mingw1120_64/bin" # g++ to run Qt Makefiles
export PATH="${PATH}:${QT_HOME}/6.2.4/mingw_64/bin"     # link Qt*.dll's

# add VirtualBox, Vagrant paths
export PATH="${PATH}:/c/Program Files/Oracle/VirtualBox"
# export VAGRANT_HOME="${HOME}/.vagrant.d"
# export PATH="${PATH}:/opt/vagrant/bin"

# add VS Code paths
export VSCODE_HOME="/c/Users/svgr2/AppData/Local/Programs/Microsoft VS Code"
export VSCODE_CONFIG="/c/Users/svgr2/AppData/Roaming/Code/User"
export PATH="${PATH}:${VSCODE_HOME}"
# 
# VSCode does not work with cygwin git client, use https://git-scm.com
export PATH="${PATH}:/c/Program Files (x86)/Git/bin"
# 
# start VS Code, e.g. "code ."
function code() {
    "${VSCODE_HOME}/code.exe" "$*" >/dev/null 2>/dev/null &
    # 
    # # open explorer with VSCode global settings.json
    # explorer "${APPDATA}\\Code\\User";
    # # open VSCode project files and caches
    # explorer "${APPDATA}\\Code\\User\\workspaceStorage";
    # explorer "${APPDATA}\\Code\\CachedData";
    # 
    # export VSCODE_CACHE="/c/Users/svgr2/AppData/Roaming/Code/CachedData"
    # also: $/c/Users/svgr2/AppData/Roaming/Code/Backups,
    # Linux: $HOME/.config/Code/Backups,
    # macOS: $HOME/Library/Application Support/Code/Backups
}

# start eclipse assuming workspace in parent directory
function eclipse() {
    "/c/opt/eclipse/eclipse.exe" "-data .." "$*" >/dev/null 2>/dev/null &
}

# start StarUML, e.g. "staruml Customer.mdj"
function staruml() {
    "/c/Program Files/StarUML/StarUML.exe" "$*" &
}

# start StarUML, e.g. "staruml Customer.mdj"
function sublime() {
    "/c/opt/sublime/sublime_text.exe" "$*" &
}

# start Chrome web browser with local file or directory, e.g. "chrome doc/index.html"
function chrome() {
    # echo $*
    "/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" "$path" &
}

# show text files with CR/LF (Windows) line endings
function crlf() {
    if [ -z "$*" ]; then dir="."; else dir="$*"; fi
    find ${dir} -not -type d -exec file "{}" ";" | grep CRLF | cut -d: -f1
}

# replace CR/LF (Windows) with newline (Unix) line endings
function cr2lf() {
    for f in $(crlf "$*"); do
        echo "-- converting CRLF to '\n' in --> " ${f}
        tmpfile=$(basename ${f})
        cat ${f} | sed 's/\r$//' > /tmp/${tmpfile}
        mv /tmp/${tmpfile} ${f}
    done
}