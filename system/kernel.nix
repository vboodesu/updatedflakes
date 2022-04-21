{ pkgs, lib, ... }:

{

  boot = { 
    kernelPackages = pkgs.linuxPackages_zen;
    extraModprobeConfig = ''
      options kvm ignore_msrs=Y
      options kvm report_ignored_msrs=N
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';
    kernelParams = [
      "nohibernate"
      "intel_iommu=on"
      "iommu=pt"
      "pcie_acs_override=downstream,multifunction"
    ];
  };
 
 # Activate kernel modules (choose from built-ins and extra ones)
  boot.kernelModules = [
    # Virtual Camera
    "v4l2loopback"
    # Virtual Microphone, built-in
    "snd-aloop"
  ];

  # Set initial kernel module settings
 
}
