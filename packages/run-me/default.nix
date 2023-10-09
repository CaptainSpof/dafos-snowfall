{ nuenv, ... }:

nuenv.writeScriptBin {
  name = "run-me";
  script = ''
      def blue [msg: string] { $"(ansi blue)($msg)(ansi reset)" }
      blue "Hello world"
  '';
}
