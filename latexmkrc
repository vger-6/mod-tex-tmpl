# Use LuaLaTeX and keep the repository root free of generated files.
$pdf_mode = 4;
$out_dir = 'build';
$aux_dir = 'build';

$lualatex = 'lualatex %O -interaction=nonstopmode -file-line-error -halt-on-error %S';

# Stop pathological rerun loops while allowing references and the TOC to settle.
$max_repeat = 5;
