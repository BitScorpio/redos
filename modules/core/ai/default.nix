{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  environment.variables = {
    VLLM_TARGET_DEVICE = "cuda";
    CUDA_HOME = "${pkgs.cudaPackages.cuda_nvcc}";
    LD_LIBRARY_PATH = lib.mkForce "/etc/sane-libs:${pkgs.cudatoolkit}/lib:${pkgs.cudaPackages.cuda_cudart}/lib";
  };
  environment.systemPackages = with pkgs; [
    pkgs.ollama
  ];

  # Ollama configuration
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };
  systemd.services.ollama.serviceConfig = {
    Environment = "OLLAMA_HOST=0.0.0.0";
  };

  services.open-webui = {
    enable = true;
    package = pkgs.open-webui;
    port = 8069;
  };

  services.perplexica = {
    enable = true;
    ollamaUrl = "http://localhost:11434";
  };

  imports = [ ./perplexica.nix ];
}
