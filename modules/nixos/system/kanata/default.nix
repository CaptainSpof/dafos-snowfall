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
    tapTimeout = mkOpt (types.number) 150 "The value for chord-timeout";
    holdTimeout = mkOpt (types.number) 300 "The value for chord-timeout";
    chordTimeout = mkOpt (types.number) 10 "The value for chord-timeout";
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
            tap-timeout   ${toString cfg.tapTimeout}
            hold-timeout  ${toString cfg.holdTimeout}
            chord-timeout ${toString cfg.chordTimeout}
            tt $tap-timeout
            ht $hold-timeout
            ct $chord-timeout
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
            med   (layer-while-held media-controls)
            num   (layer-while-held numbers)
            gam   (layer-switch gaming)
            qwe   (layer-switch qwerty)
            lsw   (layer-while-held layers-switcher)
            dft   (layer-switch bépow)
            bas   (layer-switch basic)

            ;; tap within $tt for esc, hold more than $ht for lctl
            cap      (tap-hold $tt $ht esc lctl)
            rbspc    (tap-hold-release $tt $ht up bspc)

            ;; home row mode
            lMe      (tap-hold-release $tt $ht f lmet)   ;; e → meta
            lCi      (tap-hold-release $tt $ht d lctrl)  ;; i → ctrl
            numa     (tap-hold-release $tt $ht a @num)   ;; a → numbers
            ars;     (tap-hold-release $tt $ht ; @ars)   ;; n → arrows-symbols

            mc=      (tap-hold-release $tt $ht min @med) ;; = → media-controls

            rSspc    (tap-hold-release $tt $ht spc rsft)  ;; spc → shift
            <ars     (tap-hold-release $tt $ht RA-à @ars) ;; à → arrows-symbols
            rAbspc   (tap-hold-release $tt $ht bspc ralt) ;; bspc → alt
            grv      (tap-hold-release $tt $ht (tap-dance $tt (grv @dft)) @lsw)

            ;; chords
            cht (chord chords j) ;; t
            chs (chord chords k) ;; s
          )

          (defalias
            [     AG-4
            ]     AG-5
            {     AG-x
            }     AG-c
            'lp   4
            'rp   5
            at    6
            +     7
            -     8
            /     9
            *     0
            <     AG-2
            >     AG-3
            |     AG-q
            \     AG-à
            ~     AG-b
            _     AG-spc
            `     AG-S-è
            $     `
            =     -
            %     =
            :     S-v
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
          )

          (defchords chords $chord-timeout
            (j  ) j
            (k  ) k
            (j k) C-bspc
          )

          (deflayer bépow
            _     _     _     _     _     _     _     _     _     _     _     _     _    _
            @grv  _     _     _     _     _     _     _     _     _     _     @mc=  _    _
            _     _     _     _     _    'w     _     _     _     _     _     à     è
            @cap  @numa _     @lCi  @lMe  _     _     @cht  @chs  _     @ars; _     _
            _     @<ars 'z     _     _    _     _     _     _     _     _     _     @rbspc
            _     _     _                   @rSspc               @rAbspc  _
          )

          (deflayer layers-switcher
            _     _     _     _     _     _     _     _     _     _     _     _     _    _
            @grv  @dft  @qwe  @gam  @bas  _     _     _     _     _     _     _     _    _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _                   @rSspc               @rAbspc  _
          )

          (deflayer arrows-symbols-bak
            _     _      _      _      _      _      _      _      _      _      _       _       _      _
            @`    f1     f2     f3     f4     f5     f6     f7     f8     f9     f10     f11     f12    _
            _     @|     @/     @'lp   @'rp   _      _      pgdn   pgup   _      _       _       _
            _     @at    @<     @[     @]     @>     left   down   up     rght   _       _       _
            _     _      @\     _      @{     @}     @~     _      _      home   end     _       _
            _     _     _                     bspc                           _     _
          )

          (deflayer arrows-symbols
            _     _      _      _      _      _      _      _      _      _      _       _       _      _
            @`    @`     @'lp   @'rp   ;      _      _      _      _      _      _       _       _      _
            _     @{     @'lp   @'rp   @}     _      _      pgdn   pgup   _      _       _       _
            _     @at    @=     @_     @$     @*     left   down   up     rght   _       _       _
            _     _      @\     _      @{     @}     @~     _      _      home   end     _       _
            _     _     _                     bspc                           _     _
          )

          (deflayer media-controls
            _     _      _      _      _      _      _      _      _      _      _     _     _     _
            _     mute   voldwn volu   _      brdwn  brup   pp     prev   next   prnt  _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _     _     _     _     _     _     _     _     _     _     _
            _     _     _                     bspc                            _     _
          )

          (deflayer numbers
            _     _     _     _     _     _     _     _     _     _     _     _     _    _
            _     _     _     _     _     _     _     _     _     _     _     _     _    _
            _     _     _     _     _     _     @%    @'1   @'2   @'3   @:    _     _
            _     _     _     _     _     _     @+    @'4   @'5   @'6   @-    _     _
            _     _     _     _     _     _     @*    @'7   @'8   @'9   @/    _     _
            _     _     _                   @'0                   _     _
          )

          (defalias
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
            esc     f1    f2    f3     f4     f5     f6    f7    f8     f9     f10    f11   f12  del
            @grv    @'1   @'2   @'3    @'4    @'5    @'6   @'7   @'8    @'9    @'0    -     =    _
            tab     @'q   'w    @'e    @'r    @'t    'y    @'u   @'i    @'o    @'p    @[    @]
            caps    @'a   @'s   @'d    @'f    @'g    @'h   @'j   @'k    @'l    @';    @'    ret
            lsft    '<    'z    @'x    @'c    @'v    @'b   @'n   @'m    @',    @'.    @'/   rsft
            lctl lmet lalt                     spc                @rAbspc rctl
          )

          (deflayer gaming
            esc     f1    f2    f3     f4     f5     f6    f7    f8     f9     f10    f11   f12  del
            @grv    @'1   @'2   @'3    @'4    @'5    @'6   @'7   @'8    @'9    @'0    -     =    _
            tab     @'q   up    @'e    @'r    @'t    'y    @'u   @'i    @'o    @'p    @[    @]
            caps    left  down  rght   @'f    @'g    @'h   @'j   @'k    @'l    @';    @'    ret
            lsft    '<    'z    @'x    @'c    @'v    @'b   @'n   @'m    @',    @'.    @'/   rsft
            lctl lmet lalt                     spc                @rAbspc rctl
          )

          (deflayer basic
            _     _     _     _     _     _     _     _     _     _     _     _     _     _
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
