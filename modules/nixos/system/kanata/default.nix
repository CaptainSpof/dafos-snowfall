{ config, lib, pkgs, namespace, ... }:

with lib;
with lib.${namespace};
let cfg = config.${namespace}.system.kanata;
in
{
  options.${namespace}.system.kanata = with types; {
    enable = mkBoolOpt false "Whether or not to configure kanata.";
    numlock.enable = mkBoolOpt true "Whether or not to enable auto numlock on boot";
    # FIXME/HACK: ugly hack, need to learn how to coerce list of str to lines
    excludedDevices = mkOpt (types.lines) ''"ZMK Project Kyria Keyboard"'' "The devices to be excluded";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kanata
    ];

    systemd.services.numLockOnTty = mkIf cfg.numlock.enable {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        # /run/current-system/sw/bin/setleds -D +num < "$tty";
        ExecStart = lib.mkForce (pkgs.writeShellScript "numLockOnTty" ''
          for tty in /dev/tty{1..6}; do
              ${pkgs.kbd}/bin/setleds -D +num < "$tty";
          done
        '');
      };
    };

    services.kanata = {
      enable = true;

      keyboards."bepo" = {
        extraDefCfg = ''
          linux-dev-names-exclude (
            ${cfg.excludedDevices}
          )
        '';
        config = ''
          (defvar
            tap-timeout   150
            hold-timeout  300
            tt $tap-timeout
            ht $hold-timeout
          )

          (deflocalkeys-linux
            '<   86
            'w   27
            'z   26
            'y   45
            à    44
            è    20
          )

          (defsrc
            esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  del
            grv     1    2    3    4    5    6    7    8    9    0    -    =    bspc
            tab     q    w    e    r    t    y    u    i    o    p    [    ]
            caps    a    s    d    f    g    h    j    k    l    ;    '    ret
            lsft    '<   z    x    c    v    b    n    m    ,    .    /    rsft
            lctl lmet lalt              spc            ralt rctl
          )

          (defalias
            ;; toggle layer aliases
            ars   (layer-while-held arrows-symbols)
            mctrl (layer-while-held media-controls)
            gam   (layer-switch gaming)
            qwe   (layer-switch qwerty)
            lsw   (layer-while-held layers-switcher)
            default (layer-switch bepow)
            bas     (layer-switch basic)

            ;; tap within $tt for esc, hold more than $ht for lctl
            cap      (tap-hold $tt $ht esc lctl)
            rbspc    (tap-hold-release $tt $ht up bspc)

            ;; home row mode
            lMf      (tap-hold-release $tt $ht f lmet)  ;; e
            lCd      (tap-hold-release $tt $ht d lctrl) ;; i
            aars     (tap-hold-release $tt $ht a @ars)  ;; a
            ;ars     (tap-hold-release $tt $ht ; @ars)  ;; n

            =mctrl   (tap-hold-release $tt $ht min @mctrl)  ;; =

            rSspc    (tap-hold-release $tt $ht spc rsft)
            <ars     (tap-hold-release $tt $ht RA-à @ars)
            rAbspc   (tap-hold-release $tt $ht bspc ralt)
            grv      (tap-hold-release $tt $ht (tap-dance $tt (grv @default)) @lsw)
          )

          (defalias
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
            ~     AG-b
            _     AG-spc
            `     AG-S-è
          )

          (deflayer bepow
            esc   f1    f2    f3    f4    f5    f6    f7    f8    f9    f10   f11   f12   del
            @grv  _     _     _     _     _     _     _     _     _     _     @=mctrl  _     _
            _     _     _     _     _    'w     _     _     _     _     _     à     è
            @cap  @aars _     @lCd  @lMf  _     _     _     _     _     @;ars _     _
            _     @<ars 'z     _     _    _     _     _     _     _     _     _     @rbspc
            _     _     _                   @rSspc               @rAbspc  _
          )

          (deflayer layers-switcher
            esc   f1    f2    f3    f4    f5    f6    f7    f8    f9    f10   f11   f12   del
            @grv  @default   @qwe   @gam  @bas  _     _     _     _     _     _     _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _     _     _    _     _     _     _     _     _     _      _
            _     _     _                   @rSspc               @rAbspc  _
          )

          (deflayer arrows-symbols
            esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  del
            @`     f1     f2     f3     f4     f5     f6     f7     f8     f9     f10     f11     f12     _
            _     @|     @/     @'lp   @'rp   _      _      pgdn   pgup   _      _       _       _
            _     @at    @<     @[     @]     @>     left   down   up     rght   _       _       _
            _     _      @\     _      @{     @}     @~     _      _      home   end     _       _
            _     _     _                     bspc                           _     _
          )

          (deflayer media-controls
            esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  del
            @`    mute voldwn volu f4   brdwn brup pp prev next prnt  f11     f12     _
            _     @|     @/     @'lp   @'rp   _      _      pgdn   pgup   _   M-S-prnt    _       _
            _     @at    @<     @[     @]     @>     left   down   up     rght   _       _       _
            _     _      @\     _      @{     @}     @~     _      _      home   end     _       _
            _     _     _                     bspc                           _     _
          )

          (defalias
            '1  kp1
            '2  kp2
            '3  kp3
            '4  kp4
            '5  kp5
            '6  kp6
            '7  kp7
            '8  kp8
            '9  kp9
            '0  kp0
            'q   m
            'e   f
            'r   l
            't   j
            'u   s
            'i   d
            'o   r
            'p   e
            'a   a
            's   k
            'd   i
            'f   /
            'g   ,
            'h   .
            'j   p
            'k   b
            'l   o
            ';   S-g
            '    n
            'x   c
            'c   h
            'v   u
            'b   q
            'n   ;
            'm   '
            ',   g
            '.   v
            '/   9
          )

          (deflayer qwerty
            esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  del
            @grv    @'1    @'2   @'3    @'4    @'5    @'6   @'7   @'8    @'9    @'0    -    =    _
            tab     @'q    'w    @'e    @'r    @'t    'y    @'u   @'i    @'o    @'p    @[    @]
            caps    @'a    @'s   @'d    @'f    @'g    @'h   @'j   @'k    @'l    @';    @'    ret
            lsft    '<     'z    @'x    @'c    @'v    @'b   @'n   @'m    @',    @'.    @'/   rsft
            lctl lmet lalt                     spc                @rAbspc rctl
          )

          (deflayer gaming
            esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  del
            @grv    @'1    @'2   @'3    @'4    @'5    @'6   @'7   @'8    @'9    @'0    -    =    _
            tab     @'q    up    @'e    @'r    @'t    'y    @'u   @'i    @'o    @'p    @[    @]
            caps    left   down  rght   @'f    @'g    @'h   @'j   @'k    @'l    @';    @'    ret
            lsft    '<     'z    @'x    @'c    @'v    @'b   @'n   @'m    @',    @'.    @'/   rsft
            lctl lmet lalt                     spc                @rAbspc rctl
          )

          (deflayer basic
            esc     f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  del
            @grv  _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _                       _                 _     _
          )
        '';
      };
    };
  };
}
