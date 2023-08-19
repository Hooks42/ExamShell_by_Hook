#Texte en gras : \033[1m
#Texte en italique : \033[3m
#Texte souligné : \033[4m
#Texte barré : \033[9m
#Couleurs de texte : \033[30m (noir), \033[31m (rouge), \033[32m (vert), \033[33m (jaune), \033[34m (bleu), etc.
#Couleurs de fond : \033[40m (noir), \033[41m (rouge), \033[42m (vert), \033[43m (jaune), \033[44m (bleu), etc.
#Reset : \033[0m

import time
import random
import os
import shutil
import subprocess
import glob
import threading
import sys

RED = "\033[1;31m"
GREEN = "\033[1;32m"
YELLOW = "\033[1;33m"
BLUE = "\033[1;34m"
PURPLE = "\033[1;35m"
CYAN = "\033[1;36m"
WHITE = "\033[1;37m"
RESET = "\033[0m"

TIMER_OPTION = True
EXAM_TIME = 3600 * 4

exam_time = 0
exam_time_lock = threading.Lock()
share_timer = 0
share_timer_lock = threading.Lock()
stop_thread = False
timesup = False
no_exit = False

"""
======================================================================================

Cette fonction sert a afficher le logo d'ExamShell avec un sleep entre chaque affichage
pour l'animation

======================================================================================

"""
def ft_Hello():
    print(GREEN)
    print("  _____                       ____  _          _ _ ")
    time.sleep(0.2)
    print(" | ____|_  ____ _ _ __ ___   / ___|| |__   ___| | |")
    time.sleep(0.2)
    print(" |  _| \ \/ / _` | '_ ` _ \  \___ \| '_ \ / _ \ | |")
    time.sleep(0.2)
    print(" | |___ >  < (_| | | | | | |  ___) | | | |  __/ | |")
    time.sleep(0.2)
    print(" |_____/_/\_\__,_|_| |_| |_| |____/|_| |_|\___|_|_|")
    time.sleep(0.2)
    print("                                                   ")
    print(RESET)

"""

======================================================================================

Cette fonction sert a afficher Le menu de selection de niveau

======================================================================================

"""

def ft_announce():
    print(BLUE)
    print("Bienvenue dans Exam Shell !\n")
    print("Commence par me dire ce que tu souhaites travailler 🔥\n")
    print(PURPLE)
    print("1. Palier 1 ✅")
    print("2. Palier 2 🚫")
    print("3. Palier 3 ⛔️")
    print("4. Palier 4 📛")
    print("5. Exam Complet 🔱")
    print("\n")

"""

======================================================================================

Cette fonction sert a comptabiliser le choix du niveau et a diriger l'utilisateur
vers le niveau adapte

======================================================================================

"""

def ft_choice():
    ft_announce()
    choix = 0
    chance = 2
    while choix <= 0 or choix > 5:
        try: choix = int(input())
        except ValueError:
            continue
        except EOFError:
            continue        
        if choix <= 0 or choix > 5:
            print(RESET, RED)
            print("S'il te plait fais un effort choisis entre le choix 1 et choix 5 😤")
            print(RESET, GREEN)
            print("aller je te laisse une ", chance, "eme chance 😋")
            chance += 1
            ft_announce()
    return choix

"""

======================================================================================

Cette fonction sert a appeller le bon palier

======================================================================================

"""

def ft_start_palier():
    choice = ft_choice()
    if choice == 1:
        ft_palier1()
    elif choice == 2:
        ft_palier2()
    elif choice == 3:
        ft_palier3()
    elif choice == 4:
        ft_palier4()
    elif choice == 5:
        ft_full_exam()


"""

======================================================================================

Cette fonction sert a creer le dossier exam sur le bureau, qui lui meme contiendra
le dossier Rendu, et Subject

======================================================================================

"""

def ft_init_exam():
	Desktop_path = os.path.expanduser("~/Desktop")
	Folder_name = "Exam"
	Folder_path = os.path.join(Desktop_path, Folder_name)
	if os.path.exists(Folder_path):
		shutil.rmtree(Folder_path)
	os.makedirs(Folder_path)
	print(RESET, GREEN)
	print("Le Dossier d'exam a bien ete creer sur le Bureau 🔥")
	Desktop_path = os.path.expanduser("~/Desktop/Exam")
	Folder_name = "Subjects"
	Folder_path = os.path.join(Desktop_path, Folder_name)
	os.makedirs(Folder_path)
	Desktop_path = os.path.expanduser("~/Desktop/Exam")
	Folder_name = "Rendu"
	Folder_path = os.path.join(Desktop_path, Folder_name)
	os.makedirs(Folder_path)
	time.sleep(0.8)

"""

======================================================================================

Cette fonction sert a Recuperer sur l'exercice en cours

- Son nom
- le path du nouveau dossier qui contiendra le sujet

======================================================================================

"""

def ft_get_subjects(subject_session, level):
    subject_name = subject_session[level]
    Desktop_path = os.path.expanduser("~/Desktop/Exam/Subjects")
    new_dir = os.path.join(Desktop_path, subject_name)
    return new_dir, subject_session, subject_name

"""

======================================================================================

Cette fonction sert a creer le nouveau dossier qui portera le nom de 
l'exercice en cours.
Elle s'occupe ensuite de copier le .txt de l'exo dans ce dossier
Elle renvoie le nom de l'exercice pour l'utiliser dans Recap()

======================================================================================

"""

def ft_cpy_subjects(subject_session, level, palier):
    new_dir, subject, subject_name = ft_get_subjects(subject_session, level)
    if not os.path.exists(new_dir):
        os.makedirs(new_dir)
    else:
        return subject_name
    src = os.path.join(".subjects/palier" + palier, subject_name, subject_name + ".txt")
    dest = os.path.expanduser("~/Desktop/Exam/Subjects")
    dest = os.path.join(dest, subject_name)
    shutil.copy2(src, dest)
    return subject_name

"""

======================================================================================

Cette fonction sert a creer un tableau de 5 exercices au prealables.
Les exercices sont tires au sorts avant de commencer et non pas au fur et a mesure
ce qui sera plus simple pour garder en memoire le nom des exos passe

======================================================================================

"""

def ft_create_session_subject(subjects):
	i = 0
	subject_session = [""] * 5
	while i < 5:
		subject_session[i] = random.choice(subjects)
		i += 1
	return subject_session

"""

======================================================================================

Cette fonction sert a verifier si mon tableau de 5 exos ne contient pas 2 fois le meme
En effet la fonction de tirage au sort est avec remise, donc on doit verifier si
deux fois le meme exo n'est pas sorti

======================================================================================

"""

def ft_verif_double(subject_session, token):
    if token == 0:
        j = 1
        i = 0
        while i < 5:
            while j < 5:
                if subject_session[i] == subject_session[j]:
                    return False
                j += 1
            i += 1
            j = i + 1
        return True
    elif token == 1:
        j = 1
        i = 0
        while i < 11:
            while j < 11:
                if subject_session[i] == subject_session[j]:
                    return False
                j += 1
            i += 1
            j = i + 1
        return True


def ft_configure_timer_option():
    global TIMER_OPTION
    print(PURPLE + "\nAvant de commencer dis moi si tu veux activer ou non le timer entre chaque correction fausse 😊\n")
    print("Ca te permet de travailler ta " + GREEN + "rigueur" + PURPLE + " en te punissant par le fait de te donner du temps entre chaque correction si tu as faux 👊\n")
    print(YELLOW + "🔺Cette option est obligatoire a 42 lors des vrais examens !🔺\n")
    choix = 0
    print(PURPLE + "1. ✅ Evidemment que je veux !")
    print("2. ❌ Non je suis pas du genre patient ..\n")
    while (choix <= 0 or choix > 2):
        try:
            choix = int(input())
        except ValueError:
            continue
        except EOFError:
            continue
    if choix == 1:
        TIMER_OPTION = True
    else:
        TIMER_OPTION = False
    ft_configure_exam_time()

"""

======================================================================================

Cette fonction sert a s'occuper du Palier1 des exercices.

- Elle s'occupe de creer un tableau qui contient toute la liste d'exos pour ce palier

- Elle s'occupe de creer un tableau de 5 exos

- Elle s'occupe d'afficher le recap

- Elle s'occupe d'appeller la fonction qui servira de prompt

======================================================================================

"""

def ft_palier1():
    ft_init_exam()
    palier = "1"
    current_grade = 0
    retry = 0
    level = 0
    historic = [""] * 0
    is_timer_runing = False

    ft_configure_timer_option()
    print(RESET, BLUE)
    print("C'est parti pour le palier 1 Bon courage ! 🔥", RESET)
    time.sleep(0.8)
    print(YELLOW + "\n💥 Attention : Toutes Bibliotheques inclues doivent etre utilisees sinon ce sera compris comme faux a la correction 💥\n")
    print(PURPLE + "Appuie sur Entree pour continuer 😋")
    stop = False
    while not stop == True:
        try:
            input()
            stop = True
        except ValueError:
            continue
        except EOFError:
            continue
    thread_exam_time.start()
    time.sleep(0.8)
    subjects = ["first_word", "fizzbuzz", "ft_putstr", "ft_strcpy", "ft_strlen", "ft_swap", "repeat_alpha",
                "rev_print", "rot_13", "rotone", "search_and_replace", "ulstr"]
    subject_session = ft_create_session_subject(subjects)
    while ft_verif_double(subject_session, 0) == False:
        subject_session = ft_create_session_subject(subjects)
    while level is not None and level < int(5):
        level, current_grade, historic, is_timer_runing = ft_recap(subject_session, level, current_grade, historic, retry, palier, 0, is_timer_runing)
    ft_recap(subject_session, level, current_grade, historic, retry, palier, 0, is_timer_runing)

def ft_palier2():
    ft_init_exam()
    palier = "2"
    current_grade = 0
    retry = 0
    level = 0
    historic = [""] * 0
    is_timer_runing = False

    ft_configure_timer_option()
    print(RESET, BLUE)
    print("C'est parti pour le palier 2 Bon courage ! 🔥", RESET)
    time.sleep(0.8)
    print(YELLOW + "\n💥 Attention : Toutes Bibliotheque inclues doivent etre utilisee sinon sera compris comme faux a la correction 💥\n")
    print(PURPLE + "Appuie sur Entree pour continuer 😋")
    stop = False
    while not stop == True:
        try:
            input()
            stop = True
        except ValueError:
            continue
        except EOFError:
            continue
    thread_exam_time.start()
    time.sleep(0.8)
    subjects = ["alpha_mirror", "camel_to_snake", "do_op", "ft_atoi", "ft_strcmp", "ft_strdup",
                "ft_strrev", "inter", "last_word", "max", "snake_to_camel", "union", "wdmatch"]
    subject_session = ft_create_session_subject(subjects)
    while ft_verif_double(subject_session, 0) == False:
        subject_session = ft_create_session_subject(subjects)
    while level is not None and level < int(5):
        level, current_grade, historic, is_timer_runing = ft_recap(subject_session, level, current_grade, historic, retry, palier, 0, is_timer_runing)
    ft_recap(subject_session, level, current_grade, historic, retry, palier, 0, is_timer_runing)


def ft_palier3():
    ft_init_exam()
    palier = "3"
    current_grade = 0
    retry = 0
    level = 0
    historic = [""] * 0
    is_timer_runing = False

    ft_configure_timer_option()
    print(RESET, BLUE)
    print("C'est parti pour le palier 3 Bon courage ! 🔥", RESET)
    time.sleep(0.8)
    print(YELLOW + "\n💥 Attention : Toutes Bibliotheque inclues doivent etre utilisee sinon sera compris comme faux a la correction 💥\n")
    print(PURPLE + "Appuie sur Entree pour continuer 😋")
    stop = False
    while not stop == True:
        try:
            input()
            stop = True
        except ValueError:
            continue
        except EOFError:
            continue
    thread_exam_time.start()
    time.sleep(0.8)
    subjects = ["epur_str", "expand_str", "ft_range", "ft_rrange", "hidenp", "print_hex", "rstr_capitalizer",
                "str_capitalizer", "tab_mult"]
    subject_session = ft_create_session_subject(subjects)
    while ft_verif_double(subject_session, 0) == False:
        subject_session = ft_create_session_subject(subjects)
    while level is not None and level < int(5):
        level, current_grade, historic, is_timer_runing = ft_recap(subject_session, level, current_grade, historic, retry, palier, 0, is_timer_runing)
    ft_recap(subject_session, level, current_grade, historic, retry, palier, 0, is_timer_runing)

def ft_palier4():
    ft_init_exam()
    palier = "4"
    current_grade = 0
    retry = 0
    level = 0
    historic = [""] * 0
    is_timer_runing = False

    ft_configure_timer_option()
    print(RESET, BLUE)
    print("C'est parti pour le palier 4 Bon courage ! 🔥", RESET)
    time.sleep(0.8)
    print(YELLOW + "\n💥 Attention : Toutes Bibliotheque inclues doivent etre utilisee sinon sera compris comme faux a la correction 💥\n")
    print(PURPLE + "Appuie sur Entree pour continuer 😋")
    stop = False
    while not stop == True:
        try:
            input()
            stop = True
        except ValueError:
            continue
        except EOFError:
            continue
        stop = True
    thread_exam_time.start()
    time.sleep(0.8)
    subjects = ["ft_itoa", "ft_split", "rev_wstr", "rostring", "sort_int_tab"]
    subject_session = ft_create_session_subject(subjects)
    while ft_verif_double(subject_session) == False:
        subject_session = ft_create_session_subject(subjects)
    while level is not None and level < int(5):
        level, current_grade, historic, is_timer_runing = ft_recap(subject_session, level, current_grade, historic, retry, palier, 0, is_timer_runing, is_timer_runing)
    ft_recap(subject_session, level, current_grade, historic, retry, palier, 0, is_timer_runing)


def ft_full_exam():
    ft_init_exam()
    palier = "5"
    current_grade = 0
    retry = 0
    level = 0
    historic = [""] * 0
    is_timer_runing = False

    ft_configure_timer_option()
    print(RESET, BLUE)
    print("C'est parti pour une session complete d'exam Bon courage ! 🔥", RESET)
    time.sleep(0.8)
    print(YELLOW + "\n💥 Attention : Toutes Bibliotheque inclues doivent etre utilisee sinon sera compris comme faux a la correction 💥\n")
    print(PURPLE + "Appuie sur Entree pour continuer 😋")
    stop = False
    while not stop == True:
        try:
            input()
            stop = True
        except ValueError:
            continue
        except EOFError:
            continue
    thread_exam_time.start()
    time.sleep(0.8)
    subjects_1 = ["first_word", "fizzbuzz", "ft_putstr", "ft_strcpy", "ft_strlen", "ft_swap", "repeat_alpha",
                "rev_print", "rot_13", "rotone", "search_and_replace", "ulstr"]
    subjects_2 = ["alpha_mirror", "camel_to_snake", "do_op", "ft_atoi", "ft_strcmp", "ft_strdup",
                "ft_strrev", "inter", "last_word", "max", "snake_to_camel", "union", "wdmatch"]
    subjects_3 = ["epur_str", "expand_str", "ft_range", "ft_rrange", "hidenp", "print_hex", "rstr_capitalizer",
                "str_capitalizer", "tab_mult"]
    subjects_4 = ["ft_itoa", "ft_split", "rev_wstr", "rostring", "sort_int_tab"]
    subject_session = ft_create_full_session_subjects(subjects_1, subjects_2, subjects_3, subjects_4)
    while ft_verif_double(subject_session, 1) == False:
        subject_session = ft_create_full_session_subjects(subjects_1, subjects_2, subjects_3, subjects_4)
    while level is not None and level < int(11):
        if level < 3:
            palier = "1"
        elif level < 6:
            palier = "2"
        elif level < 9:
            palier = "3"
        elif level < 11:
            palier = "4"
        level, current_grade, historic, is_timer_runing = ft_recap(subject_session, level, current_grade, historic, retry, palier, 1, is_timer_runing)
    ft_recap(subject_session, level, current_grade, historic, retry, palier, 1, is_timer_runing)


def ft_create_full_session_subjects(subjects_1, subjects_2, subjects_3, subjects_4):
    i = 0
    subject_session = [""] * 11
    while i < 3:
        subject_session[i] = random.choice(subjects_1)
        i += 1
    while i < 6:
        subject_session[i] = random.choice(subjects_2)
        i += 1
    while i < 9:
        subject_session[i] = random.choice(subjects_3)
        i += 1
    while i < 11:
        subject_session[i] = random.choice(subjects_4)
        i += 1
    return subject_session


"""

======================================================================================

Cette fonction sert a afficher toutes les infos importantes pour la bonne comprehension
du script

======================================================================================

"""

def ft_recap(subject_session, level, current_grade, historic, retry, palier, token, is_timer_runing):
    global no_exit
    i = 0
    t0_lvl = level
    subject_name = "0"
    if not current_grade == 100:
        subject_name = ft_cpy_subjects(subject_session, level, palier)
    print(GREEN)
    print("=======================================================================")
    print(RESET, PURPLE)
    print("Note Actuelle: ", GREEN, current_grade, PURPLE, " / 100\n")
    if not current_grade == 100:
        print("  Niveau", GREEN, level, PURPLE, ":")
    else:
        print("  Niveau", GREEN, level - 1, PURPLE, ":")
    historic, retry = ft_historic(subject_session, historic, retry, level, subject_name, token, is_timer_runing)
    no_exit = False
    if current_grade == 100:
        print(CYAN + "\n\n🔥 Bah voila t'es juste trop fort en fait 💯 🔥")
        os._exit(0)
    if token == 0:
        print("\n\n\n\nExercice: ", GREEN, subject_name, PURPLE, "pour", GREEN, "20", PURPLE, "points, essai:", YELLOW, retry, PURPLE, "\n")
    elif token == 1:
        if current_grade <= 99:
            print("\n\n\n\nExercice: ", GREEN, subject_name, PURPLE, "pour", GREEN, "09", PURPLE, "points, essai:", YELLOW, retry, PURPLE, "\n")
        else:
                print("\n\n\n\nExercice: ", GREEN, subject_name, PURPLE, "pour", GREEN, "10", PURPLE, "points, essai:", YELLOW, retry, PURPLE, "\n")      
    print("Localisation du Sujet:", GREEN + "\t~/Desktop/Exam/Subjects/" + subject_name + "/" + subject_name + ".txt", PURPLE)
    print("Dossier de rendu:", RED + "\t~/Desktop/Exam/Rendu/" + subject_name + "/")
    ft_print_exam_time_left()
    print("\n\n" + GREEN + "=======================================================================")
    print(PURPLE + "Tout est pret ! 😸. Quand tu as fini et que tu es SUR,")
    print("Utilise la commande " + GREEN + "grademe " + PURPLE + "pour te faire corriger 🔥")
    print("Si tu en as marre 😥, tu peux quitter en utilisant la commande " + GREEN + "finish")
    print(PURPLE + "Je te souhaite bon courrage 😁 tu vas y arriver 🔱")
    level, is_timer_runing = ft_prompt(subject_name, palier, level, retry, is_timer_runing)
    if level > t0_lvl:
        if token == 0:
            current_grade += 20
        else:
            if level < 11:
                current_grade += 9
            else:
                current_grade += 10
    return level, current_grade, historic, is_timer_runing


def ft_historic(subject_session, historic, retry, level, subject_name, token, is_timer_runing):
    if is_timer_runing == False and no_exit == False:
        if token == 0:
            if level < 5:
                historic.append(subject_session[level])
            last_subject = subject_session[4]
        else:
            if level < 11:
                historic.append(subject_session[level])
            last_subject = subject_session[10]


    if len(historic) == 1:
        if token == 0:
            print(RESET, YELLOW, "  ", retry, ":", GREEN, subject_session[0], PURPLE, "Pour 20 points potentiels ", end="")
            print("(", CYAN, "En cours", PURPLE, ")")
        else:
                print(RESET, YELLOW, "  ", retry, ":", GREEN, subject_session[0], PURPLE, "Pour 09 points potentiels ", end="")
                print("(", CYAN, "En cours", PURPLE, ")")
    else:
        i = 0
        while i < len(historic):
            if token == 0:
                print(RESET, YELLOW, "  ", retry, ":", GREEN, historic[i], PURPLE, "Pour 20 points potentiels ", end="")


            else:
                if historic[i] != last_subject:
                    print(RESET, YELLOW, "  ", retry, ":", GREEN, historic[i], PURPLE, "Pour 09 points potentiels ", end="")
                else:
                    print(RESET, YELLOW, "  ", retry, ":", GREEN, historic[i], PURPLE, "Pour 10 point potentiel ", end="")


            if token == 0:
                if i == (len(historic) - 1) and level < 5:
                    print("(", CYAN, "En cours", PURPLE, ")")
                    return historic, retry
                elif level == 5 and i == (len(historic) - 1):
                    print("(", GREEN, "Success", PURPLE, ")")
                    return historic, retry


            else:
                if i == (len(historic) - 1) and level < 11:
                    print("(", CYAN, "En cours", PURPLE, ")")
                    return historic, retry
                elif level == 11 and i == (len(historic) - 1):
                    print("(", GREEN, "Success", PURPLE, ")")
                    return historic, retry


            if historic[i] == historic[i + 1]:
                print("(", RED, "Failure", PURPLE, ")")
                retry += 1

            elif not historic[i] == historic[i + 1]:
                print("(", GREEN, "Success", PURPLE, ")")
                if not level == 10:
                    retry = 0
            i += 1
    return historic, retry

        




"""

======================================================================================

Cette fonction sert a afficher le prompt en attente d'une commande,

-grademe pour se faire corriger

-finish pour quitter la session d'exam

======================================================================================

"""

def ft_prompt(subject_name, palier, level, retry, is_timer_runing):
    prompt = ""
    t0_lvl = level
    while not (prompt == "grademe" or prompt == "finish" or prompt == "nnext" or prompt == "debug" or prompt == "debug_time"):
          print(YELLOW + "examshell" + ">" + GREEN, end=" ")
          prompt = str(input())
    if prompt == "finish":
        ft_exit()
    elif prompt == "grademe":
        if ft_access_timer() == True:
            level = ft_recap_grade(subject_name, palier, level, retry)
            is_timer_runing = False
        else:
            is_timer_runing = True
    elif prompt == "nnext":
        level+=1
    elif prompt == "debug":
        ft_run_sh(subject_name, palier)
        print("Appuie sur entree pour effacer les fichiers :)")
        stop = False
        while not stop == True:
            try:
                input()
            except ValueError:
                continue
            except EOFError:
                continue
            stop = True
        ft_clear_dossier(subject_name, palier)
    elif prompt == "debug_time":
        global exam_time
        exam_time_lock.acquire()
        exam_time -= 1790
        exam_time_lock.release()

    return level, is_timer_runing
    

"""

======================================================================================

Cette fonction sert a afficher les messages d'attente, de succes ou d'echec
et appelle la fonction de correction des exos

======================================================================================

"""
       
def ft_recap_grade(subject_name, palier, level, retry):
    i = 0
    j = 0
    nombre = random.randint(4, 12)
    print(PURPLE + "\nS'il te plait soit " + GREEN + "Patient " + PURPLE + ", ca", end=" ")
    print(GREEN + "peut " + PURPLE + "prendre quelques minutes...\n")
    print(YELLOW + "10 secondes est rapide, 30 secondes est attendu, 3 minutes est un maximum")
    while i < nombre:
        print(PURPLE + "waiting", end="")
        while j < 3:
            print(".", end="", flush=True)
            time.sleep(0.4)
            j += 1
        time.sleep(0.8)
        print("\n")
        i += 1
        j = 0
    time.sleep(0.3)
    if not ft_grade(subject_name, palier):
        ft_clear_dossier(subject_name, palier)
        print("\n\n" + RED + ">>>>>>>>>> FAILURE <<<<<<<<<<")
        print(PURPLE + "Tu as rate l'exercice 😥")
        print("Fais bien attention aux erreurs d'inattention la correction ne fais pas d'etat d'ame 😅")
        if TIMER_OPTION == True:
            print("Tu as du delai pour pouvoir remettre en correction fait bien attention a tout !🤞")
            thread_time = threading.Thread(target=ft_timer, args=(retry,))
            thread_time.start()
            current_time: int
            current_time = share_timer
            current_time /= 60
            time_remaining = share_timer % 60
            print(RED + "La prochaine correction sera disponible dans " + GREEN , int(current_time) , RED + " minutes et " + YELLOW , time_remaining , RED + " secondes\n")
        print("\n" + RED + "(Appuie sur entree pour continuer ...)")
        stop = False
        while not stop == True:
            try:
                input()
            except ValueError:
                continue
            except EOFError:
                continue
            stop = True
        return (level)
    else:
        ft_clear_dossier(subject_name, palier)
        print("\n\n" + GREEN + ">>>>>>>>>> SUCCESS <<<<<<<<<<")
        print("BRAVO tu as reussi l'exercice 🔥 je savais que tu pouvais le faire 😁")
        print("Tu es pret pour la suite ? 😋")
        print("Alors appuie sur entree 😈")
        level += 1
        stop = False
        while not stop == True:
            try:
                input()
            except ValueError:
                continue
            except EOFError:
                continue
            stop = True
    return (level)

"""

======================================================================================

Cette fonction sert a verifier si l'exercice en cours est bon elle verifie:

- Si le dossier dans exam n'existe pas OU n'a pas le nom correct

- Si le fichier dans le dossier de l'exo en cours n'existe pas OU n'a pas le bon nom

- Si il y a bien que un seul fichier dans le dossier rendu

- Si le fichier compile bien

- Et lance la fonction qui s'occupe de lancer le script de correction de l'exo

======================================================================================

"""

def ft_grade(subject_name, palier):
    dir = os.path.expanduser("~/Desktop/Exam/Rendu")
    dir = os.path.join(dir, subject_name)
    if not os.path.exists(dir):
        #print(RED + dir + "n'existe pas")
        return False
    file_name = subject_name + ".c"
    file = os.path.join(dir, file_name)
    if not os.path.isfile(file):
        return False
    if not ft_count_files(dir):
        return False
    if not ft_compil(file):
        return False
    if not ft_run_sh(subject_name, palier):
        return False
    return True

"""

======================================================================================

Cette fonction sert a lancer les scripts de corrections des exos

- Lance le script .sh dans le bon dossier

- Lis le fichier qui contient le resultat de la diff

- Si il n'y a rien ecrit dans le fichier diff, alors c'est bon [gagne +1]

- Lis le fichier qui contient le resultat du checker de fonction interdite

- Si il est vide, alors c'est bon [gagne +1]

- Si a la fin le nombre de point est de 2 alors l'exercice est bon

======================================================================================

"""

def ft_run_sh(subject_name, palier):
    grade = 0
    script_path = ".subjects/palier" + palier + "/" + subject_name + "/" + subject_name + ".sh"
    subprocess.call(["sh", script_path])
    diff_path = ".subjects/palier" + palier + "/" +  subject_name + "/result_diff.txt"
    with open(diff_path, 'r') as fichier:
        contenu = fichier.read()
    forbidden_path = ".subjects/palier" + palier + "/" + subject_name + "/forbidden.txt"
    with open(forbidden_path, 'r') as forbidden:
        forbidden_core = forbidden.read()
    if (len(forbidden_core) == 0):
        grade += 1
    if (len(contenu) == 0):
        grade += 1
    if (grade == 2):
        return True
    return False

"""

======================================================================================

Cette fonction sert a verifier si l'exercice compile correctement

- Lance la commande gcc -Wall -Wextra -Werror -c sur l'exercice pour verifier si il compile

- Si il n'y a pas de message d'erreur alors c'est bon

- Sinon c'est faux

======================================================================================

"""

def ft_compil(file):
    commande = ["gcc", "-Wall", "-Wextra", "-Werror", "-c", file]
    try:
        subprocess.check_output(commande, stderr=subprocess.STDOUT)
        return True
    except subprocess.CalledProcessError:
        return False

"""

======================================================================================

Cette fonction sert a verifier si l'exercice compile correctement

- Lance la commande gcc -Wall -Wextra -Werror -c sur l'exercice pour verifier si il compile

- Si il n'y a pas de message d'erreur alors c'est bon

- Sinon c'est faux

======================================================================================

"""

def ft_count_files(dir):
    contenu = os.listdir(dir)
    nombre_de_fichier = sum(1 for fichiers in contenu if os.path.isfile(os.path.join(dir, fichiers)))
    if nombre_de_fichier > 1:
        return False
    return True

"""

======================================================================================

Cette fonction sert a clear les fichiers creer pour la corrections et verifie avant,
si ils existent

======================================================================================

"""

def ft_clear_dossier(subject_name, palier):
    dossier_exo = os.path.expanduser("~/Desktop/Exam/Rendu/" + subject_name)
    object_file = subject_name + ".o"
    dossier = ".subjects/palier" + palier
    dossier = os.path.join(dossier,subject_name)
    if os.path.exists(os.path.join(dossier, "result_diff.txt")):
        os.remove(os.path.join(dossier, "result_diff.txt"))
    if os.path.exists(os.path.join(dossier, "trace_exo.txt")):
        os.remove(os.path.join(dossier, "trace_exo.txt"))
    if os.path.exists(os.path.join(dossier, "trace.txt")):
        os.remove(os.path.join(dossier, "trace.txt"))
    if os.path.exists(os.path.join(dossier, "Correct_" + subject_name)):
        os.remove(os.path.join(dossier, "Correct_" + subject_name))
    if os.path.exists(os.path.join(dossier, "forbidden.txt")):
        os.remove(os.path.join(dossier, "forbidden.txt"))
    if os.path.exists(os.path.join(dossier, "main")):
        os.remove(os.path.join(dossier, "main"))
    if os.path.exists(os.path.join(dossier, "a.out")):
        os.remove(os.path.join(dossier, "a.out"))
    if os.path.isfile(os.path.join(".", object_file)):
        os.remove(os.path.join(".", object_file))
    

    chemin_fichiers = glob.glob(os.path.join(dossier, "argv_*"))
    if len(chemin_fichiers) == 1:
        os.remove(chemin_fichiers[0])

    chemin_fichiers = glob.glob(os.path.join(dossier, "a.out"))
    if len(chemin_fichiers) == 1:
        os.remove(chemin_fichiers[0])

    chemin_fichiers = glob.glob(os.path.join(dossier, subject_name))
    if len(chemin_fichiers) == 1:
        os.remove(chemin_fichiers[0])      
         
"""

======================================================================================

Cette fonction sert a quitter la session d'exam

- Supprime le dossier exam

======================================================================================

"""

def ft_exit():
    global stop_thread
    global no_exit
    choice = 0
    print(GREEN + "Si tu as un probleme de correction et que tu ne comprends pas pourquoi")
    print("ca ne marche pas recupere ton code avant de dire oui et envoie le moi")
    while not (choice == "1" or choice == "Oui" or choice == "oui" or choice == "2" or choice == "Non" or choice == "non"):
        print(RED + "Es tu sur de vouloir quitter ?")
        print(RED + "Ton dossier Exam sera supprimer juste apres que tu ai repondu Oui")
        print(PURPLE + "\n\n1. Oui")
        print("2. Non")
        choice = input()
    if choice == "1" or choice == "Oui" or choice == "oui":
        dossier = os.path.expanduser("~/Desktop/Exam")
        shutil.rmtree(dossier)
        stop_thread = True
        sys.exit()
    elif choice == "2" or choice == "Non" or choice == "non":
        no_exit = True
        return


def ft_timer(retry):
    global share_timer
    global stop_thread
    retry += 1
    if retry == 1:
        share_timer = 60
    else:
        share_timer = retry + (retry - 1)
        share_timer *= 60
    while share_timer >= 0 and stop_thread == False:
        share_timer_lock.acquire()
        share_timer -= 1
        share_timer_lock.release()
        time.sleep(1)
    share_timer = 0





def ft_access_timer():
    if share_timer == 0 or TIMER_OPTION == False:
        return True
    else:
        current_time = share_timer
        current_time /= 60
        time_remaining = share_timer
        time_remaining %= 60
        print(RED + "Il te reste " + GREEN , int(current_time) , RED + " minutes et " + YELLOW , time_remaining , RED + " secondes")
        print(RED + "(Appuie sur entree pour continuer ...)")
        stop = False
        while not stop == True:
            try:
                input()
            except ValueError:
                continue
            except EOFError:
                continue
            stop = True 
        return False
    return False


"""

======================================================================================

Cette fonction sert de main

======================================================================================

"""

def ft_main():
    ft_Hello()
    ft_start_palier()

def ft_configure_exam_time():
    choix = 0
    print(PURPLE + "\n\nTu veux faire un Exam de combien de temps ? 😊\n\n")
    print("1. 🟢 4 heures, tu veux t'essayer a l'exam et voir jusqu'ou tu peux aller 🔥")
    print("2. 🔵 2 heures, tu sais que 4 heures c'est trop et que tu vas le plier en 2 heures cet exam 👑")
    print("3. 🔴 1 heure, tu veux te prouver que t'es une machine et tu as bien raison 🔱")
    print("4. ⚫️ 30 minutes, tu vis pour les cameras 🎥\n")
    while choix <= 0 or choix > 4:
        try:
            choix = int(input())
        except ValueError:
            continue
        except EOFError:
            continue
    global EXAM_TIME
    if choix == 1:
        EXAM_TIME = 4 * 3600
    elif choix == 2:
        EXAM_TIME = 2 * 3600
    elif choix == 3:
        EXAM_TIME = 3600
    elif choix == 4:
        EXAM_TIME = 1800

def ft_exam_time():
    global EXAM_TIME
    global exam_time
    global stop_thread
    exam_time = EXAM_TIME
    while (exam_time > 0 and stop_thread == False):
        exam_time_lock.acquire()
        exam_time -= 1
        exam_time_lock.release()
        time.sleep(1)
    if exam_time <= 0:
        print("\n\n\n\n\n" + RED + "Le temps est termine ⌛️")
        print(PURPLE + "\nSi tu vois ceci c'est que tu n'as pas reussi a finir a temps 😶")
        print(GREEN + "Ce n'est pas grave, c'est important d'echouer pour mieux reussir apres ! 🔥")
        print(PURPLE + "⭕️ Si tu as bloque sur un exercice tu peux me l'envoyer sur Discord avant de relancer Exam Shell ⭕️")
        os._exit(0)
def ft_print_exam_time_left():
    global EXAM_TIME
    global exam_time
    if (exam_time >= 0.5 * EXAM_TIME):
        color = GREEN
    elif (exam_time >= 0.25 * EXAM_TIME and exam_time <= 0.5 * EXAM_TIME):
        color = YELLOW
    else:
        color = RED
    hours_left = exam_time // 3600
    remaining_seconds = exam_time % 3600
    minutes_left = remaining_seconds // 60
    seconds_left = remaining_seconds % 60
    print("\n⏳️ " + color + "Il te reste " + GREEN , int(hours_left), " heure(s)" + color + ", " + BLUE , int(minutes_left), " minute(s)" + color + " et " + YELLOW , seconds_left, " seconde(s)" + color + " restantes ⏳️")

    


thread_main = threading.Thread(target=ft_main)
thread_exam_time = threading.Thread(target=ft_exam_time)
thread_main.start()
thread_main.join()

