SHAREDFILES   = moderncv.cls moderncvcompatibility.sty moderncvcolor*.sty moderncvdebugtools.sty


template_classic_*.pdf: $(SHAREDFILES) template.tex template_classic_green.diff moderncvstyleclassic.sty moderncvheadi.sty moderncvbodyi.sty moderncviconsmarvosym.sty
  TARGET=basename($<)
  echo -e "Generating $<\c";
  cp template.tex $TARGET.tex                                       && echo -e ".\c";
  patch --silent $TARGET.tex < $TARGET.diff                         && echo -e ".\c";
  lualatex --interaction=batchmode --draftmode $TARGET > /dev/null  && echo -e ".\c";
  bibtex $TARGET > /dev/null                                        && echo -e ".\c";
  lualatex --interaction=batchmode $TARGET > /dev/null              && echo -e ".\c";
  lualatex --interaction=batchmode $TARGET > /dev/null              && echo -e " done";

clean:
  rm *.aux *.log *.bbl *.blg *.out;
  rm template_*.tex;
  rm *.sty moderncv.cls;

