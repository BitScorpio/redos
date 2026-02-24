{ pkgs }:
pkgs.writeShellScriptBin "waybar-gpu-usage" ''
  nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits
''
