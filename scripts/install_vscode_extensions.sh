#!/bin/bash

extensions=(
    "ms-vscode.cpptools"
    "ms-vscode.cpptools-extension-pack"
    "ms-vscode.cpptools-themes"
    "ms-python.python"
    "ms-python.black-formatter"
    "ms-python.isort"
    "ms-python.flake8"
    "ms-python.mypy-type-checker"
    "ms-iot.vscode-ros"
)

for extension in "${extensions[@]}"; do
    code --install-extension $extension
done
