{
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    compression = true;
    addKeysToAgent = "yes";
  };
}
