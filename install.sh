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
sleep "0.15"
printf "|  ___|                  /  ___| |        | | |\n"
sleep "0.15"
printf "| |____  ____ _ _ __ ___ \ \`--.| |__   ___| | |\n"
sleep "0.15"
printf "|  __\ \/ / _\` | '_ \` _ \ \`--. \ '_ \ / _ \ | |\n"
sleep "0.15"
printf "| |___>  < (_| | | | | | /\__/ / | | |  __/ | |\n"
sleep "0.15"
printf "\____/_/\_\__,_|_| |_| |_\____/|_| |_|\___|_|_|\n"
sleep "0.15"
printf "                                               \n"
printf "                                               \n"
printf "       _____          _        _ _             \n"
sleep "0.15"
printf "      |_   _|        | |      | | |            \n"
sleep "0.15"
printf "        | | _ __  ___| |_ __ _| | | ___ _ __   \n"
sleep "0.15"
printf "        | || '_ \/ __| __/ _\` | | |/ _ \ '__|  \n"
sleep "0.15"
printf "       _| || | | \__ \ || (_| | | |  __/ |     \n"
sleep "0.15"
printf "       \___/_| |_|___/\__\__,_|_|_|\___|_|     \n"
sleep "0.15"
printf "                                               \n"
sleep "0.15"
printf "                                               \n"
printf "${RESET}"




printf "${GREEN}"
printf "==================================================="
printf "             Installation de Python 🐍"
sleep "0.15"
printf "."
sleep "0.15"
printf "."
sleep "0.15"
printf "."
printf "==================================================="
printf "${RESET}"
printf "${BLUE}"

if which python3 > /dev/null; then
	printf "${GREEN}"
	printf "Python3 est deja installe"
	printf "${RESET}"
else
	sudo apt-get update
	sudo apt-get install python3
fi

printf "${GREEN}"
printf "==================================================="
printf "             Installation de Snap 👻"
sleep "0.15"
printf "."
sleep "0.15"
printf "."
sleep "0.15"
printf "."
printf "==================================================="
printf "${RESET}"
printf "${BLUE}"

if which snap > /dev/null; then
	printf "${GREEN}"
	printf "snap est deja installe"
	printf "${RESET}"
else
	sudo apt install snapd
fi

printf "${GREEN}"
printf "==================================================="
printf "             Installation d'Emote 😄"
sleep "0.15"
printf "."
sleep "0.15"
printf "."
sleep "0.15"
printf "."
printf "==================================================="
printf "${RESET}"
printf "${BLUE}"

if which emote > /dev/null; then
	printf "${GREEN}"
	printf "emote est deja installe"
	printf "${RESET}"
else
	sudo snap install emote
fi


printf "${GREEN}"
printf "==================================================="
printf "             Installation d'ExamShell 💻️"
sleep "0.15"
printf "."
sleep "0.15"
printf "."
sleep "0.15"
printf "."
printf "==================================================="
printf "${RESET}"
printf "${BLUE}"

mkdir $HOME/Documents/Scripts > /dev/null
git clone https://github.com/Hooks42/ExamShell_by_Hook.git $HOME/Documents/Scripts
sudo echo "alias examshel=\"$HOME/Documents/Scripts/Examshell_by_Hook/Examshell\"" > ~/.zshrc
printf "${GREEN}"
printf "Tout s'est bien installe 🔥"
printf "${RESET}"