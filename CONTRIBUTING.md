# Contributing

Contributions are strongly encouraged. To do so fork the repo, make your changes, preferably test them locally and then open a pull request.

## Installing mkdocs

zec-qt-wallet docs are built with [mkdocs](https://www.mkdocs.org/) so to test any changes you make locally you will need to install it. The mkdocs docs have a great [installation guide](https://www.mkdocs.org/#installation) to follow but if you have Python (and pip) installed you can do the following:

```
pip install mkdocs
```

zec-qt-wallet docs also require some extra dependencies to build which you can install via:

```
pip install mkdocs-material pymdown-extensions pygments
```

At this point, you should have a working mkdocs install. You can now fork the repo, clone and start a local mkdocs server.

```
git clone https://github.com/adityapk00/zqw-docs.git
cd zqw-docs
git checkout -b your-branch-name
mkdocs serve
```

Now browse to http://localhost:8000 to view the documentation. Once you have reviewed your changes push to your forked repository and open a merge request.

## Deploying to GitHub Pages

For project collaborators, the changes may be pushed to GitHub pages via the `mkdocs gh-deploy` command which will deploy the currently checked out branch.