This is a minimal bookdown example. Although you see a few files here, only `index.Rmd` is required. All other files are optional, but `bookdown-minimal.Rproj` can make it much easier to build the book.

The key is the `site` setting in `index.Rmd`. If you want to build the book in RStudio, just click the `Build Book` button in the `Build` pane, otherwise call the function in R:

```r
bookdown::render_book('index.Rmd', 'all')
```
