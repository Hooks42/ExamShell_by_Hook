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
sleep "0.3"
printf "|  ___|                  /  ___| |        | | |\n"
sleep "0.3"
printf "| |____  ____ _ _ __ ___ \ \`--.| |__   ___| | |\n"
sleep "0.3"
printf "|  __\ \/ / _\` | '_ \` _ \ \`--. \ '_ \ / _ \ | |\n"
sleep "0.3"
printf "| |___>  < (_| | | | | | /\__/ / | | |  __/ | |\n"
sleep "0.3"
printf "\____/_/\_\__,_|_| |_| |_\____/|_| |_|\___|_|_|\n"
sleep "0.3"
printf "                                               \n"
printf "                                               \n"
printf "       _____          _        _ _             \n"
sleep "0.3"
printf "      |_   _|        | |      | | |            \n"
sleep "0.3"
printf "        | | _ __  ___| |_ __ _| | | ___ _ __   \n"
sleep "0.3"
printf "        | || '_ \/ __| __/ _\` | | |/ _ \ '__|  \n"
sleep "0.3"
printf "       _| || | | \__ \ || (_| | | |  __/ |     \n"
sleep "0.3"
printf "       \___/_| |_|___/\__\__,_|_|_|\___|_|     \n"
sleep "0.3"
printf "                                               \n"
sleep "0.3"
printf "                                               \n"
printf "${RESET}"




printf "${GREEN}"
printf "===================================================\n"
printf "             Installation de Python 🐍\n"
sleep "0.3"
printf "                       ."
sleep "0.3"
printf "."
sleep "0.3"
printf ".\n"
sleep "0.3"
printf "===================================================\n"
printf "${RESET}"
printf "${BLUE}"

if which python3 > /dev/null; then
	printf "${GREEN}"
	printf "\nPython3 est deja installe\n\n"
	printf "${RESET}"
else
	sudo apt-get update > /dev/null
	sudo apt-get install python3 > /dev/null
fi

printf "${GREEN}"
printf "===================================================\n"
printf "             Installation de Snap 👻\n"
sleep "0.3"
printf "                        ."
sleep "0.3"
printf "."
sleep "0.3"
printf ".\n"
sleep "0.3"
printf "===================================================\n"
printf "${RESET}"
printf "${BLUE}"

if which snap > /dev/null; then
	printf "${GREEN}"
	printf "\nsnap est deja installe\n\n"
	printf "${RESET}"
else
	sudo apt install snapd > /dev/null
fi

printf "${GREEN}"
printf "===================================================\n"
printf "             Installation d'Emote 😄\n"
sleep "0.3"
printf "                        ."
sleep "0.3"
printf "."
sleep "0.3"
printf ".\n"
sleep "0.3"
printf "===================================================\n"
printf "${RESET}"
printf "${BLUE}"

if which emote > /dev/null; then
	printf "${GREEN}"
	printf "\nemote est deja installe\n\n"
	printf "${RESET}"
else
	sudo snap install emote > /dev/null
fi


printf "${GREEN}"
printf "===================================================\n"
printf "             Installation d'ExamShell 💻️\n"
sleep "0.3"
printf "                        ."
sleep "0.3"
printf "."
sleep "0.3"
printf ".\n"
sleep "0.3"
printf "===================================================\n\n"
printf "${RESET}"
printf "${BLUE}"

mkdir $HOME/Documents/Scripts > /dev/null
git clone https://github.com/Hooks42/ExamShell_by_Hook.git $HOME/Documents/Scripts/ExamShell_by_Hook > /dev/null
echo "alias examshell=\"$HOME/Documents/Scripts/ExamShell_by_Hook/Examshell\"" | sudo tee -a ~/.zshrc
printf "${GREEN}"
printf "Tout s'est bien installe 🔥\n"
printf "Pour lancer ExamShell il suffit d'ouvrir un nouveau terminal et de taper examshell"
printf "${RESET}"