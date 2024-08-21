# Comparing pdflatex with .png and .pdf images

Running

    bash benchmark.sh

Should output something like:

    pdflatex using .pdf images: 	0m1.474s
    pdflatex using .png images: 	0m11.895s

## Notes

The example `trophy.png` (2.3M) is an 8 bits/Channel .png file and has transparency. It
was saved in Photoshop using Save As... ; Format PNG ; Smallest file size. 

The example `trophy.pdf` (4.5M) is created by embedding the `trophy.png` file in a pdf
using Illustrator.


## Why is including .png so slow?

Unless the png file meets [certain strict
conditions](https://tex.stackexchange.com/a/39933/13600), `pdflatex` will
re-encode the image rather then simply copy it.

It seems that .png files written directly from blender will not meet these
conditions, so directly including them will be slow.

A lot of times we might use .png instead of .jpg because of transparency, but
unfortunately this breaks the copy-conditions and will be slow to include.

Embedding the .png into a .pdf can sometimes result in a bigger file, but .pdf
(along with .jpg and others) will just be copied by `pdflatex`, hence fast to
compile.

## So what should I do with all my .png files?

At the very least you could convert them to .pdf using imagemagick:

    magick trophy.png trophy.pdf

There a bunch of other reasons it might convenient to use .pdf for your image
files anyway (e.g., adding vector graphic overlays, text labels, etc.). So I
tend to generate raw .png files for 2D/3D renderings and then always create a
.pdf for my figure using Illustrator.

You _could_ convert .png to .jpg but be careful about quality loss due to
compression settings or loss of transparency.

You _could_ convert your .png to a .png that meets all of the [strict
conditions](https://tex.stackexchange.com/a/39933/13600), but remember this
means no transparency.

(On Mac first do `brew install netpbm`)

One way to do this is:

    pngtopnm trophy.png > trophy.pnm
    pnmtopng trophy.pnm > trophy.png

But why not just use .pdf?
