{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = with pkgs; [
    python3

    # uv manages virtual environments, dependencies, and Python versions.
    # Use: uv init / uv add <pkg> / uv run <script>
    uv

    # Linting, formatting, and type checking
    ruff
    pyright
  ];

  shellHook = ''
    # Activate the project venv if one exists (created by uv sync / uv venv).
    if [ -f .venv/bin/activate ]; then
      source .venv/bin/activate
    fi
  '';
}
