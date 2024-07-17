#!/bin/bash

# Function to display the main menu
function main_menu() {
    clear
    echo "Docker Management TUI"
    echo "----------------------"
    ACTION=$(gum choose --height 10 \
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

# Function to list containers
function list_containers() {
    clear
    echo "Listing Docker Containers"
    echo "-------------------------"
    docker ps -a
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

# Function to start a container
function start_container() {
    clear
    echo "Starting a Docker Container"
    echo "---------------------------"
    CONTAINER=$(docker ps -a --format "{{.Names}}" | gum choose --height 10 --header "Select container to start")
    docker start $CONTAINER
    echo "Container $CONTAINER started."
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

# Function to stop a container
function stop_container() {
    clear
    echo "Stopping a Docker Container"
    echo "---------------------------"
    CONTAINER=$(docker ps --format "{{.Names}}" | gum choose --height 10 --header "Select container to stop")
    docker stop $CONTAINER
    echo "Container $CONTAINER stopped."
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

# Function to install a container
function install_container() {
    clear
    echo "Installing a Docker Container"
    echo "-----------------------------"
    IMAGE=$(gum input --placeholder "Enter the Docker image name")
    docker pull $IMAGE
    echo "Docker image $IMAGE installed."
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

# Function to open a shell in a container
function open_shell() {
    clear
    echo "Opening a Shell in a Docker Container"
    echo "-------------------------------------"
    CONTAINER=$(docker ps --format "{{.Names}}" | gum choose --height 10 --header "Select container to open a shell")
    docker exec -it $CONTAINER /bin/sh
    main_menu
}

# Function to open a root shell in a container
function open_root_shell() {
    clear
    echo "Opening a Root Shell in a Docker Container"
    echo "------------------------------------------"
    CONTAINER=$(docker ps --format "{{.Names}}" | gum choose --height 10 --header "Select container to open a root shell")
    docker exec -it --user root $CONTAINER /bin/sh
    main_menu
}

# Function to view container logs
function view_logs() {
    clear
    echo "Viewing Docker Container Logs"
    echo "-----------------------------"
    CONTAINER=$(docker ps --format "{{.Names}}" | gum choose --height 10 --header "Select container to view logs")
    docker logs $CONTAINER
    gum input --placeholder "Press Enter to return to the main menu"
    main_menu
}

# Start the main menu
main_menu
