
if ! [ -x "$(command -v pwsh)" ]; then
  echo 'Error: pwsh is not installed. Installing... (sudo apt-get install powershell)' >&2
  sudo apt-get install powershell
fi

pwsh -f dockerizer.ps1


