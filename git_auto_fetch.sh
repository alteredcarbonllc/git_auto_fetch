#!/bin/bash

# Reading the configuration file
CONFIG_FILE="/etc/git_auto_fetch.conf"

# Checking if the configuration file exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "The configuration file $CONFIG_FILE was not found."
  exit 1
fi

# Reading the configuration file and iterating through each directory
#!/bin/bash

CONFIG_FILE="repos.txt"  # Файл со списком директорий репозиториев

while IFS= read -r repo_dir; do
  # Пропускаем пустые строки и комментарии
  if [[ -z "$repo_dir" || "$repo_dir" == \#* ]]; then
    continue
  fi

  # Проверяем, существует ли каталог и является ли он репозиторием
  if [[ -d "$repo_dir/.git" ]]; then
    cd "$repo_dir" || continue

    echo "Fetching updates for $repo_dir..."

    # Выполняем git fetch
    git fetch --prune --all  --tags

    echo "Done."
  else
    echo "The directory $repo_dir is not a Git repository or does not exist."
  fi
done < "$CONFIG_FILE"
