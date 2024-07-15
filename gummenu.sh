#!/bin/bash

# Function to display the first menu
choose_primary_option() {
  echo "Escolha uma opção:"
  PRIMARY_CHOICE=$(gum choose "Apenas backup da Prod" "Backup e sobrepor algum ambiente" "(CUIDADO) Restaurar Prod" "Sair")

  case $PRIMARY_CHOICE in
    "Apenas backup da Prod")
      echo "You chose Apenas backup da Prod."
      # Add your logic for Apenas backup da Prod here
      ;;
    "Backup e sobrepor algum ambiente")
      choose_secondary_option
      ;;
    "(CUIDADO) Restaurar Prod")
      echo "You chose (CUIDADO) Restaurar Prod."
      # Add your logic for (CUIDADO) Restaurar Prod here
      ;;
    "Sair")
      echo "Operação cancelada."
      ;;
    *)
      echo "Invalid choice."
      ;;
  esac
}

# Function to display the second menu
choose_secondary_option() {
  echo "Escolha o ambiente para sobrepor:"
  SECONDARY_CHOICE=$(gum choose "Prod -> Develop" "Prod -> Staging" "Prod -> Christofoli" "Prod -> Luis" "Voltar" "Sair")

  case $SECONDARY_CHOICE in
    "Prod -> Develop")
      echo "You chose Prod -> Develop."
      # Add your logic for Prod -> Develop here
      ;;
    "Prod -> Staging")
      echo "You chose Prod -> Staging."
      # Add your logic for Prod -> Staging here
      ;;
    "Prod -> Christofoli")
      echo "You chose Prod -> Christofoli."
      # Add your logic for Prod -> Christofoli here
      ;;
    "Prod -> Luis")
      echo "You chose Prod -> Luis."
      # Add your logic for Prod -> Luis here
      ;;
    "Voltar")
      choose_primary_option
      ;;
    "Sair")
      echo "Operação cancelada."
      ;;
    *)
      echo "Invalid choice."
      ;;
  esac
}

# Start the script by displaying the first menu
choose_primary_option
