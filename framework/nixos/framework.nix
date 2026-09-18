{
  config,
  lib,
  pkgs,
  ...
}:
{
  # maybe prevents freezing on battery? recovery via
  # ssh david@laptop 'sudo cat /sys/kernel/debug/dri/1/amdgpu_gpu_recover'
  # see https://community.frame.work/t/regular-system-freeze-need-help-investigating/84715/9
  # see https://wiki.archlinux.org/title/Framework_Laptop_13_(AMD_Ryzen_7040_Series)
  # another escalation might be "amdgpu.dcdebugmask=0x610"
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
}
