# Modular LaTeX template

A small, modern foundation for article-sized mathematical LaTeX projects. It separates
document content, mathematical configuration, project styling, and figures while
keeping unrelated optional features out of the base.

## Requirements

- TeX Live 2026, or a current MiKTeX with LaTeX 2025-11-01 or newer
- LuaLaTeX
- `latexmk`

The version baseline is intentional: the template enables LaTeX's current tagged-PDF
support and produces PDF/UA-2 output.

The template prefers the `libertinus-fonts` package. Minimal MiKTeX installations may
need it installed explicitly; `lm-math` provides the Latin Modern Math fallback.

## Build

Run from the repository root:

```sh
latexmk main.tex
```

The generated document is `build/main.pdf`. To remove generated files, run:

```sh
latexmk -C main.tex
```

`latexmkrc` selects LuaLaTeX, sends all generated files to `build/`, and makes errors
suitable for editors and continuous-integration logs.

`latexmk` requires Perl. If it is unavailable, a basic document can still be built by
creating the `build/` directory and running LuaLaTeX repeatedly until references
settle:

```sh
mkdir build
lualatex -output-directory=build main.tex
lualatex -output-directory=build main.tex
```

### Texmaker

The `latexmkrc` output settings apply only when Texmaker invokes `latexmk`. When using
LuaLaTeX directly, open Texmaker's command configuration and set its LuaLaTeX command
to:

```text
lualatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=build %.tex
```

Create the output directory once before the first direct build:

```sh
mkdir build
```

Set `main.tex` as Texmaker's master document. This ensures that compiling while editing
a file under `content/` still builds the complete document. The resulting PDF and all
auxiliary files are written under `build/`.

On Linux, install LuaLaTeX, `latexmk`, and the required LaTeX packages through the
distribution's package manager. The commands above normally work without additional
path configuration.

On Windows, TeX Live includes the Perl support needed by `latexmk`. MiKTeX's `latexmk`
launcher requires a separate Perl installation. If MiKTeX is not on `PATH`, replace
`lualatex` in Texmaker's command with the full path to `lualatex.exe` from the local
MiKTeX installation.

## Structure

```text
main.tex                 Document metadata and structure
project-style.sty        Packages and project-wide formatting
math-setup.sty           Math packages, fonts, and theorem environments
content/                 Sections and other document content
figures/                 Source images, including PDF figures
latexmkrc                Reproducible local build configuration
.github/workflows/       Continuous-integration build
build/                   Generated output; ignored by Git
```

Start by changing the title, author, and language metadata in `main.tex`. When changing
the language, also update the `babel` option in `project-style.sty`. Add content files
under `content/` and include them with `\input{content/name}`. Put images under
`figures/`; meaningful images should always have an `alt` description.

Load additional packages in `project-style.sty`. Keep `hyperref` near the end of the
package list, particularly after packages that modify references, captions, or the
table of contents. Put mathematical packages, operators, and shared theorem
environments in `math-setup.sty`. The template prefers Libertinus text and math fonts
when available and otherwise falls back to the Latin Modern fonts supplied by every
standard LaTeX distribution.

## Optional features

Bibliographies, indexes, glossaries, code listings, and other specialized features are
deliberately not enabled. Add and configure them only when a project requires them so
that the base remains predictable and quick to build.

For a publisher that requires current pdfLaTeX, replace the `fontspec` and
`unicode-math` font setup with pdfLaTeX-compatible fonts, set `$pdf_mode = 1` and
configure `$pdflatex` in `latexmkrc`, then remove `latexmk_use_lualatex` from the CI
workflow. Older LaTeX releases are outside this template's supported baseline because
their PDF-tagging interfaces differ.

## Continuous integration

The GitHub Actions workflow compiles `main.tex` with the same LuaLaTeX and TeX Live
baseline and uploads the resulting PDF as a workflow artifact. Dependabot checks the
workflow actions for updates each month.

## License

This repository is licensed under GPL-3.0. Because this is a project template intended
to be copied and adapted, verify that this license matches the licensing requirements
of the project created from it.
