{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ kanata ];

  services.kanata = {
    enable = true;
    keyboards = {
      "logi".config = ''
(defsrc
  caps esc
)

(deflayer default
  esc caps
)
  '';
    };
  };
}

# full remap:
# (defsrc
#   grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
#   tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
#   caps a    s    d    f    g    h    j    k    l    ;    '    ret
#   lsft z    x    c    v    b    n    m    ,    .    /    rsft
#   lctl lmet lalt           spc            ralt rmet rctl
# )

# (deflayer capsisesc 
#   grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
#   tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
#   esc  a    s    d    f    g    h    j    k    l    ;    '    ret
#   lsft z    x    c    v    b    n    m    ,    .    /    rsft
#   lctl lmet lalt           spc            ralt rmet rctl
# )
