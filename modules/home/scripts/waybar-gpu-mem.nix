{ pkgs }:
pkgs.writeShellScriptBin "waybar-gpu-mem" ''
  nvidia-smi --query-gpu=utilization.memory --format=csv,noheader,nounits
''
