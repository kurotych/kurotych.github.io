# Run
```bash
git submodule init
git submodule update
hugo serve
```
# Create new post
```bash
hugo new posts/my-first-post.md
```

# Update submodule
git submodule update --remote programming-python-2sem/

# cv update
pandoc ./static/cv.md -o ./static/cv.html --standalone --css cv.css && chromium --headless --print-to-pdf=./static/cv.pdf --no-pdf-header-footer ./static/cv.html
