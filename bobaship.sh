#!/bin/bash

function main_menu() {
    clear
    gum style --foreground 212 --border-foreground 212 --border double --margin "1 2" --padding "2 4" "Bobaship"
    echo
    ACTION=$(gum choose --height 10 --header "Select an action:" \
        "List Containers" \
        "Start Container" \
        "Stop Container" \
        "Install Container" \
        "Open Shell in Container" \
        "Open Root Shell in Container" \
        "View Container Logs" \
        "Exit")
    
    case $ACTION in
        "List Containers") list_containers ;;
        "Start Container") start_container ;;
        "Stop Container") stop_container ;;
        "Install Container") install_container ;;
        "Open Shell in Container") open_shell ;;
        "Open Root Shell in Container") open_root_shell ;;
        "View Container Logs") view_logs ;;
        "Exit") exit 0 ;;
    esac
}

function list_containers() {
    clear
    gum style --foreground 212 --border-foreground 212 --border double --margin "1 2" --padding "2 4" "Listing Docker Containers"
    echo
    docker ps -a
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

function start_container() {
    clear
    gum style --foreground 212 --border-foreground 212 --border double --margin "1 2" --padding "2 4" "Starting a Docker Container"
    echo
    CONTAINER=$(docker ps -a --format "{{.Names}}" | gum choose --height 10 --header "Select container to start:")
    docker start $CONTAINER
    gum style --foreground 10 "Container $CONTAINER started."
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

function stop_container() {
    clear
    gum style --foreground 212 --border-foreground 212 --border double --margin "1 2" --padding "2 4" "Stopping a Docker Container"
    echo
    CONTAINER=$(docker ps --format "{{.Names}}" | gum choose --height 10 --header "Select container to stop:")
    docker stop $CONTAINER
    gum style --foreground 10 "Container $CONTAINER stopped."
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

function install_container() {
    clear
    gum style --foreground 212 --border-foreground 212 --border double --margin "1 2" --padding "2 4" "Installing a Docker Container"
    echo
    IMAGE=$(gum input --placeholder "Enter the Docker image name:")
    docker pull $IMAGE
    gum style --foreground 10 "Docker image $IMAGE installed."
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

function open_shell() {
    clear
    gum style --foreground 212 --border-foreground 212 --border double --margin "1 2" --padding "2 4" "Opening a Shell in a Docker Container"
    echo
    CONTAINER=$(docker ps --format "{{.Names}}" | gum choose --height 10 --header "Select container to open a shell:")
    docker exec -it $CONTAINER /bin/sh
    main_menu
}

function open_root_shell() {
    clear
    gum style --foreground 212 --border-foreground 212 --border double --margin "1 2" --padding "2 4" "Opening a Root Shell in a Docker Container"
    echo
    CONTAINER=$(docker ps --format "{{.Names}}" | gum choose --height 10 --header "Select container to open a root shell:")
    docker exec -it --user root $CONTAINER /bin/sh
    main_menu
}

function view_logs() {
    clear
    gum style --foreground 212 --border-foreground 212 --border double --margin "1 2" --padding "2 4" "Viewing Docker Container Logs"
    echo
    CONTAINER=$(docker ps --format "{{.Names}}" | gum choose --height 10 --header "Select container to view logs:")
    docker logs $CONTAINER
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

main_menu
