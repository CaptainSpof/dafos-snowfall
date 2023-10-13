{ config, lib, pkgs, ... }:

with lib;
with lib.dafos;
let cfg = config.dafos.system.kanata;
in
{
  options.dafos.system.kanata = with types; {
    enable = mkBoolOpt false "Whether or not to configure kanata.";
  };

  config = mkIf cfg.enable {
    services.kanata.enable = true;

    environment.systemPackages = with pkgs; [
      kanata
    ];

    services.kanata.keyboards."bepo".config = ''
    (defvar
      tap-timeout   100
      hold-timeout  250
      tt $tap-timeout
      ht $hold-timeout
    )

    (deflocalkeys-linux
      '<   86
      'w   27
      'z   26
      à    44
      è    20
    )

    (defsrc
      grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
      tab  q    w    e    r    t    y    u    i    o    p    [    ]
      caps a    s    d    f    g    h    j    k    l    ;    '    ret
      lsft '<   z    x    c    v    b    n    m    ,    .    /    rsft
      lctl lmet lalt           spc            ralt rctl
    )

    (defalias
      ;; toggle layer aliases
      arr (layer-toggle arrows)
      sym (layer-toggle symbols)

      ;; tap within $tt for esc, hold more than $ht for lctl
      cap      (tap-hold $tt $ht esc lctl)
      rS       (tap-hold-release $tt $ht up rsft)
      lMf      (tap-hold-release $tt $ht f lmet)
      lCd      (tap-hold-release $tt $ht d lctrl)
      rSspc    (tap-hold-release $tt $ht spc rsft)
      <ar      (tap-hold-release $tt $ht RA-à @arr)
      rAbspc   (tap-hold-release $tt $ht bspc ralt)
      aarr     (tap-hold-release $tt $ht a @arr)
      ;sym     (tap-hold-release $tt $ht ; @sym)

      [     AG-4
      ]     AG-5
      {     AG-x
      }     AG-c
      'lp   4
      'rp   5
      <     AG-2
      >     AG-3
      at    6
      |     AG-q
      /     9
      \     AG-à
    )

    (deflayer bepow
      _     _     _    _      _      _    _    _    _    _    _    _    _    _
      _     _     _    _      _     'w    _    _    _    _    _    à    è
      @cap  @aarr _    @lCd   @lMf   _    _    _    _    _    @;sym _    _
      _     @<ar 'z    _      _      _    _    _    _    _    _     _    @rS
      _     _    _            @rSspc          @rAbspc  _
    )

    (deflayer symbols
      _     _    _    _    _    _     _    _    _    _    _    _    _    _
      _     @|   @/   @'lp @'rp _     _    _    _    _    _    _    _
      _     @at  @<   @[   @]   @>    _    _    _    _    _    _    _
      _     _    @\   _    @{   @}   _     _    _    _    _    _    _
      _     _    _          _               _    _
    )

    (deflayer arrows
      _    f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  _
      _    _      _    _   _    _    _    pgdn pgup _    _    _    _
      _    home   _    _   end  _    left down up   rght _    _    _
      _    _      _    _   _    _    _    _    _    home end  _
      _    _    _              _              _    _    _
    )
  '';

  };
}
