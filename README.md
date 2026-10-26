# <img src="site/_static/koskari-icon.svg" height="42" align="top" alt=""> koskari.org

Source for the [koskari.org](https://koskari.org/) website. The Koskari
language itself lives in the
[koskari](https://github.com/koskari-lang/koskari) repository, which
also builds the documentation served at docs.koskari.org.


## Building

Requires Python 3.11 or newer and make.

```bash
make site       # build into build/html
make preview    # build, then serve at http://127.0.0.1:8000/
make clean      # remove build output
make purge      # remove build output and .venv
```

The first build creates `.venv` and installs the pinned packages from
`requirements.txt`.


## Layout

- `site/conf.py` -- Sphinx configuration
- `site/_templates/index.html` -- the landing page, rendered as a Sphinx
  additional page
- `site/*.md` -- Markdown pages, rendered through the theme layout
- `site/_themes/koskari/` -- the theme: page layout and stylesheets.
  `style.css` is shared with the landing page in the koskari repository;
  `site.css` holds this site's additions
- `site/_static/` -- the Koskari mark, as SVG and PNG
- `site/_extra/` -- copied verbatim to the site root: `CNAME`,
  `.nojekyll`, `robots.txt`, `llms.txt`, and `.well-known/`


## Agent discovery

- `/llms.txt` summarizes the language for language models and points to
  the MCP server at `https://corpus.koskari.org/mcp`.
- `/.well-known/ai-catalog.json` is an
  [AI Catalog](https://github.com/Agent-Card/ai-catalog) carrying the
  [MCP Server Card](https://github.com/modelcontextprotocol/experimental-ext-server-card)
  for that server inline.


## Publishing

`.github/workflows/deploy_site.yml` builds the site on every push and
pull request. Pushes to `main` deploy the build to GitHub Pages. The
repository's Pages source must be set to GitHub Actions.


## License

The site and its assets are licensed under the GNU General Public
License v3. See [LICENSE](LICENSE).
