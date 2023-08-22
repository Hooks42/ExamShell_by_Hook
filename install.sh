RESET="\e[1;0m"
BLACK="\e[1;30m"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
MAGENTA="\e[1;35m"
CYAN="\e[1;36m"
WHITE="\e[1;37m"

printf "${GREEN}"
printf " _____                    _____ _          _ _ \n"
sleep 0.3
printf "|  ___|                  /  ___| |        | | |\n"
sleep 0.3
printf "| |____  ____ _ _ __ ___ \ \`--.| |__   ___| | |\n"
sleep 0.3
printf "|  __\ \/ / _\` | '_ \` _ \ \`--. \ '_ \ / _ \ | |\n"
sleep 0.3
printf "| |___>  < (_| | | | | | /\__/ / | | |  __/ | |\n"
sleep 0.3
printf "\____/_/\_\__,_|_| |_| |_\____/|_| |_|\___|_|_|\n"
sleep 0.3
printf "                                               \n"
printf "                                               \n"
printf "       _____          _        _ _             \n"
sleep 0.3
printf "      |_   _|        | |      | | |            \n"
sleep 0.3
printf "        | | _ __  ___| |_ __ _| | | ___ _ __   \n"
sleep 0.3
printf "        | || '_ \/ __| __/ _\` | | |/ _ \ '__|  \n"
sleep 0.3
printf "       _| || | | \__ \ || (_| | | |  __/ |     \n"
sleep 0.3
printf "       \___/_| |_|___/\__\__,_|_|_|\___|_|     \n"
sleep 0.3
printf "                                               \n"
sleep 0.3
printf "                                               \n"
printf "${RESET}"




printf "${GREEN}"
printf "===================================================\n"
printf "             Installation de Python 🐍\n"
sleep 0.3
printf "                       ."
sleep 0.3
printf "."
sleep 0.3
printf ".\n"
sleep 0.3
printf "===================================================\n"
printf "${RESET}"
printf "${BLUE}"

if which python3 > /dev/null; then
	printf "${GREEN}"
	printf "\nPython3 est deja installe\n\n"
	printf "${RESET}"
else
	sudo apt-get update > /dev/null
	if [ $? -ne 0 ]; then
		exit 1
	fi
	sudo apt-get install python3 > /dev/null
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi

printf "${GREEN}"
printf "===================================================\n"
printf "             Installation de Snap 👻\n"
sleep 0.3
printf "                        ."
sleep 0.3
printf "."
sleep 0.3
printf ".\n"
sleep 0.3
printf "===================================================\n"
printf "${RESET}"
printf "${BLUE}"

if which snap > /dev/null; then
	printf "${GREEN}"
	printf "\nsnap est deja installe\n\n"
	printf "${RESET}"
else
	sudo apt install snapd > /dev/null
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi

printf "${GREEN}"
printf "===================================================\n"
printf "             Installation d'Emote 😄\n"
sleep 0.3
printf "                        ."
sleep 0.3
printf "."
sleep 0.3
printf ".\n"
sleep 0.3
printf "===================================================\n"
printf "${RESET}"
printf "${BLUE}"

if which emote > /dev/null; then
	printf "${GREEN}"
	printf "\nemote est deja installe\n\n"
	printf "${RESET}"
else
	sudo snap install emote > /dev/null
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi

printf "${GREEN}"
printf "===================================================\n"
printf "             Installation de pip 🚬\n"
sleep 0.3
printf "                        ."
sleep 0.3
printf "."
sleep 0.3
printf ".\n"
sleep 0.3
printf "===================================================\n"
printf "${RESET}"
printf "${BLUE}"

if which pip > /dev/null; then
	printf "${GREEN}"
	printf "\npip est deja installe\n\n"
	printf "${RESET}"
else
	sudo apt-get install pip > /dev/null
	if [ $? -ne 0 ]; then
		exit 1
	fi
fi

printf "${GREEN}"
printf "===================================================\n"
printf "             Installation de PYinstaller 🔱\n"
sleep 0.3
printf "                        ."
sleep 0.3
printf "."
sleep 0.3
printf ".\n"
sleep 0.3
printf "===================================================\n\n"
if which pyinstaller > /dev/null; then
	printf "${GREEN}"
	printf "\nPYinstaller est deja installe\n\n"
	printf "${RESET}"
else
	pip install pyinstaller > /dev/null
	echo "export PATH=\"$PATH:${HOME}/.local/bin\"" | sudo tee -a ~/.zshrc > /dev/null
	if [ $? -ne 0 ]; then
		exit 1
	fi
	source ~/.zshrc
fi
printf "${RESET}"

printf "${GREEN}"
printf "===================================================\n"
printf "             Installation d'ExamShell 💻️\n"
sleep 0.3
printf "                        ."
sleep 0.3
printf "."
sleep 0.3
printf ".\n"
sleep 0.3
printf "===================================================\n\n"
printf "${RESET}"
printf "${BLUE}"

if [ ! -d "${HOME}/Documents/Scripts" ]; then
	mkdir ${HOME}/Documents/Scripts
fi
if [ ! -d "${HOME}/Documents/Scripts/ExamShell_by_Hook" ]; then
	git clone https://github.com/Hooks42/ExamShell_by_Hook.git "${HOME}/Documents/Scripts/ExamShell_by_Hook" > /dev/null
else
	rm -rf "${HOME}/Documents/Scripts/ExamShell_by_Hook"
	git clone https://github.com/Hooks42/ExamShell_by_Hook.git "${HOME}/Documents/Scripts/ExamShell_by_Hook" > /dev/null
fi

pyinstaller --onefile "${HOME}/Documents/Scripts/ExamShell_by_Hook/main.py" > /dev/null
mv "./dist/main" "./dist/ExamShell"
cp "./dist/ExamShell" "${HOME}/Documents/Scripts/ExamShell_by_Hook"
rm -rf "./dist/" "./build/" "${HOME}/Documents/Scripts/ExamShell_by_Hook/main.py" "./main.spec" "${HOME}/Documents/Scripts/ExamShell_by_Hook/install.sh"
chmod -R 777 "${HOME}/Documents/Scripts/ExamShell_by_Hook/.subjects"
echo "alias examshell=\"cd ${HOME}/Documents/Scripts/ExamShell_by_Hook ; ${HOME}/Documents/Scripts/ExamShell_by_Hook/ExamShell\"" | sudo tee -a ~/.zshrc > /dev/null
if [ $? -ne 0 ]; then
	exit 1
fi
source ~/.zshrc
printf "${GREEN}"
printf "Tout s'est bien installe 🔥\n"
printf "Pour lancer ExamShell il suffit de taper examshell\n\n"
printf "${RESET}"
printf "${CYAN}"
printf "Ce terminal va se fermer dans:\n"
printf "5\n"
sleep 1
printf "4\n"
sleep 1
printf "3\n"
sleep 1
printf "2\n"
sleep 1
printf "1\n"
printf "${RESET}"
exit 1