#!/bin/bash

echo "Running flutter gen-l10n..."
flutter gen-l10n

echo "Running build_runner (delete conflicting outputs)..."
dart run build_runner build --delete-conflicting-outputs


echo "✅ Code generation completed!"